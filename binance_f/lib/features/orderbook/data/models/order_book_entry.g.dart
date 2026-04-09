// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderBookEntry _$OrderBookEntryFromJson(Map<String, dynamic> json) =>
    _OrderBookEntry(
      price: const DecimalConverter().fromJson(json['price'] as Object),
      quantity: const DecimalConverter().fromJson(json['quantity'] as Object),
    );

Map<String, dynamic> _$OrderBookEntryToJson(_OrderBookEntry instance) =>
    <String, dynamic>{
      'price': const DecimalConverter().toJson(instance.price),
      'quantity': const DecimalConverter().toJson(instance.quantity),
    };
