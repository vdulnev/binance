// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthUnauthenticated value)?  unauthenticated,TResult Function( AuthAuthenticating value)?  authenticating,TResult Function( AuthRequiresTwoFactor value)?  requiresTwoFactor,TResult Function( AuthAuthenticated value)?  authenticated,TResult Function( AuthError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthAuthenticating() when authenticating != null:
return authenticating(_that);case AuthRequiresTwoFactor() when requiresTwoFactor != null:
return requiresTwoFactor(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case AuthError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthUnauthenticated value)  unauthenticated,required TResult Function( AuthAuthenticating value)  authenticating,required TResult Function( AuthRequiresTwoFactor value)  requiresTwoFactor,required TResult Function( AuthAuthenticated value)  authenticated,required TResult Function( AuthError value)  error,}){
final _that = this;
switch (_that) {
case AuthUnauthenticated():
return unauthenticated(_that);case AuthAuthenticating():
return authenticating(_that);case AuthRequiresTwoFactor():
return requiresTwoFactor(_that);case AuthAuthenticated():
return authenticated(_that);case AuthError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthUnauthenticated value)?  unauthenticated,TResult? Function( AuthAuthenticating value)?  authenticating,TResult? Function( AuthRequiresTwoFactor value)?  requiresTwoFactor,TResult? Function( AuthAuthenticated value)?  authenticated,TResult? Function( AuthError value)?  error,}){
final _that = this;
switch (_that) {
case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthAuthenticating() when authenticating != null:
return authenticating(_that);case AuthRequiresTwoFactor() when requiresTwoFactor != null:
return requiresTwoFactor(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case AuthError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unauthenticated,TResult Function()?  authenticating,TResult Function( String twoFactorToken,  TwoFactorType type)?  requiresTwoFactor,TResult Function( String accessToken,  String refreshToken)?  authenticated,TResult Function( String message,  int? code)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthAuthenticating() when authenticating != null:
return authenticating();case AuthRequiresTwoFactor() when requiresTwoFactor != null:
return requiresTwoFactor(_that.twoFactorToken,_that.type);case AuthAuthenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.refreshToken);case AuthError() when error != null:
return error(_that.message,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unauthenticated,required TResult Function()  authenticating,required TResult Function( String twoFactorToken,  TwoFactorType type)  requiresTwoFactor,required TResult Function( String accessToken,  String refreshToken)  authenticated,required TResult Function( String message,  int? code)  error,}) {final _that = this;
switch (_that) {
case AuthUnauthenticated():
return unauthenticated();case AuthAuthenticating():
return authenticating();case AuthRequiresTwoFactor():
return requiresTwoFactor(_that.twoFactorToken,_that.type);case AuthAuthenticated():
return authenticated(_that.accessToken,_that.refreshToken);case AuthError():
return error(_that.message,_that.code);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unauthenticated,TResult? Function()?  authenticating,TResult? Function( String twoFactorToken,  TwoFactorType type)?  requiresTwoFactor,TResult? Function( String accessToken,  String refreshToken)?  authenticated,TResult? Function( String message,  int? code)?  error,}) {final _that = this;
switch (_that) {
case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthAuthenticating() when authenticating != null:
return authenticating();case AuthRequiresTwoFactor() when requiresTwoFactor != null:
return requiresTwoFactor(_that.twoFactorToken,_that.type);case AuthAuthenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.refreshToken);case AuthError() when error != null:
return error(_that.message,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class AuthUnauthenticated implements AuthState {
  const AuthUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class AuthAuthenticating implements AuthState {
  const AuthAuthenticating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAuthenticating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticating()';
}


}




/// @nodoc


class AuthRequiresTwoFactor implements AuthState {
  const AuthRequiresTwoFactor({required this.twoFactorToken, required this.type});
  

 final  String twoFactorToken;
 final  TwoFactorType type;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthRequiresTwoFactorCopyWith<AuthRequiresTwoFactor> get copyWith => _$AuthRequiresTwoFactorCopyWithImpl<AuthRequiresTwoFactor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthRequiresTwoFactor&&(identical(other.twoFactorToken, twoFactorToken) || other.twoFactorToken == twoFactorToken)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,twoFactorToken,type);

@override
String toString() {
  return 'AuthState.requiresTwoFactor(twoFactorToken: $twoFactorToken, type: $type)';
}


}

/// @nodoc
abstract mixin class $AuthRequiresTwoFactorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthRequiresTwoFactorCopyWith(AuthRequiresTwoFactor value, $Res Function(AuthRequiresTwoFactor) _then) = _$AuthRequiresTwoFactorCopyWithImpl;
@useResult
$Res call({
 String twoFactorToken, TwoFactorType type
});




}
/// @nodoc
class _$AuthRequiresTwoFactorCopyWithImpl<$Res>
    implements $AuthRequiresTwoFactorCopyWith<$Res> {
  _$AuthRequiresTwoFactorCopyWithImpl(this._self, this._then);

  final AuthRequiresTwoFactor _self;
  final $Res Function(AuthRequiresTwoFactor) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? twoFactorToken = null,Object? type = null,}) {
  return _then(AuthRequiresTwoFactor(
twoFactorToken: null == twoFactorToken ? _self.twoFactorToken : twoFactorToken // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TwoFactorType,
  ));
}


}

/// @nodoc


class AuthAuthenticated implements AuthState {
  const AuthAuthenticated({required this.accessToken, required this.refreshToken});
  

 final  String accessToken;
 final  String refreshToken;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthAuthenticatedCopyWith<AuthAuthenticated> get copyWith => _$AuthAuthenticatedCopyWithImpl<AuthAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAuthenticated&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'AuthState.authenticated(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $AuthAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthAuthenticatedCopyWith(AuthAuthenticated value, $Res Function(AuthAuthenticated) _then) = _$AuthAuthenticatedCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken
});




}
/// @nodoc
class _$AuthAuthenticatedCopyWithImpl<$Res>
    implements $AuthAuthenticatedCopyWith<$Res> {
  _$AuthAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthAuthenticated _self;
  final $Res Function(AuthAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(AuthAuthenticated(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthError implements AuthState {
  const AuthError({required this.message, this.code});
  

 final  String message;
 final  int? code;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthErrorCopyWith<AuthError> get copyWith => _$AuthErrorCopyWithImpl<AuthError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthError&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'AuthState.error(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $AuthErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthErrorCopyWith(AuthError value, $Res Function(AuthError) _then) = _$AuthErrorCopyWithImpl;
@useResult
$Res call({
 String message, int? code
});




}
/// @nodoc
class _$AuthErrorCopyWithImpl<$Res>
    implements $AuthErrorCopyWith<$Res> {
  _$AuthErrorCopyWithImpl(this._self, this._then);

  final AuthError _self;
  final $Res Function(AuthError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(AuthError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
