import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/auth_state.dart';
import 'app_router.dart';
import 'navigation_provider.dart';

@RoutePage()
class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final navStack = ref.watch(navigationProvider);

    return AutoRouter.declarative(
      routes: (_) {
        return switch (authState) {
          AuthAuthenticated() => [const HomeRoute(), ...navStack],
          AuthUnauthenticated() || AuthError() || AuthAuthenticating() => [const LoginRoute()],
          AuthInitial() => <PageRouteInfo>[],
        };
      },
      onPopRoute: (_, _) {
        ref.read(navigationProvider.notifier).pop();
      },
    );
  }
}
