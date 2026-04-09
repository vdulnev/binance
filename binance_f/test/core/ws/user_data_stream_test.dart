import 'dart:async';

import 'package:binance_f/core/env/env_manager.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/core/ws/user_data_event.dart';
import 'package:binance_f/core/ws/user_data_stream.dart';
import 'package:binance_f/core/ws/ws_client.dart';
import 'package:dio/dio.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MockListenKeyClient extends Mock implements ListenKeyClient {}

class _FakeChannel implements WebSocketChannel {
  _FakeChannel() : _inbound = StreamController<dynamic>.broadcast();

  final StreamController<dynamic> _inbound;

  void sendFromServer(dynamic data) {
    if (!_inbound.isClosed) _inbound.add(data);
  }

  Future<void> closeFromServer() async {
    if (!_inbound.isClosed) await _inbound.close();
  }

  @override
  Stream<dynamic> get stream => _inbound.stream;

  @override
  WebSocketSink get sink => _FakeSink(this);

  @override
  String? get protocol => null;

  @override
  int? get closeCode => null;

  @override
  String? get closeReason => null;

  @override
  Future<void> get ready => Future.value();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
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
    if (!_channel._inbound.isClosed) await _channel._inbound.close();
  }

  @override
  Future<dynamic> get done => Future.value();
}

class _StubEnvManager extends EnvManager {
  _StubEnvManager()
    : super(talker: Talker(), dioFactory: (_, _) => Dio());
}

WsClient _buildClient({
  required _FakeChannel channel,
  required Talker talker,
  required Uri url,
}) {
  return WsClient(
    url: url,
    talker: talker,
    channelFactory: (_) => channel,
    initialBackoff: const Duration(milliseconds: 1),
    maxBackoff: const Duration(milliseconds: 10),
    heartbeatTimeout: const Duration(seconds: 1),
  );
}

