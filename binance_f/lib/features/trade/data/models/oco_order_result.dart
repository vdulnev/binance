import 'package:freezed_annotation/freezed_annotation.dart';

import 'spot_order.dart';

part 'oco_order_result.freezed.dart';
part 'oco_order_result.g.dart';

/// Response from `POST /api/v3/order/oco`.
///
/// Contains the parent order list metadata plus two child orders
/// (limit + stop-limit).
@Freezed(toJson: true, fromJson: true)
sealed class OcoOrderResult with _$OcoOrderResult {
  const factory OcoOrderResult({
    required int orderListId,
    required String listClientOrderId,
    required String symbol,
    required List<SpotOrder> orderReports,
  }) = _OcoOrderResult;

  factory OcoOrderResult.fromJson(Map<String, dynamic> json) =>
      _$OcoOrderResultFromJson(json);
}
