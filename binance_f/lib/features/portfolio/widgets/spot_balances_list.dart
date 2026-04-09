import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../data/models/spot_balance.dart';
import '_decimal_format.dart';

/// Sectioned list of non-zero spot balances. Sorted by the repository at
/// fetch time; this widget never re-sorts.
class SpotBalancesList extends StatelessWidget {
  const SpotBalancesList({required this.balances, super.key});

  final List<SpotBalance> balances;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (balances.isEmpty) {
      return _SectionScaffold(
        title: 'Spot balances',
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'No spot balances.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return _SectionScaffold(
      title: 'Spot balances',
      child: Column(
        children: [for (final b in balances) _SpotBalanceRow(balance: b)],
      ),
    );
  }
}

class _SpotBalanceRow extends StatelessWidget {
  const _SpotBalanceRow({required this.balance});

  final SpotBalance balance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              balance.asset,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatDecimal(balance.total),
                  style: theme.textTheme.titleMedium,
                ),
                if (balance.locked > Decimal.zero)
                  Text(
                    'Locked: ${formatDecimal(balance.locked)}',
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

class _SectionScaffold extends StatelessWidget {
  const _SectionScaffold({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const Divider(height: 1),
          child,
        ],
      ),
    );
  }
}
