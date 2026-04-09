// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserDataEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserDataEvent()';
}


}

/// @nodoc
class $UserDataEventCopyWith<$Res>  {
$UserDataEventCopyWith(UserDataEvent _, $Res Function(UserDataEvent) __);
}


/// Adds pattern-matching-related methods to [UserDataEvent].
extension UserDataEventPatterns on UserDataEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountUpdate value)?  accountUpdate,TResult Function( FuturesAccountUpdate value)?  futuresAccountUpdate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountUpdate value)  accountUpdate,required TResult Function( FuturesAccountUpdate value)  futuresAccountUpdate,}){
final _that = this;
switch (_that) {
case AccountUpdate():
return accountUpdate(_that);case FuturesAccountUpdate():
return futuresAccountUpdate(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountUpdate value)?  accountUpdate,TResult? Function( FuturesAccountUpdate value)?  futuresAccountUpdate,}){
final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<SpotBalance> balances)?  accountUpdate,TResult Function( List<FuturesAssetBalance> assets,  List<FuturesPosition> positions)?  futuresAccountUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that.balances);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that.assets,_that.positions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<SpotBalance> balances)  accountUpdate,required TResult Function( List<FuturesAssetBalance> assets,  List<FuturesPosition> positions)  futuresAccountUpdate,}) {final _that = this;
switch (_that) {
case AccountUpdate():
return accountUpdate(_that.balances);case FuturesAccountUpdate():
return futuresAccountUpdate(_that.assets,_that.positions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<SpotBalance> balances)?  accountUpdate,TResult? Function( List<FuturesAssetBalance> assets,  List<FuturesPosition> positions)?  futuresAccountUpdate,}) {final _that = this;
switch (_that) {
case AccountUpdate() when accountUpdate != null:
return accountUpdate(_that.balances);case FuturesAccountUpdate() when futuresAccountUpdate != null:
return futuresAccountUpdate(_that.assets,_that.positions);case _:
  return null;

}
}

}

/// @nodoc


class AccountUpdate extends UserDataEvent {
  const AccountUpdate({required final  List<SpotBalance> balances}): _balances = balances,super._();
  

 final  List<SpotBalance> _balances;
 List<SpotBalance> get balances {
  if (_balances is EqualUnmodifiableListView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_balances);
}


/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountUpdateCopyWith<AccountUpdate> get copyWith => _$AccountUpdateCopyWithImpl<AccountUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountUpdate&&const DeepCollectionEquality().equals(other._balances, _balances));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_balances));

@override
String toString() {
  return 'UserDataEvent.accountUpdate(balances: $balances)';
}


}

/// @nodoc
abstract mixin class $AccountUpdateCopyWith<$Res> implements $UserDataEventCopyWith<$Res> {
  factory $AccountUpdateCopyWith(AccountUpdate value, $Res Function(AccountUpdate) _then) = _$AccountUpdateCopyWithImpl;
@useResult
$Res call({
 List<SpotBalance> balances
});




}
/// @nodoc
class _$AccountUpdateCopyWithImpl<$Res>
    implements $AccountUpdateCopyWith<$Res> {
  _$AccountUpdateCopyWithImpl(this._self, this._then);

  final AccountUpdate _self;
  final $Res Function(AccountUpdate) _then;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? balances = null,}) {
  return _then(AccountUpdate(
balances: null == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as List<SpotBalance>,
  ));
}


}

/// @nodoc


class FuturesAccountUpdate extends UserDataEvent {
  const FuturesAccountUpdate({required final  List<FuturesAssetBalance> assets, required final  List<FuturesPosition> positions}): _assets = assets,_positions = positions,super._();
  

 final  List<FuturesAssetBalance> _assets;
 List<FuturesAssetBalance> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<FuturesPosition> _positions;
 List<FuturesPosition> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}


/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FuturesAccountUpdateCopyWith<FuturesAccountUpdate> get copyWith => _$FuturesAccountUpdateCopyWithImpl<FuturesAccountUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FuturesAccountUpdate&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._positions, _positions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_positions));

@override
String toString() {
  return 'UserDataEvent.futuresAccountUpdate(assets: $assets, positions: $positions)';
}


}

/// @nodoc
abstract mixin class $FuturesAccountUpdateCopyWith<$Res> implements $UserDataEventCopyWith<$Res> {
  factory $FuturesAccountUpdateCopyWith(FuturesAccountUpdate value, $Res Function(FuturesAccountUpdate) _then) = _$FuturesAccountUpdateCopyWithImpl;
@useResult
$Res call({
 List<FuturesAssetBalance> assets, List<FuturesPosition> positions
});




}
/// @nodoc
class _$FuturesAccountUpdateCopyWithImpl<$Res>
    implements $FuturesAccountUpdateCopyWith<$Res> {
  _$FuturesAccountUpdateCopyWithImpl(this._self, this._then);

  final FuturesAccountUpdate _self;
  final $Res Function(FuturesAccountUpdate) _then;

/// Create a copy of UserDataEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assets = null,Object? positions = null,}) {
  return _then(FuturesAccountUpdate(
assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<FuturesAssetBalance>,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<FuturesPosition>,
  ));
}


}

// dart format on
