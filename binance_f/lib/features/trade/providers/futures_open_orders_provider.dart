import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/ws/user_data_event.dart';
import '../../../core/ws/user_data_stream.dart';
import '../data/futures_trade_repository.dart';
import '../data/models/futures_order.dart';

/// Provides the list of open futures orders, initially loaded via REST
/// and kept in sync via the user data stream's ORDER_TRADE_UPDATE events.
final futuresOpenOrdersProvider =
    AsyncNotifierProvider<FuturesOpenOrdersNotifier, List<FuturesOrder>>(
      FuturesOpenOrdersNotifier.new,
    );

class FuturesOpenOrdersNotifier extends AsyncNotifier<List<FuturesOrder>> {
  late FuturesTradeRepository _repo;
  late UserDataStream _userStream;
  StreamSubscription<UserDataEvent>? _sub;

  @override
  Future<List<FuturesOrder>> build() async {
    _repo = sl<FuturesTradeRepository>();
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
    if (event is! FuturesOrderUpdate) return;

    final current = state.value;
    if (current == null) return;

    final order = FuturesOrder(
      symbol: event.symbol,
      orderId: event.orderId,
      clientOrderId: event.clientOrderId,
      price: event.price,
      origQty: event.origQty,
      executedQty: event.executedQty,
      cumQuote: event.cumQuote,
      status: event.status,
      type: event.orderType,
      side: event.side,
      timeInForce: event.timeInForce,
      stopPrice: event.stopPrice,
      activatePrice: event.activatePrice,
      priceRate: event.callbackRate,
      reduceOnly: event.reduceOnly,
      time: event.time,
      updateTime: event.updateTime,
    );

    if (order.isOpen) {
      final updated = current.where((o) => o.orderId != order.orderId).toList()
        ..add(order)
        ..sort((a, b) => b.time.compareTo(a.time));
      state = AsyncData(updated);
    } else {
      state = AsyncData(
        current.where((o) => o.orderId != order.orderId).toList(),
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repo.getOpenOrders().run();
      return result.fold((err) => throw err, (orders) => orders);
    });
  }

  Future<FuturesOrder> cancel({
    required String symbol,
    required int orderId,
  }) async {
    final result = await _repo
        .cancelOrder(symbol: symbol, orderId: orderId)
        .run();
    return result.fold((err) => throw err, (cancelled) {
      final current = state.value ?? const [];
      state = AsyncData(current.where((o) => o.orderId != orderId).toList());
      return cancelled;
    });
  }

  Future<void> cancelAll({required String symbol}) async {
    final result = await _repo.cancelAllOrders(symbol: symbol).run();
    result.fold((err) => throw err, (_) {
      final current = state.value ?? const [];
      state = AsyncData(current.where((o) => o.symbol != symbol).toList());
    });
  }
}
