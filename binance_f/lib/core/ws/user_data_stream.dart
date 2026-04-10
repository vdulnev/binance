import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker/talker.dart';

import '../../features/auth/data/auth_repository.dart' show DioProvider;
import '../../features/portfolio/data/models/futures_asset_balance.dart';
import '../../features/portfolio/data/models/futures_position.dart';
import '../../features/portfolio/data/models/spot_balance.dart';
import '../../features/trade/data/models/order_enums.dart';
import '../env/env_manager.dart';
import '../models/app_exception.dart';
import 'user_data_event.dart';
import 'ws_client.dart';

/// Binance requires the client to PUT the listen key every 30 minutes or
/// it expires after 60 min. We refresh at half that to absorb clock drift.
const Duration kListenKeyRefreshInterval = Duration(minutes: 30);

/// Abstraction over listen-key REST + WS client construction so the
/// `UserDataStream` logic is testable without hitting any network.
///
/// The production implementation ([BinanceListenKeyClient]) calls the
/// spot / futures REST endpoints via the injected Dio pair.
abstract class ListenKeyClient {
  TaskEither<AppException, String> createSpot();
  TaskEither<AppException, Unit> keepAliveSpot(String listenKey);
  TaskEither<AppException, Unit> closeSpot(String listenKey);

  TaskEither<AppException, String> createFutures();
  TaskEither<AppException, Unit> keepAliveFutures(String listenKey);
  TaskEither<AppException, Unit> closeFutures(String listenKey);
}

class BinanceListenKeyClient implements ListenKeyClient {
  BinanceListenKeyClient({
    required DioProvider spot,
    required DioProvider futures,
  }) : _spot = spot,
       _futures = futures;

  final DioProvider _spot;
  final DioProvider _futures;

