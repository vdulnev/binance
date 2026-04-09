// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kline_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KlineUpdate _$KlineUpdateFromJson(Map<String, dynamic> json) => _KlineUpdate(
  symbol: json['symbol'] as String,
  interval: json['interval'] as String,
  openTime: (json['openTime'] as num).toInt(),
  open: const DecimalConverter().fromJson(json['open'] as Object),
  high: const DecimalConverter().fromJson(json['high'] as Object),
  low: const DecimalConverter().fromJson(json['low'] as Object),
  close: const DecimalConverter().fromJson(json['close'] as Object),
  volume: const DecimalConverter().fromJson(json['volume'] as Object),
  isClosed: json['isClosed'] as bool,
);

Map<String, dynamic> _$KlineUpdateToJson(_KlineUpdate instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'interval': instance.interval,
      'openTime': instance.openTime,
      'open': const DecimalConverter().toJson(instance.open),
      'high': const DecimalConverter().toJson(instance.high),
      'low': const DecimalConverter().toJson(instance.low),
      'close': const DecimalConverter().toJson(instance.close),
      'volume': const DecimalConverter().toJson(instance.volume),
      'isClosed': instance.isClosed,
    };
