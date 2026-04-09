// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_trade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentTrade {

 int get id;@DecimalConverter() Decimal get price;@DecimalConverter() Decimal get qty; int get time; bool get isBuyerMaker;
/// Create a copy of RecentTrade
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentTradeCopyWith<RecentTrade> get copyWith => _$RecentTradeCopyWithImpl<RecentTrade>(this as RecentTrade, _$identity);

  /// Serializes this RecentTrade to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentTrade&&(identical(other.id, id) || other.id == id)&&(identical(other.price, price) || other.price == price)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.time, time) || other.time == time)&&(identical(other.isBuyerMaker, isBuyerMaker) || other.isBuyerMaker == isBuyerMaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,price,qty,time,isBuyerMaker);

@override
String toString() {
  return 'RecentTrade(id: $id, price: $price, qty: $qty, time: $time, isBuyerMaker: $isBuyerMaker)';
}


}

/// @nodoc
abstract mixin class $RecentTradeCopyWith<$Res>  {
  factory $RecentTradeCopyWith(RecentTrade value, $Res Function(RecentTrade) _then) = _$RecentTradeCopyWithImpl;
@useResult
$Res call({
 int id,@DecimalConverter() Decimal price,@DecimalConverter() Decimal qty, int time, bool isBuyerMaker
});




}
/// @nodoc
class _$RecentTradeCopyWithImpl<$Res>
    implements $RecentTradeCopyWith<$Res> {
  _$RecentTradeCopyWithImpl(this._self, this._then);

  final RecentTrade _self;
  final $Res Function(RecentTrade) _then;

/// Create a copy of RecentTrade
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? price = null,Object? qty = null,Object? time = null,Object? isBuyerMaker = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as Decimal,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,isBuyerMaker: null == isBuyerMaker ? _self.isBuyerMaker : isBuyerMaker // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentTrade].
extension RecentTradePatterns on RecentTrade {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentTrade value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentTrade() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentTrade value)  $default,){
final _that = this;
switch (_that) {
case _RecentTrade():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentTrade value)?  $default,){
final _that = this;
switch (_that) {
case _RecentTrade() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal qty,  int time,  bool isBuyerMaker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentTrade() when $default != null:
return $default(_that.id,_that.price,_that.qty,_that.time,_that.isBuyerMaker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal qty,  int time,  bool isBuyerMaker)  $default,) {final _that = this;
switch (_that) {
case _RecentTrade():
return $default(_that.id,_that.price,_that.qty,_that.time,_that.isBuyerMaker);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @DecimalConverter()  Decimal price, @DecimalConverter()  Decimal qty,  int time,  bool isBuyerMaker)?  $default,) {final _that = this;
switch (_that) {
case _RecentTrade() when $default != null:
return $default(_that.id,_that.price,_that.qty,_that.time,_that.isBuyerMaker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentTrade extends RecentTrade {
  const _RecentTrade({required this.id, @DecimalConverter() required this.price, @DecimalConverter() required this.qty, required this.time, required this.isBuyerMaker}): super._();
  factory _RecentTrade.fromJson(Map<String, dynamic> json) => _$RecentTradeFromJson(json);

@override final  int id;
@override@DecimalConverter() final  Decimal price;
@override@DecimalConverter() final  Decimal qty;
@override final  int time;
@override final  bool isBuyerMaker;

/// Create a copy of RecentTrade
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentTradeCopyWith<_RecentTrade> get copyWith => __$RecentTradeCopyWithImpl<_RecentTrade>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentTradeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentTrade&&(identical(other.id, id) || other.id == id)&&(identical(other.price, price) || other.price == price)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.time, time) || other.time == time)&&(identical(other.isBuyerMaker, isBuyerMaker) || other.isBuyerMaker == isBuyerMaker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,price,qty,time,isBuyerMaker);

@override
String toString() {
  return 'RecentTrade(id: $id, price: $price, qty: $qty, time: $time, isBuyerMaker: $isBuyerMaker)';
}


}

/// @nodoc
abstract mixin class _$RecentTradeCopyWith<$Res> implements $RecentTradeCopyWith<$Res> {
  factory _$RecentTradeCopyWith(_RecentTrade value, $Res Function(_RecentTrade) _then) = __$RecentTradeCopyWithImpl;
@override @useResult
$Res call({
 int id,@DecimalConverter() Decimal price,@DecimalConverter() Decimal qty, int time, bool isBuyerMaker
});




}
/// @nodoc
class __$RecentTradeCopyWithImpl<$Res>
    implements _$RecentTradeCopyWith<$Res> {
  __$RecentTradeCopyWithImpl(this._self, this._then);

  final _RecentTrade _self;
  final $Res Function(_RecentTrade) _then;

/// Create a copy of RecentTrade
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? price = null,Object? qty = null,Object? time = null,Object? isBuyerMaker = null,}) {
  return _then(_RecentTrade(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as Decimal,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as int,isBuyerMaker: null == isBuyerMaker ? _self.isBuyerMaker : isBuyerMaker // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
