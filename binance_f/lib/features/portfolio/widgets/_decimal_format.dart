import 'package:decimal/decimal.dart';

/// Formats a [Decimal] for display by fixing to [maxDecimals] places and
/// trimming trailing zeros. Returns `"0"` for zero.
///
/// Binance never uses scientific notation in its UI for balances so we
/// don't either. `Decimal.toStringAsFixed` gives a canonical rendering
/// which we then strip to the shortest unambiguous form.
String formatDecimal(Decimal value, {int maxDecimals = 8}) {
  if (value == Decimal.zero) return '0';
  final fixed = value.toStringAsFixed(maxDecimals);
  if (!fixed.contains('.')) return fixed;
  var trimmed = fixed;
  while (trimmed.endsWith('0')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  if (trimmed.endsWith('.')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  return trimmed;
}
