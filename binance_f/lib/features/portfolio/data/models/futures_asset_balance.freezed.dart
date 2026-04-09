// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'futures_asset_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FuturesAssetBalance {

 String get asset;@DecimalConverter() Decimal get walletBalance;@DecimalConverter() Decimal get unrealizedProfit;@DecimalConverter() Decimal get marginBalance;@DecimalConverter() Decimal get availableBalance;
/// Create a copy of FuturesAssetBalance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesAssetBalanceCopyWith<FuturesAssetBalance> get copyWith => _$FuturesAssetBalanceCopyWithImpl<FuturesAssetBalance>(this as FuturesAssetBalance, _$identity);

  /// Serializes this FuturesAssetBalance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesAssetBalance&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.unrealizedProfit, unrealizedProfit) || other.unrealizedProfit == unrealizedProfit)&&(identical(other.marginBalance, marginBalance) || other.marginBalance == marginBalance)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,walletBalance,unrealizedProfit,marginBalance,availableBalance);

@override
String toString() {
  return 'FuturesAssetBalance(asset: $asset, walletBalance: $walletBalance, unrealizedProfit: $unrealizedProfit, marginBalance: $marginBalance, availableBalance: $availableBalance)';
}


}

/// @nodoc
abstract mixin class $FuturesAssetBalanceCopyWith<$Res>  {
  factory $FuturesAssetBalanceCopyWith(FuturesAssetBalance value, $Res Function(FuturesAssetBalance) _then) = _$FuturesAssetBalanceCopyWithImpl;
@useResult
$Res call({
 String asset,@DecimalConverter() Decimal walletBalance,@DecimalConverter() Decimal unrealizedProfit,@DecimalConverter() Decimal marginBalance,@DecimalConverter() Decimal availableBalance
});




}
/// @nodoc
class _$FuturesAssetBalanceCopyWithImpl<$Res>
    implements $FuturesAssetBalanceCopyWith<$Res> {
  _$FuturesAssetBalanceCopyWithImpl(this._self, this._then);

  final FuturesAssetBalance _self;
  final $Res Function(FuturesAssetBalance) _then;

/// Create a copy of FuturesAssetBalance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? walletBalance = null,Object? unrealizedProfit = null,Object? marginBalance = null,Object? availableBalance = null,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,walletBalance: null == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as Decimal,unrealizedProfit: null == unrealizedProfit ? _self.unrealizedProfit : unrealizedProfit // ignore: cast_nullable_to_non_nullable
as Decimal,marginBalance: null == marginBalance ? _self.marginBalance : marginBalance // ignore: cast_nullable_to_non_nullable
as Decimal,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}

}


/// Adds pattern-matching-related methods to [FuturesAssetBalance].
extension FuturesAssetBalancePatterns on FuturesAssetBalance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FuturesAssetBalance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FuturesAssetBalance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FuturesAssetBalance value)  $default,){
final _that = this;
switch (_that) {
case _FuturesAssetBalance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FuturesAssetBalance value)?  $default,){
final _that = this;
switch (_that) {
case _FuturesAssetBalance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String asset, @DecimalConverter()  Decimal walletBalance, @DecimalConverter()  Decimal unrealizedProfit, @DecimalConverter()  Decimal marginBalance, @DecimalConverter()  Decimal availableBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FuturesAssetBalance() when $default != null:
return $default(_that.asset,_that.walletBalance,_that.unrealizedProfit,_that.marginBalance,_that.availableBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String asset, @DecimalConverter()  Decimal walletBalance, @DecimalConverter()  Decimal unrealizedProfit, @DecimalConverter()  Decimal marginBalance, @DecimalConverter()  Decimal availableBalance)  $default,) {final _that = this;
switch (_that) {
case _FuturesAssetBalance():
return $default(_that.asset,_that.walletBalance,_that.unrealizedProfit,_that.marginBalance,_that.availableBalance);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String asset, @DecimalConverter()  Decimal walletBalance, @DecimalConverter()  Decimal unrealizedProfit, @DecimalConverter()  Decimal marginBalance, @DecimalConverter()  Decimal availableBalance)?  $default,) {final _that = this;
switch (_that) {
case _FuturesAssetBalance() when $default != null:
return $default(_that.asset,_that.walletBalance,_that.unrealizedProfit,_that.marginBalance,_that.availableBalance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FuturesAssetBalance extends FuturesAssetBalance {
  const _FuturesAssetBalance({required this.asset, @DecimalConverter() required this.walletBalance, @DecimalConverter() required this.unrealizedProfit, @DecimalConverter() required this.marginBalance, @DecimalConverter() required this.availableBalance}): super._();
  factory _FuturesAssetBalance.fromJson(Map<String, dynamic> json) => _$FuturesAssetBalanceFromJson(json);

@override final  String asset;
@override@DecimalConverter() final  Decimal walletBalance;
@override@DecimalConverter() final  Decimal unrealizedProfit;
@override@DecimalConverter() final  Decimal marginBalance;
@override@DecimalConverter() final  Decimal availableBalance;

/// Create a copy of FuturesAssetBalance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FuturesAssetBalanceCopyWith<_FuturesAssetBalance> get copyWith => __$FuturesAssetBalanceCopyWithImpl<_FuturesAssetBalance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FuturesAssetBalanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FuturesAssetBalance&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.unrealizedProfit, unrealizedProfit) || other.unrealizedProfit == unrealizedProfit)&&(identical(other.marginBalance, marginBalance) || other.marginBalance == marginBalance)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,walletBalance,unrealizedProfit,marginBalance,availableBalance);

@override
String toString() {
  return 'FuturesAssetBalance(asset: $asset, walletBalance: $walletBalance, unrealizedProfit: $unrealizedProfit, marginBalance: $marginBalance, availableBalance: $availableBalance)';
}


}

/// @nodoc
abstract mixin class _$FuturesAssetBalanceCopyWith<$Res> implements $FuturesAssetBalanceCopyWith<$Res> {
  factory _$FuturesAssetBalanceCopyWith(_FuturesAssetBalance value, $Res Function(_FuturesAssetBalance) _then) = __$FuturesAssetBalanceCopyWithImpl;
@override @useResult
$Res call({
 String asset,@DecimalConverter() Decimal walletBalance,@DecimalConverter() Decimal unrealizedProfit,@DecimalConverter() Decimal marginBalance,@DecimalConverter() Decimal availableBalance
});




}
/// @nodoc
class __$FuturesAssetBalanceCopyWithImpl<$Res>
    implements _$FuturesAssetBalanceCopyWith<$Res> {
  __$FuturesAssetBalanceCopyWithImpl(this._self, this._then);

  final _FuturesAssetBalance _self;
  final $Res Function(_FuturesAssetBalance) _then;

/// Create a copy of FuturesAssetBalance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? walletBalance = null,Object? unrealizedProfit = null,Object? marginBalance = null,Object? availableBalance = null,}) {
  return _then(_FuturesAssetBalance(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,walletBalance: null == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as Decimal,unrealizedProfit: null == unrealizedProfit ? _self.unrealizedProfit : unrealizedProfit // ignore: cast_nullable_to_non_nullable
as Decimal,marginBalance: null == marginBalance ? _self.marginBalance : marginBalance // ignore: cast_nullable_to_non_nullable
as Decimal,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

// dart format on
