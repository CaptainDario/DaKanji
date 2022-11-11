// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_advanced.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsAdvanced _$SettingsAdvancedFromJson(Map<String, dynamic> json) =>
    SettingsAdvanced()
      ..inferenceBackend = json['inferenceBackend'] as String? ?? 'cpu'
      ..useThanosSnap = json['useThanosSnap'] as bool? ?? false;

Map<String, dynamic> _$SettingsAdvancedToJson(SettingsAdvanced instance) =>
    <String, dynamic>{
      'inferenceBackend': instance.inferenceBackend,
      'useThanosSnap': instance.useThanosSnap,
    };
