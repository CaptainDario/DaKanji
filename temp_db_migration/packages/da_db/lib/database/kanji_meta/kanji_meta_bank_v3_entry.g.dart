// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_meta_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KanjiMetaBankV3Entry _$KanjiMetaBankV3EntryFromJson(
  Map<String, dynamic> json,
) => _KanjiMetaBankV3Entry(
  id: (json['id'] as num).toInt(),
  indexEntry: const IndexEntryJsonConverter().fromJson(json['indexEntry']),
  kanji: json['kanji'] as String,
  type: json['type'] as String,
  freqValue: (json['freqValue'] as num?)?.toInt(),
  freqDisplayValue: json['freqDisplayValue'] as String?,
);

Map<String, dynamic> _$KanjiMetaBankV3EntryToJson(
  _KanjiMetaBankV3Entry instance,
) => <String, dynamic>{
  'id': instance.id,
  'indexEntry': const IndexEntryJsonConverter().toJson(instance.indexEntry),
  'kanji': instance.kanji,
  'type': instance.type,
  'freqValue': instance.freqValue,
  'freqDisplayValue': instance.freqDisplayValue,
};
