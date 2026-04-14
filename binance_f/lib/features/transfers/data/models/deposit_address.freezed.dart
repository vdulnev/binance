// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deposit_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DepositAddress {

 String get coin; String get address; String? get tag; String get url;
/// Create a copy of DepositAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepositAddressCopyWith<DepositAddress> get copyWith => _$DepositAddressCopyWithImpl<DepositAddress>(this as DepositAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepositAddress&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.address, address) || other.address == address)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coin,address,tag,url);

@override
String toString() {
  return 'DepositAddress(coin: $coin, address: $address, tag: $tag, url: $url)';
}


}

/// @nodoc
abstract mixin class $DepositAddressCopyWith<$Res>  {
  factory $DepositAddressCopyWith(DepositAddress value, $Res Function(DepositAddress) _then) = _$DepositAddressCopyWithImpl;
@useResult
$Res call({
 String coin, String address, String? tag, String url
});




}
/// @nodoc
class _$DepositAddressCopyWithImpl<$Res>
    implements $DepositAddressCopyWith<$Res> {
  _$DepositAddressCopyWithImpl(this._self, this._then);

  final DepositAddress _self;
  final $Res Function(DepositAddress) _then;

/// Create a copy of DepositAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coin = null,Object? address = null,Object? tag = freezed,Object? url = null,}) {
  return _then(_self.copyWith(
coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DepositAddress].
extension DepositAddressPatterns on DepositAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepositAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepositAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepositAddress value)  $default,){
final _that = this;
switch (_that) {
case _DepositAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepositAddress value)?  $default,){
final _that = this;
switch (_that) {
case _DepositAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String coin,  String address,  String? tag,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DepositAddress() when $default != null:
return $default(_that.coin,_that.address,_that.tag,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String coin,  String address,  String? tag,  String url)  $default,) {final _that = this;
switch (_that) {
case _DepositAddress():
return $default(_that.coin,_that.address,_that.tag,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String coin,  String address,  String? tag,  String url)?  $default,) {final _that = this;
switch (_that) {
case _DepositAddress() when $default != null:
return $default(_that.coin,_that.address,_that.tag,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _DepositAddress implements DepositAddress {
  const _DepositAddress({required this.coin, required this.address, this.tag, required this.url});
  factory _DepositAddress.fromJson(Map<String, dynamic> json) => _$DepositAddressFromJson(json);

@override final  String coin;
@override final  String address;
@override final  String? tag;
@override final  String url;

/// Create a copy of DepositAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepositAddressCopyWith<_DepositAddress> get copyWith => __$DepositAddressCopyWithImpl<_DepositAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepositAddress&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.address, address) || other.address == address)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coin,address,tag,url);

@override
String toString() {
  return 'DepositAddress(coin: $coin, address: $address, tag: $tag, url: $url)';
}


}

/// @nodoc
abstract mixin class _$DepositAddressCopyWith<$Res> implements $DepositAddressCopyWith<$Res> {
  factory _$DepositAddressCopyWith(_DepositAddress value, $Res Function(_DepositAddress) _then) = __$DepositAddressCopyWithImpl;
@override @useResult
$Res call({
 String coin, String address, String? tag, String url
});




}
/// @nodoc
class __$DepositAddressCopyWithImpl<$Res>
    implements _$DepositAddressCopyWith<$Res> {
  __$DepositAddressCopyWithImpl(this._self, this._then);

  final _DepositAddress _self;
  final $Res Function(_DepositAddress) _then;

/// Create a copy of DepositAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coin = null,Object? address = null,Object? tag = freezed,Object? url = null,}) {
  return _then(_DepositAddress(
coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
