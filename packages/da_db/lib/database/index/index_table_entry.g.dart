// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_table_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexEntry _$IndexEntryFromJson(Map<String, dynamic> json) => IndexEntry(
  id: (json['id'] as num).toInt(),
  isDefaultDictionary: const BoolAsIntConverter().fromJson(
    (json['isDefaultDictionary'] as num).toInt(),
  ),
  enabled: const BoolAsIntConverter().fromJson(
    (json['enabled'] as num).toInt(),
  ),
  dictionaryType: $enumDecode(_$DictionaryTypesEnumMap, json['dictionaryType']),
  currentSortingOrder: (json['currentSortingOrder'] as num).toInt(),
  currentFrequencyDictionary: const BoolAsIntConverter().fromJson(
    (json['currentFrequencyDictionary'] as num).toInt(),
  ),
  yomitanData: YomitanIndex.fromJson(
    json['yomitanData'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$IndexEntryToJson(IndexEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isDefaultDictionary': const BoolAsIntConverter().toJson(
        instance.isDefaultDictionary,
      ),
      'enabled': const BoolAsIntConverter().toJson(instance.enabled),
      'dictionaryType': _$DictionaryTypesEnumMap[instance.dictionaryType]!,
      'currentSortingOrder': instance.currentSortingOrder,
      'currentFrequencyDictionary': const BoolAsIntConverter().toJson(
        instance.currentFrequencyDictionary,
      ),
      'yomitanData': instance.yomitanData,
    };

const _$DictionaryTypesEnumMap = {
  DictionaryTypes.yomitan: 'yomitan',
  DictionaryTypes.examples: 'examples',
  DictionaryTypes.audio: 'audio',
};
