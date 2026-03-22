// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomePageState {
  bool get isLoading;
  Object? get error;
  AsyncValue<List<Sample>> get samplesAsync;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      _$HomePageStateCopyWithImpl<HomePageState>(
          this as HomePageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomePageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.samplesAsync, samplesAsync) ||
                other.samplesAsync == samplesAsync));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(error), samplesAsync);

  @override
  String toString() {
    return 'HomePageState(isLoading: $isLoading, error: $error, samplesAsync: $samplesAsync)';
  }
}

/// @nodoc
abstract mixin class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) _then) =
      _$HomePageStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading, Object? error, AsyncValue<List<Sample>> samplesAsync});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._self, this._then);

  final HomePageState _self;
  final $Res Function(HomePageState) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? samplesAsync = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _self.error : error,
      samplesAsync: null == samplesAsync
          ? _self.samplesAsync
          : samplesAsync // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Sample>>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomePageState].
extension HomePageStatePatterns on HomePageState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HomePageState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomePageState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_HomePageState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePageState():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HomePageState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePageState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool isLoading, Object? error,
            AsyncValue<List<Sample>> samplesAsync)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomePageState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.samplesAsync);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(bool isLoading, Object? error,
            AsyncValue<List<Sample>> samplesAsync)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePageState():
        return $default(_that.isLoading, _that.error, _that.samplesAsync);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool isLoading, Object? error,
            AsyncValue<List<Sample>> samplesAsync)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomePageState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.samplesAsync);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HomePageState extends HomePageState {
  const _HomePageState(
      {this.isLoading = false, this.error, required this.samplesAsync})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Object? error;
  @override
  final AsyncValue<List<Sample>> samplesAsync;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomePageStateCopyWith<_HomePageState> get copyWith =>
      __$HomePageStateCopyWithImpl<_HomePageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomePageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.samplesAsync, samplesAsync) ||
                other.samplesAsync == samplesAsync));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(error), samplesAsync);

  @override
  String toString() {
    return 'HomePageState(isLoading: $isLoading, error: $error, samplesAsync: $samplesAsync)';
  }
}

/// @nodoc
abstract mixin class _$HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$HomePageStateCopyWith(
          _HomePageState value, $Res Function(_HomePageState) _then) =
      __$HomePageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading, Object? error, AsyncValue<List<Sample>> samplesAsync});
}

/// @nodoc
class __$HomePageStateCopyWithImpl<$Res>
    implements _$HomePageStateCopyWith<$Res> {
  __$HomePageStateCopyWithImpl(this._self, this._then);

  final _HomePageState _self;
  final $Res Function(_HomePageState) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? samplesAsync = null,
  }) {
    return _then(_HomePageState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _self.error : error,
      samplesAsync: null == samplesAsync
          ? _self.samplesAsync
          : samplesAsync // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Sample>>,
    ));
  }
}

// dart format on
