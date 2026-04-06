// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountInfo {

 int get uid; String get accountType; bool get canTrade; bool get canWithdraw; bool get canDeposit; List<Balance> get balances; CommissionRates get commissionRates;
/// Create a copy of AccountInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountInfoCopyWith<AccountInfo> get copyWith => _$AccountInfoCopyWithImpl<AccountInfo>(this as AccountInfo, _$identity);

  /// Serializes this AccountInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountInfo&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.canTrade, canTrade) || other.canTrade == canTrade)&&(identical(other.canWithdraw, canWithdraw) || other.canWithdraw == canWithdraw)&&(identical(other.canDeposit, canDeposit) || other.canDeposit == canDeposit)&&const DeepCollectionEquality().equals(other.balances, balances)&&(identical(other.commissionRates, commissionRates) || other.commissionRates == commissionRates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,accountType,canTrade,canWithdraw,canDeposit,const DeepCollectionEquality().hash(balances),commissionRates);

@override
String toString() {
  return 'AccountInfo(uid: $uid, accountType: $accountType, canTrade: $canTrade, canWithdraw: $canWithdraw, canDeposit: $canDeposit, balances: $balances, commissionRates: $commissionRates)';
}


}

/// @nodoc
abstract mixin class $AccountInfoCopyWith<$Res>  {
  factory $AccountInfoCopyWith(AccountInfo value, $Res Function(AccountInfo) _then) = _$AccountInfoCopyWithImpl;
@useResult
$Res call({
 int uid, String accountType, bool canTrade, bool canWithdraw, bool canDeposit, List<Balance> balances, CommissionRates commissionRates
});


$CommissionRatesCopyWith<$Res> get commissionRates;

}
/// @nodoc
class _$AccountInfoCopyWithImpl<$Res>
    implements $AccountInfoCopyWith<$Res> {
  _$AccountInfoCopyWithImpl(this._self, this._then);

  final AccountInfo _self;
  final $Res Function(AccountInfo) _then;

/// Create a copy of AccountInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? accountType = null,Object? canTrade = null,Object? canWithdraw = null,Object? canDeposit = null,Object? balances = null,Object? commissionRates = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as String,canTrade: null == canTrade ? _self.canTrade : canTrade // ignore: cast_nullable_to_non_nullable
as bool,canWithdraw: null == canWithdraw ? _self.canWithdraw : canWithdraw // ignore: cast_nullable_to_non_nullable
as bool,canDeposit: null == canDeposit ? _self.canDeposit : canDeposit // ignore: cast_nullable_to_non_nullable
as bool,balances: null == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as List<Balance>,commissionRates: null == commissionRates ? _self.commissionRates : commissionRates // ignore: cast_nullable_to_non_nullable
as CommissionRates,
  ));
}
/// Create a copy of AccountInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommissionRatesCopyWith<$Res> get commissionRates {
  
  return $CommissionRatesCopyWith<$Res>(_self.commissionRates, (value) {
    return _then(_self.copyWith(commissionRates: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountInfo].
extension AccountInfoPatterns on AccountInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountInfo value)  $default,){
final _that = this;
switch (_that) {
case _AccountInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountInfo value)?  $default,){
final _that = this;
switch (_that) {
case _AccountInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int uid,  String accountType,  bool canTrade,  bool canWithdraw,  bool canDeposit,  List<Balance> balances,  CommissionRates commissionRates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountInfo() when $default != null:
return $default(_that.uid,_that.accountType,_that.canTrade,_that.canWithdraw,_that.canDeposit,_that.balances,_that.commissionRates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int uid,  String accountType,  bool canTrade,  bool canWithdraw,  bool canDeposit,  List<Balance> balances,  CommissionRates commissionRates)  $default,) {final _that = this;
switch (_that) {
case _AccountInfo():
return $default(_that.uid,_that.accountType,_that.canTrade,_that.canWithdraw,_that.canDeposit,_that.balances,_that.commissionRates);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int uid,  String accountType,  bool canTrade,  bool canWithdraw,  bool canDeposit,  List<Balance> balances,  CommissionRates commissionRates)?  $default,) {final _that = this;
switch (_that) {
case _AccountInfo() when $default != null:
return $default(_that.uid,_that.accountType,_that.canTrade,_that.canWithdraw,_that.canDeposit,_that.balances,_that.commissionRates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountInfo implements AccountInfo {
  const _AccountInfo({required this.uid, required this.accountType, required this.canTrade, required this.canWithdraw, required this.canDeposit, required final  List<Balance> balances, required this.commissionRates}): _balances = balances;
  factory _AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);

@override final  int uid;
@override final  String accountType;
@override final  bool canTrade;
@override final  bool canWithdraw;
@override final  bool canDeposit;
 final  List<Balance> _balances;
@override List<Balance> get balances {
  if (_balances is EqualUnmodifiableListView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_balances);
}

@override final  CommissionRates commissionRates;

/// Create a copy of AccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountInfoCopyWith<_AccountInfo> get copyWith => __$AccountInfoCopyWithImpl<_AccountInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountInfo&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.canTrade, canTrade) || other.canTrade == canTrade)&&(identical(other.canWithdraw, canWithdraw) || other.canWithdraw == canWithdraw)&&(identical(other.canDeposit, canDeposit) || other.canDeposit == canDeposit)&&const DeepCollectionEquality().equals(other._balances, _balances)&&(identical(other.commissionRates, commissionRates) || other.commissionRates == commissionRates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,accountType,canTrade,canWithdraw,canDeposit,const DeepCollectionEquality().hash(_balances),commissionRates);

@override
String toString() {
  return 'AccountInfo(uid: $uid, accountType: $accountType, canTrade: $canTrade, canWithdraw: $canWithdraw, canDeposit: $canDeposit, balances: $balances, commissionRates: $commissionRates)';
}


}

/// @nodoc
abstract mixin class _$AccountInfoCopyWith<$Res> implements $AccountInfoCopyWith<$Res> {
  factory _$AccountInfoCopyWith(_AccountInfo value, $Res Function(_AccountInfo) _then) = __$AccountInfoCopyWithImpl;
@override @useResult
$Res call({
 int uid, String accountType, bool canTrade, bool canWithdraw, bool canDeposit, List<Balance> balances, CommissionRates commissionRates
});


@override $CommissionRatesCopyWith<$Res> get commissionRates;

}
/// @nodoc
class __$AccountInfoCopyWithImpl<$Res>
    implements _$AccountInfoCopyWith<$Res> {
  __$AccountInfoCopyWithImpl(this._self, this._then);

  final _AccountInfo _self;
  final $Res Function(_AccountInfo) _then;

/// Create a copy of AccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? accountType = null,Object? canTrade = null,Object? canWithdraw = null,Object? canDeposit = null,Object? balances = null,Object? commissionRates = null,}) {
  return _then(_AccountInfo(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as String,canTrade: null == canTrade ? _self.canTrade : canTrade // ignore: cast_nullable_to_non_nullable
as bool,canWithdraw: null == canWithdraw ? _self.canWithdraw : canWithdraw // ignore: cast_nullable_to_non_nullable
as bool,canDeposit: null == canDeposit ? _self.canDeposit : canDeposit // ignore: cast_nullable_to_non_nullable
as bool,balances: null == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as List<Balance>,commissionRates: null == commissionRates ? _self.commissionRates : commissionRates // ignore: cast_nullable_to_non_nullable
as CommissionRates,
  ));
}

/// Create a copy of AccountInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommissionRatesCopyWith<$Res> get commissionRates {
  
  return $CommissionRatesCopyWith<$Res>(_self.commissionRates, (value) {
    return _then(_self.copyWith(commissionRates: value));
  });
}
}


/// @nodoc
mixin _$Balance {

 String get asset; String get free; String get locked;
/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceCopyWith<Balance> get copyWith => _$BalanceCopyWithImpl<Balance>(this as Balance, _$identity);

  /// Serializes this Balance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Balance&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.free, free) || other.free == free)&&(identical(other.locked, locked) || other.locked == locked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,free,locked);

@override
String toString() {
  return 'Balance(asset: $asset, free: $free, locked: $locked)';
}


}

/// @nodoc
abstract mixin class $BalanceCopyWith<$Res>  {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) _then) = _$BalanceCopyWithImpl;
@useResult
$Res call({
 String asset, String free, String locked
});




}
/// @nodoc
class _$BalanceCopyWithImpl<$Res>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._self, this._then);

  final Balance _self;
  final $Res Function(Balance) _then;

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? free = null,Object? locked = null,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Balance].
extension BalancePatterns on Balance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Balance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Balance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Balance value)  $default,){
final _that = this;
switch (_that) {
case _Balance():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Balance value)?  $default,){
final _that = this;
switch (_that) {
case _Balance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String asset,  String free,  String locked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Balance() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String asset,  String free,  String locked)  $default,) {final _that = this;
switch (_that) {
case _Balance():
return $default(_that.asset,_that.free,_that.locked);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String asset,  String free,  String locked)?  $default,) {final _that = this;
switch (_that) {
case _Balance() when $default != null:
return $default(_that.asset,_that.free,_that.locked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Balance implements Balance {
  const _Balance({required this.asset, required this.free, required this.locked});
  factory _Balance.fromJson(Map<String, dynamic> json) => _$BalanceFromJson(json);

@override final  String asset;
@override final  String free;
@override final  String locked;

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceCopyWith<_Balance> get copyWith => __$BalanceCopyWithImpl<_Balance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Balance&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.free, free) || other.free == free)&&(identical(other.locked, locked) || other.locked == locked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,free,locked);

@override
String toString() {
  return 'Balance(asset: $asset, free: $free, locked: $locked)';
}


}

/// @nodoc
abstract mixin class _$BalanceCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$BalanceCopyWith(_Balance value, $Res Function(_Balance) _then) = __$BalanceCopyWithImpl;
@override @useResult
$Res call({
 String asset, String free, String locked
});




}
/// @nodoc
class __$BalanceCopyWithImpl<$Res>
    implements _$BalanceCopyWith<$Res> {
  __$BalanceCopyWithImpl(this._self, this._then);

  final _Balance _self;
  final $Res Function(_Balance) _then;

/// Create a copy of Balance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? free = null,Object? locked = null,}) {
  return _then(_Balance(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommissionRates {

 String get maker; String get taker; String get buyer; String get seller;
/// Create a copy of CommissionRates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommissionRatesCopyWith<CommissionRates> get copyWith => _$CommissionRatesCopyWithImpl<CommissionRates>(this as CommissionRates, _$identity);

  /// Serializes this CommissionRates to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommissionRates&&(identical(other.maker, maker) || other.maker == maker)&&(identical(other.taker, taker) || other.taker == taker)&&(identical(other.buyer, buyer) || other.buyer == buyer)&&(identical(other.seller, seller) || other.seller == seller));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maker,taker,buyer,seller);

@override
String toString() {
  return 'CommissionRates(maker: $maker, taker: $taker, buyer: $buyer, seller: $seller)';
}


}

/// @nodoc
abstract mixin class $CommissionRatesCopyWith<$Res>  {
  factory $CommissionRatesCopyWith(CommissionRates value, $Res Function(CommissionRates) _then) = _$CommissionRatesCopyWithImpl;
@useResult
$Res call({
 String maker, String taker, String buyer, String seller
});




}
/// @nodoc
class _$CommissionRatesCopyWithImpl<$Res>
    implements $CommissionRatesCopyWith<$Res> {
  _$CommissionRatesCopyWithImpl(this._self, this._then);

  final CommissionRates _self;
  final $Res Function(CommissionRates) _then;

/// Create a copy of CommissionRates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maker = null,Object? taker = null,Object? buyer = null,Object? seller = null,}) {
  return _then(_self.copyWith(
maker: null == maker ? _self.maker : maker // ignore: cast_nullable_to_non_nullable
as String,taker: null == taker ? _self.taker : taker // ignore: cast_nullable_to_non_nullable
as String,buyer: null == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as String,seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommissionRates].
extension CommissionRatesPatterns on CommissionRates {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommissionRates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommissionRates() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommissionRates value)  $default,){
final _that = this;
switch (_that) {
case _CommissionRates():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommissionRates value)?  $default,){
final _that = this;
switch (_that) {
case _CommissionRates() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String maker,  String taker,  String buyer,  String seller)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommissionRates() when $default != null:
return $default(_that.maker,_that.taker,_that.buyer,_that.seller);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String maker,  String taker,  String buyer,  String seller)  $default,) {final _that = this;
switch (_that) {
case _CommissionRates():
return $default(_that.maker,_that.taker,_that.buyer,_that.seller);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String maker,  String taker,  String buyer,  String seller)?  $default,) {final _that = this;
switch (_that) {
case _CommissionRates() when $default != null:
return $default(_that.maker,_that.taker,_that.buyer,_that.seller);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommissionRates implements CommissionRates {
  const _CommissionRates({required this.maker, required this.taker, required this.buyer, required this.seller});
  factory _CommissionRates.fromJson(Map<String, dynamic> json) => _$CommissionRatesFromJson(json);

@override final  String maker;
@override final  String taker;
@override final  String buyer;
@override final  String seller;

/// Create a copy of CommissionRates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommissionRatesCopyWith<_CommissionRates> get copyWith => __$CommissionRatesCopyWithImpl<_CommissionRates>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommissionRatesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommissionRates&&(identical(other.maker, maker) || other.maker == maker)&&(identical(other.taker, taker) || other.taker == taker)&&(identical(other.buyer, buyer) || other.buyer == buyer)&&(identical(other.seller, seller) || other.seller == seller));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maker,taker,buyer,seller);

@override
String toString() {
  return 'CommissionRates(maker: $maker, taker: $taker, buyer: $buyer, seller: $seller)';
}


}

/// @nodoc
abstract mixin class _$CommissionRatesCopyWith<$Res> implements $CommissionRatesCopyWith<$Res> {
  factory _$CommissionRatesCopyWith(_CommissionRates value, $Res Function(_CommissionRates) _then) = __$CommissionRatesCopyWithImpl;
@override @useResult
$Res call({
 String maker, String taker, String buyer, String seller
});




}
/// @nodoc
class __$CommissionRatesCopyWithImpl<$Res>
    implements _$CommissionRatesCopyWith<$Res> {
  __$CommissionRatesCopyWithImpl(this._self, this._then);

  final _CommissionRates _self;
  final $Res Function(_CommissionRates) _then;

/// Create a copy of CommissionRates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maker = null,Object? taker = null,Object? buyer = null,Object? seller = null,}) {
  return _then(_CommissionRates(
maker: null == maker ? _self.maker : maker // ignore: cast_nullable_to_non_nullable
as String,taker: null == taker ? _self.taker : taker // ignore: cast_nullable_to_non_nullable
as String,buyer: null == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as String,seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
