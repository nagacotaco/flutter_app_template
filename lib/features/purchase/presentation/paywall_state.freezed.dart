// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paywall_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaywallState {

/// 現在の Offering のパッケージ一覧。空 = 商品未設定（テンプレート状態）。
 List<PaywallPackage> get packages;/// 選択中のパッケージ ID。
 String? get selectedPackageId;/// 購入・復元の処理中。
 bool get isProcessing; String? get errorMessage;/// 復元したが有効な購入が見つからなかった。
 bool get restoreNotFound;
/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaywallStateCopyWith<PaywallState> get copyWith => _$PaywallStateCopyWithImpl<PaywallState>(this as PaywallState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallState&&const DeepCollectionEquality().equals(other.packages, packages)&&(identical(other.selectedPackageId, selectedPackageId) || other.selectedPackageId == selectedPackageId)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.restoreNotFound, restoreNotFound) || other.restoreNotFound == restoreNotFound));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(packages),selectedPackageId,isProcessing,errorMessage,restoreNotFound);

@override
String toString() {
  return 'PaywallState(packages: $packages, selectedPackageId: $selectedPackageId, isProcessing: $isProcessing, errorMessage: $errorMessage, restoreNotFound: $restoreNotFound)';
}


}

/// @nodoc
abstract mixin class $PaywallStateCopyWith<$Res>  {
  factory $PaywallStateCopyWith(PaywallState value, $Res Function(PaywallState) _then) = _$PaywallStateCopyWithImpl;
@useResult
$Res call({
 List<PaywallPackage> packages, String? selectedPackageId, bool isProcessing, String? errorMessage, bool restoreNotFound
});




}
/// @nodoc
class _$PaywallStateCopyWithImpl<$Res>
    implements $PaywallStateCopyWith<$Res> {
  _$PaywallStateCopyWithImpl(this._self, this._then);

  final PaywallState _self;
  final $Res Function(PaywallState) _then;

/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packages = null,Object? selectedPackageId = freezed,Object? isProcessing = null,Object? errorMessage = freezed,Object? restoreNotFound = null,}) {
  return _then(_self.copyWith(
packages: null == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as List<PaywallPackage>,selectedPackageId: freezed == selectedPackageId ? _self.selectedPackageId : selectedPackageId // ignore: cast_nullable_to_non_nullable
as String?,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,restoreNotFound: null == restoreNotFound ? _self.restoreNotFound : restoreNotFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaywallState].
extension PaywallStatePatterns on PaywallState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaywallState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaywallState value)  $default,){
final _that = this;
switch (_that) {
case _PaywallState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaywallState value)?  $default,){
final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PaywallPackage> packages,  String? selectedPackageId,  bool isProcessing,  String? errorMessage,  bool restoreNotFound)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
return $default(_that.packages,_that.selectedPackageId,_that.isProcessing,_that.errorMessage,_that.restoreNotFound);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PaywallPackage> packages,  String? selectedPackageId,  bool isProcessing,  String? errorMessage,  bool restoreNotFound)  $default,) {final _that = this;
switch (_that) {
case _PaywallState():
return $default(_that.packages,_that.selectedPackageId,_that.isProcessing,_that.errorMessage,_that.restoreNotFound);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PaywallPackage> packages,  String? selectedPackageId,  bool isProcessing,  String? errorMessage,  bool restoreNotFound)?  $default,) {final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
return $default(_that.packages,_that.selectedPackageId,_that.isProcessing,_that.errorMessage,_that.restoreNotFound);case _:
  return null;

}
}

}

/// @nodoc


class _PaywallState implements PaywallState {
  const _PaywallState({final  List<PaywallPackage> packages = const [], this.selectedPackageId, this.isProcessing = false, this.errorMessage, this.restoreNotFound = false}): _packages = packages;
  

/// 現在の Offering のパッケージ一覧。空 = 商品未設定（テンプレート状態）。
 final  List<PaywallPackage> _packages;
/// 現在の Offering のパッケージ一覧。空 = 商品未設定（テンプレート状態）。
@override@JsonKey() List<PaywallPackage> get packages {
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packages);
}

/// 選択中のパッケージ ID。
@override final  String? selectedPackageId;
/// 購入・復元の処理中。
@override@JsonKey() final  bool isProcessing;
@override final  String? errorMessage;
/// 復元したが有効な購入が見つからなかった。
@override@JsonKey() final  bool restoreNotFound;

/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaywallStateCopyWith<_PaywallState> get copyWith => __$PaywallStateCopyWithImpl<_PaywallState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaywallState&&const DeepCollectionEquality().equals(other._packages, _packages)&&(identical(other.selectedPackageId, selectedPackageId) || other.selectedPackageId == selectedPackageId)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.restoreNotFound, restoreNotFound) || other.restoreNotFound == restoreNotFound));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_packages),selectedPackageId,isProcessing,errorMessage,restoreNotFound);

@override
String toString() {
  return 'PaywallState(packages: $packages, selectedPackageId: $selectedPackageId, isProcessing: $isProcessing, errorMessage: $errorMessage, restoreNotFound: $restoreNotFound)';
}


}

/// @nodoc
abstract mixin class _$PaywallStateCopyWith<$Res> implements $PaywallStateCopyWith<$Res> {
  factory _$PaywallStateCopyWith(_PaywallState value, $Res Function(_PaywallState) _then) = __$PaywallStateCopyWithImpl;
@override @useResult
$Res call({
 List<PaywallPackage> packages, String? selectedPackageId, bool isProcessing, String? errorMessage, bool restoreNotFound
});




}
/// @nodoc
class __$PaywallStateCopyWithImpl<$Res>
    implements _$PaywallStateCopyWith<$Res> {
  __$PaywallStateCopyWithImpl(this._self, this._then);

  final _PaywallState _self;
  final $Res Function(_PaywallState) _then;

/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packages = null,Object? selectedPackageId = freezed,Object? isProcessing = null,Object? errorMessage = freezed,Object? restoreNotFound = null,}) {
  return _then(_PaywallState(
packages: null == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<PaywallPackage>,selectedPackageId: freezed == selectedPackageId ? _self.selectedPackageId : selectedPackageId // ignore: cast_nullable_to_non_nullable
as String?,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,restoreNotFound: null == restoreNotFound ? _self.restoreNotFound : restoreNotFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
