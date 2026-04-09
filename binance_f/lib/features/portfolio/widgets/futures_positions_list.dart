import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../data/models/futures_position.dart';
import '_decimal_format.dart';

/// Binance brand colors — used everywhere in the app for buy/sell and
/// long/short semantics. Kept as constants here rather than pulled into
/// the theme because these are product-level brand colors, not
/// theme-dependent.
const Color _binanceGreen = Color(0xFF0ECB81);
const Color _binanceRed = Color(0xFFF6465D);

/// Sectioned list of open futures positions.
class FuturesPositionsList extends StatelessWidget {
  const FuturesPositionsList({required this.positions, super.key});

  final List<FuturesPosition> positions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _SectionScaffold(
      title: 'Futures positions',
      child: positions.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No open positions.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : Column(
              children: [
                for (final p in positions) _PositionRow(position: p),
              ],
            ),
    );
  }
}

class _PositionRow extends StatelessWidget {
  const _PositionRow({required this.position});

  final FuturesPosition position;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLong = position.isLong;
    final pnlColor = position.unrealizedProfit >= Decimal.zero
        ? _binanceGreen
        : _binanceRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position.symbol,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${isLong ? "LONG" : "SHORT"} • '
                  '${formatDecimal(position.leverage)}x',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isLong ? _binanceGreen : _binanceRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatDecimal(position.positionAmt),
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  '@ ${formatDecimal(position.entryPrice)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'PnL: ${formatDecimal(position.unrealizedProfit)}',
                  style: theme.textTheme.bodySmall?.copyWith(color: pnlColor),
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