  @override
  TaskEither<AppException, String> createSpot() =>
      TaskEither<AppException, String>.tryCatch(() async {
        final r = await _spot().post<Map<String, dynamic>>(
          '/api/v3/userDataStream',
        );
        return (r.data!['listenKey'] as String);
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> keepAliveSpot(String listenKey) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _spot().put<Map<String, dynamic>>(
          '/api/v3/userDataStream',
          queryParameters: <String, dynamic>{'listenKey': listenKey},
        );
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> closeSpot(String listenKey) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _spot().delete<Map<String, dynamic>>(
          '/api/v3/userDataStream',
          queryParameters: <String, dynamic>{'listenKey': listenKey},
        );
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, String> createFutures() =>
      TaskEither<AppException, String>.tryCatch(() async {
        final r = await _futures().post<Map<String, dynamic>>(
          '/fapi/v1/listenKey',
        );
        return (r.data!['listenKey'] as String);
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> keepAliveFutures(String listenKey) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _futures().put<Map<String, dynamic>>('/fapi/v1/listenKey');
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> closeFutures(String listenKey) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _futures().delete<Map<String, dynamic>>('/fapi/v1/listenKey');
        return unit;
      }, _toAppException);
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  if (err is DioException && err.error is AppException) {
    return err.error! as AppException;
  }
  return AppException.unknown(message: err.toString());
}

/// Factory shape used by [UserDataStream] to build its WS clients. Tests
/// inject a fake factory that returns WsClients connected to a test
/// channel factory so no real socket is ever opened.
typedef WsClientFactory = WsClient Function(Uri url);

/// Owns the spot and futures user data WebSockets plus their 30-minute
/// listen-key refresh timer. Decoded events are emitted on [events].
///
/// ### Lifecycle
/// - `startSpot()` / `startFutures()` create a listen key, open the
///   socket, and arm the shared refresh timer on first start.
/// - On WS drop the underlying [WsClient] reconnects with backoff
///   (EC-6). If a reconnect cycle keeps failing, the caller's UI layer
///   is responsible for refreshing via REST to fill the gap — the
///   provider observes the stale state through the standard
///   `AsyncValue` flow.
/// - On `stopAll()` (logout — EC-15) both keys are DELETEd, both sockets
///   are disconnected, and the refresh timer is cancelled.
class UserDataStream {
  UserDataStream({
    required ListenKeyClient listenKeyClient,
    required EnvManager envManager,
    required Talker talker,
    WsClientFactory? wsClientFactory,
    Duration refreshInterval = kListenKeyRefreshInterval,
  }) : _keys = listenKeyClient,
       _env = envManager,
       _talker = talker,
       _wsClientFactory =
           wsClientFactory ?? ((u) => WsClient(url: u, talker: talker)),
       _refreshInterval = refreshInterval;

  final ListenKeyClient _keys;
  final EnvManager _env;
  final Talker _talker;
  final WsClientFactory _wsClientFactory;
  final Duration _refreshInterval;

  final StreamController<UserDataEvent> _events =
      StreamController<UserDataEvent>.broadcast();

  WsClient? _spotWs;
  WsClient? _futuresWs;
  String? _spotListenKey;
  String? _futuresListenKey;
  StreamSubscription<Map<String, dynamic>>? _spotSub;
  StreamSubscription<Map<String, dynamic>>? _futuresSub;
  Timer? _refreshTimer;

  Stream<UserDataEvent> get events => _events.stream;

  bool get spotActive => _spotWs != null;
  bool get futuresActive => _futuresWs != null;

  /// Start the spot user data stream. Safe to call repeatedly — a second
  /// call while already connected is a no-op.
  TaskEither<AppException, Unit> startSpot() {
    if (_spotWs != null) return TaskEither.right(unit);
    return _keys.createSpot().flatMap((listenKey) {
      _spotListenKey = listenKey;
      _talker.debug('UserDataStream: spot listen key acquired');
      final url = Uri.parse('${_env.current.wsBaseUrl}/ws/$listenKey');
      final ws = _wsClientFactory(url);
      _spotWs = ws;
      _spotSub = ws.messages.listen(_onSpotFrame);
      _armRefreshTimer();
      return TaskEither<AppException, Unit>.tryCatch(() async {
        await ws.connect();
        return unit;
      }, (err, _) => AppException.unknown(message: err.toString()));
    });
  }

  /// Start the futures user data stream. Same semantics as [startSpot].
  TaskEither<AppException, Unit> startFutures() {
    if (_futuresWs != null) return TaskEither.right(unit);
    return _keys.createFutures().flatMap((listenKey) {
      _futuresListenKey = listenKey;
      _talker.debug('UserDataStream: futures listen key acquired');
      final url = Uri.parse('${_env.current.futuresWsBaseUrl}/ws/$listenKey');
      final ws = _wsClientFactory(url);
      _futuresWs = ws;
      _futuresSub = ws.messages.listen(_onFuturesFrame);
      _armRefreshTimer();
      return TaskEither<AppException, Unit>.tryCatch(() async {
        await ws.connect();
        return unit;
      }, (err, _) => AppException.unknown(message: err.toString()));
    });
  }

  /// Tear down both streams. Called by `SessionManager.logout` as part of
  /// the full wipe chain.
  Future<void> stopAll() async {
    _refreshTimer?.cancel();
    _refreshTimer = null;

    final futures = <Future<void>>[];

    final spotKey = _spotListenKey;
    if (spotKey != null) {
      futures.add(_keys.closeSpot(spotKey).run().then((_) {}));
    }
    final futuresKey = _futuresListenKey;
    if (futuresKey != null) {
      futures.add(_keys.closeFutures(futuresKey).run().then((_) {}));
    }

    await _spotSub?.cancel();
    _spotSub = null;
    await _futuresSub?.cancel();
    _futuresSub = null;

    final spotWs = _spotWs;
    _spotWs = null;
    if (spotWs != null) futures.add(spotWs.dispose());

    final futuresWs = _futuresWs;
    _futuresWs = null;
    if (futuresWs != null) futures.add(futuresWs.dispose());

    _spotListenKey = null;
    _futuresListenKey = null;

    await Future.wait(futures);
    _talker.info('UserDataStream: stopped');
  }

  Future<void> dispose() async {
    await stopAll();
    await _events.close();
  }

  // ---------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------

  void _armRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(_refreshInterval, (_) => _refreshKeys());
  }

  Future<void> _refreshKeys() async {
    final spotKey = _spotListenKey;
    if (spotKey != null) {
      final r = await _keys.keepAliveSpot(spotKey).run();
      r.match(
        (err) => _talker.error('UserDataStream: spot keepAlive failed', err),
        (_) => _talker.debug('UserDataStream: spot keepAlive ok'),
      );
    }
    final futuresKey = _futuresListenKey;
    if (futuresKey != null) {
      final r = await _keys.keepAliveFutures(futuresKey).run();
      r.match(
        (err) => _talker.error('UserDataStream: futures keepAlive failed', err),
        (_) => _talker.debug('UserDataStream: futures keepAlive ok'),
      );
    }
  }

  void _onSpotFrame(Map<String, dynamic> frame) {
    final eventType = frame['e'] as String?;
    switch (eventType) {
      case 'outboundAccountPosition':
        _onSpotAccountUpdate(frame);
      case 'executionReport':
        _onSpotExecutionReport(frame);
    }
  }

  void _onSpotAccountUpdate(Map<String, dynamic> frame) {
    final raw = (frame['B'] as List?) ?? const [];
    final balances = raw
        .whereType<Map<String, dynamic>>()
        .map(
          (b) => SpotBalance(
            asset: b['a'] as String,
            free: Decimal.parse(b['f'].toString()),
            locked: Decimal.parse(b['l'].toString()),
          ),
        )
        .toList(growable: false);
    _events.add(UserDataEvent.accountUpdate(balances: balances));
  }

  void _onSpotExecutionReport(Map<String, dynamic> frame) {
    Decimal d(String key) => Decimal.parse((frame[key] ?? '0').toString());

    final statusStr = frame['X'] as String? ?? '';
    final typeStr = frame['o'] as String? ?? '';
    final sideStr = frame['S'] as String? ?? '';
    final tifStr = frame['f'] as String?;

    _events.add(
      UserDataEvent.spotOrderUpdate(
        symbol: frame['s'] as String? ?? '',
        orderId: (frame['i'] as num?)?.toInt() ?? 0,
        clientOrderId: frame['c'] as String? ?? '',
        side: OrderSide.values.firstWhere(
          (e) => e.name == sideStr,
          orElse: () => OrderSide.BUY,
        ),
        orderType: OrderType.values.firstWhere(
          (e) => e.name == typeStr,
          orElse: () => OrderType.MARKET,
        ),
        status: OrderStatus.values.firstWhere(
          (e) => e.name == statusStr,
          orElse: () => OrderStatus.NEW,
        ),
        price: d('p'),
        origQty: d('q'),
        executedQty: d('z'),
        cummulativeQuoteQty: d('Z'),
        timeInForce: tifStr != null
            ? TimeInForce.values.firstWhere(
                (e) => e.name == tifStr,
                orElse: () => TimeInForce.GTC,
              )
            : null,
        stopPrice: frame['P'] != null ? d('P') : null,
        time: (frame['T'] as num?)?.toInt() ?? 0,
        updateTime: (frame['E'] as num?)?.toInt() ?? 0,
      ),
    );
  }

  void _onFuturesFrame(Map<String, dynamic> frame) {
    final eventType = frame['e'] as String?;
    switch (eventType) {
      case 'ACCOUNT_UPDATE':
        _onFuturesAccountUpdate(frame);
      case 'ORDER_TRADE_UPDATE':
        _onFuturesOrderUpdate(frame);
    }
  }

  void _onFuturesAccountUpdate(Map<String, dynamic> frame) {
    final payload = (frame['a'] as Map<String, dynamic>?) ?? const {};
    final rawAssets = (payload['B'] as List?) ?? const [];
    final assets = rawAssets
        .whereType<Map<String, dynamic>>()
        .map(
          (a) => FuturesAssetBalance(
            asset: a['a'] as String,
            walletBalance: Decimal.parse(a['wb'].toString()),
            unrealizedProfit: Decimal.zero,
            marginBalance: Decimal.parse(a['wb'].toString()),
            availableBalance: Decimal.parse((a['cw'] ?? a['wb']).toString()),
          ),
        )
        .toList(growable: false);

    final rawPositions = (payload['P'] as List?) ?? const [];
    final positions = rawPositions
        .whereType<Map<String, dynamic>>()
        .map(
          (p) => FuturesPosition(
            symbol: p['s'] as String,
            positionAmt: Decimal.parse(p['pa'].toString()),
            entryPrice: Decimal.parse(p['ep'].toString()),
            unrealizedProfit: Decimal.parse((p['up'] ?? '0').toString()),
            leverage: Decimal.one,
            marginType: (p['mt'] as String?) ?? 'cross',
          ),
        )
        .toList(growable: false);

    _events.add(
      UserDataEvent.futuresAccountUpdate(assets: assets, positions: positions),
    );
  }

  void _onFuturesOrderUpdate(Map<String, dynamic> frame) {
    final o = (frame['o'] as Map<String, dynamic>?) ?? const {};
    Decimal d(String key) => Decimal.parse((o[key] ?? '0').toString());

    final statusStr = o['X'] as String? ?? '';
    final typeStr = o['o'] as String? ?? '';
    final sideStr = o['S'] as String? ?? '';
    final tifStr = o['f'] as String?;

    _events.add(
      UserDataEvent.futuresOrderUpdate(
        symbol: o['s'] as String? ?? '',
        orderId: (o['i'] as num?)?.toInt() ?? 0,
        clientOrderId: o['c'] as String? ?? '',
        side: OrderSide.values.firstWhere(
          (e) => e.name == sideStr,
          orElse: () => OrderSide.BUY,
        ),
        orderType: OrderType.values.firstWhere(
          (e) => e.name == typeStr,
          orElse: () => OrderType.MARKET,
        ),
        status: OrderStatus.values.firstWhere(
          (e) => e.name == statusStr,
          orElse: () => OrderStatus.NEW,
        ),
        price: d('p'),
        origQty: d('q'),
        executedQty: d('z'),
        cumQuote: d('Z'),
        timeInForce: tifStr != null
            ? TimeInForce.values.firstWhere(
                (e) => e.name == tifStr,
                orElse: () => TimeInForce.GTC,
              )
            : null,
        stopPrice: o['sp'] != null ? d('sp') : null,
        activatePrice: o['AP'] != null ? d('AP') : null,
        callbackRate: o['cr'] != null ? d('cr') : null,
        reduceOnly: o['R'] == true,
        time: (o['T'] as num?)?.toInt() ?? 0,
        updateTime: (frame['E'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}
