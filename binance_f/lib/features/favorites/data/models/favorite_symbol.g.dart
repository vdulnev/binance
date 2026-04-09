// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_symbol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteSymbol _$FavoriteSymbolFromJson(Map<String, dynamic> json) =>
    _FavoriteSymbol(
      symbol: json['symbol'] as String,
      market: json['market'] as String,
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$FavoriteSymbolToJson(_FavoriteSymbol instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'market': instance.market,
      'position': instance.position,
    };
