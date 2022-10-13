// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_advanced.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsAdvanced _$SettingsAdvancedFromJson(Map<String, dynamic> json) =>
    SettingsAdvanced()
      ..inferenceBackends = (json['inferenceBackends'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..inferenceBackend = json['inferenceBackend'] as String
      ..useThanosSnap = json['useThanosSnap'] as bool;

Map<String, dynamic> _$SettingsAdvancedToJson(SettingsAdvanced instance) =>
    <String, dynamic>{
      'inferenceBackends': instance.inferenceBackends,
      'inferenceBackend': instance.inferenceBackend,
      'useThanosSnap': instance.useThanosSnap,
    };
