// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_book_delta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderBookDelta {

@JsonKey(name: 'U') int get firstUpdateId;@JsonKey(name: 'u') int get finalUpdateId; List<OrderBookEntry> get bids; List<OrderBookEntry> get asks;
/// Create a copy of OrderBookDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderBookDeltaCopyWith<OrderBookDelta> get copyWith => _$OrderBookDeltaCopyWithImpl<OrderBookDelta>(this as OrderBookDelta, _$identity);

  /// Serializes this OrderBookDelta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderBookDelta&&(identical(other.firstUpdateId, firstUpdateId) || other.firstUpdateId == firstUpdateId)&&(identical(other.finalUpdateId, finalUpdateId) || other.finalUpdateId == finalUpdateId)&&const DeepCollectionEquality().equals(other.bids, bids)&&const DeepCollectionEquality().equals(other.asks, asks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstUpdateId,finalUpdateId,const DeepCollectionEquality().hash(bids),const DeepCollectionEquality().hash(asks));

@override
String toString() {
  return 'OrderBookDelta(firstUpdateId: $firstUpdateId, finalUpdateId: $finalUpdateId, bids: $bids, asks: $asks)';
}


}

/// @nodoc
abstract mixin class $OrderBookDeltaCopyWith<$Res>  {
  factory $OrderBookDeltaCopyWith(OrderBookDelta value, $Res Function(OrderBookDelta) _then) = _$OrderBookDeltaCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'U') int firstUpdateId,@JsonKey(name: 'u') int finalUpdateId, List<OrderBookEntry> bids, List<OrderBookEntry> asks
});




}
/// @nodoc
class _$OrderBookDeltaCopyWithImpl<$Res>
    implements $OrderBookDeltaCopyWith<$Res> {
  _$OrderBookDeltaCopyWithImpl(this._self, this._then);

  final OrderBookDelta _self;
  final $Res Function(OrderBookDelta) _then;

/// Create a copy of OrderBookDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstUpdateId = null,Object? finalUpdateId = null,Object? bids = null,Object? asks = null,}) {
  return _then(_self.copyWith(
firstUpdateId: null == firstUpdateId ? _self.firstUpdateId : firstUpdateId // ignore: cast_nullable_to_non_nullable
as int,finalUpdateId: null == finalUpdateId ? _self.finalUpdateId : finalUpdateId // ignore: cast_nullable_to_non_nullable
as int,bids: null == bids ? _self.bids : bids // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,asks: null == asks ? _self.asks : asks // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderBookDelta].
extension OrderBookDeltaPatterns on OrderBookDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderBookDelta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderBookDelta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderBookDelta value)  $default,){
final _that = this;
switch (_that) {
case _OrderBookDelta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderBookDelta value)?  $default,){
final _that = this;
switch (_that) {
case _OrderBookDelta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'U')  int firstUpdateId, @JsonKey(name: 'u')  int finalUpdateId,  List<OrderBookEntry> bids,  List<OrderBookEntry> asks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderBookDelta() when $default != null:
return $default(_that.firstUpdateId,_that.finalUpdateId,_that.bids,_that.asks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'U')  int firstUpdateId, @JsonKey(name: 'u')  int finalUpdateId,  List<OrderBookEntry> bids,  List<OrderBookEntry> asks)  $default,) {final _that = this;
switch (_that) {
case _OrderBookDelta():
return $default(_that.firstUpdateId,_that.finalUpdateId,_that.bids,_that.asks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'U')  int firstUpdateId, @JsonKey(name: 'u')  int finalUpdateId,  List<OrderBookEntry> bids,  List<OrderBookEntry> asks)?  $default,) {final _that = this;
switch (_that) {
case _OrderBookDelta() when $default != null:
return $default(_that.firstUpdateId,_that.finalUpdateId,_that.bids,_that.asks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderBookDelta implements OrderBookDelta {
  const _OrderBookDelta({@JsonKey(name: 'U') required this.firstUpdateId, @JsonKey(name: 'u') required this.finalUpdateId, final  List<OrderBookEntry> bids = const <OrderBookEntry>[], final  List<OrderBookEntry> asks = const <OrderBookEntry>[]}): _bids = bids,_asks = asks;
  factory _OrderBookDelta.fromJson(Map<String, dynamic> json) => _$OrderBookDeltaFromJson(json);

@override@JsonKey(name: 'U') final  int firstUpdateId;
@override@JsonKey(name: 'u') final  int finalUpdateId;
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


/// Create a copy of OrderBookDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderBookDeltaCopyWith<_OrderBookDelta> get copyWith => __$OrderBookDeltaCopyWithImpl<_OrderBookDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderBookDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderBookDelta&&(identical(other.firstUpdateId, firstUpdateId) || other.firstUpdateId == firstUpdateId)&&(identical(other.finalUpdateId, finalUpdateId) || other.finalUpdateId == finalUpdateId)&&const DeepCollectionEquality().equals(other._bids, _bids)&&const DeepCollectionEquality().equals(other._asks, _asks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstUpdateId,finalUpdateId,const DeepCollectionEquality().hash(_bids),const DeepCollectionEquality().hash(_asks));

@override
String toString() {
  return 'OrderBookDelta(firstUpdateId: $firstUpdateId, finalUpdateId: $finalUpdateId, bids: $bids, asks: $asks)';
}


}

/// @nodoc
abstract mixin class _$OrderBookDeltaCopyWith<$Res> implements $OrderBookDeltaCopyWith<$Res> {
  factory _$OrderBookDeltaCopyWith(_OrderBookDelta value, $Res Function(_OrderBookDelta) _then) = __$OrderBookDeltaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'U') int firstUpdateId,@JsonKey(name: 'u') int finalUpdateId, List<OrderBookEntry> bids, List<OrderBookEntry> asks
});




}
/// @nodoc
class __$OrderBookDeltaCopyWithImpl<$Res>
    implements _$OrderBookDeltaCopyWith<$Res> {
  __$OrderBookDeltaCopyWithImpl(this._self, this._then);

  final _OrderBookDelta _self;
  final $Res Function(_OrderBookDelta) _then;

/// Create a copy of OrderBookDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstUpdateId = null,Object? finalUpdateId = null,Object? bids = null,Object? asks = null,}) {
  return _then(_OrderBookDelta(
firstUpdateId: null == firstUpdateId ? _self.firstUpdateId : firstUpdateId // ignore: cast_nullable_to_non_nullable
as int,finalUpdateId: null == finalUpdateId ? _self.finalUpdateId : finalUpdateId // ignore: cast_nullable_to_non_nullable
as int,bids: null == bids ? _self._bids : bids // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,asks: null == asks ? _self._asks : asks // ignore: cast_nullable_to_non_nullable
as List<OrderBookEntry>,
  ));
}


}

// dart format on
