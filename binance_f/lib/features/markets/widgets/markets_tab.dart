import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/navigation_provider.dart';
import '../../favorites/data/models/favorite_symbol.dart';
import '../../favorites/providers/favorites_provider.dart';
import '../data/models/symbol_info.dart';
import '../data/models/ticker_24h.dart';
import '../providers/exchange_info_provider.dart';
import '../providers/market_search_provider.dart';
import '../providers/tickers_provider.dart';
import 'symbol_list_tile.dart';

/// Markets tab body with three sub-tabs: Favorites, Spot, and Futures.
/// Includes a search bar that filters all three lists.
class MarketsTab extends ConsumerStatefulWidget {
  const MarketsTab({super.key});

  @override
  ConsumerState<MarketsTab> createState() => _MarketsTabState();
}

class _MarketsTabState extends ConsumerState<MarketsTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search symbols...',
              prefixIcon: Icon(Icons.search),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: (value) =>
                ref.read(marketSearchProvider.notifier).state = value,
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Favorites'),
            Tab(text: 'Spot'),
            Tab(text: 'Futures'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _FavoritesSymbolList(),
              _MarketSymbolList(market: 'spot'),
              _MarketSymbolList(market: 'futures'),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// Favorites sub-tab
// ------------------------------------------------------------------

class _FavoritesSymbolList extends ConsumerWidget {
  const _FavoritesSymbolList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return favorites.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (favs) {
        if (favs.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_border,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  'No favorites yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap the star on any symbol to add it.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }

        final query = ref.watch(marketSearchProvider).toLowerCase();
        final filtered = query.isEmpty
            ? favs
            : favs
                  .where((f) => f.symbol.toLowerCase().contains(query))
                  .toList();

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final fav = filtered[index];
            return _FavoriteRow(fav: fav);
          },
        );
      },
    );
  }
}

class _FavoriteRow extends ConsumerWidget {
  const _FavoriteRow({required this.fav});

  final FavoriteSymbol fav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickers = ref.watch(tickersProvider(fav.market));
    final ticker = tickers.value?[fav.symbol];

    // Look up base/quote from exchange info (cached).
    final symbols = ref.watch(exchangeInfoProvider(fav.market));
    final info = symbols.value
        ?.where((s) => s.symbol == fav.symbol)
        .firstOrNull;

    return SymbolListTile(
      symbol: fav.symbol,
      baseAsset: info?.baseAsset ?? fav.symbol,
      quoteAsset: info?.quoteAsset ?? '',
      ticker: ticker,
      onTap: () =>
          ref.read(navigationProvider.notifier).pushSymbolDetail(fav.symbol),
    );
  }
}

// ------------------------------------------------------------------
// Spot / Futures sub-tab
// ------------------------------------------------------------------

class _MarketSymbolList extends ConsumerWidget {
  const _MarketSymbolList({required this.market});

  final String market;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(exchangeInfoProvider(market));
    final tickers = ref.watch(tickersProvider(market));
    final query = ref.watch(marketSearchProvider).toLowerCase();

    return symbols.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (symbolList) {
        var filtered = symbolList.where((s) => s.isTrading).toList();

        if (query.isNotEmpty) {
          filtered = filtered
              .where(
                (s) =>
                    s.symbol.toLowerCase().contains(query) ||
                    s.baseAsset.toLowerCase().contains(query) ||
                    s.quoteAsset.toLowerCase().contains(query),
              )
              .toList();
        }

        // Sort by quote volume descending when tickers are available.
        _sortByVolume(filtered, tickers.value);

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final info = filtered[index];
            final ticker = tickers.value?[info.symbol];
            return SymbolListTile(
              symbol: info.symbol,
              baseAsset: info.baseAsset,
              quoteAsset: info.quoteAsset,
              ticker: ticker,
              onTap: () => ref
                  .read(navigationProvider.notifier)
                  .pushSymbolDetail(info.symbol),
            );
          },
        );
      },
    );
  }

  void _sortByVolume(List<SymbolInfo> list, Map<String, Ticker24h>? tickers) {
    if (tickers == null) return;
    list.sort((a, b) {
      final ta = tickers[a.symbol];
      final tb = tickers[b.symbol];
      if (ta == null && tb == null) return a.symbol.compareTo(b.symbol);
      if (ta == null) return 1;
      if (tb == null) return -1;
      return tb.quoteVolume.compareTo(ta.quoteVolume);
    });
  }
}
