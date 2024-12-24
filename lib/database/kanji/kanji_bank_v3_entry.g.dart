// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanjiBankV3EntryImpl _$$KanjiBankV3EntryImplFromJson(
        Map<String, dynamic> json) =>
    _$KanjiBankV3EntryImpl(
      kanji: json['kanji'] as String,
      onyomis:
          (json['onyomis'] as List<dynamic>?)?.map((e) => e as String).toList(),
      kunyomis: (json['kunyomis'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagBankV3Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
      meanings: (json['meanings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((e) => KanjiBankV3EntryStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$KanjiBankV3EntryImplToJson(
        _$KanjiBankV3EntryImpl instance) =>
    <String, dynamic>{
      'kanji': instance.kanji,
      'onyomis': instance.onyomis,
      'kunyomis': instance.kunyomis,
      'tags': instance.tags,
      'meanings': instance.meanings,
      'stats': instance.stats,
    };
