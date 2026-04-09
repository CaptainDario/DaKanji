// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleEntry _$ExampleEntryFromJson(Map<String, dynamic> json) => ExampleEntry(
  id: (json['id'] as num).toInt(),
  indexEntry: IndexEntry.fromJson(json['indexEntry'] as Map<String, dynamic>),
  groupId: (json['groupId'] as num?)?.toInt(),
  sentence: json['sentence'] as String,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => TagBankV3Entry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  stats:
      (json['stats'] as List<dynamic>?)
          ?.map((e) => StatEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  audios:
      (json['audios'] as List<dynamic>?)
          ?.map((e) => ExampleAudioEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ExampleEntryToJson(ExampleEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexEntry': instance.indexEntry,
      'groupId': instance.groupId,
      'sentence': instance.sentence,
      'tags': instance.tags,
      'stats': instance.stats,
      'audios': instance.audios,
    };
