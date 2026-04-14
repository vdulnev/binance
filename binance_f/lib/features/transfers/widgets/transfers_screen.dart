import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/env/env_manager.dart';
import 'deposits_tab.dart';
import 'withdrawals_tab.dart';

/// Full-screen view for deposit/withdrawal history and deposit
/// addresses (Phase 10 — FR-8.1, FR-8.2).
///
/// Note: FR-8.2 explicitly forbids any UI for initiating withdrawals.
///
/// The `/sapi/v1/capital/` endpoints are **mainnet-only** — the Binance
/// testnet does not serve them. When connected to testnet this screen
/// shows an informational message instead of making doomed requests.
@RoutePage()
class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTestnet = sl<EnvManager>().current.isTestnet;

    if (isTestnet) {
      return Scaffold(
        appBar: AppBar(title: const Text('Transfers')),
        body: const _TestnetNotice(),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transfers'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Deposits'),
              Tab(text: 'Withdrawals'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DepositsTab(),
            WithdrawalsTab(),
          ],
        ),
      ),
    );
  }
}

class _TestnetNotice extends StatelessWidget {
  const _TestnetNotice();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Not available on testnet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Deposit and withdrawal history is only available '
              'when connected to mainnet.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
