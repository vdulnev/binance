import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'futures_position.freezed.dart';
part 'futures_position.g.dart';

/// Open USDⓈ-M futures position as returned by `GET /fapi/v2/account` under
/// `positions[]`.
///
/// Binance returns every symbol the account has ever touched, even when
/// `positionAmt == 0`. The repository filters those out before the model is
/// emitted to the rest of the app.
@Freezed(toJson: true, fromJson: true)
sealed class FuturesPosition with _$FuturesPosition {
  const FuturesPosition._();

  const factory FuturesPosition({
    required String symbol,
    @DecimalConverter() required Decimal positionAmt,
    @DecimalConverter() required Decimal entryPrice,
    @DecimalConverter() required Decimal unrealizedProfit,
    @NullableDecimalConverter() Decimal? liquidationPrice,
    @DecimalConverter() required Decimal leverage,
    required String marginType,
  }) = _FuturesPosition;

  factory FuturesPosition.fromJson(Map<String, dynamic> json) =>
      _$FuturesPositionFromJson(json);

  bool get isOpen => positionAmt != Decimal.zero;

  /// Net side of the position based on `positionAmt` sign.
  ///
  /// Binance encodes LONG as positive and SHORT as negative in one-way
  /// mode. In hedge mode the same convention applies within each side of
  /// the ledger.
  bool get isLong => positionAmt > Decimal.zero;
}
