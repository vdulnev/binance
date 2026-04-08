import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/env/env.dart';
import '../../../core/env/env_manager.dart';
import '../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

/// Phase 2 placeholder home screen. Real account / portfolio UI lands in
/// Phase 3 (`AccountRepository`, `accountProvider`, balances list).
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
    final env = sl<EnvManager>().current.env;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binance'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(child: _EnvChip(env: env)),
          ),
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
                'Environment: ${env.name}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                'Phase 2 complete. Account and trading screens land in '
                'Phase 3.',
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

/// Compact chip in the AppBar that surfaces which Binance environment the
/// app is currently pointed at. Testnet uses a tertiary color so a
/// developer can never confuse it with mainnet at a glance.
class _EnvChip extends StatelessWidget {
  const _EnvChip({required this.env});

  final BinanceEnv env;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isTestnet = env == BinanceEnv.testnet;
    final bg = isTestnet ? scheme.tertiaryContainer : scheme.secondaryContainer;
    final fg = isTestnet
        ? scheme.onTertiaryContainer
        : scheme.onSecondaryContainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        env.name.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
