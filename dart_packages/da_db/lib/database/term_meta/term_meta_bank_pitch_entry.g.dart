// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_pitch_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermMetaBankV3PitchEntry _$TermMetaBankV3PitchEntryFromJson(
  Map<String, dynamic> json,
) => TermMetaBankV3PitchEntry(
  position: json['position'] as String,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map(const TagBankV3EntryConverter().fromJson)
          .toList() ??
      const [],
  nasal: (json['nasal'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  devoice: (json['devoice'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$TermMetaBankV3PitchEntryToJson(
  TermMetaBankV3PitchEntry instance,
) => <String, dynamic>{
  'position': instance.position,
  'tags': instance.tags.map(const TagBankV3EntryConverter().toJson).toList(),
  'nasal': instance.nasal,
  'devoice': instance.devoice,
};
