// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_advanced.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsAdvanced _$SettingsAdvancedFromJson(Map<String, dynamic> json) =>
    SettingsAdvanced()
      ..useThanosSnap = json['useThanosSnap'] as bool
      ..iAmInTheMatrix = json['iAmInTheMatrix'] as bool
      ..noOfSearchIsolates = (json['noOfSearchIsolates'] as num?)?.toInt() ?? 2;

Map<String, dynamic> _$SettingsAdvancedToJson(SettingsAdvanced instance) =>
    <String, dynamic>{
      'useThanosSnap': instance.useThanosSnap,
      'iAmInTheMatrix': instance.iAmInTheMatrix,
      'noOfSearchIsolates': instance.noOfSearchIsolates,
    };
