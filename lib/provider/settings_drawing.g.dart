// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_drawing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsDrawing _$SettingsDrawingFromJson(Map<String, dynamic> json) =>
    SettingsDrawing()
      ..customURL = json['customURL'] as String
      ..selectedDictionary = json['selectedDictionary'] as String
      ..invertShortLongPress = json['invertShortLongPress'] as bool
      ..emptyCanvasAfterDoubleTap = json['emptyCanvasAfterDoubleTap'] as bool
      ..useWebview = json['useWebview'] as bool;

Map<String, dynamic> _$SettingsDrawingToJson(SettingsDrawing instance) =>
    <String, dynamic>{
      'customURL': instance.customURL,
      'selectedDictionary': instance.selectedDictionary,
      'invertShortLongPress': instance.invertShortLongPress,
      'emptyCanvasAfterDoubleTap': instance.emptyCanvasAfterDoubleTap,
      'useWebview': instance.useWebview,
    };
