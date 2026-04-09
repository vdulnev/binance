// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_book_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderBookEntry {

@DecimalConverter() Decimal get price;@DecimalConverter() Decimal get quantity;
/// Create a copy of OrderBookEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderBookEntryCopyWith<OrderBookEntry> get copyWith => _$OrderBookEntryCopyWithImpl<OrderBookEntry>(this as OrderBookEntry, _$identity);

  /// Serializes this OrderBookEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderBookEntry&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,quantity);

@override
String toString() {
  return 'OrderBookEntry(price: $price, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $OrderBookEntryCopyWith<$Res>  {
  factory $OrderBookEntryCopyWith(OrderBookEntry value, $Res Function(OrderBookEntry) _then) = _$OrderBookEntryCopyWithImpl;
@useResult
$Res call({
@DecimalConverter() Decimal price,@DecimalConverter() Decimal quantity
});




}
/// @nodoc
class _$OrderBookEntryCopyWithImpl<$Res>
    implements $OrderBookEntryCopyWith<$Res> {
  _$OrderBookEntryCopyWithImpl(this._self, this._then);

  final OrderBookEntry _self;
  final $Res Function(OrderBookEntry) _then;

/// Create a copy of OrderBookEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? price = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderBookEntry].
extension OrderBookEntryPatterns on OrderBookEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderBookEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderBookEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderBookEntry value)  $default,){
final _that = this;
switch (_that) {
case _OrderBookEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderBookEntry value)?  $default,){
final _that = this;
switch (_that) {
case _OrderBookEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DecimalConverter()  Decimal price, @DecimalConverter()  Decimal quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderBookEntry() when $default != null:
return $default(_that.price,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DecimalConverter()  Decimal price, @DecimalConverter()  Decimal quantity)  $default,) {final _that = this;
switch (_that) {
case _OrderBookEntry():
return $default(_that.price,_that.quantity);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DecimalConverter()  Decimal price, @DecimalConverter()  Decimal quantity)?  $default,) {final _that = this;
switch (_that) {
case _OrderBookEntry() when $default != null:
return $default(_that.price,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderBookEntry extends OrderBookEntry {
  const _OrderBookEntry({@DecimalConverter() required this.price, @DecimalConverter() required this.quantity}): super._();
  factory _OrderBookEntry.fromJson(Map<String, dynamic> json) => _$OrderBookEntryFromJson(json);

@override@DecimalConverter() final  Decimal price;
@override@DecimalConverter() final  Decimal quantity;

/// Create a copy of OrderBookEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderBookEntryCopyWith<_OrderBookEntry> get copyWith => __$OrderBookEntryCopyWithImpl<_OrderBookEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderBookEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderBookEntry&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,quantity);

@override
String toString() {
  return 'OrderBookEntry(price: $price, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$OrderBookEntryCopyWith<$Res> implements $OrderBookEntryCopyWith<$Res> {
  factory _$OrderBookEntryCopyWith(_OrderBookEntry value, $Res Function(_OrderBookEntry) _then) = __$OrderBookEntryCopyWithImpl;
@override @useResult
$Res call({
@DecimalConverter() Decimal price,@DecimalConverter() Decimal quantity
});




}
/// @nodoc
class __$OrderBookEntryCopyWithImpl<$Res>
    implements _$OrderBookEntryCopyWith<$Res> {
  __$OrderBookEntryCopyWithImpl(this._self, this._then);

  final _OrderBookEntry _self;
  final $Res Function(_OrderBookEntry) _then;

/// Create a copy of OrderBookEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? price = null,Object? quantity = null,}) {
  return _then(_OrderBookEntry(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as Decimal,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

// dart format on
