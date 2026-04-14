// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Withdrawal {

 String get id;@DecimalConverter() Decimal get amount;@DecimalConverter() Decimal get transactionFee; String get coin; String get network;/// 0: email sent, 1: cancelled, 2: awaiting approval,
/// 3: rejected, 4: processing, 5: failure, 6: completed
 int get status; String get address; String? get addressTag; String get txId; String get applyTime;
/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalCopyWith<Withdrawal> get copyWith => _$WithdrawalCopyWithImpl<Withdrawal>(this as Withdrawal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Withdrawal&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.transactionFee, transactionFee) || other.transactionFee == transactionFee)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.network, network) || other.network == network)&&(identical(other.status, status) || other.status == status)&&(identical(other.address, address) || other.address == address)&&(identical(other.addressTag, addressTag) || other.addressTag == addressTag)&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.applyTime, applyTime) || other.applyTime == applyTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,transactionFee,coin,network,status,address,addressTag,txId,applyTime);

@override
String toString() {
  return 'Withdrawal(id: $id, amount: $amount, transactionFee: $transactionFee, coin: $coin, network: $network, status: $status, address: $address, addressTag: $addressTag, txId: $txId, applyTime: $applyTime)';
}


}

/// @nodoc
abstract mixin class $WithdrawalCopyWith<$Res>  {
  factory $WithdrawalCopyWith(Withdrawal value, $Res Function(Withdrawal) _then) = _$WithdrawalCopyWithImpl;
@useResult
$Res call({
 String id,@DecimalConverter() Decimal amount,@DecimalConverter() Decimal transactionFee, String coin, String network, int status, String address, String? addressTag, String txId, String applyTime
});




}
/// @nodoc
class _$WithdrawalCopyWithImpl<$Res>
    implements $WithdrawalCopyWith<$Res> {
  _$WithdrawalCopyWithImpl(this._self, this._then);

  final Withdrawal _self;
  final $Res Function(Withdrawal) _then;

/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? transactionFee = null,Object? coin = null,Object? network = null,Object? status = null,Object? address = null,Object? addressTag = freezed,Object? txId = null,Object? applyTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Decimal,transactionFee: null == transactionFee ? _self.transactionFee : transactionFee // ignore: cast_nullable_to_non_nullable
as Decimal,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,addressTag: freezed == addressTag ? _self.addressTag : addressTag // ignore: cast_nullable_to_non_nullable
as String?,txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,applyTime: null == applyTime ? _self.applyTime : applyTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Withdrawal].
extension WithdrawalPatterns on Withdrawal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Withdrawal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Withdrawal value)  $default,){
final _that = this;
switch (_that) {
case _Withdrawal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Withdrawal value)?  $default,){
final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @DecimalConverter()  Decimal amount, @DecimalConverter()  Decimal transactionFee,  String coin,  String network,  int status,  String address,  String? addressTag,  String txId,  String applyTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
return $default(_that.id,_that.amount,_that.transactionFee,_that.coin,_that.network,_that.status,_that.address,_that.addressTag,_that.txId,_that.applyTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @DecimalConverter()  Decimal amount, @DecimalConverter()  Decimal transactionFee,  String coin,  String network,  int status,  String address,  String? addressTag,  String txId,  String applyTime)  $default,) {final _that = this;
switch (_that) {
case _Withdrawal():
return $default(_that.id,_that.amount,_that.transactionFee,_that.coin,_that.network,_that.status,_that.address,_that.addressTag,_that.txId,_that.applyTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @DecimalConverter()  Decimal amount, @DecimalConverter()  Decimal transactionFee,  String coin,  String network,  int status,  String address,  String? addressTag,  String txId,  String applyTime)?  $default,) {final _that = this;
switch (_that) {
case _Withdrawal() when $default != null:
return $default(_that.id,_that.amount,_that.transactionFee,_that.coin,_that.network,_that.status,_that.address,_that.addressTag,_that.txId,_that.applyTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Withdrawal extends Withdrawal {
  const _Withdrawal({required this.id, @DecimalConverter() required this.amount, @DecimalConverter() required this.transactionFee, required this.coin, required this.network, required this.status, required this.address, this.addressTag, required this.txId, required this.applyTime}): super._();
  factory _Withdrawal.fromJson(Map<String, dynamic> json) => _$WithdrawalFromJson(json);

@override final  String id;
@override@DecimalConverter() final  Decimal amount;
@override@DecimalConverter() final  Decimal transactionFee;
@override final  String coin;
@override final  String network;
/// 0: email sent, 1: cancelled, 2: awaiting approval,
/// 3: rejected, 4: processing, 5: failure, 6: completed
@override final  int status;
@override final  String address;
@override final  String? addressTag;
@override final  String txId;
@override final  String applyTime;

/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalCopyWith<_Withdrawal> get copyWith => __$WithdrawalCopyWithImpl<_Withdrawal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Withdrawal&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.transactionFee, transactionFee) || other.transactionFee == transactionFee)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.network, network) || other.network == network)&&(identical(other.status, status) || other.status == status)&&(identical(other.address, address) || other.address == address)&&(identical(other.addressTag, addressTag) || other.addressTag == addressTag)&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.applyTime, applyTime) || other.applyTime == applyTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,transactionFee,coin,network,status,address,addressTag,txId,applyTime);

@override
String toString() {
  return 'Withdrawal(id: $id, amount: $amount, transactionFee: $transactionFee, coin: $coin, network: $network, status: $status, address: $address, addressTag: $addressTag, txId: $txId, applyTime: $applyTime)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalCopyWith<$Res> implements $WithdrawalCopyWith<$Res> {
  factory _$WithdrawalCopyWith(_Withdrawal value, $Res Function(_Withdrawal) _then) = __$WithdrawalCopyWithImpl;
@override @useResult
$Res call({
 String id,@DecimalConverter() Decimal amount,@DecimalConverter() Decimal transactionFee, String coin, String network, int status, String address, String? addressTag, String txId, String applyTime
});




}
/// @nodoc
class __$WithdrawalCopyWithImpl<$Res>
    implements _$WithdrawalCopyWith<$Res> {
  __$WithdrawalCopyWithImpl(this._self, this._then);

  final _Withdrawal _self;
  final $Res Function(_Withdrawal) _then;

/// Create a copy of Withdrawal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? transactionFee = null,Object? coin = null,Object? network = null,Object? status = null,Object? address = null,Object? addressTag = freezed,Object? txId = null,Object? applyTime = null,}) {
  return _then(_Withdrawal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Decimal,transactionFee: null == transactionFee ? _self.transactionFee : transactionFee // ignore: cast_nullable_to_non_nullable
as Decimal,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,addressTag: freezed == addressTag ? _self.addressTag : addressTag // ignore: cast_nullable_to_non_nullable
as String?,txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,applyTime: null == applyTime ? _self.applyTime : applyTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
