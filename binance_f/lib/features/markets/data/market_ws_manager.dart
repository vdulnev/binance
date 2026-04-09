import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:talker/talker.dart';

import '../../../core/env/env_manager.dart';
import '../../../core/ws/ws_client.dart';
import '../../orderbook/data/models/order_book_delta.dart';
import '../../orderbook/data/models/order_book_entry.dart';
import '../../orderbook/data/models/recent_trade.dart';
import 'models/kline_update.dart';
import 'models/ticker_24h.dart';

/// The set of stream types the manager can subscribe to per symbol.
enum StreamType { ticker, depth, trade, kline }

/// Factory that builds a [WsClient] for a given URL. Tests inject a
/// fake factory so no real sockets open.
typedef MarketWsFactory = WsClient Function(Uri url);

/// Manages per-symbol WebSocket subscriptions for market data using the
/// Binance combined stream endpoint.
///
/// Each symbol gets one [WsClient] connected to:
/// `wss://<host>/stream?streams=<symbol>@ticker/<symbol>@depth@100ms/...`
///
/// Frames are parsed and dispatched to the typed broadcast streams that
/// providers observe.
class MarketWsManager {
  MarketWsManager({
    required EnvManager envManager,
    required Talker talker,
    MarketWsFactory? wsFactory,
  }) : _env = envManager,
       _talker = talker,
       _wsFactory = wsFactory ?? ((url) => WsClient(url: url, talker: talker));

  final EnvManager _env;
  final Talker _talker;
  final MarketWsFactory _wsFactory;

  /// Active subscriptions keyed by lowercase symbol.
  final Map<String, _SymbolSubscription> _subs = {};

  final StreamController<Ticker24h> _tickerController =
      StreamController<Ticker24h>.broadcast();
  final StreamController<OrderBookDelta> _depthController =
      StreamController<OrderBookDelta>.broadcast();
  final StreamController<RecentTrade> _tradeController =
      StreamController<RecentTrade>.broadcast();
  final StreamController<KlineUpdate> _klineController =
      StreamController<KlineUpdate>.broadcast();

  /// Broadcast stream of all 24h ticker updates across all subscribed
  /// symbols. Providers filter by symbol.
  Stream<Ticker24h> get tickerStream => _tickerController.stream;

  /// Broadcast stream of depth delta frames.
  Stream<OrderBookDelta> get depthStream => _depthController.stream;

  /// Broadcast stream of executed trades.
  Stream<RecentTrade> get tradeStream => _tradeController.stream;

  /// Broadcast stream of kline (candlestick) updates.
  Stream<KlineUpdate> get klineStream => _klineController.stream;

  /// Subscribe to the given [types] for [symbol]. If [klineInterval] is
  /// provided and [types] contains [StreamType.kline], the kline stream
  /// for that interval is included.
  ///
  /// Safe to call multiple times for the same symbol; subsequent calls
  /// are no-ops.
  Future<void> subscribe(
    String symbol,
    Set<StreamType> types, {
    String klineInterval = '1m',
    String market = 'spot',
  }) async {
    final key = symbol.toLowerCase();
    if (_subs.containsKey(key)) return;

    final streams = <String>[];
    if (types.contains(StreamType.ticker)) {
      streams.add('$key@ticker');
    }
    if (types.contains(StreamType.depth)) {
      streams.add('$key@depth@100ms');
    }
    if (types.contains(StreamType.trade)) {
      streams.add('$key@trade');
    }
    if (types.contains(StreamType.kline)) {
      streams.add('$key@kline_$klineInterval');
    }

    if (streams.isEmpty) return;

    final baseUrl = market == 'futures'
        ? _env.current.futuresWsBaseUrl
        : _env.current.wsBaseUrl;
    final url = Uri.parse('$baseUrl/stream?streams=${streams.join('/')}');

    _talker.debug('MarketWsManager: subscribing $key → $url');

    final ws = _wsFactory(url);
    final sub = ws.messages.listen((frame) => _onFrame(frame, key));
    _subs[key] = _SymbolSubscription(ws: ws, sub: sub);
    await ws.connect();
  }

