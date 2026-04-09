import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../data/models/futures_asset_balance.dart';
import '_decimal_format.dart';

const Color _binanceGreen = Color(0xFF0ECB81);
const Color _binanceRed = Color(0xFFF6465D);

/// Sectioned list of USDⓈ-M futures wallet balances per asset.
class FuturesWalletList extends StatelessWidget {
  const FuturesWalletList({required this.assets, super.key});

  final List<FuturesAssetBalance> assets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SectionScaffold(
      title: 'Futures wallet',
      child: assets.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No futures assets.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : Column(children: [for (final a in assets) _AssetRow(asset: a)]),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({required this.asset});

  final FuturesAssetBalance asset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pnlColor = asset.unrealizedProfit >= Decimal.zero
        ? _binanceGreen
        : _binanceRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              asset.asset,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Wallet: ${formatDecimal(asset.walletBalance)}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  'Margin: ${formatDecimal(asset.marginBalance)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'PnL: ${formatDecimal(asset.unrealizedProfit)}',
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
