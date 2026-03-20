// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomePageState _$HomePageStateFromJson(Map<String, dynamic> json) =>
    _HomePageState(
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'],
    );

Map<String, dynamic> _$HomePageStateToJson(_HomePageState instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
