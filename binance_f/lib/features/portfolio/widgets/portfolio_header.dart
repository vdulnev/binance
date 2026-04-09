import 'package:flutter/material.dart';

import '../data/models/portfolio_snapshot.dart';
import '_decimal_format.dart';

/// Large "total portfolio value" card at the top of the portfolio screen.
///
/// Dumb widget — takes a [PortfolioSnapshot] and renders. All loading /
/// error / staleness plumbing lives in `PortfolioScreen`.
class PortfolioHeader extends StatelessWidget {
  const PortfolioHeader({required this.snapshot, super.key});

  final PortfolioSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total value',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Text(
                    formatDecimal(snapshot.totalValueInQuote, maxDecimals: 2),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  snapshot.quoteAsset,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Updated ${_formatTimestamp(snapshot.fetchedAt)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (snapshot.skippedAssets.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Not priced in ${snapshot.quoteAsset}: '
                '${snapshot.skippedAssets.join(", ")}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime t) {
    final local = t.toLocal();
    return '${_two(local.hour)}:${_two(local.minute)}:${_two(local.second)}';
  }

  String _two(int n) => n.toString().padLeft(2, '0');
}
