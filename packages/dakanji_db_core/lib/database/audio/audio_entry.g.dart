// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioEntry _$AudioEntryFromJson(Map<String, dynamic> json) => AudioEntry(
  name: json['name'] as String,
  uri: json['uri'] as String,
  local: json['local'] as bool,
);

Map<String, dynamic> _$AudioEntryToJson(AudioEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uri': instance.uri,
      'local': instance.local,
    };
