import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/navigation_provider.dart';
import '../../alerts/widgets/create_alert_dialog.dart';
import '../../favorites/providers/favorites_provider.dart';
import '../../markets/data/models/ticker_24h.dart';
import '../../markets/providers/tickers_provider.dart';
import '../../orderbook/widgets/order_book_widget.dart';
import '../../orderbook/widgets/recent_trades_widget.dart';
import '../../trade/widgets/open_orders_widget.dart';
import '../../chart/widgets/chart_widget.dart';

/// Full-screen detail view for a single trading symbol.
///
/// Shows the live ticker header and two tabs: Order Book and Trades.
/// The order book and trades providers auto-subscribe to the
/// per-symbol WS streams on mount and unsubscribe on dispose.
@RoutePage()
class SymbolDetailScreen extends ConsumerStatefulWidget {
  const SymbolDetailScreen({
    super.key,
    @PathParam('symbol') required this.symbol,
  });

  final String symbol;

  @override
  ConsumerState<SymbolDetailScreen> createState() => _SymbolDetailScreenState();
}

class _SymbolDetailScreenState extends ConsumerState<SymbolDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final symbol = widget.symbol;
    final tickers = ref.watch(tickersProvider('spot'));
    final ticker = tickers.value?[symbol];

    return Scaffold(
      appBar: AppBar(
        title: Text(symbol),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert_outlined),
            tooltip: 'Add price alert',
            onPressed: () =>
                showCreateAlertDialog(context, symbol: symbol, market: 'spot'),
          ),
          _FavoriteToggle(symbol: symbol),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chart'),
            Tab(text: 'Order Book'),
            Tab(text: 'Trades'),
            Tab(text: 'Orders'),
          ],
        ),
      ),
      body: Column(
        children: [
          if (ticker != null) _TickerHeader(ticker: ticker),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ChartWidget(symbol: symbol),
                OrderBookWidget(symbol: symbol),
                RecentTradesWidget(symbol: symbol),
                OpenOrdersWidget(symbol: symbol),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            ref.read(navigationProvider.notifier).pushOrderTicket(symbol),
        icon: const Icon(Icons.add),
        label: const Text('Trade'),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Ticker header
// ------------------------------------------------------------------

class _TickerHeader extends StatelessWidget {
  const _TickerHeader({required this.ticker});

  final Ticker24h ticker;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = ticker.isPositive;
    final changeColor = isPositive ? Colors.green : Colors.red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price + change
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ticker.lastPrice.toString(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isPositive ? '+' : ''}'
                  '${ticker.priceChangePercent.toStringAsFixed(2)}%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: changeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // High / Low / Volume
          Row(
            children: [
              _StatChip(label: 'High', value: ticker.highPrice),
              const SizedBox(width: 16),
              _StatChip(label: 'Low', value: ticker.lowPrice),
              const SizedBox(width: 16),
              _StatChip(label: 'Vol', value: ticker.quoteVolume),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final Decimal value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(value.toString(), style: theme.textTheme.bodySmall),
      ],
    );
  }
}

// ------------------------------------------------------------------
// Favorite toggle
// ------------------------------------------------------------------

class _FavoriteToggle extends ConsumerWidget {
  const _FavoriteToggle({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFav =
        favorites.value?.any((f) => f.symbol == symbol && f.market == 'spot') ??
        false;

    return IconButton(
      icon: Icon(isFav ? Icons.star : Icons.star_border),
      color: isFav ? Colors.amber : null,
      tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
      onPressed: () {
        final notifier = ref.read(favoritesProvider.notifier);
        if (isFav) {
          notifier.remove(symbol, 'spot');
        } else {
          notifier.add(symbol, 'spot');
        }
      },
    );
  }
}
