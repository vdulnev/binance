// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deposit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Deposit {

 String get id;@DecimalConverter() Decimal get amount; String get coin; String get network;/// 0: pending, 6: credited, 1: success
 int get status; String get address; String? get addressTag; String get txId; int get insertTime; int? get confirmTimes; int? get unlockConfirm;
/// Create a copy of Deposit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepositCopyWith<Deposit> get copyWith => _$DepositCopyWithImpl<Deposit>(this as Deposit, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Deposit&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.network, network) || other.network == network)&&(identical(other.status, status) || other.status == status)&&(identical(other.address, address) || other.address == address)&&(identical(other.addressTag, addressTag) || other.addressTag == addressTag)&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.insertTime, insertTime) || other.insertTime == insertTime)&&(identical(other.confirmTimes, confirmTimes) || other.confirmTimes == confirmTimes)&&(identical(other.unlockConfirm, unlockConfirm) || other.unlockConfirm == unlockConfirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,coin,network,status,address,addressTag,txId,insertTime,confirmTimes,unlockConfirm);

@override
String toString() {
  return 'Deposit(id: $id, amount: $amount, coin: $coin, network: $network, status: $status, address: $address, addressTag: $addressTag, txId: $txId, insertTime: $insertTime, confirmTimes: $confirmTimes, unlockConfirm: $unlockConfirm)';
}


}

/// @nodoc
abstract mixin class $DepositCopyWith<$Res>  {
  factory $DepositCopyWith(Deposit value, $Res Function(Deposit) _then) = _$DepositCopyWithImpl;
@useResult
$Res call({
 String id,@DecimalConverter() Decimal amount, String coin, String network, int status, String address, String? addressTag, String txId, int insertTime, int? confirmTimes, int? unlockConfirm
});




}
/// @nodoc
class _$DepositCopyWithImpl<$Res>
    implements $DepositCopyWith<$Res> {
  _$DepositCopyWithImpl(this._self, this._then);

  final Deposit _self;
  final $Res Function(Deposit) _then;

/// Create a copy of Deposit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? coin = null,Object? network = null,Object? status = null,Object? address = null,Object? addressTag = freezed,Object? txId = null,Object? insertTime = null,Object? confirmTimes = freezed,Object? unlockConfirm = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Decimal,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,addressTag: freezed == addressTag ? _self.addressTag : addressTag // ignore: cast_nullable_to_non_nullable
as String?,txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,insertTime: null == insertTime ? _self.insertTime : insertTime // ignore: cast_nullable_to_non_nullable
as int,confirmTimes: freezed == confirmTimes ? _self.confirmTimes : confirmTimes // ignore: cast_nullable_to_non_nullable
as int?,unlockConfirm: freezed == unlockConfirm ? _self.unlockConfirm : unlockConfirm // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Deposit].
extension DepositPatterns on Deposit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Deposit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Deposit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Deposit value)  $default,){
final _that = this;
switch (_that) {
case _Deposit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Deposit value)?  $default,){
final _that = this;
switch (_that) {
case _Deposit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @DecimalConverter()  Decimal amount,  String coin,  String network,  int status,  String address,  String? addressTag,  String txId,  int insertTime,  int? confirmTimes,  int? unlockConfirm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Deposit() when $default != null:
return $default(_that.id,_that.amount,_that.coin,_that.network,_that.status,_that.address,_that.addressTag,_that.txId,_that.insertTime,_that.confirmTimes,_that.unlockConfirm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @DecimalConverter()  Decimal amount,  String coin,  String network,  int status,  String address,  String? addressTag,  String txId,  int insertTime,  int? confirmTimes,  int? unlockConfirm)  $default,) {final _that = this;
switch (_that) {
case _Deposit():
return $default(_that.id,_that.amount,_that.coin,_that.network,_that.status,_that.address,_that.addressTag,_that.txId,_that.insertTime,_that.confirmTimes,_that.unlockConfirm);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @DecimalConverter()  Decimal amount,  String coin,  String network,  int status,  String address,  String? addressTag,  String txId,  int insertTime,  int? confirmTimes,  int? unlockConfirm)?  $default,) {final _that = this;
switch (_that) {
case _Deposit() when $default != null:
return $default(_that.id,_that.amount,_that.coin,_that.network,_that.status,_that.address,_that.addressTag,_that.txId,_that.insertTime,_that.confirmTimes,_that.unlockConfirm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Deposit extends Deposit {
  const _Deposit({required this.id, @DecimalConverter() required this.amount, required this.coin, required this.network, required this.status, required this.address, this.addressTag, required this.txId, required this.insertTime, this.confirmTimes, this.unlockConfirm}): super._();
  factory _Deposit.fromJson(Map<String, dynamic> json) => _$DepositFromJson(json);

@override final  String id;
@override@DecimalConverter() final  Decimal amount;
@override final  String coin;
@override final  String network;
/// 0: pending, 6: credited, 1: success
@override final  int status;
@override final  String address;
@override final  String? addressTag;
@override final  String txId;
@override final  int insertTime;
@override final  int? confirmTimes;
@override final  int? unlockConfirm;

/// Create a copy of Deposit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepositCopyWith<_Deposit> get copyWith => __$DepositCopyWithImpl<_Deposit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Deposit&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.network, network) || other.network == network)&&(identical(other.status, status) || other.status == status)&&(identical(other.address, address) || other.address == address)&&(identical(other.addressTag, addressTag) || other.addressTag == addressTag)&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.insertTime, insertTime) || other.insertTime == insertTime)&&(identical(other.confirmTimes, confirmTimes) || other.confirmTimes == confirmTimes)&&(identical(other.unlockConfirm, unlockConfirm) || other.unlockConfirm == unlockConfirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,coin,network,status,address,addressTag,txId,insertTime,confirmTimes,unlockConfirm);

@override
String toString() {
  return 'Deposit(id: $id, amount: $amount, coin: $coin, network: $network, status: $status, address: $address, addressTag: $addressTag, txId: $txId, insertTime: $insertTime, confirmTimes: $confirmTimes, unlockConfirm: $unlockConfirm)';
}


}

/// @nodoc
abstract mixin class _$DepositCopyWith<$Res> implements $DepositCopyWith<$Res> {
  factory _$DepositCopyWith(_Deposit value, $Res Function(_Deposit) _then) = __$DepositCopyWithImpl;
@override @useResult
$Res call({
 String id,@DecimalConverter() Decimal amount, String coin, String network, int status, String address, String? addressTag, String txId, int insertTime, int? confirmTimes, int? unlockConfirm
});




}
/// @nodoc
class __$DepositCopyWithImpl<$Res>
    implements _$DepositCopyWith<$Res> {
  __$DepositCopyWithImpl(this._self, this._then);

  final _Deposit _self;
  final $Res Function(_Deposit) _then;

/// Create a copy of Deposit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? coin = null,Object? network = null,Object? status = null,Object? address = null,Object? addressTag = freezed,Object? txId = null,Object? insertTime = null,Object? confirmTimes = freezed,Object? unlockConfirm = freezed,}) {
  return _then(_Deposit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Decimal,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,addressTag: freezed == addressTag ? _self.addressTag : addressTag // ignore: cast_nullable_to_non_nullable
as String?,txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,insertTime: null == insertTime ? _self.insertTime : insertTime // ignore: cast_nullable_to_non_nullable
as int,confirmTimes: freezed == confirmTimes ? _self.confirmTimes : confirmTimes // ignore: cast_nullable_to_non_nullable
as int?,unlockConfirm: freezed == unlockConfirm ? _self.unlockConfirm : unlockConfirm // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
