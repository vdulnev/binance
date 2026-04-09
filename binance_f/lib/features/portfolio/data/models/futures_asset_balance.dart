import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'futures_asset_balance.freezed.dart';
part 'futures_asset_balance.g.dart';

/// Per-asset futures wallet entry as returned under `assets[]` on
/// `GET /fapi/v2/account`.
///
/// `marginBalance = walletBalance + unrealizedProfit` in Binance's API but
/// we store it verbatim rather than recomputing — Binance is authoritative.
@Freezed(toJson: true, fromJson: true)
sealed class FuturesAssetBalance with _$FuturesAssetBalance {
  const FuturesAssetBalance._();

  const factory FuturesAssetBalance({
    required String asset,
    @DecimalConverter() required Decimal walletBalance,
    @DecimalConverter() required Decimal unrealizedProfit,
    @DecimalConverter() required Decimal marginBalance,
    @DecimalConverter() required Decimal availableBalance,
  }) = _FuturesAssetBalance;

  factory FuturesAssetBalance.fromJson(Map<String, dynamic> json) =>
      _$FuturesAssetBalanceFromJson(json);

  bool get isZero =>
      walletBalance == Decimal.zero &&
      marginBalance == Decimal.zero &&
      availableBalance == Decimal.zero;
}
