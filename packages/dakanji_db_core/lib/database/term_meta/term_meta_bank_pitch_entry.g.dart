// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_pitch_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermMetaBankV3PitchEntry _$TermMetaBankV3PitchEntryFromJson(
  Map<String, dynamic> json,
) => TermMetaBankV3PitchEntry(
  position: (json['position'] as num).toInt(),
  tags: (json['tags'] as List<dynamic>)
      .map(const TagBankV3EntryConverter().fromJson)
      .toList(),
  nasal: (json['nasal'] as num?)?.toInt(),
  devoice: (json['devoice'] as num?)?.toInt(),
);

Map<String, dynamic> _$TermMetaBankV3PitchEntryToJson(
  TermMetaBankV3PitchEntry instance,
) => <String, dynamic>{
  'position': instance.position,
  'tags': instance.tags.map(const TagBankV3EntryConverter().toJson).toList(),
  'nasal': instance.nasal,
  'devoice': instance.devoice,
};
