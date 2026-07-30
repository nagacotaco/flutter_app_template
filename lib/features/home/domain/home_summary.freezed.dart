// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeSummary {

/// 主数値。画面冒頭に displayLarge で出す。
 int get primaryCount; int get weeklyDoneCount; String get lastSyncLabel; List<HomeRecentItem> get recentItems;
/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryCopyWith<HomeSummary> get copyWith => _$HomeSummaryCopyWithImpl<HomeSummary>(this as HomeSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummary&&(identical(other.primaryCount, primaryCount) || other.primaryCount == primaryCount)&&(identical(other.weeklyDoneCount, weeklyDoneCount) || other.weeklyDoneCount == weeklyDoneCount)&&(identical(other.lastSyncLabel, lastSyncLabel) || other.lastSyncLabel == lastSyncLabel)&&const DeepCollectionEquality().equals(other.recentItems, recentItems));
}


@override
int get hashCode => Object.hash(runtimeType,primaryCount,weeklyDoneCount,lastSyncLabel,const DeepCollectionEquality().hash(recentItems));

@override
String toString() {
  return 'HomeSummary(primaryCount: $primaryCount, weeklyDoneCount: $weeklyDoneCount, lastSyncLabel: $lastSyncLabel, recentItems: $recentItems)';
}


}

/// @nodoc
abstract mixin class $HomeSummaryCopyWith<$Res>  {
  factory $HomeSummaryCopyWith(HomeSummary value, $Res Function(HomeSummary) _then) = _$HomeSummaryCopyWithImpl;
@useResult
$Res call({
 int primaryCount, int weeklyDoneCount, String lastSyncLabel, List<HomeRecentItem> recentItems
});




}
/// @nodoc
class _$HomeSummaryCopyWithImpl<$Res>
    implements $HomeSummaryCopyWith<$Res> {
  _$HomeSummaryCopyWithImpl(this._self, this._then);

  final HomeSummary _self;
  final $Res Function(HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primaryCount = null,Object? weeklyDoneCount = null,Object? lastSyncLabel = null,Object? recentItems = null,}) {
  return _then(_self.copyWith(
primaryCount: null == primaryCount ? _self.primaryCount : primaryCount // ignore: cast_nullable_to_non_nullable
as int,weeklyDoneCount: null == weeklyDoneCount ? _self.weeklyDoneCount : weeklyDoneCount // ignore: cast_nullable_to_non_nullable
as int,lastSyncLabel: null == lastSyncLabel ? _self.lastSyncLabel : lastSyncLabel // ignore: cast_nullable_to_non_nullable
as String,recentItems: null == recentItems ? _self.recentItems : recentItems // ignore: cast_nullable_to_non_nullable
as List<HomeRecentItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSummary].
extension HomeSummaryPatterns on HomeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummary value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int primaryCount,  int weeklyDoneCount,  String lastSyncLabel,  List<HomeRecentItem> recentItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.primaryCount,_that.weeklyDoneCount,_that.lastSyncLabel,_that.recentItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int primaryCount,  int weeklyDoneCount,  String lastSyncLabel,  List<HomeRecentItem> recentItems)  $default,) {final _that = this;
switch (_that) {
case _HomeSummary():
return $default(_that.primaryCount,_that.weeklyDoneCount,_that.lastSyncLabel,_that.recentItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int primaryCount,  int weeklyDoneCount,  String lastSyncLabel,  List<HomeRecentItem> recentItems)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.primaryCount,_that.weeklyDoneCount,_that.lastSyncLabel,_that.recentItems);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSummary extends HomeSummary {
  const _HomeSummary({this.primaryCount = 0, this.weeklyDoneCount = 0, this.lastSyncLabel = '', final  List<HomeRecentItem> recentItems = const []}): _recentItems = recentItems,super._();
  

/// 主数値。画面冒頭に displayLarge で出す。
@override@JsonKey() final  int primaryCount;
@override@JsonKey() final  int weeklyDoneCount;
@override@JsonKey() final  String lastSyncLabel;
 final  List<HomeRecentItem> _recentItems;
@override@JsonKey() List<HomeRecentItem> get recentItems {
  if (_recentItems is EqualUnmodifiableListView) return _recentItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentItems);
}


/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryCopyWith<_HomeSummary> get copyWith => __$HomeSummaryCopyWithImpl<_HomeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummary&&(identical(other.primaryCount, primaryCount) || other.primaryCount == primaryCount)&&(identical(other.weeklyDoneCount, weeklyDoneCount) || other.weeklyDoneCount == weeklyDoneCount)&&(identical(other.lastSyncLabel, lastSyncLabel) || other.lastSyncLabel == lastSyncLabel)&&const DeepCollectionEquality().equals(other._recentItems, _recentItems));
}


