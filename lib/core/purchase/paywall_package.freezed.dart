// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paywall_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaywallPackage {

/// RevenueCat の Package identifier（例: `$rc_monthly`）。
 String get id;/// ストアに登録した商品名。
 String get title;/// ストアに登録した商品説明。
 String get description;/// 端末ロケールで整形済みの価格表示（例: ¥480）。
 String get priceString;
/// Create a copy of PaywallPackage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaywallPackageCopyWith<PaywallPackage> get copyWith => _$PaywallPackageCopyWithImpl<PaywallPackage>(this as PaywallPackage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallPackage&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,priceString);

@override
String toString() {
  return 'PaywallPackage(id: $id, title: $title, description: $description, priceString: $priceString)';
}


}

/// @nodoc
abstract mixin class $PaywallPackageCopyWith<$Res>  {
  factory $PaywallPackageCopyWith(PaywallPackage value, $Res Function(PaywallPackage) _then) = _$PaywallPackageCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String priceString
});




}
/// @nodoc
class _$PaywallPackageCopyWithImpl<$Res>
    implements $PaywallPackageCopyWith<$Res> {
  _$PaywallPackageCopyWithImpl(this._self, this._then);

  final PaywallPackage _self;
  final $Res Function(PaywallPackage) _then;

/// Create a copy of PaywallPackage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priceString = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaywallPackage].
extension PaywallPackagePatterns on PaywallPackage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaywallPackage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaywallPackage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaywallPackage value)  $default,){
final _that = this;
switch (_that) {
case _PaywallPackage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaywallPackage value)?  $default,){
final _that = this;
switch (_that) {
case _PaywallPackage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String priceString)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaywallPackage() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.priceString);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String priceString)  $default,) {final _that = this;
switch (_that) {
case _PaywallPackage():
return $default(_that.id,_that.title,_that.description,_that.priceString);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String priceString)?  $default,) {final _that = this;
switch (_that) {
case _PaywallPackage() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.priceString);case _:
  return null;

}
}

}

/// @nodoc


class _PaywallPackage implements PaywallPackage {
  const _PaywallPackage({required this.id, required this.title, required this.description, required this.priceString});
  

/// RevenueCat の Package identifier（例: `$rc_monthly`）。
@override final  String id;
/// ストアに登録した商品名。
@override final  String title;
/// ストアに登録した商品説明。
@override final  String description;
/// 端末ロケールで整形済みの価格表示（例: ¥480）。
@override final  String priceString;

/// Create a copy of PaywallPackage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaywallPackageCopyWith<_PaywallPackage> get copyWith => __$PaywallPackageCopyWithImpl<_PaywallPackage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaywallPackage&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,priceString);

@override
String toString() {
  return 'PaywallPackage(id: $id, title: $title, description: $description, priceString: $priceString)';
}


}

/// @nodoc
abstract mixin class _$PaywallPackageCopyWith<$Res> implements $PaywallPackageCopyWith<$Res> {
  factory _$PaywallPackageCopyWith(_PaywallPackage value, $Res Function(_PaywallPackage) _then) = __$PaywallPackageCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String priceString
});




}
/// @nodoc
class __$PaywallPackageCopyWithImpl<$Res>
    implements _$PaywallPackageCopyWith<$Res> {
  __$PaywallPackageCopyWithImpl(this._self, this._then);

  final _PaywallPackage _self;
  final $Res Function(_PaywallPackage) _then;

/// Create a copy of PaywallPackage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priceString = null,}) {
  return _then(_PaywallPackage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
