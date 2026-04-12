import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../core/db/order_history_cache.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/models/app_exception.dart';
import '../../trade/data/models/futures_order.dart';
import '../../trade/data/models/spot_order.dart';
import '../data/order_history_repository.dart';

// -------------------------------------------------------------------
// Unified order wrapper
// -------------------------------------------------------------------

/// Lightweight wrapper so the list widget can render spot + futures
/// orders uniformly without branching on type for every field.
class HistoryOrder {
  const HistoryOrder({
    required this.orderId,
    required this.symbol,
    required this.market,
    required this.side,
    required this.type,
    required this.status,
    required this.origQty,
    required this.executedQty,
    required this.price,
    required this.avgPrice,
    required this.time,
    this.reduceOnly = false,
  });

  factory HistoryOrder.fromSpot(SpotOrder o) => HistoryOrder(
    orderId: o.orderId,
    symbol: o.symbol,
    market: 'spot',
    side: o.side.name,
    type: o.type.name,
    status: o.status.name,
    origQty: o.origQty.toString(),
    executedQty: o.executedQty.toString(),
    price: o.price.toString(),
    avgPrice: o.avgPrice?.toString() ?? '-',
    time: o.createdAt,
  );

  factory HistoryOrder.fromFutures(FuturesOrder o) => HistoryOrder(
    orderId: o.orderId,
    symbol: o.symbol,
    market: 'futures',
    side: o.side.name,
    type: o.type.name,
    status: o.status.name,
    origQty: o.origQty.toString(),
    executedQty: o.executedQty.toString(),
    price: o.price.toString(),
    avgPrice: o.avgPrice?.toString() ?? '-',
    time: o.createdAt,
    reduceOnly: o.reduceOnly,
  );

  final int orderId;
  final String symbol;
  final String market;
  final String side;
  final String type;
  final String status;
  final String origQty;
  final String executedQty;
  final String price;
  final String avgPrice;
  final DateTime time;
  final bool reduceOnly;
}

// -------------------------------------------------------------------
// Provider state
// -------------------------------------------------------------------

class OrderHistoryState {
  const OrderHistoryState({required this.orders, this.stale = false});

  static const empty = OrderHistoryState(orders: []);

  final List<HistoryOrder> orders;

  /// True when the data was loaded from cache (offline / network error).
  final bool stale;
}

// -------------------------------------------------------------------
// Provider
// -------------------------------------------------------------------

final orderHistoryProvider =
    AsyncNotifierProvider<OrderHistoryNotifier, OrderHistoryState>(
      OrderHistoryNotifier.new,
    );

class OrderHistoryNotifier extends AsyncNotifier<OrderHistoryState> {
  late OrderHistoryRepository _repo;
  late OrderHistoryCache _cache;
  late Talker _talker;

  @override
  Future<OrderHistoryState> build() async {
    _repo = sl<OrderHistoryRepository>();
    _cache = sl<OrderHistoryCache>();
    _talker = sl<Talker>();

    // Start empty — the UI triggers a load when the user selects a symbol.
    return OrderHistoryState.empty;
  }

  /// Fetch order history for the given parameters and push into state.
  Future<void> loadOrders({
    required String symbol,
    required String market,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (market == 'spot') {
        return _loadSpot(symbol, startTime, endTime);
      } else {
        return _loadFutures(symbol, startTime, endTime);
      }
    });
  }

  Future<OrderHistoryState> _loadSpot(
    String symbol,
    DateTime? startTime,
    DateTime? endTime,
  ) async {
    final result = await _repo
        .getSpotOrders(symbol: symbol, startTime: startTime, endTime: endTime)
        .run();

    return result.fold(
      (err) async {
        _talker.warning(
          'OrderHistory: spot fetch failed, falling back to cache',
          err,
        );
        final cached = await _cache
            .loadSpotOrders(
              symbol: symbol,
              startTime: startTime,
              endTime: endTime,
            )
            .run();
        return cached.fold((_) => throw err, (orders) {
          if (orders.isEmpty && err is! NetworkException) throw err;
          return OrderHistoryState(
            orders: orders.map(HistoryOrder.fromSpot).toList(),
            stale: true,
          );
        });
      },
      (orders) async {
        await _cache.saveSpotOrders(orders).run();
        return OrderHistoryState(
          orders: orders.map(HistoryOrder.fromSpot).toList(),
        );
      },
    );
  }

  Future<OrderHistoryState> _loadFutures(
    String symbol,
    DateTime? startTime,
    DateTime? endTime,
  ) async {
    final result = await _repo
        .getFuturesOrders(
          symbol: symbol,
          startTime: startTime,
          endTime: endTime,
        )
        .run();

    return result.fold(
      (err) async {
        _talker.warning(
          'OrderHistory: futures fetch failed, falling back to cache',
          err,
        );
        final cached = await _cache
            .loadFuturesOrders(
              symbol: symbol,
              startTime: startTime,
              endTime: endTime,
            )
            .run();
        return cached.fold((_) => throw err, (orders) {
          if (orders.isEmpty && err is! NetworkException) throw err;
          return OrderHistoryState(
            orders: orders.map(HistoryOrder.fromFutures).toList(),
            stale: true,
          );
        });
      },
      (orders) async {
        await _cache.saveFuturesOrders(orders).run();
        return OrderHistoryState(
          orders: orders.map(HistoryOrder.fromFutures).toList(),
        );
      },
    );
  }
}
