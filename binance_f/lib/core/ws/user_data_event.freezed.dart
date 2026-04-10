// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserDataEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserDataEvent()';
}


}

/// @nodoc
class $UserDataEventCopyWith<$Res>  {
$UserDataEventCopyWith(UserDataEvent _, $Res Function(UserDataEvent) __);
}


/// Adds pattern-matching-related methods to [UserDataEvent].
extension UserDataEventPatterns on UserDataEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountUpdate value)?  accountUpdate,TResult Function( FuturesAccountUpdate value)?  futuresAccountUpdate,TResult Function( SpotOrderUpdate value)?  spotOrderUpdate,TResult Function( FuturesOrderUpdate value)?  futuresOrderUpdate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that);case SpotOrderUpdate() when spotOrderUpdate != null:
return spotOrderUpdate(_that);case FuturesOrderUpdate() when futuresOrderUpdate != null:
return futuresOrderUpdate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountUpdate value)  accountUpdate,required TResult Function( FuturesAccountUpdate value)  futuresAccountUpdate,required TResult Function( SpotOrderUpdate value)  spotOrderUpdate,required TResult Function( FuturesOrderUpdate value)  futuresOrderUpdate,}){
final _that = this;
switch (_that) {
case AccountUpdate():
return accountUpdate(_that);case FuturesAccountUpdate():
return futuresAccountUpdate(_that);case SpotOrderUpdate():
return spotOrderUpdate(_that);case FuturesOrderUpdate():
return futuresOrderUpdate(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountUpdate value)?  accountUpdate,TResult? Function( FuturesAccountUpdate value)?  futuresAccountUpdate,TResult? Function( SpotOrderUpdate value)?  spotOrderUpdate,TResult? Function( FuturesOrderUpdate value)?  futuresOrderUpdate,}){
final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that);case SpotOrderUpdate() when spotOrderUpdate != null:
return spotOrderUpdate(_that);case FuturesOrderUpdate() when futuresOrderUpdate != null:
return futuresOrderUpdate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<SpotBalance> balances)?  accountUpdate,TResult Function( List<FuturesAssetBalance> assets,  List<FuturesPosition> positions)?  futuresAccountUpdate,TResult Function( String symbol,  int orderId,  String clientOrderId,  OrderSide side,  OrderType orderType,  OrderStatus status,  Decimal price,  Decimal origQty,  Decimal executedQty,  Decimal cummulativeQuoteQty,  TimeInForce? timeInForce,  Decimal? stopPrice,  int time,  int updateTime)?  spotOrderUpdate,TResult Function( String symbol,  int orderId,  String clientOrderId,  OrderSide side,  OrderType orderType,  OrderStatus status,  Decimal price,  Decimal origQty,  Decimal executedQty,  Decimal cumQuote,  TimeInForce? timeInForce,  Decimal? stopPrice,  Decimal? activatePrice,  Decimal? callbackRate,  bool reduceOnly,  int time,  int updateTime)?  futuresOrderUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that.balances);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that.assets,_that.positions);case SpotOrderUpdate() when spotOrderUpdate != null:
return spotOrderUpdate(_that.symbol,_that.orderId,_that.clientOrderId,_that.side,_that.orderType,_that.status,_that.price,_that.origQty,_that.executedQty,_that.cummulativeQuoteQty,_that.timeInForce,_that.stopPrice,_that.time,_that.updateTime);case FuturesOrderUpdate() when futuresOrderUpdate != null:
return futuresOrderUpdate(_that.symbol,_that.orderId,_that.clientOrderId,_that.side,_that.orderType,_that.status,_that.price,_that.origQty,_that.executedQty,_that.cumQuote,_that.timeInForce,_that.stopPrice,_that.activatePrice,_that.callbackRate,_that.reduceOnly,_that.time,_that.updateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<SpotBalance> balances)  accountUpdate,required TResult Function( List<FuturesAssetBalance> assets,  List<FuturesPosition> positions)  futuresAccountUpdate,required TResult Function( String symbol,  int orderId,  String clientOrderId,  OrderSide side,  OrderType orderType,  OrderStatus status,  Decimal price,  Decimal origQty,  Decimal executedQty,  Decimal cummulativeQuoteQty,  TimeInForce? timeInForce,  Decimal? stopPrice,  int time,  int updateTime)  spotOrderUpdate,required TResult Function( String symbol,  int orderId,  String clientOrderId,  OrderSide side,  OrderType orderType,  OrderStatus status,  Decimal price,  Decimal origQty,  Decimal executedQty,  Decimal cumQuote,  TimeInForce? timeInForce,  Decimal? stopPrice,  Decimal? activatePrice,  Decimal? callbackRate,  bool reduceOnly,  int time,  int updateTime)  futuresOrderUpdate,}) {final _that = this;
switch (_that) {
case AccountUpdate():
return accountUpdate(_that.balances);case FuturesAccountUpdate():
return futuresAccountUpdate(_that.assets,_that.positions);case SpotOrderUpdate():
return spotOrderUpdate(_that.symbol,_that.orderId,_that.clientOrderId,_that.side,_that.orderType,_that.status,_that.price,_that.origQty,_that.executedQty,_that.cummulativeQuoteQty,_that.timeInForce,_that.stopPrice,_that.time,_that.updateTime);case FuturesOrderUpdate():
return futuresOrderUpdate(_that.symbol,_that.orderId,_that.clientOrderId,_that.side,_that.orderType,_that.status,_that.price,_that.origQty,_that.executedQty,_that.cumQuote,_that.timeInForce,_that.stopPrice,_that.activatePrice,_that.callbackRate,_that.reduceOnly,_that.time,_that.updateTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<SpotBalance> balances)?  accountUpdate,TResult? Function( List<FuturesAssetBalance> assets,  List<FuturesPosition> positions)?  futuresAccountUpdate,TResult? Function( String symbol,  int orderId,  String clientOrderId,  OrderSide side,  OrderType orderType,  OrderStatus status,  Decimal price,  Decimal origQty,  Decimal executedQty,  Decimal cummulativeQuoteQty,  TimeInForce? timeInForce,  Decimal? stopPrice,  int time,  int updateTime)?  spotOrderUpdate,TResult? Function( String symbol,  int orderId,  String clientOrderId,  OrderSide side,  OrderType orderType,  OrderStatus status,  Decimal price,  Decimal origQty,  Decimal executedQty,  Decimal cumQuote,  TimeInForce? timeInForce,  Decimal? stopPrice,  Decimal? activatePrice,  Decimal? callbackRate,  bool reduceOnly,  int time,  int updateTime)?  futuresOrderUpdate,}) {final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that.balances);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that.assets,_that.positions);case SpotOrderUpdate() when spotOrderUpdate != null:
return spotOrderUpdate(_that.symbol,_that.orderId,_that.clientOrderId,_that.side,_that.orderType,_that.status,_that.price,_that.origQty,_that.executedQty,_that.cummulativeQuoteQty,_that.timeInForce,_that.stopPrice,_that.time,_that.updateTime);case FuturesOrderUpdate() when futuresOrderUpdate != null:
return futuresOrderUpdate(_that.symbol,_that.orderId,_that.clientOrderId,_that.side,_that.orderType,_that.status,_that.price,_that.origQty,_that.executedQty,_that.cumQuote,_that.timeInForce,_that.stopPrice,_that.activatePrice,_that.callbackRate,_that.reduceOnly,_that.time,_that.updateTime);case _:
  return null;

}
}

}

