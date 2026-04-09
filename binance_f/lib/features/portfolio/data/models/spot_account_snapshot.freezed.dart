// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_account_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotAccountSnapshot {

 DateTime get fetchedAt; List<SpotBalance> get balances; Map<String, String>? get commissionRates;
/// Create a copy of SpotAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotAccountSnapshotCopyWith<SpotAccountSnapshot> get copyWith => _$SpotAccountSnapshotCopyWithImpl<SpotAccountSnapshot>(this as SpotAccountSnapshot, _$identity);

  /// Serializes this SpotAccountSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotAccountSnapshot&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&const DeepCollectionEquality().equals(other.balances, balances)&&const DeepCollectionEquality().equals(other.commissionRates, commissionRates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fetchedAt,const DeepCollectionEquality().hash(balances),const DeepCollectionEquality().hash(commissionRates));

@override
String toString() {
  return 'SpotAccountSnapshot(fetchedAt: $fetchedAt, balances: $balances, commissionRates: $commissionRates)';
}


}

/// @nodoc
abstract mixin class $SpotAccountSnapshotCopyWith<$Res>  {
  factory $SpotAccountSnapshotCopyWith(SpotAccountSnapshot value, $Res Function(SpotAccountSnapshot) _then) = _$SpotAccountSnapshotCopyWithImpl;
@useResult
$Res call({
 DateTime fetchedAt, List<SpotBalance> balances, Map<String, String>? commissionRates
});




}
/// @nodoc
class _$SpotAccountSnapshotCopyWithImpl<$Res>
    implements $SpotAccountSnapshotCopyWith<$Res> {
  _$SpotAccountSnapshotCopyWithImpl(this._self, this._then);

  final SpotAccountSnapshot _self;
  final $Res Function(SpotAccountSnapshot) _then;

/// Create a copy of SpotAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fetchedAt = null,Object? balances = null,Object? commissionRates = freezed,}) {
  return _then(_self.copyWith(
fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,balances: null == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as List<SpotBalance>,commissionRates: freezed == commissionRates ? _self.commissionRates : commissionRates // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotAccountSnapshot].
extension SpotAccountSnapshotPatterns on SpotAccountSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotAccountSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotAccountSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotAccountSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _SpotAccountSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotAccountSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _SpotAccountSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime fetchedAt,  List<SpotBalance> balances,  Map<String, String>? commissionRates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotAccountSnapshot() when $default != null:
return $default(_that.fetchedAt,_that.balances,_that.commissionRates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime fetchedAt,  List<SpotBalance> balances,  Map<String, String>? commissionRates)  $default,) {final _that = this;
switch (_that) {
case _SpotAccountSnapshot():
return $default(_that.fetchedAt,_that.balances,_that.commissionRates);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime fetchedAt,  List<SpotBalance> balances,  Map<String, String>? commissionRates)?  $default,) {final _that = this;
switch (_that) {
case _SpotAccountSnapshot() when $default != null:
return $default(_that.fetchedAt,_that.balances,_that.commissionRates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotAccountSnapshot extends SpotAccountSnapshot {
  const _SpotAccountSnapshot({required this.fetchedAt, required final  List<SpotBalance> balances, final  Map<String, String>? commissionRates}): _balances = balances,_commissionRates = commissionRates,super._();
  factory _SpotAccountSnapshot.fromJson(Map<String, dynamic> json) => _$SpotAccountSnapshotFromJson(json);

@override final  DateTime fetchedAt;
 final  List<SpotBalance> _balances;
@override List<SpotBalance> get balances {
  if (_balances is EqualUnmodifiableListView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_balances);
}

 final  Map<String, String>? _commissionRates;
@override Map<String, String>? get commissionRates {
  final value = _commissionRates;
  if (value == null) return null;
  if (_commissionRates is EqualUnmodifiableMapView) return _commissionRates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SpotAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotAccountSnapshotCopyWith<_SpotAccountSnapshot> get copyWith => __$SpotAccountSnapshotCopyWithImpl<_SpotAccountSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotAccountSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotAccountSnapshot&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&const DeepCollectionEquality().equals(other._balances, _balances)&&const DeepCollectionEquality().equals(other._commissionRates, _commissionRates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fetchedAt,const DeepCollectionEquality().hash(_balances),const DeepCollectionEquality().hash(_commissionRates));

@override
String toString() {
  return 'SpotAccountSnapshot(fetchedAt: $fetchedAt, balances: $balances, commissionRates: $commissionRates)';
}


}

/// @nodoc
abstract mixin class _$SpotAccountSnapshotCopyWith<$Res> implements $SpotAccountSnapshotCopyWith<$Res> {
  factory _$SpotAccountSnapshotCopyWith(_SpotAccountSnapshot value, $Res Function(_SpotAccountSnapshot) _then) = __$SpotAccountSnapshotCopyWithImpl;
@override @useResult
$Res call({
 DateTime fetchedAt, List<SpotBalance> balances, Map<String, String>? commissionRates
});




}
/// @nodoc
class __$SpotAccountSnapshotCopyWithImpl<$Res>
    implements _$SpotAccountSnapshotCopyWith<$Res> {
  __$SpotAccountSnapshotCopyWithImpl(this._self, this._then);

  final _SpotAccountSnapshot _self;
  final $Res Function(_SpotAccountSnapshot) _then;

/// Create a copy of SpotAccountSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fetchedAt = null,Object? balances = null,Object? commissionRates = freezed,}) {
  return _then(_SpotAccountSnapshot(
fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,balances: null == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as List<SpotBalance>,commissionRates: freezed == commissionRates ? _self._commissionRates : commissionRates // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
