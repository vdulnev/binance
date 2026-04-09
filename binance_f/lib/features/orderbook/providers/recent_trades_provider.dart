import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../markets/data/market_ws_manager.dart';
import '../data/models/recent_trade.dart';
import '../data/orderbook_repository.dart';

/// Provides the most recent trades for a symbol, initially loaded via
/// REST and then updated live from the `<symbol>@trade` WS stream.
///
/// Auto-disposes when the symbol detail screen leaves the tree.
final recentTradesProvider =
    AsyncNotifierProvider.family<
      RecentTradesNotifier,
      List<RecentTrade>,
      String
    >(RecentTradesNotifier.new);

class RecentTradesNotifier extends AsyncNotifier<List<RecentTrade>> {
  RecentTradesNotifier(this._symbol);

  final String _symbol;
  static const _maxTrades = 50;

  @override
  Future<List<RecentTrade>> build() async {
    final repo = sl<OrderBookRepository>();
    final wsManager = sl<MarketWsManager>();

    // Fetch initial trades via REST.
    final result = await repo.getRecentTrades(_symbol, limit: _maxTrades).run();
    final trades = result.fold((err) => throw err, (list) => list);

    // Prepend new trades from the WS stream.
    final sub = wsManager.tradeStream.listen(_onTrade);
    ref.onDispose(sub.cancel);

    return trades;
  }

  void _onTrade(RecentTrade trade) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      [trade, ...current].take(_maxTrades).toList(growable: false),
    );
  }
}
