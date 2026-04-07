import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'symbol_filters.freezed.dart';

/// Minimal subset of Binance `exchangeInfo` per-symbol filters needed for
/// client-side order validation. Phase 4 will flesh this out with the rest of
/// the filter types and a proper JSON parser.
@freezed
sealed class SymbolFilters with _$SymbolFilters {
  const factory SymbolFilters({
    required String symbol,
    required Decimal tickSize,
    required Decimal stepSize,
    required Decimal minQty,
    required Decimal minNotional,
    Decimal? maxQty,
    Decimal? minPrice,
    Decimal? maxPrice,
  }) = _SymbolFilters;
}
