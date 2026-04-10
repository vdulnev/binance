// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'futures_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FuturesOrder {

 String get symbol; int get orderId; String get clientOrderId;@DecimalConverter() Decimal get price;@DecimalConverter() Decimal get origQty;@DecimalConverter() Decimal get executedQty;@DecimalConverter() Decimal get cumQuote; OrderStatus get status; OrderType get type; OrderSide get side; TimeInForce? get timeInForce;@DecimalConverter() Decimal? get stopPrice;@DecimalConverter() Decimal? get activatePrice;@NullableDecimalConverter() Decimal? get priceRate; bool get reduceOnly; bool get closePosition; String? get positionSide; String? get workingType; bool get priceProtect; int get time; int get updateTime;
/// Create a copy of FuturesOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesOrderCopyWith<FuturesOrder> get copyWith => _$FuturesOrderCopyWithImpl<FuturesOrder>(this as FuturesOrder, _$identity);

  /// Serializes this FuturesOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesOrder&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&(identical(other.price, price) || other.price == price)&&(identical(other.origQty, origQty) || other.origQty == origQty)&&(identical(other.executedQty, executedQty) || other.executedQty == executedQty)&&(identical(other.cumQuote, cumQuote) || other.cumQuote == cumQuote)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.side, side) || other.side == side)&&(identical(other.timeInForce, timeInForce) || other.timeInForce == timeInForce)&&(identical(other.stopPrice, stopPrice) || other.stopPrice == stopPrice)&&(identical(other.activatePrice, activatePrice) || other.activatePrice == activatePrice)&&(identical(other.priceRate, priceRate) || other.priceRate == priceRate)&&(identical(other.reduceOnly, reduceOnly) || other.reduceOnly == reduceOnly)&&(identical(other.closePosition, closePosition) || other.closePosition == closePosition)&&(identical(other.positionSide, positionSide) || other.positionSide == positionSide)&&(identical(other.workingType, workingType) || other.workingType == workingType)&&(identical(other.priceProtect, priceProtect) || other.priceProtect == priceProtect)&&(identical(other.time, time) || other.time == time)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,symbol,orderId,clientOrderId,price,origQty,executedQty,cumQuote,status,type,side,timeInForce,stopPrice,activatePrice,priceRate,reduceOnly,closePosition,positionSide,workingType,priceProtect,time,updateTime]);

