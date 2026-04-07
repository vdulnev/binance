import 'package:decimal/decimal.dart';

import '../../../core/models/app_exception.dart';
import 'models/symbol_filters.dart';

/// Validates an order's price + quantity against the cached `exchangeInfo`
/// filters for the symbol. Throws an [AppException.filterViolation] on the
/// first failure (Binance also surfaces only the first violation).
///
/// Per spec FR-5.3 + EC-8: this MUST run before any signed `POST /order`,
/// so the user gets a typed, human-readable error before we burn an order
/// weight on a doomed request.
void validateOrder({
  required SymbolFilters filters,
  required Decimal price,
  required Decimal quantity,
}) {
  final symbol = filters.symbol;

  // PRICE_FILTER — tick size and bounds.
  if (filters.minPrice != null && price < filters.minPrice!) {
    throw AppException.filterViolation(
      filter: 'PRICE_FILTER',
      message: 'Price $price is below the minimum ${filters.minPrice}.',
      symbol: symbol,
    );
  }
  if (filters.maxPrice != null && price > filters.maxPrice!) {
    throw AppException.filterViolation(
      filter: 'PRICE_FILTER',
      message: 'Price $price is above the maximum ${filters.maxPrice}.',
      symbol: symbol,
    );
  }
  if (!_isMultipleOf(price, filters.tickSize)) {
    throw AppException.filterViolation(
      filter: 'PRICE_FILTER',
      message:
          'Price $price is not a multiple of tick size ${filters.tickSize}.',
      symbol: symbol,
    );
  }

  // LOT_SIZE — step, min, max.
  if (quantity < filters.minQty) {
    throw AppException.filterViolation(
      filter: 'LOT_SIZE',
      message:
          'Quantity $quantity is below the minimum lot size ${filters.minQty}.',
      symbol: symbol,
    );
  }
  if (filters.maxQty != null && quantity > filters.maxQty!) {
    throw AppException.filterViolation(
      filter: 'LOT_SIZE',
      message:
          'Quantity $quantity exceeds the maximum lot size ${filters.maxQty}.',
      symbol: symbol,
    );
  }
  if (!_isMultipleOf(quantity, filters.stepSize)) {
    throw AppException.filterViolation(
      filter: 'LOT_SIZE',
      message:
          'Quantity $quantity is not a multiple of step size ${filters.stepSize}.',
      symbol: symbol,
    );
  }

  // MIN_NOTIONAL — price * quantity must be >= minNotional.
  final notional = price * quantity;
  if (notional < filters.minNotional) {
    throw AppException.filterViolation(
      filter: 'MIN_NOTIONAL',
      message:
          'Order notional $notional is below the minimum '
          '${filters.minNotional}.',
      symbol: symbol,
    );
  }
}

/// True when [value] is an exact (decimal) multiple of [step]. We compare
/// against `Decimal.zero` rather than using `%` directly because `Decimal`'s
/// modulo on tiny step sizes is exact and unambiguous.
bool _isMultipleOf(Decimal value, Decimal step) {
  if (step == Decimal.zero) return true;
  final ratio = (value / step).toDecimal(scaleOnInfinitePrecision: 20);
  return ratio == ratio.truncate();
}
