import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

import '../../../core/di/service_locator.dart';
import '../../markets/data/market_ws_manager.dart';
import '../../markets/data/models/kline_update.dart';
import '../data/chart_repository.dart';

/// Parameters for the chart provider.
class ChartParams {
  const ChartParams({
    required this.symbol,
    required this.market,
    required this.interval,
  });

  final String symbol;
  final String market;
  final String interval;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartParams &&
          runtimeType == other.runtimeType &&
          symbol == other.symbol &&
          market == other.market &&
          interval == other.interval;

  @override
  int get hashCode => symbol.hashCode ^ market.hashCode ^ interval.hashCode;
}

/// Manages the list of candles for a symbol/market/interval.
///
/// 1. Fetches historical klines via REST on build.
/// 2. Subscribes to the `<symbol>@kline_<interval>` WS stream.
/// 3. Updates the last candle or appends a new one on WS event.
/// 4. Recalculates technical indicators via [DataUtil.calculateAll].
final chartProvider =
    AsyncNotifierProvider.family<ChartNotifier, List<KLineEntity>, ChartParams>(
      ChartNotifier.new,
    );

class ChartNotifier extends AsyncNotifier<List<KLineEntity>> {
  ChartNotifier(this._arg);
  final ChartParams _arg;

  final List<MainIndicator<dynamic, dynamic>> _mainIndicators = [
    MAIndicator(calcParams: [7, 25, 99]),
    EMAIndicator(calcParams: [7, 25, 99]),
    BOLLIndicator(),
  ];

  final List<SecondaryIndicator<dynamic, dynamic>> _secondaryIndicators = [
    MACDIndicator(),
    RSIIndicator(),
    KDJIndicator(),
    WRIndicator(),
    CCIIndicator(),
  ];

  @override
  Future<List<KLineEntity>> build() async {
    final repo = sl<ChartRepository>();
    final wsManager = sl<MarketWsManager>();

    // Subscribe to the kline stream for this symbol + interval.
    await wsManager.subscribe(
      _arg.symbol,
      {StreamType.kline},
      klineInterval: _arg.interval,
      market: _arg.market,
    );

    // Unsubscribe when the provider is disposed (e.g. interval change or screen exit).
    ref.onDispose(() => wsManager.unsubscribe(_arg.symbol));

    // Fetch historical klines.
    final result = await repo
        .getKlines(
          symbol: _arg.symbol,
          market: _arg.market,
          interval: _arg.interval,
        )
        .run();

    final klines = result.fold((err) => throw err, (list) => list);

    // Pre-calculate all indicators.
    DataUtil.calculateAll(klines, _mainIndicators, _secondaryIndicators);

    // Listen for real-time updates.
    final sub = wsManager.klineStream.listen(_onKlineUpdate);
    ref.onDispose(sub.cancel);

    return klines;
  }

  void _onKlineUpdate(KlineUpdate update) {
    // Filter events for our symbol and interval.
    if (update.symbol.toUpperCase() != _arg.symbol.toUpperCase() ||
        update.interval != _arg.interval) {
      return;
    }

    final current = state.value;
    if (current == null || current.isEmpty) return;

    final last = current.last;
    final newCandle = KLineEntity.fromCustom(
      open: double.parse(update.open.toString()),
      high: double.parse(update.high.toString()),
      low: double.parse(update.low.toString()),
      close: double.parse(update.close.toString()),
      vol: double.parse(update.volume.toString()),
      time: update.openTime,
    );

    final lastTime = last.time ?? 0;
    final newTime = newCandle.time ?? 0;

    List<KLineEntity> updatedList;
    if (lastTime == newTime) {
      // Update existing last candle.
      updatedList = [...current.sublist(0, current.length - 1), newCandle];
    } else if (newTime > lastTime) {
      // Append new candle.
      updatedList = [...current, newCandle];
    } else {
      // Stale event, ignore.
      return;
    }

    // Recalculate indicators for the whole list.
    DataUtil.calculateAll(updatedList, _mainIndicators, _secondaryIndicators);

    state = AsyncData(updatedList);
  }
}