@override
String toString() {
  return 'FuturesOrder(symbol: $symbol, orderId: $orderId, clientOrderId: $clientOrderId, price: $price, origQty: $origQty, executedQty: $executedQty, cumQuote: $cumQuote, status: $status, type: $type, side: $side, timeInForce: $timeInForce, stopPrice: $stopPrice, activatePrice: $activatePrice, priceRate: $priceRate, reduceOnly: $reduceOnly, closePosition: $closePosition, positionSide: $positionSide, workingType: $workingType, priceProtect: $priceProtect, time: $time, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $FuturesOrderCopyWith<$Res>  {
  factory $FuturesOrderCopyWith(FuturesOrder value, $Res Function(FuturesOrder) _then) = _$FuturesOrderCopyWithImpl;
@useResult
$Res call({
 String symbol, int orderId, String clientOrderId,@DecimalConverter() Decimal price,@DecimalConverter() Decimal origQty,@DecimalConverter() Decimal executedQty,@DecimalConverter() Decimal cumQuote, OrderStatus status, OrderType type, OrderSide side, TimeInForce? timeInForce,@DecimalConverter() Decimal? stopPrice,@DecimalConverter() Decimal? activatePrice,@NullableDecimalConverter() Decimal? priceRate, bool reduceOnly, bool closePosition, String? positionSide, String? workingType, bool priceProtect, int time, int updateTime
});




}
/// @nodoc
class _$FuturesOrderCopyWithImpl<$Res>
    implements $FuturesOrderCopyWith<$Res> {
  _$FuturesOrderCopyWithImpl(this._self, this._then);

  final FuturesOrder _self;
  final $Res Function(FuturesOrder) _then;

/// Create a copy of FuturesOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? orderId = null,Object? clientOrderId = null,Object? price = null,Object? origQty = null,Object? executedQty = null,Object? cumQuote = null,Object? status = null,Object? type = null,Object? side = null,Object? timeInForce = freezed,Object? stopPrice = freezed,Object? activatePrice = freezed,Object? priceRate = freezed,Object? reduceOnly = null,Object? closePosition = null,Object? positionSide = freezed,Object? workingType = freezed,Object? priceProtect = null,Object? time = null,Object? updateTime = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,origQty: null == origQty ? _self.origQty : origQty // ignore: cast_nullable_to_non_nullable
as Decimal,executedQty: null == executedQty ? _self.executedQty : executedQty // ignore: cast_nullable_to_non_nullable
as Decimal,cumQuote: null == cumQuote ? _self.cumQuote : cumQuote // ignore: cast_nullable_to_non_nullable
as Decimal,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OrderType,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,timeInForce: freezed == timeInForce ? _self.timeInForce : timeInForce // ignore: cast_nullable_to_non_nullable
as TimeInForce?,stopPrice: freezed == stopPrice ? _self.stopPrice : stopPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,activatePrice: freezed == activatePrice ? _self.activatePrice : activatePrice // ignore: cast_nullable_to_non_nullable
as Decimal?,priceRate: freezed == priceRate ? _self.priceRate : priceRate // ignore: cast_nullable_to_non_nullable
as Decimal?,reduceOnly: null == reduceOnly ? _self.reduceOnly : reduceOnly // ignore: cast_nullable_to_non_nullable
as bool,closePosition: null == closePosition ? _self.closePosition : closePosition // ignore: cast_nullable_to_non_nullable
as bool,positionSide: freezed == positionSide ? _self.positionSide : positionSide // ignore: cast_nullable_to_non_nullable
as String?,workingType: freezed == workingType ? _self.workingType : workingType // ignore: cast_nullable_to_non_nullable
as String?,priceProtect: null == priceProtect ? _self.priceProtect : priceProtect // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FuturesOrder].
extension FuturesOrderPatterns on FuturesOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FuturesOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FuturesOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FuturesOrder value)  $default,){
final _that = this;
switch (_that) {
case _FuturesOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FuturesOrder value)?  $default,){
final _that = this;
switch (_that) {
case _FuturesOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  int orderId,  String clientOrderId, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal origQty, @DecimalConverter()  Decimal executedQty, @DecimalConverter()  Decimal cumQuote,  OrderStatus status,  OrderType type,  OrderSide side,  TimeInForce? timeInForce, @DecimalConverter()  Decimal? stopPrice, @DecimalConverter()  Decimal? activatePrice, @NullableDecimalConverter()  Decimal? priceRate,  bool reduceOnly,  bool closePosition,  String? positionSide,  String? workingType,  bool priceProtect,  int time,  int updateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FuturesOrder() when $default != null:
return $default(_that.symbol,_that.orderId,_that.clientOrderId,_that.price,_that.origQty,_that.executedQty,_that.cumQuote,_that.status,_that.type,_that.side,_that.timeInForce,_that.stopPrice,_that.activatePrice,_that.priceRate,_that.reduceOnly,_that.closePosition,_that.positionSide,_that.workingType,_that.priceProtect,_that.time,_that.updateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  int orderId,  String clientOrderId, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal origQty, @DecimalConverter()  Decimal executedQty, @DecimalConverter()  Decimal cumQuote,  OrderStatus status,  OrderType type,  OrderSide side,  TimeInForce? timeInForce, @DecimalConverter()  Decimal? stopPrice, @DecimalConverter()  Decimal? activatePrice, @NullableDecimalConverter()  Decimal? priceRate,  bool reduceOnly,  bool closePosition,  String? positionSide,  String? workingType,  bool priceProtect,  int time,  int updateTime)  $default,) {final _that = this;
switch (_that) {
case _FuturesOrder():
return $default(_that.symbol,_that.orderId,_that.clientOrderId,_that.price,_that.origQty,_that.executedQty,_that.cumQuote,_that.status,_that.type,_that.side,_that.timeInForce,_that.stopPrice,_that.activatePrice,_that.priceRate,_that.reduceOnly,_that.closePosition,_that.positionSide,_that.workingType,_that.priceProtect,_that.time,_that.updateTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  int orderId,  String clientOrderId, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal origQty, @DecimalConverter()  Decimal executedQty, @DecimalConverter()  Decimal cumQuote,  OrderStatus status,  OrderType type,  OrderSide side,  TimeInForce? timeInForce, @DecimalConverter()  Decimal? stopPrice, @DecimalConverter()  Decimal? activatePrice, @NullableDecimalConverter()  Decimal? priceRate,  bool reduceOnly,  bool closePosition,  String? positionSide,  String? workingType,  bool priceProtect,  int time,  int updateTime)?  $default,) {final _that = this;
switch (_that) {
case _FuturesOrder() when $default != null:
return $default(_that.symbol,_that.orderId,_that.clientOrderId,_that.price,_that.origQty,_that.executedQty,_that.cumQuote,_that.status,_that.type,_that.side,_that.timeInForce,_that.stopPrice,_that.activatePrice,_that.priceRate,_that.reduceOnly,_that.closePosition,_that.positionSide,_that.workingType,_that.priceProtect,_that.time,_that.updateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FuturesOrder extends FuturesOrder {
  const _FuturesOrder({required this.symbol, required this.orderId, required this.clientOrderId, @DecimalConverter() required this.price, @DecimalConverter() required this.origQty, @DecimalConverter() required this.executedQty, @DecimalConverter() required this.cumQuote, required this.status, required this.type, required this.side, this.timeInForce, @DecimalConverter() this.stopPrice, @DecimalConverter() this.activatePrice, @NullableDecimalConverter() this.priceRate, this.reduceOnly = false, this.closePosition = false, this.positionSide, this.workingType, this.priceProtect = false, required this.time, required this.updateTime}): super._();
  factory _FuturesOrder.fromJson(Map<String, dynamic> json) => _$FuturesOrderFromJson(json);

@override final  String symbol;
@override final  int orderId;
@override final  String clientOrderId;
@override@DecimalConverter() final  Decimal price;
@override@DecimalConverter() final  Decimal origQty;
@override@DecimalConverter() final  Decimal executedQty;
@override@DecimalConverter() final  Decimal cumQuote;
@override final  OrderStatus status;
@override final  OrderType type;
@override final  OrderSide side;
@override final  TimeInForce? timeInForce;
@override@DecimalConverter() final  Decimal? stopPrice;
@override@DecimalConverter() final  Decimal? activatePrice;
@override@NullableDecimalConverter() final  Decimal? priceRate;
@override@JsonKey() final  bool reduceOnly;
@override@JsonKey() final  bool closePosition;
@override final  String? positionSide;
@override final  String? workingType;
@override@JsonKey() final  bool priceProtect;
@override final  int time;
@override final  int updateTime;

/// Create a copy of FuturesOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FuturesOrderCopyWith<_FuturesOrder> get copyWith => __$FuturesOrderCopyWithImpl<_FuturesOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FuturesOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FuturesOrder&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&(identical(other.price, price) || other.price == price)&&(identical(other.origQty, origQty) || other.origQty == origQty)&&(identical(other.executedQty, executedQty) || other.executedQty == executedQty)&&(identical(other.cumQuote, cumQuote) || other.cumQuote == cumQuote)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.side, side) || other.side == side)&&(identical(other.timeInForce, timeInForce) || other.timeInForce == timeInForce)&&(identical(other.stopPrice, stopPrice) || other.stopPrice == stopPrice)&&(identical(other.activatePrice, activatePrice) || other.activatePrice == activatePrice)&&(identical(other.priceRate, priceRate) || other.priceRate == priceRate)&&(identical(other.reduceOnly, reduceOnly) || other.reduceOnly == reduceOnly)&&(identical(other.closePosition, closePosition) || other.closePosition == closePosition)&&(identical(other.positionSide, positionSide) || other.positionSide == positionSide)&&(identical(other.workingType, workingType) || other.workingType == workingType)&&(identical(other.priceProtect, priceProtect) || other.priceProtect == priceProtect)&&(identical(other.time, time) || other.time == time)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,symbol,orderId,clientOrderId,price,origQty,executedQty,cumQuote,status,type,side,timeInForce,stopPrice,activatePrice,priceRate,reduceOnly,closePosition,positionSide,workingType,priceProtect,time,updateTime]);

@override
String toString() {
  return 'FuturesOrder(symbol: $symbol, orderId: $orderId, clientOrderId: $clientOrderId, price: $price, origQty: $origQty, executedQty: $executedQty, cumQuote: $cumQuote, status: $status, type: $type, side: $side, timeInForce: $timeInForce, stopPrice: $stopPrice, activatePrice: $activatePrice, priceRate: $priceRate, reduceOnly: $reduceOnly, closePosition: $closePosition, positionSide: $positionSide, workingType: $workingType, priceProtect: $priceProtect, time: $time, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class _$FuturesOrderCopyWith<$Res> implements $FuturesOrderCopyWith<$Res> {
  factory _$FuturesOrderCopyWith(_FuturesOrder value, $Res Function(_FuturesOrder) _then) = __$FuturesOrderCopyWithImpl;
@override @useResult
$Res call({
 String symbol, int orderId, String clientOrderId,@DecimalConverter() Decimal price,@DecimalConverter() Decimal origQty,@DecimalConverter() Decimal executedQty,@DecimalConverter() Decimal cumQuote, OrderStatus status, OrderType type, OrderSide side, TimeInForce? timeInForce,@DecimalConverter() Decimal? stopPrice,@DecimalConverter() Decimal? activatePrice,@NullableDecimalConverter() Decimal? priceRate, bool reduceOnly, bool closePosition, String? positionSide, String? workingType, bool priceProtect, int time, int updateTime
});




}
/// @nodoc
class __$FuturesOrderCopyWithImpl<$Res>
    implements _$FuturesOrderCopyWith<$Res> {
  __$FuturesOrderCopyWithImpl(this._self, this._then);

  final _FuturesOrder _self;
  final $Res Function(_FuturesOrder) _then;

/// Create a copy of FuturesOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? orderId = null,Object? clientOrderId = null,Object? price = null,Object? origQty = null,Object? executedQty = null,Object? cumQuote = null,Object? status = null,Object? type = null,Object? side = null,Object? timeInForce = freezed,Object? stopPrice = freezed,Object? activatePrice = freezed,Object? priceRate = freezed,Object? reduceOnly = null,Object? closePosition = null,Object? positionSide = freezed,Object? workingType = freezed,Object? priceProtect = null,Object? time = null,Object? updateTime = null,}) {
  return _then(_FuturesOrder(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,origQty: null == origQty ? _self.origQty : origQty // ignore: cast_nullable_to_non_nullable
as Decimal,executedQty: null == executedQty ? _self.executedQty : executedQty // ignore: cast_nullable_to_non_nullable
as Decimal,cumQuote: null == cumQuote ? _self.cumQuote : cumQuote // ignore: cast_nullable_to_non_nullable
as Decimal,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OrderType,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,timeInForce: freezed == timeInForce ? _self.timeInForce : timeInForce // ignore: cast_nullable_to_non_nullable
as TimeInForce?,stopPrice: freezed == stopPrice ? _self.stopPrice : stopPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,activatePrice: freezed == activatePrice ? _self.activatePrice : activatePrice // ignore: cast_nullable_to_non_nullable
as Decimal?,priceRate: freezed == priceRate ? _self.priceRate : priceRate // ignore: cast_nullable_to_non_nullable
as Decimal?,reduceOnly: null == reduceOnly ? _self.reduceOnly : reduceOnly // ignore: cast_nullable_to_non_nullable
as bool,closePosition: null == closePosition ? _self.closePosition : closePosition // ignore: cast_nullable_to_non_nullable
as bool,positionSide: freezed == positionSide ? _self.positionSide : positionSide // ignore: cast_nullable_to_non_nullable
as String?,workingType: freezed == workingType ? _self.workingType : workingType // ignore: cast_nullable_to_non_nullable
as String?,priceProtect: null == priceProtect ? _self.priceProtect : priceProtect // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
