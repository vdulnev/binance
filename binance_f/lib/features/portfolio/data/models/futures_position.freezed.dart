// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'futures_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FuturesPosition {

 String get symbol;@DecimalConverter() Decimal get positionAmt;@DecimalConverter() Decimal get entryPrice;@DecimalConverter() Decimal get unrealizedProfit;@NullableDecimalConverter() Decimal? get liquidationPrice;@DecimalConverter() Decimal get leverage; String get marginType;
/// Create a copy of FuturesPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesPositionCopyWith<FuturesPosition> get copyWith => _$FuturesPositionCopyWithImpl<FuturesPosition>(this as FuturesPosition, _$identity);

  /// Serializes this FuturesPosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesPosition&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.positionAmt, positionAmt) || other.positionAmt == positionAmt)&&(identical(other.entryPrice, entryPrice) || other.entryPrice == entryPrice)&&(identical(other.unrealizedProfit, unrealizedProfit) || other.unrealizedProfit == unrealizedProfit)&&(identical(other.liquidationPrice, liquidationPrice) || other.liquidationPrice == liquidationPrice)&&(identical(other.leverage, leverage) || other.leverage == leverage)&&(identical(other.marginType, marginType) || other.marginType == marginType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,positionAmt,entryPrice,unrealizedProfit,liquidationPrice,leverage,marginType);

@override
String toString() {
  return 'FuturesPosition(symbol: $symbol, positionAmt: $positionAmt, entryPrice: $entryPrice, unrealizedProfit: $unrealizedProfit, liquidationPrice: $liquidationPrice, leverage: $leverage, marginType: $marginType)';
}


}

