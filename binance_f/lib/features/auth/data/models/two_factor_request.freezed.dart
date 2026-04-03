// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'two_factor_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwoFactorRequest {

 String get twoFactorToken; String get code; TwoFactorType get type;
/// Create a copy of TwoFactorRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TwoFactorRequestCopyWith<TwoFactorRequest> get copyWith => _$TwoFactorRequestCopyWithImpl<TwoFactorRequest>(this as TwoFactorRequest, _$identity);

  /// Serializes this TwoFactorRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TwoFactorRequest&&(identical(other.twoFactorToken, twoFactorToken) || other.twoFactorToken == twoFactorToken)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,twoFactorToken,code,type);

@override
String toString() {
  return 'TwoFactorRequest(twoFactorToken: $twoFactorToken, code: $code, type: $type)';
}


}

/// @nodoc
abstract mixin class $TwoFactorRequestCopyWith<$Res>  {
  factory $TwoFactorRequestCopyWith(TwoFactorRequest value, $Res Function(TwoFactorRequest) _then) = _$TwoFactorRequestCopyWithImpl;
@useResult
$Res call({
 String twoFactorToken, String code, TwoFactorType type
});




}
/// @nodoc
class _$TwoFactorRequestCopyWithImpl<$Res>
    implements $TwoFactorRequestCopyWith<$Res> {
  _$TwoFactorRequestCopyWithImpl(this._self, this._then);

  final TwoFactorRequest _self;
  final $Res Function(TwoFactorRequest) _then;

/// Create a copy of TwoFactorRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? twoFactorToken = null,Object? code = null,Object? type = null,}) {
  return _then(_self.copyWith(
twoFactorToken: null == twoFactorToken ? _self.twoFactorToken : twoFactorToken // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TwoFactorType,
  ));
}

}


/// Adds pattern-matching-related methods to [TwoFactorRequest].
extension TwoFactorRequestPatterns on TwoFactorRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TwoFactorRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TwoFactorRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TwoFactorRequest value)  $default,){
final _that = this;
switch (_that) {
case _TwoFactorRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TwoFactorRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TwoFactorRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String twoFactorToken,  String code,  TwoFactorType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TwoFactorRequest() when $default != null:
return $default(_that.twoFactorToken,_that.code,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String twoFactorToken,  String code,  TwoFactorType type)  $default,) {final _that = this;
switch (_that) {
case _TwoFactorRequest():
return $default(_that.twoFactorToken,_that.code,_that.type);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String twoFactorToken,  String code,  TwoFactorType type)?  $default,) {final _that = this;
switch (_that) {
case _TwoFactorRequest() when $default != null:
return $default(_that.twoFactorToken,_that.code,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TwoFactorRequest implements TwoFactorRequest {
  const _TwoFactorRequest({required this.twoFactorToken, required this.code, required this.type});
  factory _TwoFactorRequest.fromJson(Map<String, dynamic> json) => _$TwoFactorRequestFromJson(json);

@override final  String twoFactorToken;
@override final  String code;
@override final  TwoFactorType type;

/// Create a copy of TwoFactorRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TwoFactorRequestCopyWith<_TwoFactorRequest> get copyWith => __$TwoFactorRequestCopyWithImpl<_TwoFactorRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TwoFactorRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TwoFactorRequest&&(identical(other.twoFactorToken, twoFactorToken) || other.twoFactorToken == twoFactorToken)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,twoFactorToken,code,type);

@override
String toString() {
  return 'TwoFactorRequest(twoFactorToken: $twoFactorToken, code: $code, type: $type)';
}


}

/// @nodoc
abstract mixin class _$TwoFactorRequestCopyWith<$Res> implements $TwoFactorRequestCopyWith<$Res> {
  factory _$TwoFactorRequestCopyWith(_TwoFactorRequest value, $Res Function(_TwoFactorRequest) _then) = __$TwoFactorRequestCopyWithImpl;
@override @useResult
$Res call({
 String twoFactorToken, String code, TwoFactorType type
});




}
/// @nodoc
class __$TwoFactorRequestCopyWithImpl<$Res>
    implements _$TwoFactorRequestCopyWith<$Res> {
  __$TwoFactorRequestCopyWithImpl(this._self, this._then);

  final _TwoFactorRequest _self;
  final $Res Function(_TwoFactorRequest) _then;

/// Create a copy of TwoFactorRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? twoFactorToken = null,Object? code = null,Object? type = null,}) {
  return _then(_TwoFactorRequest(
twoFactorToken: null == twoFactorToken ? _self.twoFactorToken : twoFactorToken // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TwoFactorType,
  ));
}


}

// dart format on
