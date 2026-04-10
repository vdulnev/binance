import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';
import 'order_enums.dart';

part 'spot_order.freezed.dart';
part 'spot_order.g.dart';

/// A spot order as returned by `GET /api/v3/openOrders`,
/// `GET /api/v3/order`, or `POST /api/v3/order` (FULL response type).
@Freezed(toJson: true, fromJson: true)
sealed class SpotOrder with _$SpotOrder {
  const SpotOrder._();

  const factory SpotOrder({
    required String symbol,
    required int orderId,
    required String clientOrderId,
    @DecimalConverter() required Decimal price,
    @DecimalConverter() required Decimal origQty,
    @DecimalConverter() required Decimal executedQty,
    @DecimalConverter() required Decimal cummulativeQuoteQty,
    required OrderStatus status,
    required OrderType type,
    required OrderSide side,
    TimeInForce? timeInForce,
    @DecimalConverter() Decimal? stopPrice,
    int? orderListId,
    required int time,
    required int updateTime,
    @Default(<OrderFill>[]) List<OrderFill> fills,
  }) = _SpotOrder;

  factory SpotOrder.fromJson(Map<String, dynamic> json) =>
      _$SpotOrderFromJson(json);

  /// True if this order is still live (can be cancelled).
  bool get isOpen =>
      status == OrderStatus.NEW || status == OrderStatus.PARTIALLY_FILLED;

  /// Average fill price: `cummulativeQuoteQty / executedQty`.
  Decimal? get avgPrice => executedQty > Decimal.zero
      ? (cummulativeQuoteQty / executedQty).toDecimal(
          scaleOnInfinitePrecision: 8,
        )
      : null;

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(time, isUtc: true);
}

/// A single fill entry from the FULL order response.
@Freezed(toJson: true, fromJson: true)
sealed class OrderFill with _$OrderFill {
  const factory OrderFill({
    @DecimalConverter() required Decimal price,
    @DecimalConverter() required Decimal qty,
    @DecimalConverter() required Decimal commission,
    required String commissionAsset,
    int? tradeId,
  }) = _OrderFill;

  factory OrderFill.fromJson(Map<String, dynamic> json) =>
      _$OrderFillFromJson(json);
}
