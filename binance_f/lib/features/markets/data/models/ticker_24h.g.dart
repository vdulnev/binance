// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker_24h.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ticker24h _$Ticker24hFromJson(Map<String, dynamic> json) => _Ticker24h(
  symbol: json['symbol'] as String,
  lastPrice: const DecimalConverter().fromJson(json['lastPrice'] as Object),
  priceChange: const DecimalConverter().fromJson(json['priceChange'] as Object),
  priceChangePercent: const DecimalConverter().fromJson(
    json['priceChangePercent'] as Object,
  ),
  volume: const DecimalConverter().fromJson(json['volume'] as Object),
  quoteVolume: const DecimalConverter().fromJson(json['quoteVolume'] as Object),
  highPrice: const DecimalConverter().fromJson(json['highPrice'] as Object),
  lowPrice: const DecimalConverter().fromJson(json['lowPrice'] as Object),
);

Map<String, dynamic> _$Ticker24hToJson(_Ticker24h instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'lastPrice': const DecimalConverter().toJson(instance.lastPrice),
      'priceChange': const DecimalConverter().toJson(instance.priceChange),
      'priceChangePercent': const DecimalConverter().toJson(
        instance.priceChangePercent,
      ),
      'volume': const DecimalConverter().toJson(instance.volume),
      'quoteVolume': const DecimalConverter().toJson(instance.quoteVolume),
      'highPrice': const DecimalConverter().toJson(instance.highPrice),
      'lowPrice': const DecimalConverter().toJson(instance.lowPrice),
    };
