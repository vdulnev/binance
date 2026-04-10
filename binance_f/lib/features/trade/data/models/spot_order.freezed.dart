// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotOrder {

 String get symbol; int get orderId; String get clientOrderId;@DecimalConverter() Decimal get price;@DecimalConverter() Decimal get origQty;@DecimalConverter() Decimal get executedQty;@DecimalConverter() Decimal get cummulativeQuoteQty; OrderStatus get status; OrderType get type; OrderSide get side; TimeInForce? get timeInForce;@DecimalConverter() Decimal? get stopPrice; int? get orderListId; int get time; int get updateTime; List<OrderFill> get fills;
/// Create a copy of SpotOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotOrderCopyWith<SpotOrder> get copyWith => _$SpotOrderCopyWithImpl<SpotOrder>(this as SpotOrder, _$identity);

  /// Serializes this SpotOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotOrder&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&(identical(other.price, price) || other.price == price)&&(identical(other.origQty, origQty) || other.origQty == origQty)&&(identical(other.executedQty, executedQty) || other.executedQty == executedQty)&&(identical(other.cummulativeQuoteQty, cummulativeQuoteQty) || other.cummulativeQuoteQty == cummulativeQuoteQty)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.side, side) || other.side == side)&&(identical(other.timeInForce, timeInForce) || other.timeInForce == timeInForce)&&(identical(other.stopPrice, stopPrice) || other.stopPrice == stopPrice)&&(identical(other.orderListId, orderListId) || other.orderListId == orderListId)&&(identical(other.time, time) || other.time == time)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime)&&const DeepCollectionEquality().equals(other.fills, fills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,orderId,clientOrderId,price,origQty,executedQty,cummulativeQuoteQty,status,type,side,timeInForce,stopPrice,orderListId,time,updateTime,const DeepCollectionEquality().hash(fills));

@override
String toString() {
  return 'SpotOrder(symbol: $symbol, orderId: $orderId, clientOrderId: $clientOrderId, price: $price, origQty: $origQty, executedQty: $executedQty, cummulativeQuoteQty: $cummulativeQuoteQty, status: $status, type: $type, side: $side, timeInForce: $timeInForce, stopPrice: $stopPrice, orderListId: $orderListId, time: $time, updateTime: $updateTime, fills: $fills)';
}


}

