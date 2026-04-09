// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'total_value_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TotalValueResult {

@DecimalConverter() Decimal get total; String get quoteAsset; List<String> get skippedAssets;
/// Create a copy of TotalValueResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TotalValueResultCopyWith<TotalValueResult> get copyWith => _$TotalValueResultCopyWithImpl<TotalValueResult>(this as TotalValueResult, _$identity);

  /// Serializes this TotalValueResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TotalValueResult&&(identical(other.total, total) || other.total == total)&&(identical(other.quoteAsset, quoteAsset) || other.quoteAsset == quoteAsset)&&const DeepCollectionEquality().equals(other.skippedAssets, skippedAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,quoteAsset,const DeepCollectionEquality().hash(skippedAssets));

@override
String toString() {
  return 'TotalValueResult(total: $total, quoteAsset: $quoteAsset, skippedAssets: $skippedAssets)';
}


}

/// @nodoc
abstract mixin class $TotalValueResultCopyWith<$Res>  {
  factory $TotalValueResultCopyWith(TotalValueResult value, $Res Function(TotalValueResult) _then) = _$TotalValueResultCopyWithImpl;
@useResult
$Res call({
@DecimalConverter() Decimal total, String quoteAsset, List<String> skippedAssets
});




}
/// @nodoc
class _$TotalValueResultCopyWithImpl<$Res>
    implements $TotalValueResultCopyWith<$Res> {
  _$TotalValueResultCopyWithImpl(this._self, this._then);

  final TotalValueResult _self;
  final $Res Function(TotalValueResult) _then;

/// Create a copy of TotalValueResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? quoteAsset = null,Object? skippedAssets = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Decimal,quoteAsset: null == quoteAsset ? _self.quoteAsset : quoteAsset // ignore: cast_nullable_to_non_nullable
as String,skippedAssets: null == skippedAssets ? _self.skippedAssets : skippedAssets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TotalValueResult].
extension TotalValueResultPatterns on TotalValueResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TotalValueResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TotalValueResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TotalValueResult value)  $default,){
final _that = this;
switch (_that) {
case _TotalValueResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TotalValueResult value)?  $default,){
final _that = this;
switch (_that) {
case _TotalValueResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DecimalConverter()  Decimal total,  String quoteAsset,  List<String> skippedAssets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TotalValueResult() when $default != null:
return $default(_that.total,_that.quoteAsset,_that.skippedAssets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DecimalConverter()  Decimal total,  String quoteAsset,  List<String> skippedAssets)  $default,) {final _that = this;
switch (_that) {
case _TotalValueResult():
return $default(_that.total,_that.quoteAsset,_that.skippedAssets);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DecimalConverter()  Decimal total,  String quoteAsset,  List<String> skippedAssets)?  $default,) {final _that = this;
switch (_that) {
case _TotalValueResult() when $default != null:
return $default(_that.total,_that.quoteAsset,_that.skippedAssets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TotalValueResult implements TotalValueResult {
  const _TotalValueResult({@DecimalConverter() required this.total, required this.quoteAsset, final  List<String> skippedAssets = const <String>[]}): _skippedAssets = skippedAssets;
  factory _TotalValueResult.fromJson(Map<String, dynamic> json) => _$TotalValueResultFromJson(json);

@override@DecimalConverter() final  Decimal total;
@override final  String quoteAsset;
 final  List<String> _skippedAssets;
@override@JsonKey() List<String> get skippedAssets {
  if (_skippedAssets is EqualUnmodifiableListView) return _skippedAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skippedAssets);
}


/// Create a copy of TotalValueResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotalValueResultCopyWith<_TotalValueResult> get copyWith => __$TotalValueResultCopyWithImpl<_TotalValueResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TotalValueResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TotalValueResult&&(identical(other.total, total) || other.total == total)&&(identical(other.quoteAsset, quoteAsset) || other.quoteAsset == quoteAsset)&&const DeepCollectionEquality().equals(other._skippedAssets, _skippedAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,quoteAsset,const DeepCollectionEquality().hash(_skippedAssets));

@override
String toString() {
  return 'TotalValueResult(total: $total, quoteAsset: $quoteAsset, skippedAssets: $skippedAssets)';
}


}

/// @nodoc
abstract mixin class _$TotalValueResultCopyWith<$Res> implements $TotalValueResultCopyWith<$Res> {
  factory _$TotalValueResultCopyWith(_TotalValueResult value, $Res Function(_TotalValueResult) _then) = __$TotalValueResultCopyWithImpl;
@override @useResult
$Res call({
@DecimalConverter() Decimal total, String quoteAsset, List<String> skippedAssets
});




}
/// @nodoc
class __$TotalValueResultCopyWithImpl<$Res>
    implements _$TotalValueResultCopyWith<$Res> {
  __$TotalValueResultCopyWithImpl(this._self, this._then);

  final _TotalValueResult _self;
  final $Res Function(_TotalValueResult) _then;

/// Create a copy of TotalValueResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? quoteAsset = null,Object? skippedAssets = null,}) {
  return _then(_TotalValueResult(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Decimal,quoteAsset: null == quoteAsset ? _self.quoteAsset : quoteAsset // ignore: cast_nullable_to_non_nullable
as String,skippedAssets: null == skippedAssets ? _self._skippedAssets : skippedAssets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
