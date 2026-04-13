// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PriceAlert _$PriceAlertFromJson(Map<String, dynamic> json) => _PriceAlert(
  id: (json['id'] as num).toInt(),
  symbol: json['symbol'] as String,
  market: json['market'] as String,
  direction: $enumDecode(_$AlertDirectionEnumMap, json['direction']),
  targetPrice: const DecimalConverter().fromJson(json['targetPrice'] as Object),
  enabled: json['enabled'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
  triggeredAt: json['triggeredAt'] == null
      ? null
      : DateTime.parse(json['triggeredAt'] as String),
);

Map<String, dynamic> _$PriceAlertToJson(_PriceAlert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'market': instance.market,
      'direction': _$AlertDirectionEnumMap[instance.direction]!,
      'targetPrice': const DecimalConverter().toJson(instance.targetPrice),
      'enabled': instance.enabled,
      'createdAt': instance.createdAt.toIso8601String(),
      'triggeredAt': instance.triggeredAt?.toIso8601String(),
    };

const _$AlertDirectionEnumMap = {
  AlertDirection.above: 'above',
  AlertDirection.below: 'below',
};
