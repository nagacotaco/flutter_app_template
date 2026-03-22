// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetListState {
  bool get isLoading;
  Object? get error;
  AsyncValue<List<PetEntity>> get petsAsync;

  /// Create a copy of PetListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PetListStateCopyWith<PetListState> get copyWith =>
      _$PetListStateCopyWithImpl<PetListState>(
          this as PetListState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PetListState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.petsAsync, petsAsync) ||
                other.petsAsync == petsAsync));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(error), petsAsync);

  @override
  String toString() {
    return 'PetListState(isLoading: $isLoading, error: $error, petsAsync: $petsAsync)';
  }
}

/// @nodoc
abstract mixin class $PetListStateCopyWith<$Res> {
  factory $PetListStateCopyWith(
          PetListState value, $Res Function(PetListState) _then) =
      _$PetListStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading, Object? error, AsyncValue<List<PetEntity>> petsAsync});
}

/// @nodoc
class _$PetListStateCopyWithImpl<$Res> implements $PetListStateCopyWith<$Res> {
  _$PetListStateCopyWithImpl(this._self, this._then);

  final PetListState _self;
  final $Res Function(PetListState) _then;

  /// Create a copy of PetListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? petsAsync = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _self.error : error,
      petsAsync: null == petsAsync
          ? _self.petsAsync
          : petsAsync // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<PetEntity>>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PetListState].
extension PetListStatePatterns on PetListState {
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
    TResult Function(_PetListState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PetListState() when $default != null:
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
    TResult Function(_PetListState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetListState():
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
    TResult? Function(_PetListState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetListState() when $default != null:
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
            AsyncValue<List<PetEntity>> petsAsync)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PetListState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.petsAsync);
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
            AsyncValue<List<PetEntity>> petsAsync)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetListState():
        return $default(_that.isLoading, _that.error, _that.petsAsync);
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
            AsyncValue<List<PetEntity>> petsAsync)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetListState() when $default != null:
        return $default(_that.isLoading, _that.error, _that.petsAsync);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PetListState implements PetListState {
  const _PetListState(
      {this.isLoading = false, this.error, required this.petsAsync});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Object? error;
  @override
  final AsyncValue<List<PetEntity>> petsAsync;

  /// Create a copy of PetListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PetListStateCopyWith<_PetListState> get copyWith =>
      __$PetListStateCopyWithImpl<_PetListState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PetListState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.petsAsync, petsAsync) ||
                other.petsAsync == petsAsync));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(error), petsAsync);

  @override
  String toString() {
    return 'PetListState(isLoading: $isLoading, error: $error, petsAsync: $petsAsync)';
  }
}

/// @nodoc
abstract mixin class _$PetListStateCopyWith<$Res>
    implements $PetListStateCopyWith<$Res> {
  factory _$PetListStateCopyWith(
          _PetListState value, $Res Function(_PetListState) _then) =
      __$PetListStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading, Object? error, AsyncValue<List<PetEntity>> petsAsync});
}

/// @nodoc
class __$PetListStateCopyWithImpl<$Res>
    implements _$PetListStateCopyWith<$Res> {
  __$PetListStateCopyWithImpl(this._self, this._then);

  final _PetListState _self;
  final $Res Function(_PetListState) _then;

  /// Create a copy of PetListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? petsAsync = null,
  }) {
    return _then(_PetListState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _self.error : error,
      petsAsync: null == petsAsync
          ? _self.petsAsync
          : petsAsync // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<PetEntity>>,
    ));
  }
}

// dart format on
