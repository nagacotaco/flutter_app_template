// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneLoginState {

 PhoneLoginStep get step; String get phone; bool get isSubmitting; String? get errorMessage;
/// Create a copy of PhoneLoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneLoginStateCopyWith<PhoneLoginState> get copyWith => _$PhoneLoginStateCopyWithImpl<PhoneLoginState>(this as PhoneLoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneLoginState&&(identical(other.step, step) || other.step == step)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,step,phone,isSubmitting,errorMessage);

@override
String toString() {
  return 'PhoneLoginState(step: $step, phone: $phone, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PhoneLoginStateCopyWith<$Res>  {
  factory $PhoneLoginStateCopyWith(PhoneLoginState value, $Res Function(PhoneLoginState) _then) = _$PhoneLoginStateCopyWithImpl;
@useResult
$Res call({
 PhoneLoginStep step, String phone, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$PhoneLoginStateCopyWithImpl<$Res>
    implements $PhoneLoginStateCopyWith<$Res> {
  _$PhoneLoginStateCopyWithImpl(this._self, this._then);

  final PhoneLoginState _self;
  final $Res Function(PhoneLoginState) _then;

/// Create a copy of PhoneLoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? phone = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PhoneLoginStep,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneLoginState].
extension PhoneLoginStatePatterns on PhoneLoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneLoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneLoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneLoginState value)  $default,){
final _that = this;
switch (_that) {
case _PhoneLoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneLoginState value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneLoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PhoneLoginStep step,  String phone,  bool isSubmitting,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneLoginState() when $default != null:
return $default(_that.step,_that.phone,_that.isSubmitting,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PhoneLoginStep step,  String phone,  bool isSubmitting,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PhoneLoginState():
return $default(_that.step,_that.phone,_that.isSubmitting,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PhoneLoginStep step,  String phone,  bool isSubmitting,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PhoneLoginState() when $default != null:
return $default(_that.step,_that.phone,_that.isSubmitting,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneLoginState implements PhoneLoginState {
  const _PhoneLoginState({this.step = PhoneLoginStep.inputPhone, this.phone = '', this.isSubmitting = false, this.errorMessage});
  

@override@JsonKey() final  PhoneLoginStep step;
@override@JsonKey() final  String phone;
@override@JsonKey() final  bool isSubmitting;
@override final  String? errorMessage;

/// Create a copy of PhoneLoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneLoginStateCopyWith<_PhoneLoginState> get copyWith => __$PhoneLoginStateCopyWithImpl<_PhoneLoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneLoginState&&(identical(other.step, step) || other.step == step)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,step,phone,isSubmitting,errorMessage);

@override
String toString() {
  return 'PhoneLoginState(step: $step, phone: $phone, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PhoneLoginStateCopyWith<$Res> implements $PhoneLoginStateCopyWith<$Res> {
  factory _$PhoneLoginStateCopyWith(_PhoneLoginState value, $Res Function(_PhoneLoginState) _then) = __$PhoneLoginStateCopyWithImpl;
@override @useResult
$Res call({
 PhoneLoginStep step, String phone, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class __$PhoneLoginStateCopyWithImpl<$Res>
    implements _$PhoneLoginStateCopyWith<$Res> {
  __$PhoneLoginStateCopyWithImpl(this._self, this._then);

  final _PhoneLoginState _self;
  final $Res Function(_PhoneLoginState) _then;

/// Create a copy of PhoneLoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? phone = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(_PhoneLoginState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PhoneLoginStep,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