/// @nodoc


class AccountUpdate extends UserDataEvent {
  const AccountUpdate({required final  List<SpotBalance> balances}): _balances = balances,super._();
  

 final  List<SpotBalance> _balances;
 List<SpotBalance> get balances {
  if (_balances is EqualUnmodifiableListView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_balances);
}


/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountUpdateCopyWith<AccountUpdate> get copyWith => _$AccountUpdateCopyWithImpl<AccountUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountUpdate&&const DeepCollectionEquality().equals(other._balances, _balances));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_balances));

@override
String toString() {
  return 'UserDataEvent.accountUpdate(balances: $balances)';
}


}

/// @nodoc
abstract mixin class $AccountUpdateCopyWith<$Res> implements $UserDataEventCopyWith<$Res> {
  factory $AccountUpdateCopyWith(AccountUpdate value, $Res Function(AccountUpdate) _then) = _$AccountUpdateCopyWithImpl;
@useResult
$Res call({
 List<SpotBalance> balances
});




}
/// @nodoc
class _$AccountUpdateCopyWithImpl<$Res>
    implements $AccountUpdateCopyWith<$Res> {
  _$AccountUpdateCopyWithImpl(this._self, this._then);

  final AccountUpdate _self;
  final $Res Function(AccountUpdate) _then;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? balances = null,}) {
  return _then(AccountUpdate(
balances: null == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as List<SpotBalance>,
  ));
}


}

