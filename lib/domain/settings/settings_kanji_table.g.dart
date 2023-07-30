// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_kanji_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsKanjiTable _$SettingsKanjiTableFromJson(Map<String, dynamic> json) =>
    SettingsKanjiTable()
      ..kanjiCategory =
          $enumDecodeNullable(_$KanjiCategoryEnumMap, json['kanjiCategory']) ??
              KanjiCategory.JLPT
      ..kanjiCategoryLevel = json['kanjiCategoryLevel'] as String? ?? '5'
      ..kanjiSorting =
          $enumDecodeNullable(_$KanjiSortingEnumMap, json['kanjiSorting']) ??
              KanjiSorting.STROKES_ASC;

Map<String, dynamic> _$SettingsKanjiTableToJson(SettingsKanjiTable instance) =>
    <String, dynamic>{
      'kanjiCategory': _$KanjiCategoryEnumMap[instance.kanjiCategory]!,
      'kanjiCategoryLevel': instance.kanjiCategoryLevel,
      'kanjiSorting': _$KanjiSortingEnumMap[instance.kanjiSorting]!,
    };

const _$KanjiCategoryEnumMap = {
  KanjiCategory.JLPT: 'JLPT',
  KanjiCategory.RTK: 'RTK',
  KanjiCategory.SCHOOL: 'SCHOOL',
  KanjiCategory.FREQ: 'FREQ',
  KanjiCategory.KLC: 'KLC',
  KanjiCategory.KENTEI: 'KENTEI',
  KanjiCategory.WANIKANI: 'WANIKANI',
};

const _$KanjiSortingEnumMap = {
  KanjiSorting.STROKES_ASC: 'STROKES_ASC',
  KanjiSorting.STROKES_DSC: 'STROKES_DSC',
  KanjiSorting.FREQ_ASC: 'FREQ_ASC',
  KanjiSorting.FREQ_DSC: 'FREQ_DSC',
  KanjiSorting.RTK_ASC: 'RTK_ASC',
  KanjiSorting.RTK_DSC: 'RTK_DSC',
  KanjiSorting.KLC_ASC: 'KLC_ASC',
  KanjiSorting.KLC_DSC: 'KLC_DSC',
};
