// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpPageState {
  bool get isLoading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpPageStateCopyWith<SignUpPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpPageStateCopyWith<$Res> {
  factory $SignUpPageStateCopyWith(
          SignUpPageState value, $Res Function(SignUpPageState) then) =
      _$SignUpPageStateCopyWithImpl<$Res, SignUpPageState>;
  @useResult
  $Res call({bool isLoading, Object? error});
}

/// @nodoc
class _$SignUpPageStateCopyWithImpl<$Res, $Val extends SignUpPageState>
    implements $SignUpPageStateCopyWith<$Res> {
  _$SignUpPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpPageStateImplCopyWith<$Res>
    implements $SignUpPageStateCopyWith<$Res> {
  factory _$$SignUpPageStateImplCopyWith(_$SignUpPageStateImpl value,
          $Res Function(_$SignUpPageStateImpl) then) =
      __$$SignUpPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, Object? error});
}

/// @nodoc
class __$$SignUpPageStateImplCopyWithImpl<$Res>
    extends _$SignUpPageStateCopyWithImpl<$Res, _$SignUpPageStateImpl>
    implements _$$SignUpPageStateImplCopyWith<$Res> {
  __$$SignUpPageStateImplCopyWithImpl(
      _$SignUpPageStateImpl _value, $Res Function(_$SignUpPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$SignUpPageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$SignUpPageStateImpl extends _SignUpPageState {
  const _$SignUpPageStateImpl({this.isLoading = false, this.error}) : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Object? error;

  @override
  String toString() {
    return 'SignUpPageState(isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpPageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpPageStateImplCopyWith<_$SignUpPageStateImpl> get copyWith =>
      __$$SignUpPageStateImplCopyWithImpl<_$SignUpPageStateImpl>(
          this, _$identity);
}

abstract class _SignUpPageState extends SignUpPageState {
  const factory _SignUpPageState({final bool isLoading, final Object? error}) =
      _$SignUpPageStateImpl;
  const _SignUpPageState._() : super._();

  @override
  bool get isLoading;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$SignUpPageStateImplCopyWith<_$SignUpPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
