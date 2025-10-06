// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_pitch_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TermMetaBankV3PitchEntry _$TermMetaBankV3PitchEntryFromJson(
  Map<String, dynamic> json,
) => _TermMetaBankV3PitchEntry(
  position: (json['position'] as num).toInt(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  nasal: (json['nasal'] as num?)?.toInt(),
  devoice: (json['devoice'] as num?)?.toInt(),
);

Map<String, dynamic> _$TermMetaBankV3PitchEntryToJson(
  _TermMetaBankV3PitchEntry instance,
) => <String, dynamic>{
  'position': instance.position,
  'tags': instance.tags,
  'nasal': instance.nasal,
  'devoice': instance.devoice,
};
