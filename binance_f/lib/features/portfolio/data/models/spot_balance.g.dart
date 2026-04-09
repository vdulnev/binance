// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotBalance _$SpotBalanceFromJson(Map<String, dynamic> json) => _SpotBalance(
  asset: json['asset'] as String,
  free: const DecimalConverter().fromJson(json['free'] as Object),
  locked: const DecimalConverter().fromJson(json['locked'] as Object),
);

Map<String, dynamic> _$SpotBalanceToJson(_SpotBalance instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'free': const DecimalConverter().toJson(instance.free),
      'locked': const DecimalConverter().toJson(instance.locked),
    };
