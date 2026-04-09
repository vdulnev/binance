// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_symbol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteSymbol {

 String get symbol; String get market; int get position;
/// Create a copy of FavoriteSymbol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteSymbolCopyWith<FavoriteSymbol> get copyWith => _$FavoriteSymbolCopyWithImpl<FavoriteSymbol>(this as FavoriteSymbol, _$identity);

  /// Serializes this FavoriteSymbol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteSymbol&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.market, market) || other.market == market)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,market,position);

@override
String toString() {
  return 'FavoriteSymbol(symbol: $symbol, market: $market, position: $position)';
}


}

/// @nodoc
abstract mixin class $FavoriteSymbolCopyWith<$Res>  {
  factory $FavoriteSymbolCopyWith(FavoriteSymbol value, $Res Function(FavoriteSymbol) _then) = _$FavoriteSymbolCopyWithImpl;
@useResult
$Res call({
 String symbol, String market, int position
});




}
/// @nodoc
class _$FavoriteSymbolCopyWithImpl<$Res>
    implements $FavoriteSymbolCopyWith<$Res> {
  _$FavoriteSymbolCopyWithImpl(this._self, this._then);

  final FavoriteSymbol _self;
  final $Res Function(FavoriteSymbol) _then;

/// Create a copy of FavoriteSymbol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? market = null,Object? position = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteSymbol].
extension FavoriteSymbolPatterns on FavoriteSymbol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteSymbol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteSymbol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteSymbol value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteSymbol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteSymbol value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteSymbol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String market,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteSymbol() when $default != null:
return $default(_that.symbol,_that.market,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String market,  int position)  $default,) {final _that = this;
switch (_that) {
case _FavoriteSymbol():
return $default(_that.symbol,_that.market,_that.position);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String market,  int position)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteSymbol() when $default != null:
return $default(_that.symbol,_that.market,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteSymbol implements FavoriteSymbol {
  const _FavoriteSymbol({required this.symbol, required this.market, required this.position});
  factory _FavoriteSymbol.fromJson(Map<String, dynamic> json) => _$FavoriteSymbolFromJson(json);

@override final  String symbol;
@override final  String market;
@override final  int position;

/// Create a copy of FavoriteSymbol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteSymbolCopyWith<_FavoriteSymbol> get copyWith => __$FavoriteSymbolCopyWithImpl<_FavoriteSymbol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteSymbolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteSymbol&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.market, market) || other.market == market)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,market,position);

@override
String toString() {
  return 'FavoriteSymbol(symbol: $symbol, market: $market, position: $position)';
}


}

/// @nodoc
abstract mixin class _$FavoriteSymbolCopyWith<$Res> implements $FavoriteSymbolCopyWith<$Res> {
  factory _$FavoriteSymbolCopyWith(_FavoriteSymbol value, $Res Function(_FavoriteSymbol) _then) = __$FavoriteSymbolCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String market, int position
});




}
/// @nodoc
class __$FavoriteSymbolCopyWithImpl<$Res>
    implements _$FavoriteSymbolCopyWith<$Res> {
  __$FavoriteSymbolCopyWithImpl(this._self, this._then);

  final _FavoriteSymbol _self;
  final $Res Function(_FavoriteSymbol) _then;

/// Create a copy of FavoriteSymbol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? market = null,Object? position = null,}) {
  return _then(_FavoriteSymbol(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
