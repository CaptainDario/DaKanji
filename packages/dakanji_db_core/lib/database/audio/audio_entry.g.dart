// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioEntry _$AudioEntryFromJson(Map<String, dynamic> json) => AudioEntry(
  id: (json['id'] as num).toInt(),
  indexEntry: IndexEntry.fromJson(json['indexEntry'] as Map<String, dynamic>),
  terms: (json['terms'] as List<dynamic>).map((e) => e as String).toList(),
  reading: json['reading'] as String?,
  pitchAccentPattern: (json['pitchAccentPattern'] as num?)?.toInt(),
  filePath: json['filePath'] as String?,
  fileName: json['fileName'] as String,
  fileData: base64Decode(json['fileData'] as String),
);

Map<String, dynamic> _$AudioEntryToJson(AudioEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexEntry': instance.indexEntry,
      'terms': instance.terms,
      'reading': instance.reading,
      'pitchAccentPattern': instance.pitchAccentPattern,
      'filePath': instance.filePath,
      'fileName': instance.fileName,
      'fileData': base64Encode(instance.fileData),
    };
