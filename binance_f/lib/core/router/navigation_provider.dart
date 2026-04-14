import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

final navigationProvider =
    NotifierProvider<NavigationNotifier, List<PageRouteInfo>>(
      NavigationNotifier.new,
    );

class NavigationNotifier extends Notifier<List<PageRouteInfo>> {
  @override
  List<PageRouteInfo> build() => const [];

  void push(PageRouteInfo route) {
    state = [...state, route];
  }

  void pop() {
    if (state.isNotEmpty) {
      state = state.sublist(0, state.length - 1);
    }
  }

  void pushSymbolDetail(String symbol) {
    push(SymbolDetailRoute(symbol: symbol));
  }

  void pushOrderTicket(String symbol) {
    push(OrderTicketRoute(symbol: symbol));
  }

  void pushFuturesOrderTicket(String symbol) {
    push(FuturesOrderTicketRoute(symbol: symbol));
  }

  void pushTransfers() {
    push(const TransfersRoute());
  }

  /// Clears the entire stack (e.g. on logout).
  void clear() {
    state = const [];
  }
}
