// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'futures_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FuturesPosition _$FuturesPositionFromJson(
  Map<String, dynamic> json,
) => _FuturesPosition(
  symbol: json['symbol'] as String,
  positionAmt: const DecimalConverter().fromJson(json['positionAmt'] as Object),
  entryPrice: const DecimalConverter().fromJson(json['entryPrice'] as Object),
  unrealizedProfit: const DecimalConverter().fromJson(
    json['unrealizedProfit'] as Object,
  ),
  liquidationPrice: const NullableDecimalConverter().fromJson(
    json['liquidationPrice'],
  ),
  leverage: const DecimalConverter().fromJson(json['leverage'] as Object),
  marginType: json['marginType'] as String,
);

Map<String, dynamic> _$FuturesPositionToJson(_FuturesPosition instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'positionAmt': const DecimalConverter().toJson(instance.positionAmt),
      'entryPrice': const DecimalConverter().toJson(instance.entryPrice),
      'unrealizedProfit': const DecimalConverter().toJson(
        instance.unrealizedProfit,
      ),
      'liquidationPrice': const NullableDecimalConverter().toJson(
        instance.liquidationPrice,
      ),
      'leverage': const DecimalConverter().toJson(instance.leverage),
      'marginType': instance.marginType,
    };
