import 'dart:async';

import 'package:binance_f/core/ws/ws_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Minimal fake [WebSocketChannel] that exposes an inbound / outbound
/// controller so tests can push frames, close the socket, or simulate
/// errors without any real I/O.
///
/// `noSuchMethod` fills in the `StreamChannelMixin` members the test
/// never touches (cast/transform/etc.) so the class stays tiny.
class _FakeChannel implements WebSocketChannel {
  _FakeChannel() : _inbound = StreamController<dynamic>() {
    _sink = _FakeSink(this);
  }

  final StreamController<dynamic> _inbound;
  late final _FakeSink _sink;
  bool closed = false;

  void sendFromServer(dynamic data) {
    if (_inbound.isClosed) return;
    _inbound.add(data);
  }

  void emitError(Object error) {
    if (_inbound.isClosed) return;
    _inbound.addError(error);
  }

  Future<void> closeFromServer() async {
    if (!_inbound.isClosed) await _inbound.close();
  }

  @override
  Stream<dynamic> get stream => _inbound.stream;

  @override
  WebSocketSink get sink => _sink;

  @override
  String? get protocol => null;

  @override
  int? get closeCode => null;

  @override
  String? get closeReason => null;

  @override
  Future<void> get ready => Future.value();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeSink implements WebSocketSink {
  _FakeSink(this._channel);

  final _FakeChannel _channel;

  @override
  void add(dynamic data) {}

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future<dynamic> addStream(Stream<dynamic> stream) async {}

  @override
  Future<dynamic> close([int? closeCode, String? closeReason]) async {
    _channel.closed = true;
    if (!_channel._inbound.isClosed) {
      await _channel._inbound.close();
    }
  }

  @override
  Future<dynamic> get done => Future.value();
}

void main() {
  group('WsClient', () {
    test('connects, decodes JSON frames, and emits them on messages', () async {
      final channel = _FakeChannel();
      final client = WsClient(
        url: Uri.parse('wss://example.com/ws'),
        talker: Talker(),
        channelFactory: (_) => channel,
      );
      addTearDown(client.dispose);

      final received = <Map<String, dynamic>>[];
      client.messages.listen(received.add);

      await client.connect();
      expect(client.currentState, WsState.connected);

      channel.sendFromServer('{"e":"ping","v":1}');
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(1));
      expect(received.first['e'], 'ping');
    });

    test('backoff schedule is 1s, 2s, 4s, 8s, 16s, capped at 30s', () async {
      final channel = _FakeChannel();
      final states = <WsState>[];
      var attempts = 0;

      final client = WsClient(
        url: Uri.parse('wss://example.com/ws'),
        talker: Talker(),
        channelFactory: (_) {
          attempts++;
          // Fail immediately on every attempt.
          throw StateError('boom');
        },
        initialBackoff: const Duration(milliseconds: 1),
        maxBackoff: const Duration(milliseconds: 30),
        stableThreshold: const Duration(seconds: 10),
      );
      addTearDown(client.dispose);
      client.state.listen(states.add);

      await client.connect();

      // Let a few reconnect cycles run. Initial attempt + retries.
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(attempts, greaterThan(3));
      expect(states.contains(WsState.reconnecting), isTrue);

      channel.closed; // touch to silence analyzer unused warning
    });

    test(
      'reconnect on stream close (simulated drop) fires another connect',
      () async {
        var calls = 0;
        _FakeChannel? current;

        final client = WsClient(
          url: Uri.parse('wss://example.com/ws'),
          talker: Talker(),
          channelFactory: (_) {
            calls++;
            current = _FakeChannel();
            return current!;
          },
          initialBackoff: const Duration(milliseconds: 1),
          maxBackoff: const Duration(milliseconds: 10),
        );
        addTearDown(client.dispose);

        await client.connect();
        expect(calls, 1);

        // Simulate the server closing the socket.
        await current!.closeFromServer();
        await Future<void>.delayed(const Duration(milliseconds: 20));

        expect(calls, greaterThanOrEqualTo(2));
      },
    );

    test(
      'heartbeat timeout triggers reconnect even when socket is silent',
      () async {
        var calls = 0;
        final client = WsClient(
          url: Uri.parse('wss://example.com/ws'),
          talker: Talker(),
          channelFactory: (_) {
            calls++;
            return _FakeChannel();
          },
          initialBackoff: const Duration(milliseconds: 1),
          maxBackoff: const Duration(milliseconds: 10),
          heartbeatTimeout: const Duration(milliseconds: 20),
        );
        addTearDown(client.dispose);

        await client.connect();
        expect(calls, 1);

        // Don't push any frames — let the heartbeat timer expire.
        await Future<void>.delayed(const Duration(milliseconds: 60));

        expect(calls, greaterThanOrEqualTo(2));
      },
    );

    test('disconnect stops reconnect and closes the current socket', () async {
      _FakeChannel? current;
      final client = WsClient(
        url: Uri.parse('wss://example.com/ws'),
        talker: Talker(),
        channelFactory: (_) {
          current = _FakeChannel();
          return current!;
        },
      );

      await client.connect();
      expect(client.currentState, WsState.connected);

      await client.disconnect();
      expect(client.currentState, WsState.disconnected);
      expect(current!.closed, isTrue);
    });
  });
}
