import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'ticker_24h.freezed.dart';
part 'ticker_24h.g.dart';

/// 24-hour rolling window ticker statistics for a single symbol.
///
/// Parsed from `GET /api/v3/ticker/24hr` (or `/fapi/v1/ticker/24hr`)
/// and also from the `<symbol>@ticker` WebSocket stream.
@Freezed(toJson: true, fromJson: true)
sealed class Ticker24h with _$Ticker24h {
  const Ticker24h._();

  const factory Ticker24h({
    required String symbol,
    @JsonKey(name: 'lastPrice') @DecimalConverter() required Decimal lastPrice,
    @JsonKey(name: 'priceChange')
    @DecimalConverter()
    required Decimal priceChange,
    @JsonKey(name: 'priceChangePercent')
    @DecimalConverter()
    required Decimal priceChangePercent,
    @JsonKey(name: 'volume') @DecimalConverter() required Decimal volume,
    @JsonKey(name: 'quoteVolume')
    @DecimalConverter()
    required Decimal quoteVolume,
    @JsonKey(name: 'highPrice') @DecimalConverter() required Decimal highPrice,
    @JsonKey(name: 'lowPrice') @DecimalConverter() required Decimal lowPrice,
  }) = _Ticker24h;

  factory Ticker24h.fromJson(Map<String, dynamic> json) =>
      _$Ticker24hFromJson(json);

  /// Whether the 24h change is non-negative.
  bool get isPositive => priceChange >= Decimal.zero;
}
