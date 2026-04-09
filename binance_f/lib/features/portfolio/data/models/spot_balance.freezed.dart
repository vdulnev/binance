// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotBalance {

 String get asset;@DecimalConverter() Decimal get free;@DecimalConverter() Decimal get locked;
/// Create a copy of SpotBalance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotBalanceCopyWith<SpotBalance> get copyWith => _$SpotBalanceCopyWithImpl<SpotBalance>(this as SpotBalance, _$identity);

  /// Serializes this SpotBalance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotBalance&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.free, free) || other.free == free)&&(identical(other.locked, locked) || other.locked == locked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,free,locked);

@override
String toString() {
  return 'SpotBalance(asset: $asset, free: $free, locked: $locked)';
}


}

/// @nodoc
abstract mixin class $SpotBalanceCopyWith<$Res>  {
  factory $SpotBalanceCopyWith(SpotBalance value, $Res Function(SpotBalance) _then) = _$SpotBalanceCopyWithImpl;
@useResult
$Res call({
 String asset,@DecimalConverter() Decimal free,@DecimalConverter() Decimal locked
});




}
/// @nodoc
class _$SpotBalanceCopyWithImpl<$Res>
    implements $SpotBalanceCopyWith<$Res> {
  _$SpotBalanceCopyWithImpl(this._self, this._then);

  final SpotBalance _self;
  final $Res Function(SpotBalance) _then;

/// Create a copy of SpotBalance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? free = null,Object? locked = null,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as Decimal,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotBalance].
extension SpotBalancePatterns on SpotBalance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotBalance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotBalance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotBalance value)  $default,){
final _that = this;
switch (_that) {
case _SpotBalance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotBalance value)?  $default,){
final _that = this;
switch (_that) {
case _SpotBalance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String asset, @DecimalConverter()  Decimal free, @DecimalConverter()  Decimal locked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotBalance() when $default != null:
return $default(_that.asset,_that.free,_that.locked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String asset, @DecimalConverter()  Decimal free, @DecimalConverter()  Decimal locked)  $default,) {final _that = this;
switch (_that) {
case _SpotBalance():
return $default(_that.asset,_that.free,_that.locked);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String asset, @DecimalConverter()  Decimal free, @DecimalConverter()  Decimal locked)?  $default,) {final _that = this;
switch (_that) {
case _SpotBalance() when $default != null:
return $default(_that.asset,_that.free,_that.locked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotBalance extends SpotBalance {
  const _SpotBalance({required this.asset, @DecimalConverter() required this.free, @DecimalConverter() required this.locked}): super._();
  factory _SpotBalance.fromJson(Map<String, dynamic> json) => _$SpotBalanceFromJson(json);

@override final  String asset;
@override@DecimalConverter() final  Decimal free;
@override@DecimalConverter() final  Decimal locked;

/// Create a copy of SpotBalance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotBalanceCopyWith<_SpotBalance> get copyWith => __$SpotBalanceCopyWithImpl<_SpotBalance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotBalanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotBalance&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.free, free) || other.free == free)&&(identical(other.locked, locked) || other.locked == locked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,free,locked);

@override
String toString() {
  return 'SpotBalance(asset: $asset, free: $free, locked: $locked)';
}


}

/// @nodoc
abstract mixin class _$SpotBalanceCopyWith<$Res> implements $SpotBalanceCopyWith<$Res> {
  factory _$SpotBalanceCopyWith(_SpotBalance value, $Res Function(_SpotBalance) _then) = __$SpotBalanceCopyWithImpl;
@override @useResult
$Res call({
 String asset,@DecimalConverter() Decimal free,@DecimalConverter() Decimal locked
});




}
/// @nodoc
class __$SpotBalanceCopyWithImpl<$Res>
    implements _$SpotBalanceCopyWith<$Res> {
  __$SpotBalanceCopyWithImpl(this._self, this._then);

  final _SpotBalance _self;
  final $Res Function(_SpotBalance) _then;

/// Create a copy of SpotBalance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? free = null,Object? locked = null,}) {
  return _then(_SpotBalance(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as Decimal,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

// dart format on