@override
int get hashCode => Object.hash(runtimeType,primaryCount,weeklyDoneCount,lastSyncLabel,const DeepCollectionEquality().hash(_recentItems));

@override
String toString() {
  return 'HomeSummary(primaryCount: $primaryCount, weeklyDoneCount: $weeklyDoneCount, lastSyncLabel: $lastSyncLabel, recentItems: $recentItems)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryCopyWith<$Res> implements $HomeSummaryCopyWith<$Res> {
  factory _$HomeSummaryCopyWith(_HomeSummary value, $Res Function(_HomeSummary) _then) = __$HomeSummaryCopyWithImpl;
@override @useResult
$Res call({
 int primaryCount, int weeklyDoneCount, String lastSyncLabel, List<HomeRecentItem> recentItems
});




}
/// @nodoc
class __$HomeSummaryCopyWithImpl<$Res>
    implements _$HomeSummaryCopyWith<$Res> {
  __$HomeSummaryCopyWithImpl(this._self, this._then);

  final _HomeSummary _self;
  final $Res Function(_HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primaryCount = null,Object? weeklyDoneCount = null,Object? lastSyncLabel = null,Object? recentItems = null,}) {
  return _then(_HomeSummary(
primaryCount: null == primaryCount ? _self.primaryCount : primaryCount // ignore: cast_nullable_to_non_nullable
as int,weeklyDoneCount: null == weeklyDoneCount ? _self.weeklyDoneCount : weeklyDoneCount // ignore: cast_nullable_to_non_nullable
as int,lastSyncLabel: null == lastSyncLabel ? _self.lastSyncLabel : lastSyncLabel // ignore: cast_nullable_to_non_nullable
as String,recentItems: null == recentItems ? _self._recentItems : recentItems // ignore: cast_nullable_to_non_nullable
as List<HomeRecentItem>,
  ));
}


}

/// @nodoc
mixin _$HomeRecentItem {

 String get title; String get subtitle;
/// Create a copy of HomeRecentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeRecentItemCopyWith<HomeRecentItem> get copyWith => _$HomeRecentItemCopyWithImpl<HomeRecentItem>(this as HomeRecentItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRecentItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle);

@override
String toString() {
  return 'HomeRecentItem(title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $HomeRecentItemCopyWith<$Res>  {
  factory $HomeRecentItemCopyWith(HomeRecentItem value, $Res Function(HomeRecentItem) _then) = _$HomeRecentItemCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle
});




}
/// @nodoc
class _$HomeRecentItemCopyWithImpl<$Res>
    implements $HomeRecentItemCopyWith<$Res> {
  _$HomeRecentItemCopyWithImpl(this._self, this._then);

  final HomeRecentItem _self;
  final $Res Function(HomeRecentItem) _then;

/// Create a copy of HomeRecentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeRecentItem].
extension HomeRecentItemPatterns on HomeRecentItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeRecentItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeRecentItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeRecentItem value)  $default,){
final _that = this;
switch (_that) {
case _HomeRecentItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeRecentItem value)?  $default,){
final _that = this;
switch (_that) {
case _HomeRecentItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeRecentItem() when $default != null:
return $default(_that.title,_that.subtitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _HomeRecentItem():
return $default(_that.title,_that.subtitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _HomeRecentItem() when $default != null:
return $default(_that.title,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc


class _HomeRecentItem implements HomeRecentItem {
  const _HomeRecentItem({required this.title, required this.subtitle});
  

@override final  String title;
@override final  String subtitle;

/// Create a copy of HomeRecentItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeRecentItemCopyWith<_HomeRecentItem> get copyWith => __$HomeRecentItemCopyWithImpl<_HomeRecentItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeRecentItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle);

@override
String toString() {
  return 'HomeRecentItem(title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$HomeRecentItemCopyWith<$Res> implements $HomeRecentItemCopyWith<$Res> {
  factory _$HomeRecentItemCopyWith(_HomeRecentItem value, $Res Function(_HomeRecentItem) _then) = __$HomeRecentItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String subtitle
});




}
/// @nodoc
class __$HomeRecentItemCopyWithImpl<$Res>
    implements _$HomeRecentItemCopyWith<$Res> {
  __$HomeRecentItemCopyWithImpl(this._self, this._then);

  final _HomeRecentItem _self;
  final $Res Function(_HomeRecentItem) _then;

/// Create a copy of HomeRecentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,}) {
  return _then(_HomeRecentItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
