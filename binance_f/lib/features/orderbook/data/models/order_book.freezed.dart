// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderBook {

 String get symbol; int get lastUpdateId; List<OrderBookEntry> get bids; List<OrderBookEntry> get asks;
/// Create a copy of OrderBook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderBookCopyWith<OrderBook> get copyWith => _$OrderBookCopyWithImpl<OrderBook>(this as OrderBook, _$identity);

  /// Serializes this OrderBook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderBook&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.lastUpdateId, lastUpdateId) || other.lastUpdateId == lastUpdateId)&&const DeepCollectionEquality().equals(other.bids, bids)&&const DeepCollectionEquality().equals(other.asks, asks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,lastUpdateId,const DeepCollectionEquality().hash(bids),const DeepCollectionEquality().hash(asks));

@override
String toString() {
  return 'OrderBook(symbol: $symbol, lastUpdateId: $lastUpdateId, bids: $bids, asks: $asks)';
}


}

/// @nodoc
abstract mixin class $OrderBookCopyWith<$Res>  {
  factory $OrderBookCopyWith(OrderBook value, $Res Function(OrderBook) _then) = _$OrderBookCopyWithImpl;
@useResult
$Res call({
 String symbol, int lastUpdateId, List<OrderBookEntry> bids, List<OrderBookEntry> asks
});




}
/// @nodoc
class _$OrderBookCopyWithImpl<$Res>
    implements $OrderBookCopyWith<$Res> {
  _$OrderBookCopyWithImpl(this._self, this._then);

  final OrderBook _self;
  final $Res Function(OrderBook) _then;

/// Create a copy of OrderBook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? lastUpdateId = null,Object? bids = null,Object? asks = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,lastUpdateId: null == lastUpdateId ? _self.lastUpdateId : lastUpdateId // ignore: cast_nullable_to_non_nullable
as int,bids: null == bids ? _self.bids : bids // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,asks: null == asks ? _self.asks : asks // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderBook].
extension OrderBookPatterns on OrderBook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderBook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderBook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderBook value)  $default,){
final _that = this;
switch (_that) {
case _OrderBook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderBook value)?  $default,){
final _that = this;
switch (_that) {
case _OrderBook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  int lastUpdateId,  List<OrderBookEntry> bids,  List<OrderBookEntry> asks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderBook() when $default != null:
return $default(_that.symbol,_that.lastUpdateId,_that.bids,_that.asks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  int lastUpdateId,  List<OrderBookEntry> bids,  List<OrderBookEntry> asks)  $default,) {final _that = this;
switch (_that) {
case _OrderBook():
return $default(_that.symbol,_that.lastUpdateId,_that.bids,_that.asks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  int lastUpdateId,  List<OrderBookEntry> bids,  List<OrderBookEntry> asks)?  $default,) {final _that = this;
switch (_that) {
case _OrderBook() when $default != null:
return $default(_that.symbol,_that.lastUpdateId,_that.bids,_that.asks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderBook extends OrderBook {
  const _OrderBook({required this.symbol, required this.lastUpdateId, final  List<OrderBookEntry> bids = const <OrderBookEntry>[], final  List<OrderBookEntry> asks = const <OrderBookEntry>[]}): _bids = bids,_asks = asks,super._();
  factory _OrderBook.fromJson(Map<String, dynamic> json) => _$OrderBookFromJson(json);

@override final  String symbol;
@override final  int lastUpdateId;
 final  List<OrderBookEntry> _bids;
@override@JsonKey() List<OrderBookEntry> get bids {
  if (_bids is EqualUnmodifiableListView) return _bids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bids);
}

 final  List<OrderBookEntry> _asks;
@override@JsonKey() List<OrderBookEntry> get asks {
  if (_asks is EqualUnmodifiableListView) return _asks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_asks);
}


/// Create a copy of OrderBook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderBookCopyWith<_OrderBook> get copyWith => __$OrderBookCopyWithImpl<_OrderBook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderBookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderBook&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.lastUpdateId, lastUpdateId) || other.lastUpdateId == lastUpdateId)&&const DeepCollectionEquality().equals(other._bids, _bids)&&const DeepCollectionEquality().equals(other._asks, _asks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,lastUpdateId,const DeepCollectionEquality().hash(_bids),const DeepCollectionEquality().hash(_asks));

@override
String toString() {
  return 'OrderBook(symbol: $symbol, lastUpdateId: $lastUpdateId, bids: $bids, asks: $asks)';
}


}

/// @nodoc
abstract mixin class _$OrderBookCopyWith<$Res> implements $OrderBookCopyWith<$Res> {
  factory _$OrderBookCopyWith(_OrderBook value, $Res Function(_OrderBook) _then) = __$OrderBookCopyWithImpl;
@override @useResult
$Res call({
 String symbol, int lastUpdateId, List<OrderBookEntry> bids, List<OrderBookEntry> asks
});




}
/// @nodoc
class __$OrderBookCopyWithImpl<$Res>
    implements _$OrderBookCopyWith<$Res> {
  __$OrderBookCopyWithImpl(this._self, this._then);

  final _OrderBook _self;
  final $Res Function(_OrderBook) _then;

/// Create a copy of OrderBook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? lastUpdateId = null,Object? bids = null,Object? asks = null,}) {
  return _then(_OrderBook(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,lastUpdateId: null == lastUpdateId ? _self.lastUpdateId : lastUpdateId // ignore: cast_nullable_to_non_nullable
as int,bids: null == bids ? _self._bids : bids // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,asks: null == asks ? _self._asks : asks // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,
  ));
}


}

// dart format on
