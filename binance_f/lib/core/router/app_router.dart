import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/alerts/widgets/alerts_screen.dart';
import '../../features/auth/widgets/home_screen.dart';
import '../../features/auth/widgets/login_screen.dart';
import '../../features/history/widgets/order_history_screen.dart';
import '../../features/symbol/widgets/symbol_detail_screen.dart';
import '../../features/trade/widgets/futures_order_ticket_screen.dart';
import '../../features/trade/widgets/order_ticket_screen.dart';
import '../../features/transfers/widgets/transfers_screen.dart';
import 'root_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootRoute.page,
      initial: true,
      children: [
        AutoRoute(page: LoginRoute.page, path: 'login'),
        AutoRoute(page: HomeRoute.page, path: ''),
        AutoRoute(page: SymbolDetailRoute.page, path: 'symbol/:symbol'),
        AutoRoute(page: OrderTicketRoute.page, path: 'trade/:symbol'),
        AutoRoute(
          page: FuturesOrderTicketRoute.page,
          path: 'futures-trade/:symbol',
        ),
        AutoRoute(page: OrderHistoryRoute.page, path: 'history'),
        AutoRoute(page: AlertsRoute.page, path: 'alerts'),
        AutoRoute(page: TransfersRoute.page, path: 'transfers'),
      ],
    ),
  ];
}
