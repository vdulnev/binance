import 'dart:async';
import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Connection lifecycle states exposed by [WsClient.state].
enum WsState { disconnected, connecting, connected, reconnecting, disconnecting }

/// Function shape used by [WsClient] to open an underlying
/// [WebSocketChannel]. Injecting this lets tests swap in a fake channel
/// without hitting a real socket.
typedef WsChannelFactory = WebSocketChannel Function(Uri url);

/// Thin wrapper around [WebSocketChannel] that owns reconnect, heartbeat,
/// and exposes JSON-decoded frames as a broadcast [Stream].
///
/// ### Reconnect
/// Exponential backoff: 1s → 2s → 4s → 8s → 16s → cap 30s. The attempt
/// counter resets whenever the connection stays up for more than 10s so a
/// stable socket isn't dragged back into a tight retry loop just because
/// of an ancient failure.
///
/// ### Heartbeat
/// Binance's server pings every ~3 min and clients must respond within
/// 10 min. `web_socket_channel` forwards pings transparently at the
/// socket layer, but if we don't see **any** frame from the server for
/// 6 min we assume the link is half-open and reconnect proactively.
///
/// ### try/catch carve-out
/// This file is part of the infrastructure carve-out from the project's
/// "no try/catch" rule (see `feedback_fpdart_convention.md` and
/// `lib/core/api/signing_interceptor.dart`). It sits below the repository
/// boundary and has to interop with the throw-based
/// [WebSocketChannel.ready] / [StreamSubscription.onError] APIs. The
/// `try`/`catch` is scoped to the narrow adapter section that bridges
/// into async error flow; higher-level code above `WsClient` remains
/// fpdart-only.
class WsClient {
  WsClient({
    required this.url,
    required Talker talker,
    WsChannelFactory? channelFactory,
    Duration initialBackoff = const Duration(seconds: 1),
    Duration maxBackoff = const Duration(seconds: 30),
    Duration stableThreshold = const Duration(seconds: 10),
    Duration heartbeatTimeout = const Duration(minutes: 6),
  }) : _talker = talker,
       _channelFactory =
           channelFactory ?? ((u) => WebSocketChannel.connect(u)),
       _initialBackoff = initialBackoff,
       _maxBackoff = maxBackoff,
       _stableThreshold = stableThreshold,
       _heartbeatTimeout = heartbeatTimeout;

  final Uri url;
  final Talker _talker;
  final WsChannelFactory _channelFactory;
  final Duration _initialBackoff;
  final Duration _maxBackoff;
  final Duration _stableThreshold;
  final Duration _heartbeatTimeout;

  final StreamController<WsState> _stateController =
      StreamController<WsState>.broadcast();
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  WsState _state = WsState.disconnected;
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  Timer? _stableTimer;
  int _attempt = 0;
  bool _closedByCaller = false;

  WsState get currentState => _state;
  Stream<WsState> get state => _stateController.stream;
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  /// Open the connection. Safe to call multiple times; successive calls
  /// are no-ops while a connection is in flight or already connected.
  Future<void> connect() async {
    if (_state == WsState.connected ||
        _state == WsState.connecting ||
        _state == WsState.reconnecting) {
      return;
    }
    _closedByCaller = false;
    await _open();
  }

  /// Close the connection and cancel any pending reconnect.
  Future<void> disconnect() async {
    _closedByCaller = true;
    _setState(WsState.disconnecting);
    _cancelTimers();
    // Adapter: close the channel and swallow any sink-close error so the
    // caller's awaited `disconnect` never throws back out of infrastructure.
    final channel = _channel;
    _channel = null;
    await _subscription?.cancel();
    _subscription = null;
    if (channel != null) {
      try {
        await channel.sink.close();
      } on Object catch (e) {
        _talker.debug('WsClient: sink.close swallowed error: $e');
      }
    }
    _setState(WsState.disconnected);
  }

  /// Send a single text frame. No-op if the socket isn't connected.
  void send(String data) {
    final channel = _channel;
    if (channel == null || _state != WsState.connected) return;
    channel.sink.add(data);
  }

  /// Dispose the client. Closes both the underlying socket and the
  /// broadcast controllers so awaiters can unblock.
  Future<void> dispose() async {
    await disconnect();
    await _stateController.close();
    await _messageController.close();
  }

  // ---------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------

  Future<void> _open() async {
    _setState(_attempt == 0 ? WsState.connecting : WsState.reconnecting);
    _talker.debug('WsClient: connecting to $url (attempt=$_attempt)');

    // Adapter: the channel factory is allowed to throw on DNS / TLS
    // failures. Catch and schedule a reconnect; higher-level callers
    // observe the failure via [state] updates, not exceptions.
    try {
      final channel = _channelFactory(url);
      _channel = channel;
      _subscription = channel.stream.listen(
        _onFrame,
        onError: _onSocketError,
        onDone: _onSocketDone,
        cancelOnError: false,
      );
      _setState(WsState.connected);
      _armHeartbeat();
      _armStableTimer();
    } on Object catch (e, st) {
      _talker.error('WsClient: connect threw', e, st);
      _scheduleReconnect();
    }
  }

  void _onFrame(dynamic frame) {
    _armHeartbeat();
    final text = frame is String ? frame : (frame is List<int> ? utf8.decode(frame) : null);
    if (text == null || text.isEmpty) return;

    // Adapter: malformed JSON gets logged and dropped rather than crashing
    // the subscription. Upstream consumers should be resilient to gaps.
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) {
        _messageController.add(decoded);
      }
    } on FormatException catch (e) {
      _talker.debug('WsClient: dropped malformed frame: $e');
    }
  }

  void _onSocketError(Object error, StackTrace stackTrace) {
    _talker.error('WsClient: socket error', error, stackTrace);
    _scheduleReconnect();
  }

  void _onSocketDone() {
    _talker.debug('WsClient: socket done (closedByCaller=$_closedByCaller)');
    if (_closedByCaller) return;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_closedByCaller) return;
    _cancelTimers();
    _subscription?.cancel();
    _subscription = null;
    _channel = null;

    final delay = _backoffFor(_attempt);
    _attempt++;
    _setState(WsState.reconnecting);
    _talker.debug(
      'WsClient: reconnect scheduled in ${delay.inMilliseconds}ms '
      '(nextAttempt=$_attempt)',
    );
    _reconnectTimer = Timer(delay, _open);
  }

  Duration _backoffFor(int attempt) {
    // 1s, 2s, 4s, 8s, 16s, cap 30s.
    final ms = _initialBackoff.inMilliseconds * (1 << attempt);
    if (ms >= _maxBackoff.inMilliseconds) return _maxBackoff;
    return Duration(milliseconds: ms);
  }

  void _armHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer(_heartbeatTimeout, () {
      _talker.debug(
        'WsClient: heartbeat timeout (no frames in '
        '${_heartbeatTimeout.inSeconds}s) — reconnecting',
      );
      _scheduleReconnect();
    });
  }

  void _armStableTimer() {
    _stableTimer?.cancel();
    _stableTimer = Timer(_stableThreshold, () {
      if (_state == WsState.connected) {
        _attempt = 0;
        _talker.debug('WsClient: connection stable — backoff attempt reset');
      }
    });
  }

  void _cancelTimers() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _stableTimer?.cancel();
    _stableTimer = null;
  }

  void _setState(WsState next) {
    if (_state == next) return;
    _state = next;
    if (!_stateController.isClosed) _stateController.add(next);
  }
}
