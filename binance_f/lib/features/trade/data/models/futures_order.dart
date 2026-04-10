import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';
import 'order_enums.dart';

part 'futures_order.freezed.dart';
part 'futures_order.g.dart';

/// A USDⓈ-M futures order as returned by `GET /fapi/v1/openOrders`,
/// `GET /fapi/v1/order`, or `POST /fapi/v1/order`.
@Freezed(toJson: true, fromJson: true)
sealed class FuturesOrder with _$FuturesOrder {
  const FuturesOrder._();

  const factory FuturesOrder({
    required String symbol,
    required int orderId,
    required String clientOrderId,
    @DecimalConverter() required Decimal price,
    @DecimalConverter() required Decimal origQty,
    @DecimalConverter() required Decimal executedQty,
    @DecimalConverter() required Decimal cumQuote,
    required OrderStatus status,
    required OrderType type,
    required OrderSide side,
    TimeInForce? timeInForce,
    @DecimalConverter() Decimal? stopPrice,
    @DecimalConverter() Decimal? activatePrice,
    @NullableDecimalConverter() Decimal? priceRate,
    @Default(false) bool reduceOnly,
    @Default(false) bool closePosition,
    String? positionSide,
    String? workingType,
    @Default(false) bool priceProtect,
    required int time,
    required int updateTime,
  }) = _FuturesOrder;

  factory FuturesOrder.fromJson(Map<String, dynamic> json) =>
      _$FuturesOrderFromJson(json);

  bool get isOpen =>
      status == OrderStatus.NEW || status == OrderStatus.PARTIALLY_FILLED;

  Decimal? get avgPrice => executedQty > Decimal.zero
      ? (cumQuote / executedQty).toDecimal(scaleOnInfinitePrecision: 8)
      : null;

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(time, isUtc: true);
}
