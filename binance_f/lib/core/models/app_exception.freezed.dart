// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppException {

 String? get message;
/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppExceptionCopyWith<AppException> get copyWith => _$AppExceptionCopyWithImpl<AppException>(this as AppException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppException&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppException(message: $message)';
}


}

/// @nodoc
abstract mixin class $AppExceptionCopyWith<$Res>  {
  factory $AppExceptionCopyWith(AppException value, $Res Function(AppException) _then) = _$AppExceptionCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AppExceptionCopyWithImpl<$Res>
    implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._self, this._then);

  final AppException _self;
  final $Res Function(AppException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message! : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppException].
extension AppExceptionPatterns on AppException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkException value)?  network,TResult Function( AuthException value)?  auth,TResult Function( RateLimitException value)?  rateLimit,TResult Function( IpBanException value)?  ipBan,TResult Function( InvalidSignatureException value)?  invalidSignature,TResult Function( ClockSkewException value)?  clockSkew,TResult Function( FilterViolationException value)?  filterViolation,TResult Function( BinanceApiException value)?  binanceApi,TResult Function( UnknownException value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkException() when network != null:
return network(_that);case AuthException() when auth != null:
return auth(_that);case RateLimitException() when rateLimit != null:
return rateLimit(_that);case IpBanException() when ipBan != null:
return ipBan(_that);case InvalidSignatureException() when invalidSignature != null:
return invalidSignature(_that);case ClockSkewException() when clockSkew != null:
return clockSkew(_that);case FilterViolationException() when filterViolation != null:
return filterViolation(_that);case BinanceApiException() when binanceApi != null:
return binanceApi(_that);case UnknownException() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkException value)  network,required TResult Function( AuthException value)  auth,required TResult Function( RateLimitException value)  rateLimit,required TResult Function( IpBanException value)  ipBan,required TResult Function( InvalidSignatureException value)  invalidSignature,required TResult Function( ClockSkewException value)  clockSkew,required TResult Function( FilterViolationException value)  filterViolation,required TResult Function( BinanceApiException value)  binanceApi,required TResult Function( UnknownException value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkException():
return network(_that);case AuthException():
return auth(_that);case RateLimitException():
return rateLimit(_that);case IpBanException():
return ipBan(_that);case InvalidSignatureException():
return invalidSignature(_that);case ClockSkewException():
return clockSkew(_that);case FilterViolationException():
return filterViolation(_that);case BinanceApiException():
return binanceApi(_that);case UnknownException():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkException value)?  network,TResult? Function( AuthException value)?  auth,TResult? Function( RateLimitException value)?  rateLimit,TResult? Function( IpBanException value)?  ipBan,TResult? Function( InvalidSignatureException value)?  invalidSignature,TResult? Function( ClockSkewException value)?  clockSkew,TResult? Function( FilterViolationException value)?  filterViolation,TResult? Function( BinanceApiException value)?  binanceApi,TResult? Function( UnknownException value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkException() when network != null:
return network(_that);case AuthException() when auth != null:
return auth(_that);case RateLimitException() when rateLimit != null:
return rateLimit(_that);case IpBanException() when ipBan != null:
return ipBan(_that);case InvalidSignatureException() when invalidSignature != null:
return invalidSignature(_that);case ClockSkewException() when clockSkew != null:
return clockSkew(_that);case FilterViolationException() when filterViolation != null:
return filterViolation(_that);case BinanceApiException() when binanceApi != null:
return binanceApi(_that);case UnknownException() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message,  bool retriable)?  network,TResult Function( String message,  int? code)?  auth,TResult Function( String message,  int? retryAfterSeconds,  int? code)?  rateLimit,TResult Function( String message,  DateTime? bannedUntil)?  ipBan,TResult Function( String? message)?  invalidSignature,TResult Function( String? message)?  clockSkew,TResult Function( String filter,  String message,  String? symbol)?  filterViolation,TResult Function( int code,  String message,  int? httpStatusCode)?  binanceApi,TResult Function( String? message)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkException() when network != null:
return network(_that.message,_that.retriable);case AuthException() when auth != null:
return auth(_that.message,_that.code);case RateLimitException() when rateLimit != null:
return rateLimit(_that.message,_that.retryAfterSeconds,_that.code);case IpBanException() when ipBan != null:
return ipBan(_that.message,_that.bannedUntil);case InvalidSignatureException() when invalidSignature != null:
return invalidSignature(_that.message);case ClockSkewException() when clockSkew != null:
return clockSkew(_that.message);case FilterViolationException() when filterViolation != null:
return filterViolation(_that.filter,_that.message,_that.symbol);case BinanceApiException() when binanceApi != null:
return binanceApi(_that.code,_that.message,_that.httpStatusCode);case UnknownException() when unknown != null:
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message,  bool retriable)  network,required TResult Function( String message,  int? code)  auth,required TResult Function( String message,  int? retryAfterSeconds,  int? code)  rateLimit,required TResult Function( String message,  DateTime? bannedUntil)  ipBan,required TResult Function( String? message)  invalidSignature,required TResult Function( String? message)  clockSkew,required TResult Function( String filter,  String message,  String? symbol)  filterViolation,required TResult Function( int code,  String message,  int? httpStatusCode)  binanceApi,required TResult Function( String? message)  unknown,}) {final _that = this;
switch (_that) {
case NetworkException():
return network(_that.message,_that.retriable);case AuthException():
return auth(_that.message,_that.code);case RateLimitException():
return rateLimit(_that.message,_that.retryAfterSeconds,_that.code);case IpBanException():
return ipBan(_that.message,_that.bannedUntil);case InvalidSignatureException():
return invalidSignature(_that.message);case ClockSkewException():
return clockSkew(_that.message);case FilterViolationException():
return filterViolation(_that.filter,_that.message,_that.symbol);case BinanceApiException():
return binanceApi(_that.code,_that.message,_that.httpStatusCode);case UnknownException():
return unknown(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message,  bool retriable)?  network,TResult? Function( String message,  int? code)?  auth,TResult? Function( String message,  int? retryAfterSeconds,  int? code)?  rateLimit,TResult? Function( String message,  DateTime? bannedUntil)?  ipBan,TResult? Function( String? message)?  invalidSignature,TResult? Function( String? message)?  clockSkew,TResult? Function( String filter,  String message,  String? symbol)?  filterViolation,TResult? Function( int code,  String message,  int? httpStatusCode)?  binanceApi,TResult? Function( String? message)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkException() when network != null:
return network(_that.message,_that.retriable);case AuthException() when auth != null:
return auth(_that.message,_that.code);case RateLimitException() when rateLimit != null:
return rateLimit(_that.message,_that.retryAfterSeconds,_that.code);case IpBanException() when ipBan != null:
return ipBan(_that.message,_that.bannedUntil);case InvalidSignatureException() when invalidSignature != null:
return invalidSignature(_that.message);case ClockSkewException() when clockSkew != null:
return clockSkew(_that.message);case FilterViolationException() when filterViolation != null:
return filterViolation(_that.filter,_that.message,_that.symbol);case BinanceApiException() when binanceApi != null:
return binanceApi(_that.code,_that.message,_that.httpStatusCode);case UnknownException() when unknown != null:
return unknown(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NetworkException extends AppException {
  const NetworkException({this.message, this.retriable = false}): super._();
  

@override final  String? message;
@JsonKey() final  bool retriable;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkExceptionCopyWith<NetworkException> get copyWith => _$NetworkExceptionCopyWithImpl<NetworkException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkException&&(identical(other.message, message) || other.message == message)&&(identical(other.retriable, retriable) || other.retriable == retriable));
}


@override
int get hashCode => Object.hash(runtimeType,message,retriable);

@override
String toString() {
  return 'AppException.network(message: $message, retriable: $retriable)';
}


}

/// @nodoc
abstract mixin class $NetworkExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $NetworkExceptionCopyWith(NetworkException value, $Res Function(NetworkException) _then) = _$NetworkExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message, bool retriable
});




}
/// @nodoc
class _$NetworkExceptionCopyWithImpl<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  _$NetworkExceptionCopyWithImpl(this._self, this._then);

  final NetworkException _self;
  final $Res Function(NetworkException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? retriable = null,}) {
  return _then(NetworkException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,retriable: null == retriable ? _self.retriable : retriable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AuthException extends AppException {
  const AuthException({required this.message, this.code}): super._();
  

@override final  String message;
 final  int? code;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthExceptionCopyWith<AuthException> get copyWith => _$AuthExceptionCopyWithImpl<AuthException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthException&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'AppException.auth(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $AuthExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $AuthExceptionCopyWith(AuthException value, $Res Function(AuthException) _then) = _$AuthExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, int? code
});




}
/// @nodoc
class _$AuthExceptionCopyWithImpl<$Res>
    implements $AuthExceptionCopyWith<$Res> {
  _$AuthExceptionCopyWithImpl(this._self, this._then);

  final AuthException _self;
  final $Res Function(AuthException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(AuthException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class RateLimitException extends AppException {
  const RateLimitException({required this.message, this.retryAfterSeconds, this.code}): super._();
  

@override final  String message;
 final  int? retryAfterSeconds;
 final  int? code;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateLimitExceptionCopyWith<RateLimitException> get copyWith => _$RateLimitExceptionCopyWithImpl<RateLimitException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateLimitException&&(identical(other.message, message) || other.message == message)&&(identical(other.retryAfterSeconds, retryAfterSeconds) || other.retryAfterSeconds == retryAfterSeconds)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,retryAfterSeconds,code);

@override
String toString() {
  return 'AppException.rateLimit(message: $message, retryAfterSeconds: $retryAfterSeconds, code: $code)';
}


}

/// @nodoc
abstract mixin class $RateLimitExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $RateLimitExceptionCopyWith(RateLimitException value, $Res Function(RateLimitException) _then) = _$RateLimitExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, int? retryAfterSeconds, int? code
});




}
/// @nodoc
class _$RateLimitExceptionCopyWithImpl<$Res>
    implements $RateLimitExceptionCopyWith<$Res> {
  _$RateLimitExceptionCopyWithImpl(this._self, this._then);

  final RateLimitException _self;
  final $Res Function(RateLimitException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? retryAfterSeconds = freezed,Object? code = freezed,}) {
  return _then(RateLimitException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,retryAfterSeconds: freezed == retryAfterSeconds ? _self.retryAfterSeconds : retryAfterSeconds // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class IpBanException extends AppException {
  const IpBanException({required this.message, this.bannedUntil}): super._();
  

@override final  String message;
 final  DateTime? bannedUntil;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IpBanExceptionCopyWith<IpBanException> get copyWith => _$IpBanExceptionCopyWithImpl<IpBanException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IpBanException&&(identical(other.message, message) || other.message == message)&&(identical(other.bannedUntil, bannedUntil) || other.bannedUntil == bannedUntil));
}


