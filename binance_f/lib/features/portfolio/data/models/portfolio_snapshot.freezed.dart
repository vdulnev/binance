// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PortfolioSnapshot {

 SpotAccountSnapshot get spot; FuturesAccountSnapshot get futures;@DecimalConverter() Decimal get totalValueInQuote; String get quoteAsset; DateTime get fetchedAt; bool get stale; List<String> get skippedAssets;
/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioSnapshotCopyWith<PortfolioSnapshot> get copyWith => _$PortfolioSnapshotCopyWithImpl<PortfolioSnapshot>(this as PortfolioSnapshot, _$identity);

  /// Serializes this PortfolioSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioSnapshot&&(identical(other.spot, spot) || other.spot == spot)&&(identical(other.futures, futures) || other.futures == futures)&&(identical(other.totalValueInQuote, totalValueInQuote) || other.totalValueInQuote == totalValueInQuote)&&(identical(other.quoteAsset, quoteAsset) || other.quoteAsset == quoteAsset)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&(identical(other.stale, stale) || other.stale == stale)&&const DeepCollectionEquality().equals(other.skippedAssets, skippedAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,spot,futures,totalValueInQuote,quoteAsset,fetchedAt,stale,const DeepCollectionEquality().hash(skippedAssets));

@override
String toString() {
  return 'PortfolioSnapshot(spot: $spot, futures: $futures, totalValueInQuote: $totalValueInQuote, quoteAsset: $quoteAsset, fetchedAt: $fetchedAt, stale: $stale, skippedAssets: $skippedAssets)';
}


}