/// @nodoc
abstract mixin class $FuturesPositionCopyWith<$Res>  {
  factory $FuturesPositionCopyWith(FuturesPosition value, $Res Function(FuturesPosition) _then) = _$FuturesPositionCopyWithImpl;
@useResult
$Res call({
 String symbol,@DecimalConverter() Decimal positionAmt,@DecimalConverter() Decimal entryPrice,@DecimalConverter() Decimal unrealizedProfit,@NullableDecimalConverter() Decimal? liquidationPrice,@DecimalConverter() Decimal leverage, String marginType
});




}
/// @nodoc
class _$FuturesPositionCopyWithImpl<$Res>
    implements $FuturesPositionCopyWith<$Res> {
  _$FuturesPositionCopyWithImpl(this._self, this._then);

  final FuturesPosition _self;
  final $Res Function(FuturesPosition) _then;

/// Create a copy of FuturesPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? positionAmt = null,Object? entryPrice = null,Object? unrealizedProfit = null,Object? liquidationPrice = freezed,Object? leverage = null,Object? marginType = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,positionAmt: null == positionAmt ? _self.positionAmt : positionAmt // ignore: cast_nullable_to_non_nullable
as Decimal,entryPrice: null == entryPrice ? _self.entryPrice : entryPrice // ignore: cast_nullable_to_non_nullable
as Decimal,unrealizedProfit: null == unrealizedProfit ? _self.unrealizedProfit : unrealizedProfit // ignore: cast_nullable_to_non_nullable
as Decimal,liquidationPrice: freezed == liquidationPrice ? _self.liquidationPrice : liquidationPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,leverage: null == leverage ? _self.leverage : leverage // ignore: cast_nullable_to_non_nullable
as Decimal,marginType: null == marginType ? _self.marginType : marginType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FuturesPosition].
extension FuturesPositionPatterns on FuturesPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FuturesPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FuturesPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FuturesPosition value)  $default,){
final _that = this;
switch (_that) {
case _FuturesPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FuturesPosition value)?  $default,){
final _that = this;
switch (_that) {
case _FuturesPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol, @DecimalConverter()  Decimal positionAmt, @DecimalConverter()  Decimal entryPrice, @DecimalConverter()  Decimal unrealizedProfit, @NullableDecimalConverter()  Decimal? liquidationPrice, @DecimalConverter()  Decimal leverage,  String marginType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FuturesPosition() when $default != null:
return $default(_that.symbol,_that.positionAmt,_that.entryPrice,_that.unrealizedProfit,_that.liquidationPrice,_that.leverage,_that.marginType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol, @DecimalConverter()  Decimal positionAmt, @DecimalConverter()  Decimal entryPrice, @DecimalConverter()  Decimal unrealizedProfit, @NullableDecimalConverter()  Decimal? liquidationPrice, @DecimalConverter()  Decimal leverage,  String marginType)  $default,) {final _that = this;
switch (_that) {
case _FuturesPosition():
return $default(_that.symbol,_that.positionAmt,_that.entryPrice,_that.unrealizedProfit,_that.liquidationPrice,_that.leverage,_that.marginType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol, @DecimalConverter()  Decimal positionAmt, @DecimalConverter()  Decimal entryPrice, @DecimalConverter()  Decimal unrealizedProfit, @NullableDecimalConverter()  Decimal? liquidationPrice, @DecimalConverter()  Decimal leverage,  String marginType)?  $default,) {final _that = this;
switch (_that) {
case _FuturesPosition() when $default != null:
return $default(_that.symbol,_that.positionAmt,_that.entryPrice,_that.unrealizedProfit,_that.liquidationPrice,_that.leverage,_that.marginType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FuturesPosition extends FuturesPosition {
  const _FuturesPosition({required this.symbol, @DecimalConverter() required this.positionAmt, @DecimalConverter() required this.entryPrice, @DecimalConverter() required this.unrealizedProfit, @NullableDecimalConverter() this.liquidationPrice, @DecimalConverter() required this.leverage, required this.marginType}): super._();
  factory _FuturesPosition.fromJson(Map<String, dynamic> json) => _$FuturesPositionFromJson(json);

@override final  String symbol;
@override@DecimalConverter() final  Decimal positionAmt;
@override@DecimalConverter() final  Decimal entryPrice;
@override@DecimalConverter() final  Decimal unrealizedProfit;
@override@NullableDecimalConverter() final  Decimal? liquidationPrice;
@override@DecimalConverter() final  Decimal leverage;
@override final  String marginType;

/// Create a copy of FuturesPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FuturesPositionCopyWith<_FuturesPosition> get copyWith => __$FuturesPositionCopyWithImpl<_FuturesPosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FuturesPositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FuturesPosition&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.positionAmt, positionAmt) || other.positionAmt == positionAmt)&&(identical(other.entryPrice, entryPrice) || other.entryPrice == entryPrice)&&(identical(other.unrealizedProfit, unrealizedProfit) || other.unrealizedProfit == unrealizedProfit)&&(identical(other.liquidationPrice, liquidationPrice) || other.liquidationPrice == liquidationPrice)&&(identical(other.leverage, leverage) || other.leverage == leverage)&&(identical(other.marginType, marginType) || other.marginType == marginType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,positionAmt,entryPrice,unrealizedProfit,liquidationPrice,leverage,marginType);

@override
String toString() {
  return 'FuturesPosition(symbol: $symbol, positionAmt: $positionAmt, entryPrice: $entryPrice, unrealizedProfit: $unrealizedProfit, liquidationPrice: $liquidationPrice, leverage: $leverage, marginType: $marginType)';
}


}

/// @nodoc
abstract mixin class _$FuturesPositionCopyWith<$Res> implements $FuturesPositionCopyWith<$Res> {
  factory _$FuturesPositionCopyWith(_FuturesPosition value, $Res Function(_FuturesPosition) _then) = __$FuturesPositionCopyWithImpl;
@override @useResult
$Res call({
 String symbol,@DecimalConverter() Decimal positionAmt,@DecimalConverter() Decimal entryPrice,@DecimalConverter() Decimal unrealizedProfit,@NullableDecimalConverter() Decimal? liquidationPrice,@DecimalConverter() Decimal leverage, String marginType
});




}
/// @nodoc
class __$FuturesPositionCopyWithImpl<$Res>
    implements _$FuturesPositionCopyWith<$Res> {
  __$FuturesPositionCopyWithImpl(this._self, this._then);

  final _FuturesPosition _self;
  final $Res Function(_FuturesPosition) _then;

/// Create a copy of FuturesPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? positionAmt = null,Object? entryPrice = null,Object? unrealizedProfit = null,Object? liquidationPrice = freezed,Object? leverage = null,Object? marginType = null,}) {
  return _then(_FuturesPosition(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,positionAmt: null == positionAmt ? _self.positionAmt : positionAmt // ignore: cast_nullable_to_non_nullable
as Decimal,entryPrice: null == entryPrice ? _self.entryPrice : entryPrice // ignore: cast_nullable_to_non_nullable
as Decimal,unrealizedProfit: null == unrealizedProfit ? _self.unrealizedProfit : unrealizedProfit // ignore: cast_nullable_to_non_nullable
as Decimal,liquidationPrice: freezed == liquidationPrice ? _self.liquidationPrice : liquidationPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,leverage: null == leverage ? _self.leverage : leverage // ignore: cast_nullable_to_non_nullable
as Decimal,marginType: null == marginType ? _self.marginType : marginType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
