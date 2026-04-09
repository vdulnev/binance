// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_value_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TotalValueResult _$TotalValueResultFromJson(Map<String, dynamic> json) =>
    _TotalValueResult(
      total: const DecimalConverter().fromJson(json['total'] as Object),
      quoteAsset: json['quoteAsset'] as String,
      skippedAssets:
          (json['skippedAssets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$TotalValueResultToJson(_TotalValueResult instance) =>
    <String, dynamic>{
      'total': const DecimalConverter().toJson(instance.total),
      'quoteAsset': instance.quoteAsset,
      'skippedAssets': instance.skippedAssets,
    };
