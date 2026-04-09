import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'symbol_filter.freezed.dart';
part 'symbol_filter.g.dart';

/// Sealed union representing exchange filters attached to a symbol in the
/// `GET /api/v3/exchangeInfo` (or `/fapi/v1/exchangeInfo`) response.
///
/// The filters Binance returns that the app needs for client-side order
/// validation are modelled as typed variants. Everything else lands in
/// [SymbolFilterOther] with the raw JSON preserved so later phases can
/// consume them without a model change.
@Freezed(toJson: true, fromJson: true)
sealed class SymbolFilter with _$SymbolFilter {
  const SymbolFilter._();

  @FreezedUnionValue('PRICE_FILTER')
  const factory SymbolFilter.priceFilter({
    @DecimalConverter() required Decimal minPrice,
    @DecimalConverter() required Decimal maxPrice,
    @DecimalConverter() required Decimal tickSize,
  }) = PriceFilter;

  @FreezedUnionValue('LOT_SIZE')
  const factory SymbolFilter.lotSize({
    @DecimalConverter() required Decimal minQty,
    @DecimalConverter() required Decimal maxQty,
    @DecimalConverter() required Decimal stepSize,
  }) = LotSize;

  @FreezedUnionValue('MIN_NOTIONAL')
  const factory SymbolFilter.minNotional({
    @DecimalConverter() required Decimal minNotional,
  }) = MinNotional;

  @FreezedUnionValue('other')
  const factory SymbolFilter.other({
    required String filterType,
    @Default(<String, dynamic>{}) Map<String, dynamic> raw,
  }) = SymbolFilterOther;

  factory SymbolFilter.fromJson(Map<String, dynamic> json) =>
      _symbolFilterFromJson(json);
}

/// Custom parser that maps the Binance `filterType` string to the
/// correct Freezed union variant.
///
/// Binance encodes the discriminator as `filterType` at the top level
/// of each filter object. We map known types to the typed variant and
/// everything else to [SymbolFilterOther].
SymbolFilter _symbolFilterFromJson(Map<String, dynamic> json) {
  final filterType = json['filterType'] as String? ?? '';
  return switch (filterType) {
    'PRICE_FILTER' => PriceFilter(
      minPrice: const DecimalConverter().fromJson(json['minPrice'] as Object),
      maxPrice: const DecimalConverter().fromJson(json['maxPrice'] as Object),
      tickSize: const DecimalConverter().fromJson(json['tickSize'] as Object),
    ),
    'LOT_SIZE' => LotSize(
      minQty: const DecimalConverter().fromJson(json['minQty'] as Object),
      maxQty: const DecimalConverter().fromJson(json['maxQty'] as Object),
      stepSize: const DecimalConverter().fromJson(json['stepSize'] as Object),
    ),
    'MIN_NOTIONAL' || 'NOTIONAL' => MinNotional(
      minNotional: const DecimalConverter().fromJson(
        (json['minNotional'] ?? json['notional'] ?? '0') as Object,
      ),
    ),
    _ => SymbolFilterOther(filterType: filterType, raw: json),
  };
}
