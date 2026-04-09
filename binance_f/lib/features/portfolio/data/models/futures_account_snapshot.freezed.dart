// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'futures_account_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FuturesAccountSnapshot {

 DateTime get fetchedAt; List<FuturesAssetBalance> get assets; List<FuturesPosition> get positions;@DecimalConverter() Decimal get totalWalletBalance;@DecimalConverter() Decimal get totalUnrealizedProfit;@DecimalConverter() Decimal get totalMarginBalance;
/// Create a copy of FuturesAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesAccountSnapshotCopyWith<FuturesAccountSnapshot> get copyWith => _$FuturesAccountSnapshotCopyWithImpl<FuturesAccountSnapshot>(this as FuturesAccountSnapshot, _$identity);

  /// Serializes this FuturesAccountSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesAccountSnapshot&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&const DeepCollectionEquality().equals(other.assets, assets)&&const DeepCollectionEquality().equals(other.positions, positions)&&(identical(other.totalWalletBalance, totalWalletBalance) || other.totalWalletBalance == totalWalletBalance)&&(identical(other.totalUnrealizedProfit, totalUnrealizedProfit) || other.totalUnrealizedProfit == totalUnrealizedProfit)&&(identical(other.totalMarginBalance, totalMarginBalance) || other.totalMarginBalance == totalMarginBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fetchedAt,const DeepCollectionEquality().hash(assets),const DeepCollectionEquality().hash(positions),totalWalletBalance,totalUnrealizedProfit,totalMarginBalance);

@override
String toString() {
  return 'FuturesAccountSnapshot(fetchedAt: $fetchedAt, assets: $assets, positions: $positions, totalWalletBalance: $totalWalletBalance, totalUnrealizedProfit: $totalUnrealizedProfit, totalMarginBalance: $totalMarginBalance)';
}


}

