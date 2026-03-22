// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetEntity {
  int get id;
  String get name;
  List<String> get photoUrls;
  String? get categoryName;
  List<String> get tags;
  PetStatus get status;

  /// Create a copy of PetEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PetEntityCopyWith<PetEntity> get copyWith =>
      _$PetEntityCopyWithImpl<PetEntity>(this as PetEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PetEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.photoUrls, photoUrls) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(photoUrls),
      categoryName,
      const DeepCollectionEquality().hash(tags),
      status);

  @override
  String toString() {
    return 'PetEntity(id: $id, name: $name, photoUrls: $photoUrls, categoryName: $categoryName, tags: $tags, status: $status)';
  }
}

/// @nodoc
abstract mixin class $PetEntityCopyWith<$Res> {
  factory $PetEntityCopyWith(PetEntity value, $Res Function(PetEntity) _then) =
      _$PetEntityCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      List<String> photoUrls,
      String? categoryName,
      List<String> tags,
      PetStatus status});
}

/// @nodoc
class _$PetEntityCopyWithImpl<$Res> implements $PetEntityCopyWith<$Res> {
  _$PetEntityCopyWithImpl(this._self, this._then);

  final PetEntity _self;
  final $Res Function(PetEntity) _then;

  /// Create a copy of PetEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrls = null,
    Object? categoryName = freezed,
    Object? tags = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrls: null == photoUrls
          ? _self.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categoryName: freezed == categoryName
          ? _self.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PetStatus,
    ));
  }
}

/// Adds pattern-matching-related methods to [PetEntity].
extension PetEntityPatterns on PetEntity {
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
    TResult Function(_PetEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PetEntity() when $default != null:
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
    TResult Function(_PetEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetEntity():
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
    TResult? Function(_PetEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetEntity() when $default != null:
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
    TResult Function(int id, String name, List<String> photoUrls,
            String? categoryName, List<String> tags, PetStatus status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PetEntity() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrls,
            _that.categoryName, _that.tags, _that.status);
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
    TResult Function(int id, String name, List<String> photoUrls,
            String? categoryName, List<String> tags, PetStatus status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetEntity():
        return $default(_that.id, _that.name, _that.photoUrls,
            _that.categoryName, _that.tags, _that.status);
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
    TResult? Function(int id, String name, List<String> photoUrls,
            String? categoryName, List<String> tags, PetStatus status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PetEntity() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrls,
            _that.categoryName, _that.tags, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PetEntity implements PetEntity {
  const _PetEntity(
      {required this.id,
      required this.name,
      final List<String> photoUrls = const [],
      this.categoryName,
      final List<String> tags = const [],
      this.status = PetStatus.available})
      : _photoUrls = photoUrls,
        _tags = tags;

  @override
  final int id;
  @override
  final String name;
  final List<String> _photoUrls;
  @override
  @JsonKey()
  List<String> get photoUrls {
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoUrls);
  }

  @override
  final String? categoryName;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final PetStatus status;

  /// Create a copy of PetEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PetEntityCopyWith<_PetEntity> get copyWith =>
      __$PetEntityCopyWithImpl<_PetEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PetEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_photoUrls),
      categoryName,
      const DeepCollectionEquality().hash(_tags),
      status);

  @override
  String toString() {
    return 'PetEntity(id: $id, name: $name, photoUrls: $photoUrls, categoryName: $categoryName, tags: $tags, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$PetEntityCopyWith<$Res>
    implements $PetEntityCopyWith<$Res> {
  factory _$PetEntityCopyWith(
          _PetEntity value, $Res Function(_PetEntity) _then) =
      __$PetEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      List<String> photoUrls,
      String? categoryName,
      List<String> tags,
      PetStatus status});
}

/// @nodoc
class __$PetEntityCopyWithImpl<$Res> implements _$PetEntityCopyWith<$Res> {
  __$PetEntityCopyWithImpl(this._self, this._then);

  final _PetEntity _self;
  final $Res Function(_PetEntity) _then;

  /// Create a copy of PetEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrls = null,
    Object? categoryName = freezed,
    Object? tags = null,
    Object? status = null,
  }) {
    return _then(_PetEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrls: null == photoUrls
          ? _self._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categoryName: freezed == categoryName
          ? _self.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PetStatus,
    ));
  }
}

// dart format on
