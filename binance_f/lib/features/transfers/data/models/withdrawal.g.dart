// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Withdrawal _$WithdrawalFromJson(Map<String, dynamic> json) => _Withdrawal(
  id: json['id'] as String,
  amount: const DecimalConverter().fromJson(json['amount'] as Object),
  transactionFee: const DecimalConverter().fromJson(
    json['transactionFee'] as Object,
  ),
  coin: json['coin'] as String,
  network: json['network'] as String,
  status: (json['status'] as num).toInt(),
  address: json['address'] as String,
  addressTag: json['addressTag'] as String?,
  txId: json['txId'] as String,
  applyTime: json['applyTime'] as String,
);