/// @nodoc
abstract mixin class $PortfolioSnapshotCopyWith<$Res>  {
  factory $PortfolioSnapshotCopyWith(PortfolioSnapshot value, $Res Function(PortfolioSnapshot) _then) = _$PortfolioSnapshotCopyWithImpl;
@useResult
$Res call({
 SpotAccountSnapshot spot, FuturesAccountSnapshot futures,@DecimalConverter() Decimal totalValueInQuote, String quoteAsset, DateTime fetchedAt, bool stale, List<String> skippedAssets
});


$SpotAccountSnapshotCopyWith<$Res> get spot;$FuturesAccountSnapshotCopyWith<$Res> get futures;

}
/// @nodoc
class _$PortfolioSnapshotCopyWithImpl<$Res>
    implements $PortfolioSnapshotCopyWith<$Res> {
  _$PortfolioSnapshotCopyWithImpl(this._self, this._then);

  final PortfolioSnapshot _self;
  final $Res Function(PortfolioSnapshot) _then;

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spot = null,Object? futures = null,Object? totalValueInQuote = null,Object? quoteAsset = null,Object? fetchedAt = null,Object? stale = null,Object? skippedAssets = null,}) {
  return _then(_self.copyWith(
spot: null == spot ? _self.spot : spot // ignore: cast_nullable_to_non_nullable
as SpotAccountSnapshot,futures: null == futures ? _self.futures : futures // ignore: cast_nullable_to_non_nullable
as FuturesAccountSnapshot,totalValueInQuote: null == totalValueInQuote ? _self.totalValueInQuote : totalValueInQuote // ignore: cast_nullable_to_non_nullable
as Decimal,quoteAsset: null == quoteAsset ? _self.quoteAsset : quoteAsset // ignore: cast_nullable_to_non_nullable
as String,fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as bool,skippedAssets: null == skippedAssets ? _self.skippedAssets : skippedAssets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotAccountSnapshotCopyWith<$Res> get spot {
  
  return $SpotAccountSnapshotCopyWith<$Res>(_self.spot, (value) {
    return _then(_self.copyWith(spot: value));
  });
}/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FuturesAccountSnapshotCopyWith<$Res> get futures {
  
  return $FuturesAccountSnapshotCopyWith<$Res>(_self.futures, (value) {
    return _then(_self.copyWith(futures: value));
  });
}
}


/// Adds pattern-matching-related methods to [PortfolioSnapshot].
extension PortfolioSnapshotPatterns on PortfolioSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SpotAccountSnapshot spot,  FuturesAccountSnapshot futures, @DecimalConverter()  Decimal totalValueInQuote,  String quoteAsset,  DateTime fetchedAt,  bool stale,  List<String> skippedAssets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
return $default(_that.spot,_that.futures,_that.totalValueInQuote,_that.quoteAsset,_that.fetchedAt,_that.stale,_that.skippedAssets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SpotAccountSnapshot spot,  FuturesAccountSnapshot futures, @DecimalConverter()  Decimal totalValueInQuote,  String quoteAsset,  DateTime fetchedAt,  bool stale,  List<String> skippedAssets)  $default,) {final _that = this;
switch (_that) {
case _PortfolioSnapshot():
return $default(_that.spot,_that.futures,_that.totalValueInQuote,_that.quoteAsset,_that.fetchedAt,_that.stale,_that.skippedAssets);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SpotAccountSnapshot spot,  FuturesAccountSnapshot futures, @DecimalConverter()  Decimal totalValueInQuote,  String quoteAsset,  DateTime fetchedAt,  bool stale,  List<String> skippedAssets)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioSnapshot() when $default != null:
return $default(_that.spot,_that.futures,_that.totalValueInQuote,_that.quoteAsset,_that.fetchedAt,_that.stale,_that.skippedAssets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioSnapshot extends PortfolioSnapshot {
  const _PortfolioSnapshot({required this.spot, required this.futures, @DecimalConverter() required this.totalValueInQuote, required this.quoteAsset, required this.fetchedAt, this.stale = false, final  List<String> skippedAssets = const <String>[]}): _skippedAssets = skippedAssets,super._();
  factory _PortfolioSnapshot.fromJson(Map<String, dynamic> json) => _$PortfolioSnapshotFromJson(json);

@override final  SpotAccountSnapshot spot;
@override final  FuturesAccountSnapshot futures;
@override@DecimalConverter() final  Decimal totalValueInQuote;
@override final  String quoteAsset;
@override final  DateTime fetchedAt;
@override@JsonKey() final  bool stale;
 final  List<String> _skippedAssets;
@override@JsonKey() List<String> get skippedAssets {
  if (_skippedAssets is EqualUnmodifiableListView) return _skippedAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skippedAssets);
}


/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioSnapshotCopyWith<_PortfolioSnapshot> get copyWith => __$PortfolioSnapshotCopyWithImpl<_PortfolioSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioSnapshot&&(identical(other.spot, spot) || other.spot == spot)&&(identical(other.futures, futures) || other.futures == futures)&&(identical(other.totalValueInQuote, totalValueInQuote) || other.totalValueInQuote == totalValueInQuote)&&(identical(other.quoteAsset, quoteAsset) || other.quoteAsset == quoteAsset)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&(identical(other.stale, stale) || other.stale == stale)&&const DeepCollectionEquality().equals(other._skippedAssets, _skippedAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,spot,futures,totalValueInQuote,quoteAsset,fetchedAt,stale,const DeepCollectionEquality().hash(_skippedAssets));

@override
String toString() {
  return 'PortfolioSnapshot(spot: $spot, futures: $futures, totalValueInQuote: $totalValueInQuote, quoteAsset: $quoteAsset, fetchedAt: $fetchedAt, stale: $stale, skippedAssets: $skippedAssets)';
}


}

/// @nodoc
abstract mixin class _$PortfolioSnapshotCopyWith<$Res> implements $PortfolioSnapshotCopyWith<$Res> {
  factory _$PortfolioSnapshotCopyWith(_PortfolioSnapshot value, $Res Function(_PortfolioSnapshot) _then) = __$PortfolioSnapshotCopyWithImpl;
@override @useResult
$Res call({
 SpotAccountSnapshot spot, FuturesAccountSnapshot futures,@DecimalConverter() Decimal totalValueInQuote, String quoteAsset, DateTime fetchedAt, bool stale, List<String> skippedAssets
});


@override $SpotAccountSnapshotCopyWith<$Res> get spot;@override $FuturesAccountSnapshotCopyWith<$Res> get futures;

}
/// @nodoc
class __$PortfolioSnapshotCopyWithImpl<$Res>
    implements _$PortfolioSnapshotCopyWith<$Res> {
  __$PortfolioSnapshotCopyWithImpl(this._self, this._then);

  final _PortfolioSnapshot _self;
  final $Res Function(_PortfolioSnapshot) _then;

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spot = null,Object? futures = null,Object? totalValueInQuote = null,Object? quoteAsset = null,Object? fetchedAt = null,Object? stale = null,Object? skippedAssets = null,}) {
  return _then(_PortfolioSnapshot(
spot: null == spot ? _self.spot : spot // ignore: cast_nullable_to_non_nullable
as SpotAccountSnapshot,futures: null == futures ? _self.futures : futures // ignore: cast_nullable_to_non_nullable
as FuturesAccountSnapshot,totalValueInQuote: null == totalValueInQuote ? _self.totalValueInQuote : totalValueInQuote // ignore: cast_nullable_to_non_nullable
as Decimal,quoteAsset: null == quoteAsset ? _self.quoteAsset : quoteAsset // ignore: cast_nullable_to_non_nullable
as String,fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as bool,skippedAssets: null == skippedAssets ? _self._skippedAssets : skippedAssets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotAccountSnapshotCopyWith<$Res> get spot {
  
  return $SpotAccountSnapshotCopyWith<$Res>(_self.spot, (value) {
    return _then(_self.copyWith(spot: value));
  });
}/// Create a copy of PortfolioSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FuturesAccountSnapshotCopyWith<$Res> get futures {
  
  return $FuturesAccountSnapshotCopyWith<$Res>(_self.futures, (value) {
    return _then(_self.copyWith(futures: value));
  });
}
}

// dart format on
