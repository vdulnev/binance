// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceFilter _$PriceFilterFromJson(Map<String, dynamic> json) => PriceFilter(
  minPrice: const DecimalConverter().fromJson(json['minPrice'] as Object),
  maxPrice: const DecimalConverter().fromJson(json['maxPrice'] as Object),
  tickSize: const DecimalConverter().fromJson(json['tickSize'] as Object),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PriceFilterToJson(PriceFilter instance) =>
    <String, dynamic>{
      'minPrice': const DecimalConverter().toJson(instance.minPrice),
      'maxPrice': const DecimalConverter().toJson(instance.maxPrice),
      'tickSize': const DecimalConverter().toJson(instance.tickSize),
      'runtimeType': instance.$type,
    };

LotSize _$LotSizeFromJson(Map<String, dynamic> json) => LotSize(
  minQty: const DecimalConverter().fromJson(json['minQty'] as Object),
  maxQty: const DecimalConverter().fromJson(json['maxQty'] as Object),
  stepSize: const DecimalConverter().fromJson(json['stepSize'] as Object),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$LotSizeToJson(LotSize instance) => <String, dynamic>{
  'minQty': const DecimalConverter().toJson(instance.minQty),
  'maxQty': const DecimalConverter().toJson(instance.maxQty),
  'stepSize': const DecimalConverter().toJson(instance.stepSize),
  'runtimeType': instance.$type,
};

MinNotional _$MinNotionalFromJson(Map<String, dynamic> json) => MinNotional(
  minNotional: const DecimalConverter().fromJson(json['minNotional'] as Object),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$MinNotionalToJson(MinNotional instance) =>
    <String, dynamic>{
      'minNotional': const DecimalConverter().toJson(instance.minNotional),
      'runtimeType': instance.$type,
    };

SymbolFilterOther _$SymbolFilterOtherFromJson(Map<String, dynamic> json) =>
    SymbolFilterOther(
      filterType: json['filterType'] as String,
      raw: json['raw'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SymbolFilterOtherToJson(SymbolFilterOther instance) =>
    <String, dynamic>{
      'filterType': instance.filterType,
      'raw': instance.raw,
      'runtimeType': instance.$type,
    };
