import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/ws/user_data_event.dart';
import '../../../core/ws/user_data_stream.dart';
import '../data/models/spot_order.dart';
import '../data/spot_trade_repository.dart';

/// Provides the list of open spot orders, initially loaded via REST and
/// kept in sync via the user data stream's `executionReport` events.
final openOrdersProvider =
    AsyncNotifierProvider<OpenOrdersNotifier, List<SpotOrder>>(
      OpenOrdersNotifier.new,
    );

class OpenOrdersNotifier extends AsyncNotifier<List<SpotOrder>> {
  late SpotTradeRepository _repo;
  late UserDataStream _userStream;
  StreamSubscription<UserDataEvent>? _sub;

  @override
  Future<List<SpotOrder>> build() async {
    _repo = sl<SpotTradeRepository>();
    _userStream = sl<UserDataStream>();

    ref.onDispose(() {
      _sub?.cancel();
      _sub = null;
    });

    _sub = _userStream.events.listen(_onUserEvent);

    final result = await _repo.getOpenOrders().run();
    return result.fold((err) => throw err, (orders) => orders);
  }

  void _onUserEvent(UserDataEvent event) {
    if (event is! SpotOrderUpdate) return;

    final current = state.value;
    if (current == null) return;

    final order = SpotOrder(
      symbol: event.symbol,
      orderId: event.orderId,
      clientOrderId: event.clientOrderId,
      price: event.price,
      origQty: event.origQty,
      executedQty: event.executedQty,
      cummulativeQuoteQty: event.cummulativeQuoteQty,
      status: event.status,
      type: event.orderType,
      side: event.side,
      timeInForce: event.timeInForce,
      stopPrice: event.stopPrice,
      time: event.time,
      updateTime: event.updateTime,
    );

    if (order.isOpen) {
      // Upsert: replace existing or add new.
      final updated = current.where((o) => o.orderId != order.orderId).toList()
        ..add(order)
        ..sort((a, b) => b.time.compareTo(a.time));
      state = AsyncData(updated);
    } else {
      // Remove closed / cancelled / filled orders.
      state = AsyncData(
        current.where((o) => o.orderId != order.orderId).toList(),
      );
    }
  }

  /// Full refresh from REST. Called after placing/cancelling to ensure
  /// consistency in case a WS event was missed.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.getOpenOrders().run();
      return result.fold((err) => throw err, (orders) => orders);
    });
  }

  /// Cancel a single order. Returns the cancelled order on success.
  Future<SpotOrder> cancel({
    required String symbol,
    required int orderId,
  }) async {
    final result = await _repo
        .cancelOrder(symbol: symbol, orderId: orderId)
        .run();
    return result.fold((err) => throw err, (cancelled) {
      // Optimistic remove — the WS event will also fire, but this
      // gives instant UI feedback.
      final current = state.value ?? const [];
      state = AsyncData(current.where((o) => o.orderId != orderId).toList());
      return cancelled;
    });
  }

  /// Cancel all open orders for a symbol.
  Future<List<SpotOrder>> cancelAll({required String symbol}) async {
    final result = await _repo.cancelAllOrders(symbol: symbol).run();
    return result.fold((err) => throw err, (cancelled) {
      final current = state.value ?? const [];
      final cancelledIds = cancelled.map((o) => o.orderId).toSet();
      state = AsyncData(
        current.where((o) => !cancelledIds.contains(o.orderId)).toList(),
      );
      return cancelled;
    });
  }
}
