import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/order_book.dart';
import '../data/models/order_book_entry.dart';
import '../providers/orderbook_provider.dart';

/// Displays a live order book for the given [symbol] — bids on the left,
/// asks on the right, with depth-bar backgrounds indicating relative size.
class OrderBookWidget extends ConsumerWidget {
  const OrderBookWidget({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderBook = ref.watch(orderBookProvider(symbol));

    return orderBook.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Text(
          'Failed to load order book',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
      data: (book) => _OrderBookBody(book: book),
    );
  }
}

class _OrderBookBody extends StatelessWidget {
  const _OrderBookBody({required this.book});

  final OrderBook book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxBidQty = _maxQty(book.bids);
    final maxAskQty = _maxQty(book.asks);
    final levelCount = book.bids.length > book.asks.length
        ? book.bids.length
        : book.asks.length;

    if (levelCount == 0) {
      return const Center(child: Text('No data'));
    }

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Bid',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Price',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall,
                ),
              ),
              Expanded(
                child: Text(
                  'Ask',
                  textAlign: TextAlign.end,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Spread
        if (book.bestAsk != null && book.bestBid != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Spread: ${(book.bestAsk!.price - book.bestBid!.price).toStringAsFixed(2)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        // Levels
        Expanded(
          child: ListView.builder(
            itemCount: levelCount,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final bid = index < book.bids.length ? book.bids[index] : null;
              final ask = index < book.asks.length ? book.asks[index] : null;
              return _LevelRow(
                bid: bid,
                ask: ask,
                maxBidQty: maxBidQty,
                maxAskQty: maxAskQty,
              );
            },
          ),
        ),
      ],
    );
  }

  Decimal _maxQty(List<OrderBookEntry> entries) {
    if (entries.isEmpty) return Decimal.one;
    return entries.fold<Decimal>(
      Decimal.zero,
      (max, e) => e.quantity > max ? e.quantity : max,
    );
  }
}

class _LevelRow extends StatelessWidget {
  const _LevelRow({
    required this.bid,
    required this.ask,
    required this.maxBidQty,
    required this.maxAskQty,
  });

  final OrderBookEntry? bid;
  final OrderBookEntry? ask;
  final Decimal maxBidQty;
  final Decimal maxAskQty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const height = 24.0;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          // Bid quantity (right-aligned, green bar grows from right)
          Expanded(
            child: bid != null
                ? _DepthBar(
                    entry: bid!,
                    maxQty: maxBidQty,
                    color: Colors.green.withAlpha(40),
                    alignment: Alignment.centerRight,
                    textColor: theme.colorScheme.onSurface,
                  )
                : const SizedBox.shrink(),
          ),
          // Bid price
          SizedBox(
            width: 80,
            child: bid != null
                ? Text(
                    bid!.price.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: 4),
          // Ask price
          SizedBox(
            width: 80,
            child: ask != null
                ? Text(
                    ask!.price.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          // Ask quantity (left-aligned, red bar grows from left)
          Expanded(
            child: ask != null
                ? _DepthBar(
                    entry: ask!,
                    maxQty: maxAskQty,
                    color: Colors.red.withAlpha(40),
                    alignment: Alignment.centerLeft,
                    textColor: theme.colorScheme.onSurface,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _DepthBar extends StatelessWidget {
  const _DepthBar({
    required this.entry,
    required this.maxQty,
    required this.color,
    required this.alignment,
    required this.textColor,
  });

  final OrderBookEntry entry;
  final Decimal maxQty;
  final Color color;
  final Alignment alignment;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final fraction = maxQty > Decimal.zero
        ? (entry.quantity / maxQty).toDouble().clamp(0.0, 1.0)
        : 0.0;
    return Stack(
      alignment: alignment,
      children: [
        FractionallySizedBox(
          widthFactor: fraction,
          child: Container(color: color),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            entry.quantity.toStringAsFixed(4),
            style: TextStyle(fontSize: 11, color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
