// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_source_list_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioSourceListEntry _$AudioSourceListEntryFromJson(
  Map<String, dynamic> json,
) => AudioSourceListEntry(
  name: json['name'] as String,
  uri: json['uri'] as String,
  indexEntry: IndexEntry.fromJson(json['indexEntry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AudioSourceListEntryToJson(
  AudioSourceListEntry instance,
) => <String, dynamic>{
  'name': instance.name,
  'uri': instance.uri,
  'indexEntry': instance.indexEntry,
};
