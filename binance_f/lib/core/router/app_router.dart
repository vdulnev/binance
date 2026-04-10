import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/auth/widgets/home_screen.dart';
import '../../features/auth/widgets/login_screen.dart';
import '../../features/symbol/widgets/symbol_detail_screen.dart';
import '../../features/trade/widgets/order_ticket_screen.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required AuthGuard authGuard}) : _authGuard = authGuard;

  final AuthGuard _authGuard;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true, guards: [_authGuard]),
    AutoRoute(
      page: SymbolDetailRoute.page,
      path: '/symbol/:symbol',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: OrderTicketRoute.page,
      path: '/trade/:symbol',
      guards: [_authGuard],
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
  ];
}
