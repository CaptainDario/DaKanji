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
      ..useWebview = json['useWebview'] as bool
      ..kbLongPressMod = (json['kbLongPressMod'] as List<dynamic>)
          .map((e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
          .toSet()
      ..kbDoublePressMod = (json['kbDoublePressMod'] as List<dynamic>)
          .map((e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
          .toSet()
      ..kbClearCanvas = (json['kbClearCanvas'] as List<dynamic>)
          .map((e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
          .toSet()
      ..kbUndoStroke = (json['kbUndoStroke'] as List<dynamic>)
          .map((e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
          .toSet()
      ..kbWordBar = (json['kbWordBar'] as List<dynamic>)
          .map((e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
          .toSet()
      ..kbWordBarDelChar = (json['kbWordBarDelChar'] as List<dynamic>)
          .map((e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
          .toSet()
      ..kbPreds = (json['kbPreds'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map(
                  (e) => const LogicalKeyboardKeyConverter().fromJson(e as int))
              .toSet())
          .toList();

Map<String, dynamic> _$SettingsDrawingToJson(SettingsDrawing instance) =>
    <String, dynamic>{
      'customURL': instance.customURL,
      'selectedDictionary': instance.selectedDictionary,
      'invertShortLongPress': instance.invertShortLongPress,
      'emptyCanvasAfterDoubleTap': instance.emptyCanvasAfterDoubleTap,
      'useWebview': instance.useWebview,
      'kbLongPressMod': instance.kbLongPressMod
          .map(const LogicalKeyboardKeyConverter().toJson)
          .toList(),
      'kbDoublePressMod': instance.kbDoublePressMod
          .map(const LogicalKeyboardKeyConverter().toJson)
          .toList(),
      'kbClearCanvas': instance.kbClearCanvas
          .map(const LogicalKeyboardKeyConverter().toJson)
          .toList(),
      'kbUndoStroke': instance.kbUndoStroke
          .map(const LogicalKeyboardKeyConverter().toJson)
          .toList(),
      'kbWordBar': instance.kbWordBar
          .map(const LogicalKeyboardKeyConverter().toJson)
          .toList(),
      'kbWordBarDelChar': instance.kbWordBarDelChar
          .map(const LogicalKeyboardKeyConverter().toJson)
          .toList(),
      'kbPreds': instance.kbPreds
          .map(
              (e) => e.map(const LogicalKeyboardKeyConverter().toJson).toList())
          .toList(),
    };
