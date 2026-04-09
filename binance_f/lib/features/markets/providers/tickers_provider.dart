import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../data/market_ws_manager.dart';
import '../data/markets_repository.dart';
import '../data/models/ticker_24h.dart';

/// Provides a map of `symbol -> Ticker24h` for a given market, initially
/// loaded via REST and then continuously updated from the WS ticker
/// stream.
///
/// The family parameter is the market string: `'spot'` or `'futures'`.
final tickersProvider =
    AsyncNotifierProvider.family<
      TickersNotifier,
      Map<String, Ticker24h>,
      String
    >(TickersNotifier.new);

class TickersNotifier extends AsyncNotifier<Map<String, Ticker24h>> {
  TickersNotifier(this._market);

  final String _market;
  late MarketsRepository _repo;
  late MarketWsManager _wsManager;
  StreamSubscription<Ticker24h>? _sub;

  @override
  Future<Map<String, Ticker24h>> build() async {
    _repo = sl<MarketsRepository>();
    _wsManager = sl<MarketWsManager>();

    ref.onDispose(() {
      _sub?.cancel();
      _sub = null;
    });

    final result = await _repo.get24hTickers(market: _market).run();
    final tickers = result.fold(
      (err) => throw err,
      (list) => {for (final t in list) t.symbol: t},
    );

    // Start listening to WS ticker updates and merge them in.
    _sub = _wsManager.tickerStream.listen(_onWsTicker);

    return tickers;
  }

  void _onWsTicker(Ticker24h update) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData({...current, update.symbol: update});
  }

  /// Re-fetch from REST. Called by pull-to-refresh.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.get24hTickers(market: _market).run();
      return result.fold(
        (err) => throw err,
        (list) => {for (final t in list) t.symbol: t},
      );
    });
  }
}
