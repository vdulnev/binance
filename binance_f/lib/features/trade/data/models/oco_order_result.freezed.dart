// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oco_order_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcoOrderResult {

 int get orderListId; String get listClientOrderId; String get symbol; List<SpotOrder> get orderReports;
/// Create a copy of OcoOrderResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcoOrderResultCopyWith<OcoOrderResult> get copyWith => _$OcoOrderResultCopyWithImpl<OcoOrderResult>(this as OcoOrderResult, _$identity);

  /// Serializes this OcoOrderResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcoOrderResult&&(identical(other.orderListId, orderListId) || other.orderListId == orderListId)&&(identical(other.listClientOrderId, listClientOrderId) || other.listClientOrderId == listClientOrderId)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other.orderReports, orderReports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderListId,listClientOrderId,symbol,const DeepCollectionEquality().hash(orderReports));

@override
String toString() {
  return 'OcoOrderResult(orderListId: $orderListId, listClientOrderId: $listClientOrderId, symbol: $symbol, orderReports: $orderReports)';
}


}

/// @nodoc
abstract mixin class $OcoOrderResultCopyWith<$Res>  {
  factory $OcoOrderResultCopyWith(OcoOrderResult value, $Res Function(OcoOrderResult) _then) = _$OcoOrderResultCopyWithImpl;
@useResult
$Res call({
 int orderListId, String listClientOrderId, String symbol, List<SpotOrder> orderReports
});




}
/// @nodoc
class _$OcoOrderResultCopyWithImpl<$Res>
    implements $OcoOrderResultCopyWith<$Res> {
  _$OcoOrderResultCopyWithImpl(this._self, this._then);

  final OcoOrderResult _self;
  final $Res Function(OcoOrderResult) _then;

/// Create a copy of OcoOrderResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderListId = null,Object? listClientOrderId = null,Object? symbol = null,Object? orderReports = null,}) {
  return _then(_self.copyWith(
orderListId: null == orderListId ? _self.orderListId : orderListId // ignore: cast_nullable_to_non_nullable
as int,listClientOrderId: null == listClientOrderId ? _self.listClientOrderId : listClientOrderId // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderReports: null == orderReports ? _self.orderReports : orderReports // ignore: cast_nullable_to_non_nullable
as List<SpotOrder>,
  ));
}

}


/// Adds pattern-matching-related methods to [OcoOrderResult].
extension OcoOrderResultPatterns on OcoOrderResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcoOrderResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcoOrderResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcoOrderResult value)  $default,){
final _that = this;
switch (_that) {
case _OcoOrderResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcoOrderResult value)?  $default,){
final _that = this;
switch (_that) {
case _OcoOrderResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderListId,  String listClientOrderId,  String symbol,  List<SpotOrder> orderReports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcoOrderResult() when $default != null:
return $default(_that.orderListId,_that.listClientOrderId,_that.symbol,_that.orderReports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderListId,  String listClientOrderId,  String symbol,  List<SpotOrder> orderReports)  $default,) {final _that = this;
switch (_that) {
case _OcoOrderResult():
return $default(_that.orderListId,_that.listClientOrderId,_that.symbol,_that.orderReports);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderListId,  String listClientOrderId,  String symbol,  List<SpotOrder> orderReports)?  $default,) {final _that = this;
switch (_that) {
case _OcoOrderResult() when $default != null:
return $default(_that.orderListId,_that.listClientOrderId,_that.symbol,_that.orderReports);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcoOrderResult implements OcoOrderResult {
  const _OcoOrderResult({required this.orderListId, required this.listClientOrderId, required this.symbol, required final  List<SpotOrder> orderReports}): _orderReports = orderReports;
  factory _OcoOrderResult.fromJson(Map<String, dynamic> json) => _$OcoOrderResultFromJson(json);

@override final  int orderListId;
@override final  String listClientOrderId;
@override final  String symbol;
 final  List<SpotOrder> _orderReports;
@override List<SpotOrder> get orderReports {
  if (_orderReports is EqualUnmodifiableListView) return _orderReports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderReports);
}


/// Create a copy of OcoOrderResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcoOrderResultCopyWith<_OcoOrderResult> get copyWith => __$OcoOrderResultCopyWithImpl<_OcoOrderResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcoOrderResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcoOrderResult&&(identical(other.orderListId, orderListId) || other.orderListId == orderListId)&&(identical(other.listClientOrderId, listClientOrderId) || other.listClientOrderId == listClientOrderId)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other._orderReports, _orderReports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderListId,listClientOrderId,symbol,const DeepCollectionEquality().hash(_orderReports));

@override
String toString() {
  return 'OcoOrderResult(orderListId: $orderListId, listClientOrderId: $listClientOrderId, symbol: $symbol, orderReports: $orderReports)';
}


}

/// @nodoc
abstract mixin class _$OcoOrderResultCopyWith<$Res> implements $OcoOrderResultCopyWith<$Res> {
  factory _$OcoOrderResultCopyWith(_OcoOrderResult value, $Res Function(_OcoOrderResult) _then) = __$OcoOrderResultCopyWithImpl;
@override @useResult
$Res call({
 int orderListId, String listClientOrderId, String symbol, List<SpotOrder> orderReports
});




}
/// @nodoc
class __$OcoOrderResultCopyWithImpl<$Res>
    implements _$OcoOrderResultCopyWith<$Res> {
  __$OcoOrderResultCopyWithImpl(this._self, this._then);

  final _OcoOrderResult _self;
  final $Res Function(_OcoOrderResult) _then;

/// Create a copy of OcoOrderResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderListId = null,Object? listClientOrderId = null,Object? symbol = null,Object? orderReports = null,}) {
  return _then(_OcoOrderResult(
orderListId: null == orderListId ? _self.orderListId : orderListId // ignore: cast_nullable_to_non_nullable
as int,listClientOrderId: null == listClientOrderId ? _self.listClientOrderId : listClientOrderId // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,orderReports: null == orderReports ? _self._orderReports : orderReports // ignore: cast_nullable_to_non_nullable
as List<SpotOrder>,
  ));
}


}

// dart format on
