// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {

/// このビルド番号未満のアプリは強制アップデート画面を表示する。
@JsonKey(name: 'min_build_number') int get minBuildNumber;@JsonKey(name: 'maintenance_mode') bool get maintenanceMode;/// メンテナンス画面に表示する文言。null なら l10n のデフォルト文言。
@JsonKey(name: 'maintenance_message') String? get maintenanceMessage;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.minBuildNumber, minBuildNumber) || other.minBuildNumber == minBuildNumber)&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.maintenanceMessage, maintenanceMessage) || other.maintenanceMessage == maintenanceMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minBuildNumber,maintenanceMode,maintenanceMessage);

@override
String toString() {
  return 'AppConfig(minBuildNumber: $minBuildNumber, maintenanceMode: $maintenanceMode, maintenanceMessage: $maintenanceMessage)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'min_build_number') int minBuildNumber,@JsonKey(name: 'maintenance_mode') bool maintenanceMode,@JsonKey(name: 'maintenance_message') String? maintenanceMessage
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minBuildNumber = null,Object? maintenanceMode = null,Object? maintenanceMessage = freezed,}) {
  return _then(_self.copyWith(
minBuildNumber: null == minBuildNumber ? _self.minBuildNumber : minBuildNumber // ignore: cast_nullable_to_non_nullable
as int,maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,maintenanceMessage: freezed == maintenanceMessage ? _self.maintenanceMessage : maintenanceMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_build_number')  int minBuildNumber, @JsonKey(name: 'maintenance_mode')  bool maintenanceMode, @JsonKey(name: 'maintenance_message')  String? maintenanceMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.minBuildNumber,_that.maintenanceMode,_that.maintenanceMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'min_build_number')  int minBuildNumber, @JsonKey(name: 'maintenance_mode')  bool maintenanceMode, @JsonKey(name: 'maintenance_message')  String? maintenanceMessage)  $default,) {final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that.minBuildNumber,_that.maintenanceMode,_that.maintenanceMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'min_build_number')  int minBuildNumber, @JsonKey(name: 'maintenance_mode')  bool maintenanceMode, @JsonKey(name: 'maintenance_message')  String? maintenanceMessage)?  $default,) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.minBuildNumber,_that.maintenanceMode,_that.maintenanceMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppConfig implements AppConfig {
  const _AppConfig({@JsonKey(name: 'min_build_number') this.minBuildNumber = 0, @JsonKey(name: 'maintenance_mode') this.maintenanceMode = false, @JsonKey(name: 'maintenance_message') this.maintenanceMessage});
  factory _AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

/// このビルド番号未満のアプリは強制アップデート画面を表示する。
@override@JsonKey(name: 'min_build_number') final  int minBuildNumber;
@override@JsonKey(name: 'maintenance_mode') final  bool maintenanceMode;
/// メンテナンス画面に表示する文言。null なら l10n のデフォルト文言。
@override@JsonKey(name: 'maintenance_message') final  String? maintenanceMessage;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&(identical(other.minBuildNumber, minBuildNumber) || other.minBuildNumber == minBuildNumber)&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.maintenanceMessage, maintenanceMessage) || other.maintenanceMessage == maintenanceMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minBuildNumber,maintenanceMode,maintenanceMessage);

@override
String toString() {
  return 'AppConfig(minBuildNumber: $minBuildNumber, maintenanceMode: $maintenanceMode, maintenanceMessage: $maintenanceMessage)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'min_build_number') int minBuildNumber,@JsonKey(name: 'maintenance_mode') bool maintenanceMode,@JsonKey(name: 'maintenance_message') String? maintenanceMessage
});




}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minBuildNumber = null,Object? maintenanceMode = null,Object? maintenanceMessage = freezed,}) {
  return _then(_AppConfig(
minBuildNumber: null == minBuildNumber ? _self.minBuildNumber : minBuildNumber // ignore: cast_nullable_to_non_nullable
as int,maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,maintenanceMessage: freezed == maintenanceMessage ? _self.maintenanceMessage : maintenanceMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
