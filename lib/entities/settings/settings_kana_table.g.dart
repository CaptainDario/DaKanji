// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_kana_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsKanaTable _$SettingsKanaTableFromJson(Map<String, dynamic> json) =>
    SettingsKanaTable()
      ..playAudio = json['playAudio'] as bool? ?? true
      ..playKanaAnimationWhenOpened =
          json['playKanaAnimationWhenOpened'] as bool? ?? true
      ..kanaAnimationStrokesPerSecond =
          (json['kanaAnimationStrokesPerSecond'] as num?)?.toDouble() ?? 2
      ..resumeAnimationAfterStopSwipe =
          json['resumeAnimationAfterStopSwipe'] as bool? ?? false
      ..isHiragana = json['isHiragana'] as bool? ?? true
      ..showRomaji = json['showRomaji'] as bool? ?? true
      ..showDaku = json['showDaku'] as bool? ?? false
      ..showYoon = json['showYoon'] as bool? ?? false
      ..showSpecial = json['showSpecial'] as bool? ?? false;

Map<String, dynamic> _$SettingsKanaTableToJson(SettingsKanaTable instance) =>
    <String, dynamic>{
      'playAudio': instance.playAudio,
      'playKanaAnimationWhenOpened': instance.playKanaAnimationWhenOpened,
      'kanaAnimationStrokesPerSecond': instance.kanaAnimationStrokesPerSecond,
      'resumeAnimationAfterStopSwipe': instance.resumeAnimationAfterStopSwipe,
      'isHiragana': instance.isHiragana,
      'showRomaji': instance.showRomaji,
      'showDaku': instance.showDaku,
      'showYoon': instance.showYoon,
      'showSpecial': instance.showSpecial,
    };
