// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticker_24h.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ticker24h {

 String get symbol;@JsonKey(name: 'lastPrice')@DecimalConverter() Decimal get lastPrice;@JsonKey(name: 'priceChange')@DecimalConverter() Decimal get priceChange;@JsonKey(name: 'priceChangePercent')@DecimalConverter() Decimal get priceChangePercent;@JsonKey(name: 'volume')@DecimalConverter() Decimal get volume;@JsonKey(name: 'quoteVolume')@DecimalConverter() Decimal get quoteVolume;@JsonKey(name: 'highPrice')@DecimalConverter() Decimal get highPrice;@JsonKey(name: 'lowPrice')@DecimalConverter() Decimal get lowPrice;
/// Create a copy of Ticker24h
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Ticker24hCopyWith<Ticker24h> get copyWith => _$Ticker24hCopyWithImpl<Ticker24h>(this as Ticker24h, _$identity);

  /// Serializes this Ticker24h to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticker24h&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.priceChangePercent, priceChangePercent) || other.priceChangePercent == priceChangePercent)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.quoteVolume, quoteVolume) || other.quoteVolume == quoteVolume)&&(identical(other.highPrice, highPrice) || other.highPrice == highPrice)&&(identical(other.lowPrice, lowPrice) || other.lowPrice == lowPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,lastPrice,priceChange,priceChangePercent,volume,quoteVolume,highPrice,lowPrice);

@override
String toString() {
  return 'Ticker24h(symbol: $symbol, lastPrice: $lastPrice, priceChange: $priceChange, priceChangePercent: $priceChangePercent, volume: $volume, quoteVolume: $quoteVolume, highPrice: $highPrice, lowPrice: $lowPrice)';
}


}

/// @nodoc
abstract mixin class $Ticker24hCopyWith<$Res>  {
  factory $Ticker24hCopyWith(Ticker24h value, $Res Function(Ticker24h) _then) = _$Ticker24hCopyWithImpl;
@useResult
$Res call({
 String symbol,@JsonKey(name: 'lastPrice')@DecimalConverter() Decimal lastPrice,@JsonKey(name: 'priceChange')@DecimalConverter() Decimal priceChange,@JsonKey(name: 'priceChangePercent')@DecimalConverter() Decimal priceChangePercent,@JsonKey(name: 'volume')@DecimalConverter() Decimal volume,@JsonKey(name: 'quoteVolume')@DecimalConverter() Decimal quoteVolume,@JsonKey(name: 'highPrice')@DecimalConverter() Decimal highPrice,@JsonKey(name: 'lowPrice')@DecimalConverter() Decimal lowPrice
});




}
/// @nodoc
class _$Ticker24hCopyWithImpl<$Res>
    implements $Ticker24hCopyWith<$Res> {
  _$Ticker24hCopyWithImpl(this._self, this._then);

  final Ticker24h _self;
  final $Res Function(Ticker24h) _then;

/// Create a copy of Ticker24h
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? lastPrice = null,Object? priceChange = null,Object? priceChangePercent = null,Object? volume = null,Object? quoteVolume = null,Object? highPrice = null,Object? lowPrice = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as Decimal,priceChange: null == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as Decimal,priceChangePercent: null == priceChangePercent ? _self.priceChangePercent : priceChangePercent // ignore: cast_nullable_to_non_nullable
as Decimal,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as Decimal,quoteVolume: null == quoteVolume ? _self.quoteVolume : quoteVolume // ignore: cast_nullable_to_non_nullable
as Decimal,highPrice: null == highPrice ? _self.highPrice : highPrice // ignore: cast_nullable_to_non_nullable
as Decimal,lowPrice: null == lowPrice ? _self.lowPrice : lowPrice // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}

}


