// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symbol_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SymbolFilters {

 String get symbol; Decimal get tickSize; Decimal get stepSize; Decimal get minQty; Decimal get minNotional; Decimal? get maxQty; Decimal? get minPrice; Decimal? get maxPrice;
/// Create a copy of SymbolFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymbolFiltersCopyWith<SymbolFilters> get copyWith => _$SymbolFiltersCopyWithImpl<SymbolFilters>(this as SymbolFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymbolFilters&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.tickSize, tickSize) || other.tickSize == tickSize)&&(identical(other.stepSize, stepSize) || other.stepSize == stepSize)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.minNotional, minNotional) || other.minNotional == minNotional)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,tickSize,stepSize,minQty,minNotional,maxQty,minPrice,maxPrice);

@override
String toString() {
  return 'SymbolFilters(symbol: $symbol, tickSize: $tickSize, stepSize: $stepSize, minQty: $minQty, minNotional: $minNotional, maxQty: $maxQty, minPrice: $minPrice, maxPrice: $maxPrice)';
}


}

/// @nodoc
abstract mixin class $SymbolFiltersCopyWith<$Res>  {
  factory $SymbolFiltersCopyWith(SymbolFilters value, $Res Function(SymbolFilters) _then) = _$SymbolFiltersCopyWithImpl;
@useResult
$Res call({
 String symbol, Decimal tickSize, Decimal stepSize, Decimal minQty, Decimal minNotional, Decimal? maxQty, Decimal? minPrice, Decimal? maxPrice
});




}
/// @nodoc
class _$SymbolFiltersCopyWithImpl<$Res>
    implements $SymbolFiltersCopyWith<$Res> {
  _$SymbolFiltersCopyWithImpl(this._self, this._then);

  final SymbolFilters _self;
  final $Res Function(SymbolFilters) _then;

/// Create a copy of SymbolFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? tickSize = null,Object? stepSize = null,Object? minQty = null,Object? minNotional = null,Object? maxQty = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,tickSize: null == tickSize ? _self.tickSize : tickSize // ignore: cast_nullable_to_non_nullable
as Decimal,stepSize: null == stepSize ? _self.stepSize : stepSize // ignore: cast_nullable_to_non_nullable
as Decimal,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as Decimal,minNotional: null == minNotional ? _self.minNotional : minNotional // ignore: cast_nullable_to_non_nullable
as Decimal,maxQty: freezed == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as Decimal?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,
  ));
}

}


/// Adds pattern-matching-related methods to [SymbolFilters].
extension SymbolFiltersPatterns on SymbolFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymbolFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymbolFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymbolFilters value)  $default,){
final _that = this;
switch (_that) {
case _SymbolFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymbolFilters value)?  $default,){
final _that = this;
switch (_that) {
case _SymbolFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  Decimal tickSize,  Decimal stepSize,  Decimal minQty,  Decimal minNotional,  Decimal? maxQty,  Decimal? minPrice,  Decimal? maxPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymbolFilters() when $default != null:
return $default(_that.symbol,_that.tickSize,_that.stepSize,_that.minQty,_that.minNotional,_that.maxQty,_that.minPrice,_that.maxPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  Decimal tickSize,  Decimal stepSize,  Decimal minQty,  Decimal minNotional,  Decimal? maxQty,  Decimal? minPrice,  Decimal? maxPrice)  $default,) {final _that = this;
switch (_that) {
case _SymbolFilters():
return $default(_that.symbol,_that.tickSize,_that.stepSize,_that.minQty,_that.minNotional,_that.maxQty,_that.minPrice,_that.maxPrice);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  Decimal tickSize,  Decimal stepSize,  Decimal minQty,  Decimal minNotional,  Decimal? maxQty,  Decimal? minPrice,  Decimal? maxPrice)?  $default,) {final _that = this;
switch (_that) {
case _SymbolFilters() when $default != null:
return $default(_that.symbol,_that.tickSize,_that.stepSize,_that.minQty,_that.minNotional,_that.maxQty,_that.minPrice,_that.maxPrice);case _:
  return null;

}
}

}

/// @nodoc


class _SymbolFilters implements SymbolFilters {
  const _SymbolFilters({required this.symbol, required this.tickSize, required this.stepSize, required this.minQty, required this.minNotional, this.maxQty, this.minPrice, this.maxPrice});
  

@override final  String symbol;
@override final  Decimal tickSize;
@override final  Decimal stepSize;
@override final  Decimal minQty;
@override final  Decimal minNotional;
@override final  Decimal? maxQty;
@override final  Decimal? minPrice;
@override final  Decimal? maxPrice;

/// Create a copy of SymbolFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymbolFiltersCopyWith<_SymbolFilters> get copyWith => __$SymbolFiltersCopyWithImpl<_SymbolFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymbolFilters&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.tickSize, tickSize) || other.tickSize == tickSize)&&(identical(other.stepSize, stepSize) || other.stepSize == stepSize)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.minNotional, minNotional) || other.minNotional == minNotional)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,tickSize,stepSize,minQty,minNotional,maxQty,minPrice,maxPrice);

@override
String toString() {
  return 'SymbolFilters(symbol: $symbol, tickSize: $tickSize, stepSize: $stepSize, minQty: $minQty, minNotional: $minNotional, maxQty: $maxQty, minPrice: $minPrice, maxPrice: $maxPrice)';
}


}

/// @nodoc
abstract mixin class _$SymbolFiltersCopyWith<$Res> implements $SymbolFiltersCopyWith<$Res> {
  factory _$SymbolFiltersCopyWith(_SymbolFilters value, $Res Function(_SymbolFilters) _then) = __$SymbolFiltersCopyWithImpl;
@override @useResult
$Res call({
 String symbol, Decimal tickSize, Decimal stepSize, Decimal minQty, Decimal minNotional, Decimal? maxQty, Decimal? minPrice, Decimal? maxPrice
});




}
/// @nodoc
class __$SymbolFiltersCopyWithImpl<$Res>
    implements _$SymbolFiltersCopyWith<$Res> {
  __$SymbolFiltersCopyWithImpl(this._self, this._then);

  final _SymbolFilters _self;
  final $Res Function(_SymbolFilters) _then;

/// Create a copy of SymbolFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? tickSize = null,Object? stepSize = null,Object? minQty = null,Object? minNotional = null,Object? maxQty = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,}) {
  return _then(_SymbolFilters(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,tickSize: null == tickSize ? _self.tickSize : tickSize // ignore: cast_nullable_to_non_nullable
as Decimal,stepSize: null == stepSize ? _self.stepSize : stepSize // ignore: cast_nullable_to_non_nullable
as Decimal,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as Decimal,minNotional: null == minNotional ? _self.minNotional : minNotional // ignore: cast_nullable_to_non_nullable
as Decimal,maxQty: freezed == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as Decimal?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,
  ));
}


}

// dart format on
