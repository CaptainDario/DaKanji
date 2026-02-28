// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_audio_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleAudioEntry _$ExampleAudioEntryFromJson(Map<String, dynamic> json) =>
    ExampleAudioEntry(
      path: json['path'] as String,
      name: json['name'] as String,
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
    );

Map<String, dynamic> _$ExampleAudioEntryToJson(ExampleAudioEntry instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'tags': instance.tags,
      'stats': instance.stats,
    };
