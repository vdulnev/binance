import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'spot_balance.freezed.dart';
part 'spot_balance.g.dart';

/// A single asset balance on the Binance spot account.
///
/// Mirrors the shape of an entry in the `balances` array on
/// `GET /api/v3/account`. Binance serializes `free` and `locked` as strings
/// to preserve precision; we keep them as [Decimal] throughout the app.
@Freezed(toJson: true, fromJson: true)
sealed class SpotBalance with _$SpotBalance {
  const SpotBalance._();

  const factory SpotBalance({
    required String asset,
    @DecimalConverter() required Decimal free,
    @DecimalConverter() required Decimal locked,
  }) = _SpotBalance;

  factory SpotBalance.fromJson(Map<String, dynamic> json) =>
      _$SpotBalanceFromJson(json);

  /// Total = free + locked. Computed, not persisted.
  Decimal get total => free + locked;

  /// Convenience used by the offline filter to drop zero rows.
  bool get isZero => free == Decimal.zero && locked == Decimal.zero;
}
