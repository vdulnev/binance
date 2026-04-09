// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'futures_account_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FuturesAccountSnapshot _$FuturesAccountSnapshotFromJson(
  Map<String, dynamic> json,
) => _FuturesAccountSnapshot(
  fetchedAt: DateTime.parse(json['fetchedAt'] as String),
  assets: (json['assets'] as List<dynamic>)
      .map((e) => FuturesAssetBalance.fromJson(e as Map<String, dynamic>))
      .toList(),
  positions: (json['positions'] as List<dynamic>)
      .map((e) => FuturesPosition.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalWalletBalance: const DecimalConverter().fromJson(
    json['totalWalletBalance'] as Object,
  ),
  totalUnrealizedProfit: const DecimalConverter().fromJson(
    json['totalUnrealizedProfit'] as Object,
  ),
  totalMarginBalance: const DecimalConverter().fromJson(
    json['totalMarginBalance'] as Object,
  ),
);

Map<String, dynamic> _$FuturesAccountSnapshotToJson(
  _FuturesAccountSnapshot instance,
) => <String, dynamic>{
  'fetchedAt': instance.fetchedAt.toIso8601String(),
  'assets': instance.assets,
  'positions': instance.positions,
  'totalWalletBalance': const DecimalConverter().toJson(
    instance.totalWalletBalance,
  ),
  'totalUnrealizedProfit': const DecimalConverter().toJson(
    instance.totalUnrealizedProfit,
  ),
  'totalMarginBalance': const DecimalConverter().toJson(
    instance.totalMarginBalance,
  ),
};
