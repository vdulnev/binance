// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderBook _$OrderBookFromJson(Map<String, dynamic> json) => _OrderBook(
  symbol: json['symbol'] as String,
  lastUpdateId: (json['lastUpdateId'] as num).toInt(),
  bids:
      (json['bids'] as List<dynamic>?)
          ?.map((e) => OrderBookEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrderBookEntry>[],
  asks:
      (json['asks'] as List<dynamic>?)
          ?.map((e) => OrderBookEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrderBookEntry>[],
);

Map<String, dynamic> _$OrderBookToJson(_OrderBook instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'lastUpdateId': instance.lastUpdateId,
      'bids': instance.bids,
      'asks': instance.asks,
    };
