import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../data/models/ticker_24h.dart';

/// A single row in the symbol list showing the pair name, last price,
/// 24h change percentage, and quote volume.
class SymbolListTile extends StatelessWidget {
  const SymbolListTile({
    super.key,
    required this.symbol,
    required this.baseAsset,
    required this.quoteAsset,
    this.ticker,
    this.onTap,
    this.trailing,
  });

  final String symbol;
  final String baseAsset;
  final String quoteAsset;
  final Ticker24h? ticker;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = ticker;
    final changeColor = t != null && t.isPositive ? Colors.green : Colors.red;

    return ListTile(
      dense: true,
      onTap: onTap,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: baseAsset,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '/$quoteAsset',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      subtitle: t != null
          ? Text(
              'Vol ${_formatVolume(t.quoteVolume)}',
              style: theme.textTheme.bodySmall,
            )
          : null,
      trailing: t != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      t.lastPrice.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: changeColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${t.isPositive ? '+' : ''}'
                        '${t.priceChangePercent.toStringAsFixed(2)}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: changeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (trailing != null) ...[const SizedBox(width: 8), trailing!],
              ],
            )
          : trailing,
    );
  }

  static String _formatVolume(Decimal vol) {
    final d = vol.toDouble();
    if (d >= 1e9) return '${(d / 1e9).toStringAsFixed(1)}B';
    if (d >= 1e6) return '${(d / 1e6).toStringAsFixed(1)}M';
    if (d >= 1e3) return '${(d / 1e3).toStringAsFixed(1)}K';
    return d.toStringAsFixed(2);
  }
}
