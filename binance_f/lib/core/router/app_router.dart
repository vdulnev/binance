import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/auth/data/models/two_factor_request.dart';
import '../../features/auth/widgets/home_screen.dart';
import '../../features/auth/widgets/login_screen.dart';
import '../../features/auth/widgets/two_factor_screen.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required AuthGuard authGuard}) : _authGuard = authGuard;

  final AuthGuard _authGuard;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: TwoFactorRoute.page),
    AutoRoute(page: HomeRoute.page, guards: [_authGuard]),
  ];
}