/// @nodoc
abstract mixin class $FuturesAccountSnapshotCopyWith<$Res>  {
  factory $FuturesAccountSnapshotCopyWith(FuturesAccountSnapshot value, $Res Function(FuturesAccountSnapshot) _then) = _$FuturesAccountSnapshotCopyWithImpl;
@useResult
$Res call({
 DateTime fetchedAt, List<FuturesAssetBalance> assets, List<FuturesPosition> positions,@DecimalConverter() Decimal totalWalletBalance,@DecimalConverter() Decimal totalUnrealizedProfit,@DecimalConverter() Decimal totalMarginBalance
});




}
/// @nodoc
class _$FuturesAccountSnapshotCopyWithImpl<$Res>
    implements $FuturesAccountSnapshotCopyWith<$Res> {
  _$FuturesAccountSnapshotCopyWithImpl(this._self, this._then);

  final FuturesAccountSnapshot _self;
  final $Res Function(FuturesAccountSnapshot) _then;

/// Create a copy of FuturesAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fetchedAt = null,Object? assets = null,Object? positions = null,Object? totalWalletBalance = null,Object? totalUnrealizedProfit = null,Object? totalMarginBalance = null,}) {
  return _then(_self.copyWith(
fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<FuturesAssetBalance>,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as List<FuturesPosition>,totalWalletBalance: null == totalWalletBalance ? _self.totalWalletBalance : totalWalletBalance // ignore: cast_nullable_to_non_nullable
as Decimal,totalUnrealizedProfit: null == totalUnrealizedProfit ? _self.totalUnrealizedProfit : totalUnrealizedProfit // ignore: cast_nullable_to_non_nullable
as Decimal,totalMarginBalance: null == totalMarginBalance ? _self.totalMarginBalance : totalMarginBalance // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}

}


/// Adds pattern-matching-related methods to [FuturesAccountSnapshot].
extension FuturesAccountSnapshotPatterns on FuturesAccountSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FuturesAccountSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FuturesAccountSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FuturesAccountSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _FuturesAccountSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FuturesAccountSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _FuturesAccountSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime fetchedAt,  List<FuturesAssetBalance> assets,  List<FuturesPosition> positions, @DecimalConverter()  Decimal totalWalletBalance, @DecimalConverter()  Decimal totalUnrealizedProfit, @DecimalConverter()  Decimal totalMarginBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FuturesAccountSnapshot() when $default != null:
return $default(_that.fetchedAt,_that.assets,_that.positions,_that.totalWalletBalance,_that.totalUnrealizedProfit,_that.totalMarginBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime fetchedAt,  List<FuturesAssetBalance> assets,  List<FuturesPosition> positions, @DecimalConverter()  Decimal totalWalletBalance, @DecimalConverter()  Decimal totalUnrealizedProfit, @DecimalConverter()  Decimal totalMarginBalance)  $default,) {final _that = this;
switch (_that) {
case _FuturesAccountSnapshot():
return $default(_that.fetchedAt,_that.assets,_that.positions,_that.totalWalletBalance,_that.totalUnrealizedProfit,_that.totalMarginBalance);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime fetchedAt,  List<FuturesAssetBalance> assets,  List<FuturesPosition> positions, @DecimalConverter()  Decimal totalWalletBalance, @DecimalConverter()  Decimal totalUnrealizedProfit, @DecimalConverter()  Decimal totalMarginBalance)?  $default,) {final _that = this;
switch (_that) {
case _FuturesAccountSnapshot() when $default != null:
return $default(_that.fetchedAt,_that.assets,_that.positions,_that.totalWalletBalance,_that.totalUnrealizedProfit,_that.totalMarginBalance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FuturesAccountSnapshot extends FuturesAccountSnapshot {
  const _FuturesAccountSnapshot({required this.fetchedAt, required final  List<FuturesAssetBalance> assets, required final  List<FuturesPosition> positions, @DecimalConverter() required this.totalWalletBalance, @DecimalConverter() required this.totalUnrealizedProfit, @DecimalConverter() required this.totalMarginBalance}): _assets = assets,_positions = positions,super._();
  factory _FuturesAccountSnapshot.fromJson(Map<String, dynamic> json) => _$FuturesAccountSnapshotFromJson(json);

@override final  DateTime fetchedAt;
 final  List<FuturesAssetBalance> _assets;
@override List<FuturesAssetBalance> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<FuturesPosition> _positions;
@override List<FuturesPosition> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}

@override@DecimalConverter() final  Decimal totalWalletBalance;
@override@DecimalConverter() final  Decimal totalUnrealizedProfit;
@override@DecimalConverter() final  Decimal totalMarginBalance;

/// Create a copy of FuturesAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FuturesAccountSnapshotCopyWith<_FuturesAccountSnapshot> get copyWith => __$FuturesAccountSnapshotCopyWithImpl<_FuturesAccountSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FuturesAccountSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FuturesAccountSnapshot&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._positions, _positions)&&(identical(other.totalWalletBalance, totalWalletBalance) || other.totalWalletBalance == totalWalletBalance)&&(identical(other.totalUnrealizedProfit, totalUnrealizedProfit) || other.totalUnrealizedProfit == totalUnrealizedProfit)&&(identical(other.totalMarginBalance, totalMarginBalance) || other.totalMarginBalance == totalMarginBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fetchedAt,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_positions),totalWalletBalance,totalUnrealizedProfit,totalMarginBalance);

@override
String toString() {
  return 'FuturesAccountSnapshot(fetchedAt: $fetchedAt, assets: $assets, positions: $positions, totalWalletBalance: $totalWalletBalance, totalUnrealizedProfit: $totalUnrealizedProfit, totalMarginBalance: $totalMarginBalance)';
}


}

/// @nodoc
abstract mixin class _$FuturesAccountSnapshotCopyWith<$Res> implements $FuturesAccountSnapshotCopyWith<$Res> {
  factory _$FuturesAccountSnapshotCopyWith(_FuturesAccountSnapshot value, $Res Function(_FuturesAccountSnapshot) _then) = __$FuturesAccountSnapshotCopyWithImpl;
@override @useResult
$Res call({
 DateTime fetchedAt, List<FuturesAssetBalance> assets, List<FuturesPosition> positions,@DecimalConverter() Decimal totalWalletBalance,@DecimalConverter() Decimal totalUnrealizedProfit,@DecimalConverter() Decimal totalMarginBalance
});




}
/// @nodoc
class __$FuturesAccountSnapshotCopyWithImpl<$Res>
    implements _$FuturesAccountSnapshotCopyWith<$Res> {
  __$FuturesAccountSnapshotCopyWithImpl(this._self, this._then);

  final _FuturesAccountSnapshot _self;
  final $Res Function(_FuturesAccountSnapshot) _then;

/// Create a copy of FuturesAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fetchedAt = null,Object? assets = null,Object? positions = null,Object? totalWalletBalance = null,Object? totalUnrealizedProfit = null,Object? totalMarginBalance = null,}) {
  return _then(_FuturesAccountSnapshot(
fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<FuturesAssetBalance>,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<FuturesPosition>,totalWalletBalance: null == totalWalletBalance ? _self.totalWalletBalance : totalWalletBalance // ignore: cast_nullable_to_non_nullable
as Decimal,totalUnrealizedProfit: null == totalUnrealizedProfit ? _self.totalUnrealizedProfit : totalUnrealizedProfit // ignore: cast_nullable_to_non_nullable
as Decimal,totalMarginBalance: null == totalMarginBalance ? _self.totalMarginBalance : totalMarginBalance // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

// dart format on
