// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecentTrade _$RecentTradeFromJson(Map<String, dynamic> json) => _RecentTrade(
  id: (json['id'] as num).toInt(),
  price: const DecimalConverter().fromJson(json['price'] as Object),
  qty: const DecimalConverter().fromJson(json['qty'] as Object),
  time: (json['time'] as num).toInt(),
  isBuyerMaker: json['isBuyerMaker'] as bool,
);

Map<String, dynamic> _$RecentTradeToJson(_RecentTrade instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': const DecimalConverter().toJson(instance.price),
      'qty': const DecimalConverter().toJson(instance.qty),
      'time': instance.time,
      'isBuyerMaker': instance.isBuyerMaker,
    };
