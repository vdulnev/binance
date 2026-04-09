// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kline_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KlineUpdate {

 String get symbol; String get interval; int get openTime;@DecimalConverter() Decimal get open;@DecimalConverter() Decimal get high;@DecimalConverter() Decimal get low;@DecimalConverter() Decimal get close;@DecimalConverter() Decimal get volume; bool get isClosed;
/// Create a copy of KlineUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KlineUpdateCopyWith<KlineUpdate> get copyWith => _$KlineUpdateCopyWithImpl<KlineUpdate>(this as KlineUpdate, _$identity);

  /// Serializes this KlineUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KlineUpdate&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,interval,openTime,open,high,low,close,volume,isClosed);

@override
String toString() {
  return 'KlineUpdate(symbol: $symbol, interval: $interval, openTime: $openTime, open: $open, high: $high, low: $low, close: $close, volume: $volume, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class $KlineUpdateCopyWith<$Res>  {
  factory $KlineUpdateCopyWith(KlineUpdate value, $Res Function(KlineUpdate) _then) = _$KlineUpdateCopyWithImpl;
@useResult
$Res call({
 String symbol, String interval, int openTime,@DecimalConverter() Decimal open,@DecimalConverter() Decimal high,@DecimalConverter() Decimal low,@DecimalConverter() Decimal close,@DecimalConverter() Decimal volume, bool isClosed
});




}
/// @nodoc
class _$KlineUpdateCopyWithImpl<$Res>
    implements $KlineUpdateCopyWith<$Res> {
  _$KlineUpdateCopyWithImpl(this._self, this._then);

  final KlineUpdate _self;
  final $Res Function(KlineUpdate) _then;

/// Create a copy of KlineUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? interval = null,Object? openTime = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,Object? volume = null,Object? isClosed = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as int,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as Decimal,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as Decimal,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as Decimal,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as Decimal,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as Decimal,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [KlineUpdate].
extension KlineUpdatePatterns on KlineUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KlineUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KlineUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KlineUpdate value)  $default,){
final _that = this;
switch (_that) {
case _KlineUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KlineUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _KlineUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String interval,  int openTime, @DecimalConverter()  Decimal open, @DecimalConverter()  Decimal high, @DecimalConverter()  Decimal low, @DecimalConverter()  Decimal close, @DecimalConverter()  Decimal volume,  bool isClosed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KlineUpdate() when $default != null:
return $default(_that.symbol,_that.interval,_that.openTime,_that.open,_that.high,_that.low,_that.close,_that.volume,_that.isClosed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String interval,  int openTime, @DecimalConverter()  Decimal open, @DecimalConverter()  Decimal high, @DecimalConverter()  Decimal low, @DecimalConverter()  Decimal close, @DecimalConverter()  Decimal volume,  bool isClosed)  $default,) {final _that = this;
switch (_that) {
case _KlineUpdate():
return $default(_that.symbol,_that.interval,_that.openTime,_that.open,_that.high,_that.low,_that.close,_that.volume,_that.isClosed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String interval,  int openTime, @DecimalConverter()  Decimal open, @DecimalConverter()  Decimal high, @DecimalConverter()  Decimal low, @DecimalConverter()  Decimal close, @DecimalConverter()  Decimal volume,  bool isClosed)?  $default,) {final _that = this;
switch (_that) {
case _KlineUpdate() when $default != null:
return $default(_that.symbol,_that.interval,_that.openTime,_that.open,_that.high,_that.low,_that.close,_that.volume,_that.isClosed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KlineUpdate implements KlineUpdate {
  const _KlineUpdate({required this.symbol, required this.interval, required this.openTime, @DecimalConverter() required this.open, @DecimalConverter() required this.high, @DecimalConverter() required this.low, @DecimalConverter() required this.close, @DecimalConverter() required this.volume, required this.isClosed});
  factory _KlineUpdate.fromJson(Map<String, dynamic> json) => _$KlineUpdateFromJson(json);

@override final  String symbol;
@override final  String interval;
@override final  int openTime;
@override@DecimalConverter() final  Decimal open;
@override@DecimalConverter() final  Decimal high;
@override@DecimalConverter() final  Decimal low;
@override@DecimalConverter() final  Decimal close;
@override@DecimalConverter() final  Decimal volume;
@override final  bool isClosed;

/// Create a copy of KlineUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KlineUpdateCopyWith<_KlineUpdate> get copyWith => __$KlineUpdateCopyWithImpl<_KlineUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KlineUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KlineUpdate&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,interval,openTime,open,high,low,close,volume,isClosed);

@override
String toString() {
  return 'KlineUpdate(symbol: $symbol, interval: $interval, openTime: $openTime, open: $open, high: $high, low: $low, close: $close, volume: $volume, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class _$KlineUpdateCopyWith<$Res> implements $KlineUpdateCopyWith<$Res> {
  factory _$KlineUpdateCopyWith(_KlineUpdate value, $Res Function(_KlineUpdate) _then) = __$KlineUpdateCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String interval, int openTime,@DecimalConverter() Decimal open,@DecimalConverter() Decimal high,@DecimalConverter() Decimal low,@DecimalConverter() Decimal close,@DecimalConverter() Decimal volume, bool isClosed
});




}
/// @nodoc
class __$KlineUpdateCopyWithImpl<$Res>
    implements _$KlineUpdateCopyWith<$Res> {
  __$KlineUpdateCopyWithImpl(this._self, this._then);

  final _KlineUpdate _self;
  final $Res Function(_KlineUpdate) _then;

/// Create a copy of KlineUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? interval = null,Object? openTime = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,Object? volume = null,Object? isClosed = null,}) {
  return _then(_KlineUpdate(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String,openTime: null == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as int,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as Decimal,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as Decimal,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as Decimal,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as Decimal,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as Decimal,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
