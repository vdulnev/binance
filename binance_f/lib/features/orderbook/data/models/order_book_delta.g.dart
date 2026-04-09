// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book_delta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderBookDelta _$OrderBookDeltaFromJson(Map<String, dynamic> json) =>
    _OrderBookDelta(
      firstUpdateId: (json['U'] as num).toInt(),
      finalUpdateId: (json['u'] as num).toInt(),
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

Map<String, dynamic> _$OrderBookDeltaToJson(_OrderBookDelta instance) =>
    <String, dynamic>{
      'U': instance.firstUpdateId,
      'u': instance.finalUpdateId,
      'bids': instance.bids,
      'asks': instance.asks,
    };
