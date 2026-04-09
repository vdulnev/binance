import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_book_entry.dart';

part 'order_book_delta.freezed.dart';
part 'order_book_delta.g.dart';

/// Incremental depth update received from the `<symbol>@depth@100ms`
/// WebSocket stream.
///
/// The provider uses [firstUpdateId] and [finalUpdateId] to verify
/// continuity against the local order book's [lastUpdateId] before
/// applying the delta.
@Freezed(toJson: true, fromJson: true)
sealed class OrderBookDelta with _$OrderBookDelta {
  const factory OrderBookDelta({
    @JsonKey(name: 'U') required int firstUpdateId,
    @JsonKey(name: 'u') required int finalUpdateId,
    @Default(<OrderBookEntry>[]) List<OrderBookEntry> bids,
    @Default(<OrderBookEntry>[]) List<OrderBookEntry> asks,
  }) = _OrderBookDelta;

  factory OrderBookDelta.fromJson(Map<String, dynamic> json) =>
      _$OrderBookDeltaFromJson(json);
}
