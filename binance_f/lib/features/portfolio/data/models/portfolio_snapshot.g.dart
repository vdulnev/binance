// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PortfolioSnapshot _$PortfolioSnapshotFromJson(Map<String, dynamic> json) =>
    _PortfolioSnapshot(
      spot: SpotAccountSnapshot.fromJson(json['spot'] as Map<String, dynamic>),
      futures: FuturesAccountSnapshot.fromJson(
        json['futures'] as Map<String, dynamic>,
      ),
      totalValueInQuote: const DecimalConverter().fromJson(
        json['totalValueInQuote'] as Object,
      ),
      quoteAsset: json['quoteAsset'] as String,
      fetchedAt: DateTime.parse(json['fetchedAt'] as String),
      stale: json['stale'] as bool? ?? false,
      skippedAssets:
          (json['skippedAssets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$PortfolioSnapshotToJson(_PortfolioSnapshot instance) =>
    <String, dynamic>{
      'spot': instance.spot,
      'futures': instance.futures,
      'totalValueInQuote': const DecimalConverter().toJson(
        instance.totalValueInQuote,
      ),
      'quoteAsset': instance.quoteAsset,
      'fetchedAt': instance.fetchedAt.toIso8601String(),
      'stale': instance.stale,
      'skippedAssets': instance.skippedAssets,
    };
