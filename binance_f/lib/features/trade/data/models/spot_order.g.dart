// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotOrder _$SpotOrderFromJson(Map<String, dynamic> json) => _SpotOrder(
  symbol: json['symbol'] as String,
  orderId: (json['orderId'] as num).toInt(),
  clientOrderId: json['clientOrderId'] as String,
  price: const DecimalConverter().fromJson(json['price'] as Object),
  origQty: const DecimalConverter().fromJson(json['origQty'] as Object),
  executedQty: const DecimalConverter().fromJson(json['executedQty'] as Object),
  cummulativeQuoteQty: const DecimalConverter().fromJson(
    json['cummulativeQuoteQty'] as Object,
  ),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  type: $enumDecode(_$OrderTypeEnumMap, json['type']),
  side: $enumDecode(_$OrderSideEnumMap, json['side']),
  timeInForce: $enumDecodeNullable(_$TimeInForceEnumMap, json['timeInForce']),
  stopPrice: _$JsonConverterFromJson<Object, Decimal>(
    json['stopPrice'],
    const DecimalConverter().fromJson,
  ),
  orderListId: (json['orderListId'] as num?)?.toInt(),
  time: (json['time'] as num).toInt(),
  updateTime: (json['updateTime'] as num).toInt(),
  fills:
      (json['fills'] as List<dynamic>?)
          ?.map((e) => OrderFill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrderFill>[],
);

Map<String, dynamic> _$SpotOrderToJson(_SpotOrder instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'orderId': instance.orderId,
      'clientOrderId': instance.clientOrderId,
      'price': const DecimalConverter().toJson(instance.price),
      'origQty': const DecimalConverter().toJson(instance.origQty),
      'executedQty': const DecimalConverter().toJson(instance.executedQty),
      'cummulativeQuoteQty': const DecimalConverter().toJson(
        instance.cummulativeQuoteQty,
      ),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'type': _$OrderTypeEnumMap[instance.type]!,
      'side': _$OrderSideEnumMap[instance.side]!,
      'timeInForce': _$TimeInForceEnumMap[instance.timeInForce],
      'stopPrice': _$JsonConverterToJson<Object, Decimal>(
        instance.stopPrice,
        const DecimalConverter().toJson,
      ),
      'orderListId': instance.orderListId,
      'time': instance.time,
      'updateTime': instance.updateTime,
      'fills': instance.fills,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.NEW: 'NEW',
  OrderStatus.PARTIALLY_FILLED: 'PARTIALLY_FILLED',
  OrderStatus.FILLED: 'FILLED',
  OrderStatus.CANCELED: 'CANCELED',
  OrderStatus.PENDING_CANCEL: 'PENDING_CANCEL',
  OrderStatus.REJECTED: 'REJECTED',
  OrderStatus.EXPIRED: 'EXPIRED',
  OrderStatus.EXPIRED_IN_MATCH: 'EXPIRED_IN_MATCH',
};

const _$OrderTypeEnumMap = {
  OrderType.MARKET: 'MARKET',
  OrderType.LIMIT: 'LIMIT',
  OrderType.STOP_LOSS: 'STOP_LOSS',
  OrderType.STOP_LOSS_LIMIT: 'STOP_LOSS_LIMIT',
  OrderType.TAKE_PROFIT: 'TAKE_PROFIT',
  OrderType.TAKE_PROFIT_LIMIT: 'TAKE_PROFIT_LIMIT',
  OrderType.LIMIT_MAKER: 'LIMIT_MAKER',
};

const _$OrderSideEnumMap = {OrderSide.BUY: 'BUY', OrderSide.SELL: 'SELL'};

const _$TimeInForceEnumMap = {
  TimeInForce.GTC: 'GTC',
  TimeInForce.IOC: 'IOC',
  TimeInForce.FOK: 'FOK',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_OrderFill _$OrderFillFromJson(Map<String, dynamic> json) => _OrderFill(
  price: const DecimalConverter().fromJson(json['price'] as Object),
  qty: const DecimalConverter().fromJson(json['qty'] as Object),
  commission: const DecimalConverter().fromJson(json['commission'] as Object),
  commissionAsset: json['commissionAsset'] as String,
  tradeId: (json['tradeId'] as num?)?.toInt(),
);

Map<String, dynamic> _$OrderFillToJson(_OrderFill instance) =>
    <String, dynamic>{
      'price': const DecimalConverter().toJson(instance.price),
      'qty': const DecimalConverter().toJson(instance.qty),
      'commission': const DecimalConverter().toJson(instance.commission),
      'commissionAsset': instance.commissionAsset,
      'tradeId': instance.tradeId,
    };