@override
int get hashCode => Object.hash(runtimeType,message,bannedUntil);

@override
String toString() {
  return 'AppException.ipBan(message: $message, bannedUntil: $bannedUntil)';
}


}

/// @nodoc
abstract mixin class $IpBanExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $IpBanExceptionCopyWith(IpBanException value, $Res Function(IpBanException) _then) = _$IpBanExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, DateTime? bannedUntil
});




}
/// @nodoc
class _$IpBanExceptionCopyWithImpl<$Res>
    implements $IpBanExceptionCopyWith<$Res> {
  _$IpBanExceptionCopyWithImpl(this._self, this._then);

  final IpBanException _self;
  final $Res Function(IpBanException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? bannedUntil = freezed,}) {
  return _then(IpBanException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,bannedUntil: freezed == bannedUntil ? _self.bannedUntil : bannedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class InvalidSignatureException extends AppException {
  const InvalidSignatureException({this.message}): super._();
  

@override final  String? message;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidSignatureExceptionCopyWith<InvalidSignatureException> get copyWith => _$InvalidSignatureExceptionCopyWithImpl<InvalidSignatureException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidSignatureException&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppException.invalidSignature(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidSignatureExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $InvalidSignatureExceptionCopyWith(InvalidSignatureException value, $Res Function(InvalidSignatureException) _then) = _$InvalidSignatureExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$InvalidSignatureExceptionCopyWithImpl<$Res>
    implements $InvalidSignatureExceptionCopyWith<$Res> {
  _$InvalidSignatureExceptionCopyWithImpl(this._self, this._then);

  final InvalidSignatureException _self;
  final $Res Function(InvalidSignatureException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(InvalidSignatureException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ClockSkewException extends AppException {
  const ClockSkewException({this.message}): super._();
  

@override final  String? message;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClockSkewExceptionCopyWith<ClockSkewException> get copyWith => _$ClockSkewExceptionCopyWithImpl<ClockSkewException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClockSkewException&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppException.clockSkew(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClockSkewExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $ClockSkewExceptionCopyWith(ClockSkewException value, $Res Function(ClockSkewException) _then) = _$ClockSkewExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ClockSkewExceptionCopyWithImpl<$Res>
    implements $ClockSkewExceptionCopyWith<$Res> {
  _$ClockSkewExceptionCopyWithImpl(this._self, this._then);

  final ClockSkewException _self;
  final $Res Function(ClockSkewException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ClockSkewException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FilterViolationException extends AppException {
  const FilterViolationException({required this.filter, required this.message, this.symbol}): super._();
  

 final  String filter;
@override final  String message;
 final  String? symbol;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterViolationExceptionCopyWith<FilterViolationException> get copyWith => _$FilterViolationExceptionCopyWithImpl<FilterViolationException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterViolationException&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.message, message) || other.message == message)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}


@override
int get hashCode => Object.hash(runtimeType,filter,message,symbol);

@override
String toString() {
  return 'AppException.filterViolation(filter: $filter, message: $message, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class $FilterViolationExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $FilterViolationExceptionCopyWith(FilterViolationException value, $Res Function(FilterViolationException) _then) = _$FilterViolationExceptionCopyWithImpl;
@override @useResult
$Res call({
 String filter, String message, String? symbol
});




}
/// @nodoc
class _$FilterViolationExceptionCopyWithImpl<$Res>
    implements $FilterViolationExceptionCopyWith<$Res> {
  _$FilterViolationExceptionCopyWithImpl(this._self, this._then);

  final FilterViolationException _self;
  final $Res Function(FilterViolationException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filter = null,Object? message = null,Object? symbol = freezed,}) {
  return _then(FilterViolationException(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BinanceApiException extends AppException {
  const BinanceApiException({required this.code, required this.message, this.httpStatusCode}): super._();
  

 final  int code;
@override final  String message;
 final  int? httpStatusCode;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BinanceApiExceptionCopyWith<BinanceApiException> get copyWith => _$BinanceApiExceptionCopyWithImpl<BinanceApiException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BinanceApiException&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.httpStatusCode, httpStatusCode) || other.httpStatusCode == httpStatusCode));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,httpStatusCode);

@override
String toString() {
  return 'AppException.binanceApi(code: $code, message: $message, httpStatusCode: $httpStatusCode)';
}


}

/// @nodoc
abstract mixin class $BinanceApiExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $BinanceApiExceptionCopyWith(BinanceApiException value, $Res Function(BinanceApiException) _then) = _$BinanceApiExceptionCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, int? httpStatusCode
});




}
/// @nodoc
class _$BinanceApiExceptionCopyWithImpl<$Res>
    implements $BinanceApiExceptionCopyWith<$Res> {
  _$BinanceApiExceptionCopyWithImpl(this._self, this._then);

  final BinanceApiException _self;
  final $Res Function(BinanceApiException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? httpStatusCode = freezed,}) {
  return _then(BinanceApiException(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,httpStatusCode: freezed == httpStatusCode ? _self.httpStatusCode : httpStatusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class UnknownException extends AppException {
  const UnknownException({this.message}): super._();
  

@override final  String? message;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownExceptionCopyWith<UnknownException> get copyWith => _$UnknownExceptionCopyWithImpl<UnknownException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownException&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppException.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownExceptionCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $UnknownExceptionCopyWith(UnknownException value, $Res Function(UnknownException) _then) = _$UnknownExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$UnknownExceptionCopyWithImpl<$Res>
    implements $UnknownExceptionCopyWith<$Res> {
  _$UnknownExceptionCopyWithImpl(this._self, this._then);

  final UnknownException _self;
  final $Res Function(UnknownException) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(UnknownException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
