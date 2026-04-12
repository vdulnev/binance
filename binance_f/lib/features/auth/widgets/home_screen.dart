import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/env/env.dart';
import '../../../core/env/env_manager.dart';
import '../../../core/router/app_router.dart';
import '../../history/widgets/order_history_tab.dart';
import '../../markets/widgets/markets_tab.dart';
import '../../portfolio/providers/portfolio_provider.dart';
import '../../portfolio/widgets/portfolio_tab.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

/// Shell screen with a bottom navigation bar switching between the
/// Portfolio (Phase 3) and Markets (Phase 4) tabs.
///
/// Auth listener redirects to login on logout. Common actions (env
/// chip, refresh, logout) live in the AppBar; tab-specific content is
/// delegated to [PortfolioTab] and [MarketsTab].
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (_, state) {
      if (state is AuthUnauthenticated) {
        context.router.replaceAll([const LoginRoute()]);
      }
    });

    final env = sl<EnvManager>().current.env;

    final titles = const ['Portfolio', 'Markets', 'History'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(child: _EnvChip(env: env)),
          ),
          if (_currentIndex == 0)
            IconButton(
              key: const ValueKey('portfolio-refresh'),
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => ref.read(portfolioProvider.notifier).refresh(),
            ),
          IconButton(
            key: const ValueKey('portfolio-logout'),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [PortfolioTab(), MarketsTab(), OrderHistoryTab()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
          NavigationDestination(
            icon: Icon(Icons.candlestick_chart_outlined),
            selectedIcon: Icon(Icons.candlestick_chart),
            label: 'Markets',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

/// Compact chip in the AppBar that surfaces which Binance environment the
/// app is currently pointed at.
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
