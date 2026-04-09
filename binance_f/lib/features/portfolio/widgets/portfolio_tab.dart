import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/app_exception.dart';
import '../data/models/portfolio_snapshot.dart';
import '../providers/portfolio_provider.dart';
import 'futures_positions_list.dart';
import 'futures_wallet_list.dart';
import 'portfolio_header.dart';
import 'spot_balances_list.dart';
import 'stale_banner.dart';

/// Portfolio tab body extracted from HomeScreen so the home shell can
/// switch between Portfolio and Markets via a bottom nav.
class PortfolioTab extends ConsumerWidget {
  const PortfolioTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio = ref.watch(portfolioProvider);

    return portfolio.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => _ErrorView(
        error: err,
        onRetry: () => ref.read(portfolioProvider.notifier).refresh(),
      ),
      data: (snapshot) => _PortfolioBody(snapshot: snapshot),
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
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
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
