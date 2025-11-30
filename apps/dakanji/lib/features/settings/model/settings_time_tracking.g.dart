// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_time_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsTimeTracking _$SettingsTimeTrackingFromJson(
  Map<String, dynamic> json,
) => SettingsTimeTracking()
  ..sessionLength = (json['sessionLength'] as num).toInt()
  ..breakLength = (json['breakLength'] as num).toInt();

Map<String, dynamic> _$SettingsTimeTrackingToJson(
  SettingsTimeTracking instance,
) => <String, dynamic>{
  'sessionLength': instance.sessionLength,
  'breakLength': instance.breakLength,
};
