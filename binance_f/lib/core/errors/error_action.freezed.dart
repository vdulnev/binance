// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ErrorAction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorAction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ErrorAction()';
}


}

/// @nodoc
class $ErrorActionCopyWith<$Res>  {
$ErrorActionCopyWith(ErrorAction _, $Res Function(ErrorAction) __);
}


/// Adds pattern-matching-related methods to [ErrorAction].
extension ErrorActionPatterns on ErrorAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShowSnackbar value)?  showSnackbar,TResult Function( ShowDialog value)?  showDialog,TResult Function( ForceRelogin value)?  forceRelogin,TResult Function( BlockUi value)?  blockUi,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShowSnackbar() when showSnackbar != null:
return showSnackbar(_that);case ShowDialog() when showDialog != null:
return showDialog(_that);case ForceRelogin() when forceRelogin != null:
return forceRelogin(_that);case BlockUi() when blockUi != null:
return blockUi(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShowSnackbar value)  showSnackbar,required TResult Function( ShowDialog value)  showDialog,required TResult Function( ForceRelogin value)  forceRelogin,required TResult Function( BlockUi value)  blockUi,}){
final _that = this;
switch (_that) {
case ShowSnackbar():
return showSnackbar(_that);case ShowDialog():
return showDialog(_that);case ForceRelogin():
return forceRelogin(_that);case BlockUi():
return blockUi(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShowSnackbar value)?  showSnackbar,TResult? Function( ShowDialog value)?  showDialog,TResult? Function( ForceRelogin value)?  forceRelogin,TResult? Function( BlockUi value)?  blockUi,}){
final _that = this;
switch (_that) {
case ShowSnackbar() when showSnackbar != null:
return showSnackbar(_that);case ShowDialog() when showDialog != null:
return showDialog(_that);case ForceRelogin() when forceRelogin != null:
return forceRelogin(_that);case BlockUi() when blockUi != null:
return blockUi(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  showSnackbar,TResult Function( String title,  String message)?  showDialog,TResult Function( String reason)?  forceRelogin,TResult Function( String reason)?  blockUi,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShowSnackbar() when showSnackbar != null:
return showSnackbar(_that.message);case ShowDialog() when showDialog != null:
return showDialog(_that.title,_that.message);case ForceRelogin() when forceRelogin != null:
return forceRelogin(_that.reason);case BlockUi() when blockUi != null:
return blockUi(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  showSnackbar,required TResult Function( String title,  String message)  showDialog,required TResult Function( String reason)  forceRelogin,required TResult Function( String reason)  blockUi,}) {final _that = this;
switch (_that) {
case ShowSnackbar():
return showSnackbar(_that.message);case ShowDialog():
return showDialog(_that.title,_that.message);case ForceRelogin():
return forceRelogin(_that.reason);case BlockUi():
return blockUi(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  showSnackbar,TResult? Function( String title,  String message)?  showDialog,TResult? Function( String reason)?  forceRelogin,TResult? Function( String reason)?  blockUi,}) {final _that = this;
switch (_that) {
case ShowSnackbar() when showSnackbar != null:
return showSnackbar(_that.message);case ShowDialog() when showDialog != null:
return showDialog(_that.title,_that.message);case ForceRelogin() when forceRelogin != null:
return forceRelogin(_that.reason);case BlockUi() when blockUi != null:
return blockUi(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class ShowSnackbar implements ErrorAction {
  const ShowSnackbar(this.message);
  

 final  String message;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowSnackbarCopyWith<ShowSnackbar> get copyWith => _$ShowSnackbarCopyWithImpl<ShowSnackbar>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowSnackbar&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ErrorAction.showSnackbar(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShowSnackbarCopyWith<$Res> implements $ErrorActionCopyWith<$Res> {
  factory $ShowSnackbarCopyWith(ShowSnackbar value, $Res Function(ShowSnackbar) _then) = _$ShowSnackbarCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ShowSnackbarCopyWithImpl<$Res>
    implements $ShowSnackbarCopyWith<$Res> {
  _$ShowSnackbarCopyWithImpl(this._self, this._then);

  final ShowSnackbar _self;
  final $Res Function(ShowSnackbar) _then;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShowSnackbar(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ShowDialog implements ErrorAction {
  const ShowDialog({required this.title, required this.message});
  

 final  String title;
 final  String message;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowDialogCopyWith<ShowDialog> get copyWith => _$ShowDialogCopyWithImpl<ShowDialog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowDialog&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,title,message);

@override
String toString() {
  return 'ErrorAction.showDialog(title: $title, message: $message)';
}


}

/// @nodoc
abstract mixin class $ShowDialogCopyWith<$Res> implements $ErrorActionCopyWith<$Res> {
  factory $ShowDialogCopyWith(ShowDialog value, $Res Function(ShowDialog) _then) = _$ShowDialogCopyWithImpl;
@useResult
$Res call({
 String title, String message
});




}
/// @nodoc
class _$ShowDialogCopyWithImpl<$Res>
    implements $ShowDialogCopyWith<$Res> {
  _$ShowDialogCopyWithImpl(this._self, this._then);

  final ShowDialog _self;
  final $Res Function(ShowDialog) _then;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? message = null,}) {
  return _then(ShowDialog(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForceRelogin implements ErrorAction {
  const ForceRelogin(this.reason);
  

 final  String reason;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForceReloginCopyWith<ForceRelogin> get copyWith => _$ForceReloginCopyWithImpl<ForceRelogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForceRelogin&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'ErrorAction.forceRelogin(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ForceReloginCopyWith<$Res> implements $ErrorActionCopyWith<$Res> {
  factory $ForceReloginCopyWith(ForceRelogin value, $Res Function(ForceRelogin) _then) = _$ForceReloginCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$ForceReloginCopyWithImpl<$Res>
    implements $ForceReloginCopyWith<$Res> {
  _$ForceReloginCopyWithImpl(this._self, this._then);

  final ForceRelogin _self;
  final $Res Function(ForceRelogin) _then;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(ForceRelogin(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BlockUi implements ErrorAction {
  const BlockUi(this.reason);
  

 final  String reason;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockUiCopyWith<BlockUi> get copyWith => _$BlockUiCopyWithImpl<BlockUi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockUi&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'ErrorAction.blockUi(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $BlockUiCopyWith<$Res> implements $ErrorActionCopyWith<$Res> {
  factory $BlockUiCopyWith(BlockUi value, $Res Function(BlockUi) _then) = _$BlockUiCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$BlockUiCopyWithImpl<$Res>
    implements $BlockUiCopyWith<$Res> {
  _$BlockUiCopyWithImpl(this._self, this._then);

  final BlockUi _self;
  final $Res Function(BlockUi) _then;

/// Create a copy of ErrorAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(BlockUi(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
