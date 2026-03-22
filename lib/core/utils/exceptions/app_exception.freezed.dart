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
  String get message;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppExceptionCopyWith<AppException> get copyWith =>
      _$AppExceptionCopyWithImpl<AppException>(
          this as AppException, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppException &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AppException(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) _then) =
      _$AppExceptionCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res> implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._self, this._then);

  final AppException _self;
  final $Res Function(AppException) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(ServerException value)? server,
    TResult Function(AuthException value)? auth,
    TResult Function(UnknownException value)? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NetworkException() when network != null:
        return network(_that);
      case ServerException() when server != null:
        return server(_that);
      case AuthException() when auth != null:
        return auth(_that);
      case UnknownException() when unknown != null:
        return unknown(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(ServerException value) server,
    required TResult Function(AuthException value) auth,
    required TResult Function(UnknownException value) unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NetworkException():
        return network(_that);
      case ServerException():
        return server(_that);
      case AuthException():
        return auth(_that);
      case UnknownException():
        return unknown(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(ServerException value)? server,
    TResult? Function(AuthException value)? auth,
    TResult? Function(UnknownException value)? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NetworkException() when network != null:
        return network(_that);
      case ServerException() when server != null:
        return server(_that);
      case AuthException() when auth != null:
        return auth(_that);
      case UnknownException() when unknown != null:
        return unknown(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Object? error)? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NetworkException() when network != null:
        return network(_that.message);
      case ServerException() when server != null:
        return server(_that.statusCode, _that.message);
      case AuthException() when auth != null:
        return auth(_that.message);
      case UnknownException() when unknown != null:
        return unknown(_that.message, _that.error);
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
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Object? error) unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NetworkException():
        return network(_that.message);
      case ServerException():
        return server(_that.statusCode, _that.message);
      case AuthException():
        return auth(_that.message);
      case UnknownException():
        return unknown(_that.message, _that.error);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Object? error)? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NetworkException() when network != null:
        return network(_that.message);
      case ServerException() when server != null:
        return server(_that.statusCode, _that.message);
      case AuthException() when auth != null:
        return auth(_that.message);
      case UnknownException() when unknown != null:
        return unknown(_that.message, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NetworkException implements AppException {
  const NetworkException({this.message = 'ネットワークに接続できませんでした'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NetworkExceptionCopyWith<NetworkException> get copyWith =>
      _$NetworkExceptionCopyWithImpl<NetworkException>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NetworkException &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AppException.network(message: $message)';
  }
}

/// @nodoc
abstract mixin class $NetworkExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory $NetworkExceptionCopyWith(
          NetworkException value, $Res Function(NetworkException) _then) =
      _$NetworkExceptionCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$NetworkExceptionCopyWithImpl<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  _$NetworkExceptionCopyWithImpl(this._self, this._then);

  final NetworkException _self;
  final $Res Function(NetworkException) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(NetworkException(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ServerException implements AppException {
  const ServerException(
      {required this.statusCode, this.message = 'サーバーエラーが発生しました'});

  final int statusCode;
  @override
  @JsonKey()
  final String message;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServerExceptionCopyWith<ServerException> get copyWith =>
      _$ServerExceptionCopyWithImpl<ServerException>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServerException &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @override
  String toString() {
    return 'AppException.server(statusCode: $statusCode, message: $message)';
  }
}

/// @nodoc
abstract mixin class $ServerExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory $ServerExceptionCopyWith(
          ServerException value, $Res Function(ServerException) _then) =
      _$ServerExceptionCopyWithImpl;
  @override
  @useResult
  $Res call({int statusCode, String message});
}

/// @nodoc
class _$ServerExceptionCopyWithImpl<$Res>
    implements $ServerExceptionCopyWith<$Res> {
  _$ServerExceptionCopyWithImpl(this._self, this._then);

  final ServerException _self;
  final $Res Function(ServerException) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(ServerException(
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthException implements AppException {
  const AuthException({this.message = '認証エラーが発生しました'});

  @override
  @JsonKey()
  final String message;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthExceptionCopyWith<AuthException> get copyWith =>
      _$AuthExceptionCopyWithImpl<AuthException>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthException &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AppException.auth(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AuthExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory $AuthExceptionCopyWith(
          AuthException value, $Res Function(AuthException) _then) =
      _$AuthExceptionCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AuthExceptionCopyWithImpl<$Res>
    implements $AuthExceptionCopyWith<$Res> {
  _$AuthExceptionCopyWithImpl(this._self, this._then);

  final AuthException _self;
  final $Res Function(AuthException) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(AuthException(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UnknownException implements AppException {
  const UnknownException({this.message = '予期しないエラーが発生しました', this.error});

  @override
  @JsonKey()
  final String message;
  final Object? error;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnknownExceptionCopyWith<UnknownException> get copyWith =>
      _$UnknownExceptionCopyWithImpl<UnknownException>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnknownException &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'AppException.unknown(message: $message, error: $error)';
  }
}

/// @nodoc
abstract mixin class $UnknownExceptionCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory $UnknownExceptionCopyWith(
          UnknownException value, $Res Function(UnknownException) _then) =
      _$UnknownExceptionCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? error});
}

/// @nodoc
class _$UnknownExceptionCopyWithImpl<$Res>
    implements $UnknownExceptionCopyWith<$Res> {
  _$UnknownExceptionCopyWithImpl(this._self, this._then);

  final UnknownException _self;
  final $Res Function(UnknownException) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? error = freezed,
  }) {
    return _then(UnknownException(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error ? _self.error : error,
    ));
  }
}

// dart format on
