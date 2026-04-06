// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) => _AccountInfo(
  uid: (json['uid'] as num).toInt(),
  accountType: json['accountType'] as String,
  canTrade: json['canTrade'] as bool,
  canWithdraw: json['canWithdraw'] as bool,
  canDeposit: json['canDeposit'] as bool,
  balances: (json['balances'] as List<dynamic>)
      .map((e) => Balance.fromJson(e as Map<String, dynamic>))
      .toList(),
  commissionRates: CommissionRates.fromJson(
    json['commissionRates'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AccountInfoToJson(_AccountInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'accountType': instance.accountType,
      'canTrade': instance.canTrade,
      'canWithdraw': instance.canWithdraw,
      'canDeposit': instance.canDeposit,
      'balances': instance.balances,
      'commissionRates': instance.commissionRates,
    };

_Balance _$BalanceFromJson(Map<String, dynamic> json) => _Balance(
  asset: json['asset'] as String,
  free: json['free'] as String,
  locked: json['locked'] as String,
);

Map<String, dynamic> _$BalanceToJson(_Balance instance) => <String, dynamic>{
  'asset': instance.asset,
  'free': instance.free,
  'locked': instance.locked,
};

_CommissionRates _$CommissionRatesFromJson(Map<String, dynamic> json) =>
    _CommissionRates(
      maker: json['maker'] as String,
      taker: json['taker'] as String,
      buyer: json['buyer'] as String,
      seller: json['seller'] as String,
    );

Map<String, dynamic> _$CommissionRatesToJson(_CommissionRates instance) =>
    <String, dynamic>{
      'maker': instance.maker,
      'taker': instance.taker,
      'buyer': instance.buyer,
      'seller': instance.seller,
    };
