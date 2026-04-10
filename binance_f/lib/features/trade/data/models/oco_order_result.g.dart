// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oco_order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcoOrderResult _$OcoOrderResultFromJson(Map<String, dynamic> json) =>
    _OcoOrderResult(
      orderListId: (json['orderListId'] as num).toInt(),
      listClientOrderId: json['listClientOrderId'] as String,
      symbol: json['symbol'] as String,
      orderReports: (json['orderReports'] as List<dynamic>)
          .map((e) => SpotOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OcoOrderResultToJson(_OcoOrderResult instance) =>
    <String, dynamic>{
      'orderListId': instance.orderListId,
      'listClientOrderId': instance.listClientOrderId,
      'symbol': instance.symbol,
      'orderReports': instance.orderReports,
    };
