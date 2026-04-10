// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'futures_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FuturesOrder _$FuturesOrderFromJson(
  Map<String, dynamic> json,
) => _FuturesOrder(
  symbol: json['symbol'] as String,
  orderId: (json['orderId'] as num).toInt(),
  clientOrderId: json['clientOrderId'] as String,
  price: const DecimalConverter().fromJson(json['price'] as Object),
  origQty: const DecimalConverter().fromJson(json['origQty'] as Object),
  executedQty: const DecimalConverter().fromJson(json['executedQty'] as Object),
  cumQuote: const DecimalConverter().fromJson(json['cumQuote'] as Object),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  type: $enumDecode(_$OrderTypeEnumMap, json['type']),
  side: $enumDecode(_$OrderSideEnumMap, json['side']),
  timeInForce: $enumDecodeNullable(_$TimeInForceEnumMap, json['timeInForce']),
  stopPrice: _$JsonConverterFromJson<Object, Decimal>(
    json['stopPrice'],
    const DecimalConverter().fromJson,
  ),
  activatePrice: _$JsonConverterFromJson<Object, Decimal>(
    json['activatePrice'],
    const DecimalConverter().fromJson,
  ),
  priceRate: const NullableDecimalConverter().fromJson(json['priceRate']),
  reduceOnly: json['reduceOnly'] as bool? ?? false,
  closePosition: json['closePosition'] as bool? ?? false,
  positionSide: json['positionSide'] as String?,
  workingType: json['workingType'] as String?,
  priceProtect: json['priceProtect'] as bool? ?? false,
  time: (json['time'] as num).toInt(),
  updateTime: (json['updateTime'] as num).toInt(),
);

Map<String, dynamic> _$FuturesOrderToJson(_FuturesOrder instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'orderId': instance.orderId,
      'clientOrderId': instance.clientOrderId,
      'price': const DecimalConverter().toJson(instance.price),
      'origQty': const DecimalConverter().toJson(instance.origQty),
      'executedQty': const DecimalConverter().toJson(instance.executedQty),
      'cumQuote': const DecimalConverter().toJson(instance.cumQuote),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'type': _$OrderTypeEnumMap[instance.type]!,
      'side': _$OrderSideEnumMap[instance.side]!,
      'timeInForce': _$TimeInForceEnumMap[instance.timeInForce],
      'stopPrice': _$JsonConverterToJson<Object, Decimal>(
        instance.stopPrice,
        const DecimalConverter().toJson,
      ),
      'activatePrice': _$JsonConverterToJson<Object, Decimal>(
        instance.activatePrice,
        const DecimalConverter().toJson,
      ),
      'priceRate': const NullableDecimalConverter().toJson(instance.priceRate),
      'reduceOnly': instance.reduceOnly,
      'closePosition': instance.closePosition,
      'positionSide': instance.positionSide,
      'workingType': instance.workingType,
      'priceProtect': instance.priceProtect,
      'time': instance.time,
      'updateTime': instance.updateTime,
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
  OrderType.STOP_MARKET: 'STOP_MARKET',
  OrderType.TAKE_PROFIT_MARKET: 'TAKE_PROFIT_MARKET',
  OrderType.TRAILING_STOP_MARKET: 'TRAILING_STOP_MARKET',
};

const _$OrderSideEnumMap = {OrderSide.BUY: 'BUY', OrderSide.SELL: 'SELL'};

const _$TimeInForceEnumMap = {
  TimeInForce.GTC: 'GTC',
  TimeInForce.IOC: 'IOC',
  TimeInForce.FOK: 'FOK',
  TimeInForce.GTX: 'GTX',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