/// Adds pattern-matching-related methods to [Ticker24h].
extension Ticker24hPatterns on Ticker24h {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticker24h value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticker24h() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticker24h value)  $default,){
final _that = this;
switch (_that) {
case _Ticker24h():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticker24h value)?  $default,){
final _that = this;
switch (_that) {
case _Ticker24h() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol, @JsonKey(name: 'lastPrice')@DecimalConverter()  Decimal lastPrice, @JsonKey(name: 'priceChange')@DecimalConverter()  Decimal priceChange, @JsonKey(name: 'priceChangePercent')@DecimalConverter()  Decimal priceChangePercent, @JsonKey(name: 'volume')@DecimalConverter()  Decimal volume, @JsonKey(name: 'quoteVolume')@DecimalConverter()  Decimal quoteVolume, @JsonKey(name: 'highPrice')@DecimalConverter()  Decimal highPrice, @JsonKey(name: 'lowPrice')@DecimalConverter()  Decimal lowPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticker24h() when $default != null:
return $default(_that.symbol,_that.lastPrice,_that.priceChange,_that.priceChangePercent,_that.volume,_that.quoteVolume,_that.highPrice,_that.lowPrice);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol, @JsonKey(name: 'lastPrice')@DecimalConverter()  Decimal lastPrice, @JsonKey(name: 'priceChange')@DecimalConverter()  Decimal priceChange, @JsonKey(name: 'priceChangePercent')@DecimalConverter()  Decimal priceChangePercent, @JsonKey(name: 'volume')@DecimalConverter()  Decimal volume, @JsonKey(name: 'quoteVolume')@DecimalConverter()  Decimal quoteVolume, @JsonKey(name: 'highPrice')@DecimalConverter()  Decimal highPrice, @JsonKey(name: 'lowPrice')@DecimalConverter()  Decimal lowPrice)  $default,) {final _that = this;
switch (_that) {
case _Ticker24h():
return $default(_that.symbol,_that.lastPrice,_that.priceChange,_that.priceChangePercent,_that.volume,_that.quoteVolume,_that.highPrice,_that.lowPrice);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol, @JsonKey(name: 'lastPrice')@DecimalConverter()  Decimal lastPrice, @JsonKey(name: 'priceChange')@DecimalConverter()  Decimal priceChange, @JsonKey(name: 'priceChangePercent')@DecimalConverter()  Decimal priceChangePercent, @JsonKey(name: 'volume')@DecimalConverter()  Decimal volume, @JsonKey(name: 'quoteVolume')@DecimalConverter()  Decimal quoteVolume, @JsonKey(name: 'highPrice')@DecimalConverter()  Decimal highPrice, @JsonKey(name: 'lowPrice')@DecimalConverter()  Decimal lowPrice)?  $default,) {final _that = this;
switch (_that) {
case _Ticker24h() when $default != null:
return $default(_that.symbol,_that.lastPrice,_that.priceChange,_that.priceChangePercent,_that.volume,_that.quoteVolume,_that.highPrice,_that.lowPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticker24h extends Ticker24h {
  const _Ticker24h({required this.symbol, @JsonKey(name: 'lastPrice')@DecimalConverter() required this.lastPrice, @JsonKey(name: 'priceChange')@DecimalConverter() required this.priceChange, @JsonKey(name: 'priceChangePercent')@DecimalConverter() required this.priceChangePercent, @JsonKey(name: 'volume')@DecimalConverter() required this.volume, @JsonKey(name: 'quoteVolume')@DecimalConverter() required this.quoteVolume, @JsonKey(name: 'highPrice')@DecimalConverter() required this.highPrice, @JsonKey(name: 'lowPrice')@DecimalConverter() required this.lowPrice}): super._();
  factory _Ticker24h.fromJson(Map<String, dynamic> json) => _$Ticker24hFromJson(json);

@override final  String symbol;
@override@JsonKey(name: 'lastPrice')@DecimalConverter() final  Decimal lastPrice;
@override@JsonKey(name: 'priceChange')@DecimalConverter() final  Decimal priceChange;
@override@JsonKey(name: 'priceChangePercent')@DecimalConverter() final  Decimal priceChangePercent;
@override@JsonKey(name: 'volume')@DecimalConverter() final  Decimal volume;
@override@JsonKey(name: 'quoteVolume')@DecimalConverter() final  Decimal quoteVolume;
@override@JsonKey(name: 'highPrice')@DecimalConverter() final  Decimal highPrice;
@override@JsonKey(name: 'lowPrice')@DecimalConverter() final  Decimal lowPrice;

/// Create a copy of Ticker24h
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Ticker24hCopyWith<_Ticker24h> get copyWith => __$Ticker24hCopyWithImpl<_Ticker24h>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Ticker24hToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticker24h&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.priceChangePercent, priceChangePercent) || other.priceChangePercent == priceChangePercent)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.quoteVolume, quoteVolume) || other.quoteVolume == quoteVolume)&&(identical(other.highPrice, highPrice) || other.highPrice == highPrice)&&(identical(other.lowPrice, lowPrice) || other.lowPrice == lowPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,lastPrice,priceChange,priceChangePercent,volume,quoteVolume,highPrice,lowPrice);

@override
String toString() {
  return 'Ticker24h(symbol: $symbol, lastPrice: $lastPrice, priceChange: $priceChange, priceChangePercent: $priceChangePercent, volume: $volume, quoteVolume: $quoteVolume, highPrice: $highPrice, lowPrice: $lowPrice)';
}


}

/// @nodoc
abstract mixin class _$Ticker24hCopyWith<$Res> implements $Ticker24hCopyWith<$Res> {
  factory _$Ticker24hCopyWith(_Ticker24h value, $Res Function(_Ticker24h) _then) = __$Ticker24hCopyWithImpl;
@override @useResult
$Res call({
 String symbol,@JsonKey(name: 'lastPrice')@DecimalConverter() Decimal lastPrice,@JsonKey(name: 'priceChange')@DecimalConverter() Decimal priceChange,@JsonKey(name: 'priceChangePercent')@DecimalConverter() Decimal priceChangePercent,@JsonKey(name: 'volume')@DecimalConverter() Decimal volume,@JsonKey(name: 'quoteVolume')@DecimalConverter() Decimal quoteVolume,@JsonKey(name: 'highPrice')@DecimalConverter() Decimal highPrice,@JsonKey(name: 'lowPrice')@DecimalConverter() Decimal lowPrice
});




}
/// @nodoc
class __$Ticker24hCopyWithImpl<$Res>
    implements _$Ticker24hCopyWith<$Res> {
  __$Ticker24hCopyWithImpl(this._self, this._then);

  final _Ticker24h _self;
  final $Res Function(_Ticker24h) _then;

/// Create a copy of Ticker24h
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? lastPrice = null,Object? priceChange = null,Object? priceChangePercent = null,Object? volume = null,Object? quoteVolume = null,Object? highPrice = null,Object? lowPrice = null,}) {
  return _then(_Ticker24h(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,lastPrice: null == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as Decimal,priceChange: null == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as Decimal,priceChangePercent: null == priceChangePercent ? _self.priceChangePercent : priceChangePercent // ignore: cast_nullable_to_non_nullable
as Decimal,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as Decimal,quoteVolume: null == quoteVolume ? _self.quoteVolume : quoteVolume // ignore: cast_nullable_to_non_nullable
as Decimal,highPrice: null == highPrice ? _self.highPrice : highPrice // ignore: cast_nullable_to_non_nullable
as Decimal,lowPrice: null == lowPrice ? _self.lowPrice : lowPrice // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

// dart format on
