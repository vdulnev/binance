import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../../account/data/models/account_info.dart';
import '../../account/providers/account_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

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

    final account = ref.watch(accountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Binance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => ref.read(accountProvider.notifier).refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: account.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Failed to load account',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(error.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.read(accountProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (info) => _AccountView(info: info),
      ),
    );
  }
}

class _AccountView extends StatelessWidget {
  const _AccountView({required this.info});

  final AccountInfo info;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nonZeroBalances = info.balances
        .where(
          (b) => double.tryParse(b.free) != 0 || double.tryParse(b.locked) != 0,
        )
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                _InfoRow(label: 'UID', value: info.uid.toString()),
                _InfoRow(label: 'Type', value: info.accountType),
                _InfoRow(
                  label: 'Trading',
                  value: info.canTrade ? 'Enabled' : 'Disabled',
                ),
                _InfoRow(
                  label: 'Withdrawals',
                  value: info.canWithdraw ? 'Enabled' : 'Disabled',
                ),
                _InfoRow(
                  label: 'Deposits',
                  value: info.canDeposit ? 'Enabled' : 'Disabled',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Commission Rates', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'Maker',
                  value: '${info.commissionRates.maker}%',
                ),
                _InfoRow(
                  label: 'Taker',
                  value: '${info.commissionRates.taker}%',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balances (${nonZeroBalances.length})',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                if (nonZeroBalances.isEmpty)
                  const Text('No assets with balance')
                else
                  ...nonZeroBalances.map((b) => _BalanceRow(balance: b)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  const _BalanceRow({required this.balance});

  final Balance balance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locked = double.tryParse(balance.locked) ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(balance.asset, style: theme.textTheme.titleSmall),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(balance.free, style: theme.textTheme.bodyMedium),
                if (locked > 0)
                  Text(
                    'Locked: ${balance.locked}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
