import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'order_book_entry.freezed.dart';
part 'order_book_entry.g.dart';

/// A single price level in the order book (either a bid or an ask).
///
/// Binance represents each level as a two-element array:
/// `["price", "quantity"]`. The custom [fromBinanceList] factory handles
/// that format, while the standard `fromJson` handles map-based
/// (de)serialization for Drift caching.
@Freezed(toJson: true, fromJson: true)
sealed class OrderBookEntry with _$OrderBookEntry {
  const OrderBookEntry._();

  const factory OrderBookEntry({
    @DecimalConverter() required Decimal price,
    @DecimalConverter() required Decimal quantity,
  }) = _OrderBookEntry;

  factory OrderBookEntry.fromJson(Map<String, dynamic> json) =>
      _$OrderBookEntryFromJson(json);

  /// Parse from the Binance `["price", "quantity"]` array format used in
  /// both REST depth snapshots and WS depth frames.
  factory OrderBookEntry.fromBinanceList(List<dynamic> pair) {
    return OrderBookEntry(
      price: Decimal.parse(pair[0].toString()),
      quantity: Decimal.parse(pair[1].toString()),
    );
  }

  /// Whether this level has been removed (quantity is zero).
  bool get isRemoved => quantity == Decimal.zero;
}
