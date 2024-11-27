// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanjiBankEntryImpl _$$KanjiBankEntryImplFromJson(Map<String, dynamic> json) =>
    _$KanjiBankEntryImpl(
      kanji: json['kanji'] as String,
      onyomis:
          (json['onyomis'] as List<dynamic>?)?.map((e) => e as String).toList(),
      kunyomis: (json['kunyomis'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      meanings: (json['meanings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((e) => KanjiBankEntryStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$KanjiBankEntryImplToJson(
        _$KanjiBankEntryImpl instance) =>
    <String, dynamic>{
      'kanji': instance.kanji,
      'onyomis': instance.onyomis,
      'kunyomis': instance.kunyomis,
      'tags': instance.tags,
      'meanings': instance.meanings,
      'stats': instance.stats,
    };
