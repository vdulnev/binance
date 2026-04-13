import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:talker/talker.dart';

import '../../markets/data/market_ws_manager.dart';
import '../../markets/data/models/ticker_24h.dart';
import 'alerts_repository.dart';
import 'models/price_alert.dart';

/// Callback invoked when a price alert triggers.
typedef AlertTriggeredCallback =
    void Function(PriceAlert alert, Decimal currentPrice);

/// Evaluates local price alerts against the live WebSocket ticker
/// stream (Phase 9 — FR-7.2).
///
/// Registered as a get_it singleton (not a Riverpod provider) because
/// it must run continuously while the user is logged in, regardless of
/// whether any UI is watching it.
///
/// **Crossing logic:** an alert fires only when the price *crosses*
/// the threshold between two consecutive ticks for the same symbol.
/// The first tick for a symbol records the price without evaluating
/// (two data points are required to detect a crossing).
class AlertEvaluator {
  AlertEvaluator({
    required AlertsRepository alertsRepository,
    required MarketWsManager marketWsManager,
    required Talker talker,
    required AlertTriggeredCallback onTriggered,
  }) : _repo = alertsRepository,
       _wsManager = marketWsManager,
       _talker = talker,
       _onTriggered = onTriggered;

  final AlertsRepository _repo;
  final MarketWsManager _wsManager;
  final Talker _talker;
  final AlertTriggeredCallback _onTriggered;

  /// Last-seen price per symbol (lowercase key) for crossing detection.
  final Map<String, Decimal> _lastPrices = {};

  /// Current set of enabled, untriggered alerts — kept in sync via
  /// [watchEnabled].
  List<PriceAlert> _activeAlerts = const [];

  /// Symbols the evaluator has subscribed to via [MarketWsManager].
  final Set<String> _subscribedSymbols = {};

  StreamSubscription<List<PriceAlert>>? _alertsSub;
  StreamSubscription<Ticker24h>? _tickerSub;

  bool _running = false;

  bool get isRunning => _running;

  /// Start listening to enabled alerts and the ticker stream.
  void start() {
    if (_running) return;
    _running = true;
    _talker.info('AlertEvaluator: started');

    _alertsSub = _repo.watchEnabled().listen(
      _onAlertsUpdate,
      onError: (Object err) {
        _talker.error('AlertEvaluator: watchEnabled error', err);
      },
    );

    _tickerSub = _wsManager.tickerStream.listen(
      _onTicker,
      onError: (Object err) {
        _talker.error('AlertEvaluator: tickerStream error', err);
      },
    );
  }

  /// Stop the evaluator and clear internal state.
  void stop() {
    if (!_running) return;
    _running = false;

    _alertsSub?.cancel();
    _alertsSub = null;
    _tickerSub?.cancel();
    _tickerSub = null;

    _lastPrices.clear();
    _activeAlerts = const [];
    _subscribedSymbols.clear();

    _talker.info('AlertEvaluator: stopped');
  }

  void dispose() => stop();

  // -----------------------------------------------------------------
  // Internal handlers
  // -----------------------------------------------------------------

  void _onAlertsUpdate(List<PriceAlert> alerts) {
    _activeAlerts = alerts;
    _reconcileSubscriptions(alerts);
  }

  void _onTicker(Ticker24h ticker) {
    final symbol = ticker.symbol.toUpperCase();
    final currentPrice = ticker.lastPrice;
    final previousPrice = _lastPrices[symbol];

    if (previousPrice == null) {
      // First tick — store and skip evaluation.
      _lastPrices[symbol] = currentPrice;
      return;
    }

    for (final alert in _activeAlerts) {
      if (alert.symbol.toUpperCase() != symbol) continue;

      final crossed = switch (alert.direction) {
        AlertDirection.above =>
          previousPrice < alert.targetPrice &&
              currentPrice >= alert.targetPrice,
        AlertDirection.below =>
          previousPrice > alert.targetPrice &&
              currentPrice <= alert.targetPrice,
      };

      if (crossed) {
        _talker.info(
          'AlertEvaluator: ${alert.symbol} ${alert.direction.name} '
          '${alert.targetPrice} triggered at $currentPrice',
        );
        _onTriggered(alert, currentPrice);
        _repo.markTriggered(alert.id, DateTime.now()).run();
      }
    }

    _lastPrices[symbol] = currentPrice;
  }

  /// Ensure all symbols with active alerts are subscribed for ticker
  /// data. Never unsubscribes — other app components may be listening.
  void _reconcileSubscriptions(List<PriceAlert> alerts) {
    for (final alert in alerts) {
      final key = alert.symbol.toLowerCase();
      if (_subscribedSymbols.contains(key)) continue;

      _subscribedSymbols.add(key);
      _wsManager.subscribe(alert.symbol, const {
        StreamType.ticker,
      }, market: alert.market);
    }
  }
}
