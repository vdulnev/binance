import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../markets/data/market_ws_manager.dart';
import '../data/models/order_book.dart';
import '../data/models/order_book_delta.dart';
import '../data/models/order_book_entry.dart';
import '../data/orderbook_repository.dart';

/// Manages the live order book for a single symbol.
///
/// 1. Fetches a REST depth snapshot on build.
/// 2. Subscribes to the `<symbol>@depth@100ms` WS stream.
/// 3. Merges incoming deltas by update-id continuity.
///
/// Auto-disposes when the symbol detail screen leaves the tree,
/// which also unsubscribes the WS stream.
final orderBookProvider =
    AsyncNotifierProvider.family<OrderBookNotifier, OrderBook, String>(
      OrderBookNotifier.new,
    );

class OrderBookNotifier extends AsyncNotifier<OrderBook> {
  OrderBookNotifier(this._symbol);

  final String _symbol;
  static const _maxLevels = 20;

  @override
  Future<OrderBook> build() async {
    final repo = sl<OrderBookRepository>();
    final wsManager = sl<MarketWsManager>();

    // Subscribe to WS streams for this symbol (depth + ticker + trade).
    await wsManager.subscribe(_symbol, {
      StreamType.depth,
      StreamType.ticker,
      StreamType.trade,
    });
    ref.onDispose(() => wsManager.unsubscribe(_symbol));

    // Fetch REST snapshot.
    final result = await repo.getSnapshot(_symbol, limit: _maxLevels).run();
    final snapshot = result.fold((err) => throw err, (ob) => ob);

    // Listen to depth deltas and merge into the local book.
    final sub = wsManager.depthStream.listen(_onDelta);
    ref.onDispose(sub.cancel);

    return snapshot;
  }

  void _onDelta(OrderBookDelta delta) {
    final current = state.value;
    if (current == null) return;

    // Drop stale events whose final update id is at or before the
    // snapshot's last update id.
    if (delta.finalUpdateId <= current.lastUpdateId) return;

    state = AsyncData(
      current.copyWith(
        lastUpdateId: delta.finalUpdateId,
        bids: _mergeLevels(current.bids, delta.bids, ascending: false),
        asks: _mergeLevels(current.asks, delta.asks, ascending: true),
      ),
    );
  }

  /// Merges delta price levels into the existing book side.
  ///
  /// Levels with zero quantity are removed (Binance convention).
  /// The result is sorted and capped at [_maxLevels].
  List<OrderBookEntry> _mergeLevels(
    List<OrderBookEntry> existing,
    List<OrderBookEntry> updates, {
    required bool ascending,
  }) {
    final map = {for (final e in existing) e.price: e};
    for (final u in updates) {
      if (u.isRemoved) {
        map.remove(u.price);
      } else {
        map[u.price] = u;
      }
    }
    final sorted = map.values.toList()
      ..sort(
        (a, b) =>
            ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price),
      );
    return sorted.take(_maxLevels).toList(growable: false);
  }
}
