import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/recent_trade.dart';
import '../providers/recent_trades_provider.dart';

/// Displays a scrolling list of recent trades for the given [symbol],
/// updated live via the `<symbol>@trade` WebSocket stream.
class RecentTradesWidget extends ConsumerWidget {
  const RecentTradesWidget({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trades = ref.watch(recentTradesProvider(symbol));

    return trades.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Text(
          'Failed to load trades',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
      data: (list) {
        if (list.isEmpty) {
          return const Center(child: Text('No trades yet'));
        }
        return _TradesList(trades: list);
      },
    );
  }
}

class _TradesList extends StatelessWidget {
  const _TradesList({required this.trades});

  final List<RecentTrade> trades;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(child: Text('Price', style: theme.textTheme.labelSmall)),
              Expanded(
                child: Text(
                  'Qty',
                  textAlign: TextAlign.end,
                  style: theme.textTheme.labelSmall,
                ),
              ),
              Expanded(
                child: Text(
                  'Time',
                  textAlign: TextAlign.end,
                  style: theme.textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: trades.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final trade = trades[index];
              final color = trade.isBuy ? Colors.green : Colors.red;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 3,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        trade.price.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        trade.qty.toStringAsFixed(4),
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _formatTime(trade.timestamp.toLocal()),
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  static String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}
