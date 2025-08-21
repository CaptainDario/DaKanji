// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KanjiBankV3Entry _$KanjiBankV3EntryFromJson(Map<String, dynamic> json) =>
    _KanjiBankV3Entry(
      kanji: json['kanji'] as String,
      onyomis: (json['onyomis'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      kunyomis: (json['kunyomis'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagBankV3Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((e) => KanjiBankV3EntryStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KanjiBankV3EntryToJson(_KanjiBankV3Entry instance) =>
    <String, dynamic>{
      'kanji': instance.kanji,
      'onyomis': instance.onyomis,
      'kunyomis': instance.kunyomis,
      'tags': instance.tags,
      'definitions': instance.definitions,
      'stats': instance.stats,
    };
