import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/env/env.dart';
import '../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

/// Phase 1 placeholder home screen. Real account / portfolio UI lands in
/// Phase 2 (`AccountRepository`, `accountProvider`, balances list).
@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (_, state) {
      if (state is AuthUnauthenticated) {
        context.router.replaceAll([const LoginRoute()]);
      }
    });

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 64,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text('Connected', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Environment: ${Env.current.env.name}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                'Phase 1 complete. Account and trading screens land in '
                'Phase 2.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