/// @nodoc


class FuturesAccountUpdate extends UserDataEvent {
  const FuturesAccountUpdate({required final  List<FuturesAssetBalance> assets, required final  List<FuturesPosition> positions}): _assets = assets,_positions = positions,super._();
  

 final  List<FuturesAssetBalance> _assets;
 List<FuturesAssetBalance> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<FuturesPosition> _positions;
 List<FuturesPosition> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}


/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesAccountUpdateCopyWith<FuturesAccountUpdate> get copyWith => _$FuturesAccountUpdateCopyWithImpl<FuturesAccountUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesAccountUpdate&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._positions, _positions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_positions));

@override
String toString() {
  return 'UserDataEvent.futuresAccountUpdate(assets: $assets, positions: $positions)';
}


}

/// @nodoc
abstract mixin class $FuturesAccountUpdateCopyWith<$Res> implements $UserDataEventCopyWith<$Res> {
  factory $FuturesAccountUpdateCopyWith(FuturesAccountUpdate value, $Res Function(FuturesAccountUpdate) _then) = _$FuturesAccountUpdateCopyWithImpl;
@useResult
$Res call({
 List<FuturesAssetBalance> assets, List<FuturesPosition> positions
});




}
/// @nodoc
class _$FuturesAccountUpdateCopyWithImpl<$Res>
    implements $FuturesAccountUpdateCopyWith<$Res> {
  _$FuturesAccountUpdateCopyWithImpl(this._self, this._then);

  final FuturesAccountUpdate _self;
  final $Res Function(FuturesAccountUpdate) _then;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assets = null,Object? positions = null,}) {
  return _then(FuturesAccountUpdate(
assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<FuturesAssetBalance>,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<FuturesPosition>,
  ));
}


}

/// @nodoc


class SpotOrderUpdate extends UserDataEvent {
  const SpotOrderUpdate({required this.symbol, required this.orderId, required this.clientOrderId, required this.side, required this.orderType, required this.status, required this.price, required this.origQty, required this.executedQty, required this.cummulativeQuoteQty, this.timeInForce, this.stopPrice, required this.time, required this.updateTime}): super._();
  

 final  String symbol;
 final  int orderId;
 final  String clientOrderId;
 final  OrderSide side;
 final  OrderType orderType;
 final  OrderStatus status;
 final  Decimal price;
 final  Decimal origQty;
 final  Decimal executedQty;
 final  Decimal cummulativeQuoteQty;
 final  TimeInForce? timeInForce;
 final  Decimal? stopPrice;
 final  int time;
 final  int updateTime;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotOrderUpdateCopyWith<SpotOrderUpdate> get copyWith => _$SpotOrderUpdateCopyWithImpl<SpotOrderUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotOrderUpdate&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&(identical(other.side, side) || other.side == side)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&(identical(other.status, status) || other.status == status)&&(identical(other.price, price) || other.price == price)&&(identical(other.origQty, origQty) || other.origQty == origQty)&&(identical(other.executedQty, executedQty) || other.executedQty == executedQty)&&(identical(other.cummulativeQuoteQty, cummulativeQuoteQty) || other.cummulativeQuoteQty == cummulativeQuoteQty)&&(identical(other.timeInForce, timeInForce) || other.timeInForce == timeInForce)&&(identical(other.stopPrice, stopPrice) || other.stopPrice == stopPrice)&&(identical(other.time, time) || other.time == time)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,orderId,clientOrderId,side,orderType,status,price,origQty,executedQty,cummulativeQuoteQty,timeInForce,stopPrice,time,updateTime);

