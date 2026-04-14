// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Deposit _$DepositFromJson(Map<String, dynamic> json) => _Deposit(
  id: json['id'] as String,
  amount: const DecimalConverter().fromJson(json['amount'] as Object),
  coin: json['coin'] as String,
  network: json['network'] as String,
  status: (json['status'] as num).toInt(),
  address: json['address'] as String,
  addressTag: json['addressTag'] as String?,
  txId: json['txId'] as String,
  insertTime: (json['insertTime'] as num).toInt(),
  confirmTimes: (json['confirmTimes'] as num?)?.toInt(),
  unlockConfirm: (json['unlockConfirm'] as num?)?.toInt(),
);
