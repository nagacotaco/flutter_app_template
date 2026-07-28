// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  minBuildNumber: (json['min_build_number'] as num?)?.toInt() ?? 0,
  maintenanceMode: json['maintenance_mode'] as bool? ?? false,
  maintenanceMessage: json['maintenance_message'] as String?,
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'min_build_number': instance.minBuildNumber,
      'maintenance_mode': instance.maintenanceMode,
      'maintenance_message': instance.maintenanceMessage,
    };