@override
String toString() {
  return 'UserDataEvent.spotOrderUpdate(symbol: $symbol, orderId: $orderId, clientOrderId: $clientOrderId, side: $side, orderType: $orderType, status: $status, price: $price, origQty: $origQty, executedQty: $executedQty, cummulativeQuoteQty: $cummulativeQuoteQty, timeInForce: $timeInForce, stopPrice: $stopPrice, time: $time, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $SpotOrderUpdateCopyWith<$Res> implements $UserDataEventCopyWith<$Res> {
  factory $SpotOrderUpdateCopyWith(SpotOrderUpdate value, $Res Function(SpotOrderUpdate) _then) = _$SpotOrderUpdateCopyWithImpl;
@useResult
$Res call({
 String symbol, int orderId, String clientOrderId, OrderSide side, OrderType orderType, OrderStatus status, Decimal price, Decimal origQty, Decimal executedQty, Decimal cummulativeQuoteQty, TimeInForce? timeInForce, Decimal? stopPrice, int time, int updateTime
});




}
/// @nodoc
class _$SpotOrderUpdateCopyWithImpl<$Res>
    implements $SpotOrderUpdateCopyWith<$Res> {
  _$SpotOrderUpdateCopyWithImpl(this._self, this._then);

  final SpotOrderUpdate _self;
  final $Res Function(SpotOrderUpdate) _then;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? orderId = null,Object? clientOrderId = null,Object? side = null,Object? orderType = null,Object? status = null,Object? price = null,Object? origQty = null,Object? executedQty = null,Object? cummulativeQuoteQty = null,Object? timeInForce = freezed,Object? stopPrice = freezed,Object? time = null,Object? updateTime = null,}) {
  return _then(SpotOrderUpdate(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as OrderType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,origQty: null == origQty ? _self.origQty : origQty // ignore: cast_nullable_to_non_nullable
as Decimal,executedQty: null == executedQty ? _self.executedQty : executedQty // ignore: cast_nullable_to_non_nullable
as Decimal,cummulativeQuoteQty: null == cummulativeQuoteQty ? _self.cummulativeQuoteQty : cummulativeQuoteQty // ignore: cast_nullable_to_non_nullable
as Decimal,timeInForce: freezed == timeInForce ? _self.timeInForce : timeInForce // ignore: cast_nullable_to_non_nullable
as TimeInForce?,stopPrice: freezed == stopPrice ? _self.stopPrice : stopPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class FuturesOrderUpdate extends UserDataEvent {
  const FuturesOrderUpdate({required this.symbol, required this.orderId, required this.clientOrderId, required this.side, required this.orderType, required this.status, required this.price, required this.origQty, required this.executedQty, required this.cumQuote, this.timeInForce, this.stopPrice, this.activatePrice, this.callbackRate, required this.reduceOnly, required this.time, required this.updateTime}): super._();
  

 final  String symbol;
 final  int orderId;
 final  String clientOrderId;
 final  OrderSide side;
 final  OrderType orderType;
 final  OrderStatus status;
 final  Decimal price;
 final  Decimal origQty;
 final  Decimal executedQty;
 final  Decimal cumQuote;
 final  TimeInForce? timeInForce;
 final  Decimal? stopPrice;
 final  Decimal? activatePrice;
 final  Decimal? callbackRate;
 final  bool reduceOnly;
 final  int time;
 final  int updateTime;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesOrderUpdateCopyWith<FuturesOrderUpdate> get copyWith => _$FuturesOrderUpdateCopyWithImpl<FuturesOrderUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesOrderUpdate&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&(identical(other.side, side) || other.side == side)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&(identical(other.status, status) || other.status == status)&&(identical(other.price, price) || other.price == price)&&(identical(other.origQty, origQty) || other.origQty == origQty)&&(identical(other.executedQty, executedQty) || other.executedQty == executedQty)&&(identical(other.cumQuote, cumQuote) || other.cumQuote == cumQuote)&&(identical(other.timeInForce, timeInForce) || other.timeInForce == timeInForce)&&(identical(other.stopPrice, stopPrice) || other.stopPrice == stopPrice)&&(identical(other.activatePrice, activatePrice) || other.activatePrice == activatePrice)&&(identical(other.callbackRate, callbackRate) || other.callbackRate == callbackRate)&&(identical(other.reduceOnly, reduceOnly) || other.reduceOnly == reduceOnly)&&(identical(other.time, time) || other.time == time)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,orderId,clientOrderId,side,orderType,status,price,origQty,executedQty,cumQuote,timeInForce,stopPrice,activatePrice,callbackRate,reduceOnly,time,updateTime);

@override
String toString() {
  return 'UserDataEvent.futuresOrderUpdate(symbol: $symbol, orderId: $orderId, clientOrderId: $clientOrderId, side: $side, orderType: $orderType, status: $status, price: $price, origQty: $origQty, executedQty: $executedQty, cumQuote: $cumQuote, timeInForce: $timeInForce, stopPrice: $stopPrice, activatePrice: $activatePrice, callbackRate: $callbackRate, reduceOnly: $reduceOnly, time: $time, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $FuturesOrderUpdateCopyWith<$Res> implements $UserDataEventCopyWith<$Res> {
  factory $FuturesOrderUpdateCopyWith(FuturesOrderUpdate value, $Res Function(FuturesOrderUpdate) _then) = _$FuturesOrderUpdateCopyWithImpl;
@useResult
$Res call({
 String symbol, int orderId, String clientOrderId, OrderSide side, OrderType orderType, OrderStatus status, Decimal price, Decimal origQty, Decimal executedQty, Decimal cumQuote, TimeInForce? timeInForce, Decimal? stopPrice, Decimal? activatePrice, Decimal? callbackRate, bool reduceOnly, int time, int updateTime
});




}
/// @nodoc
class _$FuturesOrderUpdateCopyWithImpl<$Res>
    implements $FuturesOrderUpdateCopyWith<$Res> {
  _$FuturesOrderUpdateCopyWithImpl(this._self, this._then);

  final FuturesOrderUpdate _self;
  final $Res Function(FuturesOrderUpdate) _then;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? orderId = null,Object? clientOrderId = null,Object? side = null,Object? orderType = null,Object? status = null,Object? price = null,Object? origQty = null,Object? executedQty = null,Object? cumQuote = null,Object? timeInForce = freezed,Object? stopPrice = freezed,Object? activatePrice = freezed,Object? callbackRate = freezed,Object? reduceOnly = null,Object? time = null,Object? updateTime = null,}) {
  return _then(FuturesOrderUpdate(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as OrderType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,origQty: null == origQty ? _self.origQty : origQty // ignore: cast_nullable_to_non_nullable
as Decimal,executedQty: null == executedQty ? _self.executedQty : executedQty // ignore: cast_nullable_to_non_nullable
as Decimal,cumQuote: null == cumQuote ? _self.cumQuote : cumQuote // ignore: cast_nullable_to_non_nullable
as Decimal,timeInForce: freezed == timeInForce ? _self.timeInForce : timeInForce // ignore: cast_nullable_to_non_nullable
as TimeInForce?,stopPrice: freezed == stopPrice ? _self.stopPrice : stopPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,activatePrice: freezed == activatePrice ? _self.activatePrice : activatePrice // ignore: cast_nullable_to_non_nullable
as Decimal?,callbackRate: freezed == callbackRate ? _self.callbackRate : callbackRate // ignore: cast_nullable_to_non_nullable
as Decimal?,reduceOnly: null == reduceOnly ? _self.reduceOnly : reduceOnly // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
