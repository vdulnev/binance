// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'futures_asset_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FuturesAssetBalance _$FuturesAssetBalanceFromJson(Map<String, dynamic> json) =>
    _FuturesAssetBalance(
      asset: json['asset'] as String,
      walletBalance: const DecimalConverter().fromJson(
        json['walletBalance'] as Object,
      ),
      unrealizedProfit: const DecimalConverter().fromJson(
        json['unrealizedProfit'] as Object,
      ),
      marginBalance: const DecimalConverter().fromJson(
        json['marginBalance'] as Object,
      ),
      availableBalance: const DecimalConverter().fromJson(
        json['availableBalance'] as Object,
      ),
    );

Map<String, dynamic> _$FuturesAssetBalanceToJson(
  _FuturesAssetBalance instance,
) => <String, dynamic>{
  'asset': instance.asset,
  'walletBalance': const DecimalConverter().toJson(instance.walletBalance),
  'unrealizedProfit': const DecimalConverter().toJson(
    instance.unrealizedProfit,
  ),
  'marginBalance': const DecimalConverter().toJson(instance.marginBalance),
  'availableBalance': const DecimalConverter().toJson(
    instance.availableBalance,
  ),
};
