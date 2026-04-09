// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symbol_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SymbolInfo {

 String get symbol; String get baseAsset; String get quoteAsset; String get status; String get market; List<SymbolFilter> get filters;
/// Create a copy of SymbolInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymbolInfoCopyWith<SymbolInfo> get copyWith => _$SymbolInfoCopyWithImpl<SymbolInfo>(this as SymbolInfo, _$identity);

  /// Serializes this SymbolInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymbolInfo&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.baseAsset, baseAsset) || other.baseAsset == baseAsset)&&(identical(other.quoteAsset, quoteAsset) || other.quoteAsset == quoteAsset)&&(identical(other.status, status) || other.status == status)&&(identical(other.market, market) || other.market == market)&&const DeepCollectionEquality().equals(other.filters, filters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,baseAsset,quoteAsset,status,market,const DeepCollectionEquality().hash(filters));

@override
String toString() {
  return 'SymbolInfo(symbol: $symbol, baseAsset: $baseAsset, quoteAsset: $quoteAsset, status: $status, market: $market, filters: $filters)';
}


}

/// @nodoc
abstract mixin class $SymbolInfoCopyWith<$Res>  {
  factory $SymbolInfoCopyWith(SymbolInfo value, $Res Function(SymbolInfo) _then) = _$SymbolInfoCopyWithImpl;
@useResult
$Res call({
 String symbol, String baseAsset, String quoteAsset, String status, String market, List<SymbolFilter> filters
});




}
/// @nodoc
class _$SymbolInfoCopyWithImpl<$Res>
    implements $SymbolInfoCopyWith<$Res> {
  _$SymbolInfoCopyWithImpl(this._self, this._then);

  final SymbolInfo _self;
  final $Res Function(SymbolInfo) _then;

/// Create a copy of SymbolInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? baseAsset = null,Object? quoteAsset = null,Object? status = null,Object? market = null,Object? filters = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,baseAsset: null == baseAsset ? _self.baseAsset : baseAsset // ignore: cast_nullable_to_non_nullable
as String,quoteAsset: null == quoteAsset ? _self.quoteAsset : quoteAsset // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as List<SymbolFilter>,
  ));
}

}


/// Adds pattern-matching-related methods to [SymbolInfo].
extension SymbolInfoPatterns on SymbolInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SymbolInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SymbolInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SymbolInfo value)  $default,){
final _that = this;
switch (_that) {
case _SymbolInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SymbolInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SymbolInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String baseAsset,  String quoteAsset,  String status,  String market,  List<SymbolFilter> filters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SymbolInfo() when $default != null:
return $default(_that.symbol,_that.baseAsset,_that.quoteAsset,_that.status,_that.market,_that.filters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String baseAsset,  String quoteAsset,  String status,  String market,  List<SymbolFilter> filters)  $default,) {final _that = this;
switch (_that) {
case _SymbolInfo():
return $default(_that.symbol,_that.baseAsset,_that.quoteAsset,_that.status,_that.market,_that.filters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String baseAsset,  String quoteAsset,  String status,  String market,  List<SymbolFilter> filters)?  $default,) {final _that = this;
switch (_that) {
case _SymbolInfo() when $default != null:
return $default(_that.symbol,_that.baseAsset,_that.quoteAsset,_that.status,_that.market,_that.filters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SymbolInfo extends SymbolInfo {
  const _SymbolInfo({required this.symbol, required this.baseAsset, required this.quoteAsset, required this.status, required this.market, final  List<SymbolFilter> filters = const <SymbolFilter>[]}): _filters = filters,super._();
  factory _SymbolInfo.fromJson(Map<String, dynamic> json) => _$SymbolInfoFromJson(json);

@override final  String symbol;
@override final  String baseAsset;
@override final  String quoteAsset;
@override final  String status;
@override final  String market;
 final  List<SymbolFilter> _filters;
@override@JsonKey() List<SymbolFilter> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}


/// Create a copy of SymbolInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SymbolInfoCopyWith<_SymbolInfo> get copyWith => __$SymbolInfoCopyWithImpl<_SymbolInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SymbolInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SymbolInfo&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.baseAsset, baseAsset) || other.baseAsset == baseAsset)&&(identical(other.quoteAsset, quoteAsset) || other.quoteAsset == quoteAsset)&&(identical(other.status, status) || other.status == status)&&(identical(other.market, market) || other.market == market)&&const DeepCollectionEquality().equals(other._filters, _filters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,baseAsset,quoteAsset,status,market,const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'SymbolInfo(symbol: $symbol, baseAsset: $baseAsset, quoteAsset: $quoteAsset, status: $status, market: $market, filters: $filters)';
}


}

/// @nodoc
abstract mixin class _$SymbolInfoCopyWith<$Res> implements $SymbolInfoCopyWith<$Res> {
  factory _$SymbolInfoCopyWith(_SymbolInfo value, $Res Function(_SymbolInfo) _then) = __$SymbolInfoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String baseAsset, String quoteAsset, String status, String market, List<SymbolFilter> filters
});




}
/// @nodoc
class __$SymbolInfoCopyWithImpl<$Res>
    implements _$SymbolInfoCopyWith<$Res> {
  __$SymbolInfoCopyWithImpl(this._self, this._then);

  final _SymbolInfo _self;
  final $Res Function(_SymbolInfo) _then;

/// Create a copy of SymbolInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? baseAsset = null,Object? quoteAsset = null,Object? status = null,Object? market = null,Object? filters = null,}) {
  return _then(_SymbolInfo(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,baseAsset: null == baseAsset ? _self.baseAsset : baseAsset // ignore: cast_nullable_to_non_nullable
as String,quoteAsset: null == quoteAsset ? _self.quoteAsset : quoteAsset // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<SymbolFilter>,
  ));
}


}

// dart format on
