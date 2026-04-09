import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/env/env.dart';
import '../../../core/env/env_manager.dart';
import '../../../core/models/app_exception.dart';
import '../../../core/router/app_router.dart';
import '../../portfolio/data/models/portfolio_snapshot.dart';
import '../../portfolio/providers/portfolio_provider.dart';
import '../../portfolio/widgets/futures_positions_list.dart';
import '../../portfolio/widgets/futures_wallet_list.dart';
import '../../portfolio/widgets/portfolio_header.dart';
import '../../portfolio/widgets/spot_balances_list.dart';
import '../../portfolio/widgets/stale_banner.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

/// Phase 3 home screen: portfolio dashboard.
///
/// Watches [portfolioProvider] and renders the loading / error / data
/// states. Business logic (refresh, live updates, caching) lives in the
/// provider. This widget only dispatches actions and renders state.
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

    final portfolio = ref.watch(portfolioProvider);
    final env = sl<EnvManager>().current.env;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(child: _EnvChip(env: env)),
          ),
          IconButton(
            key: const ValueKey('portfolio-refresh'),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () =>
                ref.read(portfolioProvider.notifier).refresh(),
          ),
          IconButton(
            key: const ValueKey('portfolio-logout'),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: portfolio.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => _ErrorView(
          error: err,
          onRetry: () => ref.read(portfolioProvider.notifier).refresh(),
        ),
        data: (snapshot) => _PortfolioBody(snapshot: snapshot),
      ),
    );
  }
}

class _PortfolioBody extends StatelessWidget {
  const _PortfolioBody({required this.snapshot});

  final PortfolioSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (snapshot.stale) const StaleBanner(),
        PortfolioHeader(snapshot: snapshot),
        SpotBalancesList(balances: snapshot.spot.balances),
        FuturesPositionsList(positions: snapshot.futures.positions),
        FuturesWalletList(assets: snapshot.futures.assets),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _messageFor(error),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _messageFor(Object error) {
    if (error is AppException) return error.displayMessage;
    return error.toString();
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