/// @nodoc
abstract mixin class $SpotOrderCopyWith<$Res>  {
  factory $SpotOrderCopyWith(SpotOrder value, $Res Function(SpotOrder) _then) = _$SpotOrderCopyWithImpl;
@useResult
$Res call({
 String symbol, int orderId, String clientOrderId,@DecimalConverter() Decimal price,@DecimalConverter() Decimal origQty,@DecimalConverter() Decimal executedQty,@DecimalConverter() Decimal cummulativeQuoteQty, OrderStatus status, OrderType type, OrderSide side, TimeInForce? timeInForce,@DecimalConverter() Decimal? stopPrice, int? orderListId, int time, int updateTime, List<OrderFill> fills
});




}
/// @nodoc
class _$SpotOrderCopyWithImpl<$Res>
    implements $SpotOrderCopyWith<$Res> {
  _$SpotOrderCopyWithImpl(this._self, this._then);

  final SpotOrder _self;
  final $Res Function(SpotOrder) _then;

/// Create a copy of SpotOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? orderId = null,Object? clientOrderId = null,Object? price = null,Object? origQty = null,Object? executedQty = null,Object? cummulativeQuoteQty = null,Object? status = null,Object? type = null,Object? side = null,Object? timeInForce = freezed,Object? stopPrice = freezed,Object? orderListId = freezed,Object? time = null,Object? updateTime = null,Object? fills = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,origQty: null == origQty ? _self.origQty : origQty // ignore: cast_nullable_to_non_nullable
as Decimal,executedQty: null == executedQty ? _self.executedQty : executedQty // ignore: cast_nullable_to_non_nullable
as Decimal,cummulativeQuoteQty: null == cummulativeQuoteQty ? _self.cummulativeQuoteQty : cummulativeQuoteQty // ignore: cast_nullable_to_non_nullable
as Decimal,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OrderType,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,timeInForce: freezed == timeInForce ? _self.timeInForce : timeInForce // ignore: cast_nullable_to_non_nullable
as TimeInForce?,stopPrice: freezed == stopPrice ? _self.stopPrice : stopPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,orderListId: freezed == orderListId ? _self.orderListId : orderListId // ignore: cast_nullable_to_non_nullable
as int?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as int,fills: null == fills ? _self.fills : fills // ignore: cast_nullable_to_non_nullable
as List<OrderFill>,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotOrder].
extension SpotOrderPatterns on SpotOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotOrder value)  $default,){
final _that = this;
switch (_that) {
case _SpotOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotOrder value)?  $default,){
final _that = this;
switch (_that) {
case _SpotOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  int orderId,  String clientOrderId, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal origQty, @DecimalConverter()  Decimal executedQty, @DecimalConverter()  Decimal cummulativeQuoteQty,  OrderStatus status,  OrderType type,  OrderSide side,  TimeInForce? timeInForce, @DecimalConverter()  Decimal? stopPrice,  int? orderListId,  int time,  int updateTime,  List<OrderFill> fills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotOrder() when $default != null:
return $default(_that.symbol,_that.orderId,_that.clientOrderId,_that.price,_that.origQty,_that.executedQty,_that.cummulativeQuoteQty,_that.status,_that.type,_that.side,_that.timeInForce,_that.stopPrice,_that.orderListId,_that.time,_that.updateTime,_that.fills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  int orderId,  String clientOrderId, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal origQty, @DecimalConverter()  Decimal executedQty, @DecimalConverter()  Decimal cummulativeQuoteQty,  OrderStatus status,  OrderType type,  OrderSide side,  TimeInForce? timeInForce, @DecimalConverter()  Decimal? stopPrice,  int? orderListId,  int time,  int updateTime,  List<OrderFill> fills)  $default,) {final _that = this;
switch (_that) {
case _SpotOrder():
return $default(_that.symbol,_that.orderId,_that.clientOrderId,_that.price,_that.origQty,_that.executedQty,_that.cummulativeQuoteQty,_that.status,_that.type,_that.side,_that.timeInForce,_that.stopPrice,_that.orderListId,_that.time,_that.updateTime,_that.fills);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  int orderId,  String clientOrderId, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal origQty, @DecimalConverter()  Decimal executedQty, @DecimalConverter()  Decimal cummulativeQuoteQty,  OrderStatus status,  OrderType type,  OrderSide side,  TimeInForce? timeInForce, @DecimalConverter()  Decimal? stopPrice,  int? orderListId,  int time,  int updateTime,  List<OrderFill> fills)?  $default,) {final _that = this;
switch (_that) {
case _SpotOrder() when $default != null:
return $default(_that.symbol,_that.orderId,_that.clientOrderId,_that.price,_that.origQty,_that.executedQty,_that.cummulativeQuoteQty,_that.status,_that.type,_that.side,_that.timeInForce,_that.stopPrice,_that.orderListId,_that.time,_that.updateTime,_that.fills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotOrder extends SpotOrder {
  const _SpotOrder({required this.symbol, required this.orderId, required this.clientOrderId, @DecimalConverter() required this.price, @DecimalConverter() required this.origQty, @DecimalConverter() required this.executedQty, @DecimalConverter() required this.cummulativeQuoteQty, required this.status, required this.type, required this.side, this.timeInForce, @DecimalConverter() this.stopPrice, this.orderListId, required this.time, required this.updateTime, final  List<OrderFill> fills = const <OrderFill>[]}): _fills = fills,super._();
  factory _SpotOrder.fromJson(Map<String, dynamic> json) => _$SpotOrderFromJson(json);

@override final  String symbol;
@override final  int orderId;
@override final  String clientOrderId;
@override@DecimalConverter() final  Decimal price;
@override@DecimalConverter() final  Decimal origQty;
@override@DecimalConverter() final  Decimal executedQty;
@override@DecimalConverter() final  Decimal cummulativeQuoteQty;
@override final  OrderStatus status;
@override final  OrderType type;
@override final  OrderSide side;
@override final  TimeInForce? timeInForce;
@override@DecimalConverter() final  Decimal? stopPrice;
@override final  int? orderListId;
@override final  int time;
@override final  int updateTime;
 final  List<OrderFill> _fills;
@override@JsonKey() List<OrderFill> get fills {
  if (_fills is EqualUnmodifiableListView) return _fills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fills);
}


/// Create a copy of SpotOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotOrderCopyWith<_SpotOrder> get copyWith => __$SpotOrderCopyWithImpl<_SpotOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotOrder&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&(identical(other.price, price) || other.price == price)&&(identical(other.origQty, origQty) || other.origQty == origQty)&&(identical(other.executedQty, executedQty) || other.executedQty == executedQty)&&(identical(other.cummulativeQuoteQty, cummulativeQuoteQty) || other.cummulativeQuoteQty == cummulativeQuoteQty)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.side, side) || other.side == side)&&(identical(other.timeInForce, timeInForce) || other.timeInForce == timeInForce)&&(identical(other.stopPrice, stopPrice) || other.stopPrice == stopPrice)&&(identical(other.orderListId, orderListId) || other.orderListId == orderListId)&&(identical(other.time, time) || other.time == time)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime)&&const DeepCollectionEquality().equals(other._fills, _fills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,orderId,clientOrderId,price,origQty,executedQty,cummulativeQuoteQty,status,type,side,timeInForce,stopPrice,orderListId,time,updateTime,const DeepCollectionEquality().hash(_fills));

@override
String toString() {
  return 'SpotOrder(symbol: $symbol, orderId: $orderId, clientOrderId: $clientOrderId, price: $price, origQty: $origQty, executedQty: $executedQty, cummulativeQuoteQty: $cummulativeQuoteQty, status: $status, type: $type, side: $side, timeInForce: $timeInForce, stopPrice: $stopPrice, orderListId: $orderListId, time: $time, updateTime: $updateTime, fills: $fills)';
}


}

/// @nodoc
abstract mixin class _$SpotOrderCopyWith<$Res> implements $SpotOrderCopyWith<$Res> {
  factory _$SpotOrderCopyWith(_SpotOrder value, $Res Function(_SpotOrder) _then) = __$SpotOrderCopyWithImpl;
@override @useResult
$Res call({
 String symbol, int orderId, String clientOrderId,@DecimalConverter() Decimal price,@DecimalConverter() Decimal origQty,@DecimalConverter() Decimal executedQty,@DecimalConverter() Decimal cummulativeQuoteQty, OrderStatus status, OrderType type, OrderSide side, TimeInForce? timeInForce,@DecimalConverter() Decimal? stopPrice, int? orderListId, int time, int updateTime, List<OrderFill> fills
});




}
/// @nodoc
class __$SpotOrderCopyWithImpl<$Res>
    implements _$SpotOrderCopyWith<$Res> {
  __$SpotOrderCopyWithImpl(this._self, this._then);

  final _SpotOrder _self;
  final $Res Function(_SpotOrder) _then;

/// Create a copy of SpotOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? orderId = null,Object? clientOrderId = null,Object? price = null,Object? origQty = null,Object? executedQty = null,Object? cummulativeQuoteQty = null,Object? status = null,Object? type = null,Object? side = null,Object? timeInForce = freezed,Object? stopPrice = freezed,Object? orderListId = freezed,Object? time = null,Object? updateTime = null,Object? fills = null,}) {
  return _then(_SpotOrder(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,origQty: null == origQty ? _self.origQty : origQty // ignore: cast_nullable_to_non_nullable
as Decimal,executedQty: null == executedQty ? _self.executedQty : executedQty // ignore: cast_nullable_to_non_nullable
as Decimal,cummulativeQuoteQty: null == cummulativeQuoteQty ? _self.cummulativeQuoteQty : cummulativeQuoteQty // ignore: cast_nullable_to_non_nullable
as Decimal,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OrderType,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as OrderSide,timeInForce: freezed == timeInForce ? _self.timeInForce : timeInForce // ignore: cast_nullable_to_non_nullable
as TimeInForce?,stopPrice: freezed == stopPrice ? _self.stopPrice : stopPrice // ignore: cast_nullable_to_non_nullable
as Decimal?,orderListId: freezed == orderListId ? _self.orderListId : orderListId // ignore: cast_nullable_to_non_nullable
as int?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,updateTime: null == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as int,fills: null == fills ? _self._fills : fills // ignore: cast_nullable_to_non_nullable
as List<OrderFill>,
  ));
}


}


/// @nodoc
mixin _$OrderFill {

@DecimalConverter() Decimal get price;@DecimalConverter() Decimal get qty;@DecimalConverter() Decimal get commission; String get commissionAsset; int? get tradeId;
/// Create a copy of OrderFill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderFillCopyWith<OrderFill> get copyWith => _$OrderFillCopyWithImpl<OrderFill>(this as OrderFill, _$identity);

  /// Serializes this OrderFill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderFill&&(identical(other.price, price) || other.price == price)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.commissionAsset, commissionAsset) || other.commissionAsset == commissionAsset)&&(identical(other.tradeId, tradeId) || other.tradeId == tradeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,qty,commission,commissionAsset,tradeId);

@override
String toString() {
  return 'OrderFill(price: $price, qty: $qty, commission: $commission, commissionAsset: $commissionAsset, tradeId: $tradeId)';
}


}

/// @nodoc
abstract mixin class $OrderFillCopyWith<$Res>  {
  factory $OrderFillCopyWith(OrderFill value, $Res Function(OrderFill) _then) = _$OrderFillCopyWithImpl;
@useResult
$Res call({
@DecimalConverter() Decimal price,@DecimalConverter() Decimal qty,@DecimalConverter() Decimal commission, String commissionAsset, int? tradeId
});




}
/// @nodoc
class _$OrderFillCopyWithImpl<$Res>
    implements $OrderFillCopyWith<$Res> {
  _$OrderFillCopyWithImpl(this._self, this._then);

  final OrderFill _self;
  final $Res Function(OrderFill) _then;

/// Create a copy of OrderFill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? price = null,Object? qty = null,Object? commission = null,Object? commissionAsset = null,Object? tradeId = freezed,}) {
  return _then(_self.copyWith(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as Decimal,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as Decimal,commissionAsset: null == commissionAsset ? _self.commissionAsset : commissionAsset // ignore: cast_nullable_to_non_nullable
as String,tradeId: freezed == tradeId ? _self.tradeId : tradeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderFill].
extension OrderFillPatterns on OrderFill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderFill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderFill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderFill value)  $default,){
final _that = this;
switch (_that) {
case _OrderFill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderFill value)?  $default,){
final _that = this;
switch (_that) {
case _OrderFill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DecimalConverter()  Decimal price, @DecimalConverter()  Decimal qty, @DecimalConverter()  Decimal commission,  String commissionAsset,  int? tradeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderFill() when $default != null:
return $default(_that.price,_that.qty,_that.commission,_that.commissionAsset,_that.tradeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DecimalConverter()  Decimal price, @DecimalConverter()  Decimal qty, @DecimalConverter()  Decimal commission,  String commissionAsset,  int? tradeId)  $default,) {final _that = this;
switch (_that) {
case _OrderFill():
return $default(_that.price,_that.qty,_that.commission,_that.commissionAsset,_that.tradeId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DecimalConverter()  Decimal price, @DecimalConverter()  Decimal qty, @DecimalConverter()  Decimal commission,  String commissionAsset,  int? tradeId)?  $default,) {final _that = this;
switch (_that) {
case _OrderFill() when $default != null:
return $default(_that.price,_that.qty,_that.commission,_that.commissionAsset,_that.tradeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderFill implements OrderFill {
  const _OrderFill({@DecimalConverter() required this.price, @DecimalConverter() required this.qty, @DecimalConverter() required this.commission, required this.commissionAsset, this.tradeId});
  factory _OrderFill.fromJson(Map<String, dynamic> json) => _$OrderFillFromJson(json);

@override@DecimalConverter() final  Decimal price;
@override@DecimalConverter() final  Decimal qty;
@override@DecimalConverter() final  Decimal commission;
@override final  String commissionAsset;
@override final  int? tradeId;

/// Create a copy of OrderFill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderFillCopyWith<_OrderFill> get copyWith => __$OrderFillCopyWithImpl<_OrderFill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderFillToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderFill&&(identical(other.price, price) || other.price == price)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.commissionAsset, commissionAsset) || other.commissionAsset == commissionAsset)&&(identical(other.tradeId, tradeId) || other.tradeId == tradeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,qty,commission,commissionAsset,tradeId);

@override
String toString() {
  return 'OrderFill(price: $price, qty: $qty, commission: $commission, commissionAsset: $commissionAsset, tradeId: $tradeId)';
}


}

/// @nodoc
abstract mixin class _$OrderFillCopyWith<$Res> implements $OrderFillCopyWith<$Res> {
  factory _$OrderFillCopyWith(_OrderFill value, $Res Function(_OrderFill) _then) = __$OrderFillCopyWithImpl;
@override @useResult
$Res call({
@DecimalConverter() Decimal price,@DecimalConverter() Decimal qty,@DecimalConverter() Decimal commission, String commissionAsset, int? tradeId
});




}
/// @nodoc
class __$OrderFillCopyWithImpl<$Res>
    implements _$OrderFillCopyWith<$Res> {
  __$OrderFillCopyWithImpl(this._self, this._then);

  final _OrderFill _self;
  final $Res Function(_OrderFill) _then;

/// Create a copy of OrderFill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? price = null,Object? qty = null,Object? commission = null,Object? commissionAsset = null,Object? tradeId = freezed,}) {
  return _then(_OrderFill(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as Decimal,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as Decimal,commissionAsset: null == commissionAsset ? _self.commissionAsset : commissionAsset // ignore: cast_nullable_to_non_nullable
as String,tradeId: freezed == tradeId ? _self.tradeId : tradeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