void main() {
  late MockListenKeyClient keys;
  late _StubEnvManager env;
  late Talker talker;

  setUp(() {
    keys = MockListenKeyClient();
    env = _StubEnvManager();
    talker = Talker();

    // Default stubs for the close/keepAlive paths so that tearDown chains
    // (which call `dispose` → `stopAll`) don't blow up. Individual tests
    // override these as needed.
    when(
      () => keys.closeSpot(any()),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => keys.closeFutures(any()),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => keys.keepAliveSpot(any()),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => keys.keepAliveFutures(any()),
    ).thenReturn(TaskEither.right(unit));
  });

  group('UserDataStream.startSpot', () {
    test('POSTs the spot listen key and connects a WsClient', () async {
      when(
        () => keys.createSpot(),
      ).thenReturn(TaskEither.right('spot-listen-key'));

      final channel = _FakeChannel();
      final stream = UserDataStream(
        listenKeyClient: keys,
        envManager: env,
        talker: talker,
        wsClientFactory: (u) =>
            _buildClient(channel: channel, talker: talker, url: u),
      );
      addTearDown(stream.dispose);

      final result = await stream.startSpot().run();

      expect(result.isRight(), isTrue);
      verify(() => keys.createSpot()).called(1);
      expect(stream.spotActive, isTrue);
    });

    test(
      'outboundAccountPosition frame is parsed into AccountUpdate event',
      () async {
        when(
          () => keys.createSpot(),
        ).thenReturn(TaskEither.right('spot-listen-key'));

        final channel = _FakeChannel();
        final stream = UserDataStream(
          listenKeyClient: keys,
          envManager: env,
          talker: talker,
          wsClientFactory: (u) =>
              _buildClient(channel: channel, talker: talker, url: u),
        );
        addTearDown(stream.dispose);

        final events = <UserDataEvent>[];
        stream.events.listen(events.add);

        await stream.startSpot().run();

        channel.sendFromServer(
          '{"e":"outboundAccountPosition","B":[{"a":"BTC","f":"1.5","l":"0"}]}',
        );
        await Future<void>.delayed(const Duration(milliseconds: 5));

        expect(events, hasLength(1));
        final evt = events.first as AccountUpdate;
        expect(evt.balances.first.asset, 'BTC');
      },
    );

    test('ACCOUNT_UPDATE futures frame → FuturesAccountUpdate event', () async {
      when(
        () => keys.createFutures(),
      ).thenReturn(TaskEither.right('futures-listen-key'));

      final channel = _FakeChannel();
      final stream = UserDataStream(
        listenKeyClient: keys,
        envManager: env,
        talker: talker,
        wsClientFactory: (u) =>
            _buildClient(channel: channel, talker: talker, url: u),
      );
      addTearDown(stream.dispose);

      final events = <UserDataEvent>[];
      stream.events.listen(events.add);

      await stream.startFutures().run();

      channel.sendFromServer(
        '{"e":"ACCOUNT_UPDATE","a":{"B":[{"a":"USDT","wb":"1000","cw":"900"}],'
        '"P":[{"s":"BTCUSDT","pa":"0.1","ep":"30000","up":"50","mt":"cross"}]}}',
      );
      await Future<void>.delayed(const Duration(milliseconds: 5));

      expect(events, hasLength(1));
      final evt = events.first as FuturesAccountUpdate;
      expect(evt.assets.first.asset, 'USDT');
      expect(evt.positions.first.symbol, 'BTCUSDT');
    });
  });

  group('UserDataStream.stopAll', () {
    test(
      'DELETEs both listen keys and tears down both sockets',
      () async {
        when(
          () => keys.createSpot(),
        ).thenReturn(TaskEither.right('spot-listen-key'));
        when(
          () => keys.createFutures(),
        ).thenReturn(TaskEither.right('futures-listen-key'));
        when(
          () => keys.closeSpot(any()),
        ).thenReturn(TaskEither.right(unit));
        when(
          () => keys.closeFutures(any()),
        ).thenReturn(TaskEither.right(unit));

        final stream = UserDataStream(
          listenKeyClient: keys,
          envManager: env,
          talker: talker,
          wsClientFactory: (u) => _buildClient(
            channel: _FakeChannel(),
            talker: talker,
            url: u,
          ),
        );

        await stream.startSpot().run();
        await stream.startFutures().run();
        await stream.stopAll();

        verify(() => keys.closeSpot('spot-listen-key')).called(1);
        verify(() => keys.closeFutures('futures-listen-key')).called(1);
        expect(stream.spotActive, isFalse);
        expect(stream.futuresActive, isFalse);
      },
    );
  });

  group('UserDataStream.refresh timer', () {
    test(
      '30-min refresh timer PUTs both listen keys on each tick',
      () {
        FakeAsync().run((fake) {
          when(
            () => keys.createSpot(),
          ).thenReturn(TaskEither.right('spot-listen-key'));
          when(
            () => keys.createFutures(),
          ).thenReturn(TaskEither.right('futures-listen-key'));
          when(
            () => keys.keepAliveSpot(any()),
          ).thenReturn(TaskEither.right(unit));
          when(
            () => keys.keepAliveFutures(any()),
          ).thenReturn(TaskEither.right(unit));
          when(
            () => keys.closeSpot(any()),
          ).thenReturn(TaskEither.right(unit));
          when(
            () => keys.closeFutures(any()),
          ).thenReturn(TaskEither.right(unit));

          final stream = UserDataStream(
            listenKeyClient: keys,
            envManager: env,
            talker: talker,
            wsClientFactory: (u) => _buildClient(
              channel: _FakeChannel(),
              talker: talker,
              url: u,
            ),
            refreshInterval: const Duration(minutes: 30),
          );

          stream.startSpot().run();
          stream.startFutures().run();
          fake.flushMicrotasks();

          // No keepAlive yet.
          verifyNever(() => keys.keepAliveSpot(any()));
          verifyNever(() => keys.keepAliveFutures(any()));

          // Tick at 30 min → both PUTs fire.
          fake.elapse(const Duration(minutes: 30));
          fake.flushMicrotasks();

          verify(() => keys.keepAliveSpot('spot-listen-key')).called(1);
          verify(() => keys.keepAliveFutures('futures-listen-key')).called(1);

          // Tick at 60 min → another pair of PUTs.
          fake.elapse(const Duration(minutes: 30));
          fake.flushMicrotasks();

          verify(() => keys.keepAliveSpot('spot-listen-key')).called(1);
          verify(() => keys.keepAliveFutures('futures-listen-key')).called(1);
        });
      },
    );
  });

  group('listen key failure modes', () {
    test('POST failure propagates Left', () async {
      when(
        () => keys.createSpot(),
      ).thenReturn(TaskEither.left(const AppException.auth(message: 'bad')));

      final stream = UserDataStream(
        listenKeyClient: keys,
        envManager: env,
        talker: talker,
        wsClientFactory: (u) => _buildClient(
          channel: _FakeChannel(),
          talker: talker,
          url: u,
        ),
      );
      addTearDown(stream.dispose);

      final r = await stream.startSpot().run();
      expect(r.isLeft(), isTrue);
      r.match(
        (err) => expect(err, isA<AuthException>()),
        (_) => fail('expected Left'),
      );
      expect(stream.spotActive, isFalse);
    });
  });
}
