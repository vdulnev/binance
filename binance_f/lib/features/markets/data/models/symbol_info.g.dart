// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SymbolInfo _$SymbolInfoFromJson(Map<String, dynamic> json) => _SymbolInfo(
  symbol: json['symbol'] as String,
  baseAsset: json['baseAsset'] as String,
  quoteAsset: json['quoteAsset'] as String,
  status: json['status'] as String,
  market: json['market'] as String,
  filters:
      (json['filters'] as List<dynamic>?)
          ?.map((e) => SymbolFilter.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SymbolFilter>[],
);

Map<String, dynamic> _$SymbolInfoToJson(_SymbolInfo instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'baseAsset': instance.baseAsset,
      'quoteAsset': instance.quoteAsset,
      'status': instance.status,
      'market': instance.market,
      'filters': instance.filters,
    };
