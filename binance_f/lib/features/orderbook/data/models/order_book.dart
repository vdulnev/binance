import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_book_entry.dart';

part 'order_book.freezed.dart';
part 'order_book.g.dart';

/// Full order book snapshot from `GET /api/v3/depth`.
///
/// Bids are sorted descending by price (best bid first), asks ascending
/// (best ask first). The [lastUpdateId] is used by the WS delta merge
/// to verify continuity.
@Freezed(toJson: true, fromJson: true)
sealed class OrderBook with _$OrderBook {
  const OrderBook._();

  const factory OrderBook({
    required String symbol,
    required int lastUpdateId,
    @Default(<OrderBookEntry>[]) List<OrderBookEntry> bids,
    @Default(<OrderBookEntry>[]) List<OrderBookEntry> asks,
  }) = _OrderBook;

  factory OrderBook.fromJson(Map<String, dynamic> json) =>
      _$OrderBookFromJson(json);

  /// Best bid price (top of book), or `null` if empty.
  OrderBookEntry? get bestBid => bids.isNotEmpty ? bids.first : null;

  /// Best ask price (top of book), or `null` if empty.
  OrderBookEntry? get bestAsk => asks.isNotEmpty ? asks.first : null;
}
