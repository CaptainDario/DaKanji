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
              KanjiSorting.strokesAsc;

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
  KanjiSorting.strokesAsc: 'STROKES_ASC',
  KanjiSorting.strokesDsc: 'STROKES_DSC',
  KanjiSorting.freqAsc: 'FREQ_ASC',
  KanjiSorting.freqDsc: 'FREQ_DSC',
  KanjiSorting.rtkAsc: 'RTK_ASC',
  KanjiSorting.rtkDsc: 'RTK_DSC',
  KanjiSorting.klcAsc: 'KLC_ASC',
  KanjiSorting.klcDsc: 'KLC_DSC',
};
