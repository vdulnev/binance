// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_account_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotAccountSnapshot _$SpotAccountSnapshotFromJson(Map<String, dynamic> json) =>
    _SpotAccountSnapshot(
      fetchedAt: DateTime.parse(json['fetchedAt'] as String),
      balances: (json['balances'] as List<dynamic>)
          .map((e) => SpotBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      commissionRates: (json['commissionRates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$SpotAccountSnapshotToJson(
  _SpotAccountSnapshot instance,
) => <String, dynamic>{
  'fetchedAt': instance.fetchedAt.toIso8601String(),
  'balances': instance.balances,
  'commissionRates': instance.commissionRates,
};