  /// Unsubscribe and disconnect the WS for [symbol].
  Future<void> unsubscribe(String symbol) async {
    final key = symbol.toLowerCase();
    final sub = _subs.remove(key);
    if (sub == null) return;
    _talker.debug('MarketWsManager: unsubscribing $key');
    await sub.sub.cancel();
    await sub.ws.dispose();
  }

  /// Tear down all active subscriptions. Called by
  /// `SessionManager.logout`.
  Future<void> unsubscribeAll() async {
    final keys = _subs.keys.toList();
    for (final key in keys) {
      await unsubscribe(key);
    }
  }

  Future<void> dispose() async {
    await unsubscribeAll();
    await _tickerController.close();
    await _depthController.close();
    await _tradeController.close();
    await _klineController.close();
  }

  // -----------------------------------------------------------------
  // Frame parsing
  // -----------------------------------------------------------------

  void _onFrame(Map<String, dynamic> frame, String symbol) {
    // Combined stream wraps data in `{"stream": "...", "data": {...}}`.
    final data = (frame['data'] as Map<String, dynamic>?) ?? frame;
    final eventType = data['e'] as String? ?? '';

    switch (eventType) {
      case '24hrTicker':
        _onTicker(data);
      case 'depthUpdate':
        _onDepth(data);
      case 'trade':
        _onTrade(data);
      case 'kline':
        _onKline(data);
    }
  }

  void _onTicker(Map<String, dynamic> data) {
    if (_tickerController.isClosed) return;
    _tickerController.add(
      Ticker24h(
        symbol: data['s'] as String,
        lastPrice: Decimal.parse((data['c'] ?? '0').toString()),
        priceChange: Decimal.parse((data['p'] ?? '0').toString()),
        priceChangePercent: Decimal.parse((data['P'] ?? '0').toString()),
        volume: Decimal.parse((data['v'] ?? '0').toString()),
        quoteVolume: Decimal.parse((data['q'] ?? '0').toString()),
        highPrice: Decimal.parse((data['h'] ?? '0').toString()),
        lowPrice: Decimal.parse((data['l'] ?? '0').toString()),
      ),
    );
  }

  void _onDepth(Map<String, dynamic> data) {
    if (_depthController.isClosed) return;
    final rawBids = (data['b'] as List?) ?? const [];
    final rawAsks = (data['a'] as List?) ?? const [];
    _depthController.add(
      OrderBookDelta(
        firstUpdateId: (data['U'] as int?) ?? 0,
        finalUpdateId: (data['u'] as int?) ?? 0,
        bids: rawBids
            .whereType<List<dynamic>>()
            .map(OrderBookEntry.fromBinanceList)
            .toList(growable: false),
        asks: rawAsks
            .whereType<List<dynamic>>()
            .map(OrderBookEntry.fromBinanceList)
            .toList(growable: false),
      ),
    );
  }

  void _onTrade(Map<String, dynamic> data) {
    if (_tradeController.isClosed) return;
    _tradeController.add(
      RecentTrade(
        id: (data['t'] as int?) ?? 0,
        price: Decimal.parse((data['p'] ?? '0').toString()),
        qty: Decimal.parse((data['q'] ?? '0').toString()),
        time: (data['T'] as int?) ?? 0,
        isBuyerMaker: (data['m'] as bool?) ?? false,
      ),
    );
  }

  void _onKline(Map<String, dynamic> data) {
    if (_klineController.isClosed) return;
    final k = (data['k'] as Map<String, dynamic>?) ?? const {};
    _klineController.add(
      KlineUpdate(
        symbol: data['s'] as String? ?? '',
        interval: k['i'] as String? ?? '',
        openTime: (k['t'] as int?) ?? 0,
        open: Decimal.parse((k['o'] ?? '0').toString()),
        high: Decimal.parse((k['h'] ?? '0').toString()),
        low: Decimal.parse((k['l'] ?? '0').toString()),
        close: Decimal.parse((k['c'] ?? '0').toString()),
        volume: Decimal.parse((k['v'] ?? '0').toString()),
        isClosed: (k['x'] as bool?) ?? false,
      ),
    );
  }
}

class _SymbolSubscription {
  _SymbolSubscription({required this.ws, required this.sub});

  final WsClient ws;
  final StreamSubscription<Map<String, dynamic>> sub;
}
