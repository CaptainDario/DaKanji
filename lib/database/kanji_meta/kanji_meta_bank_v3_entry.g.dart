// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_meta_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanjiMetaBankV3EntryImpl _$$KanjiMetaBankV3EntryImplFromJson(
        Map<String, dynamic> json) =>
    _$KanjiMetaBankV3EntryImpl(
      kanji: json['kanji'] as String,
      type: json['type'] as String,
      freqValue: (json['freqValue'] as num?)?.toInt(),
      freqDisplayValue: json['freqDisplayValue'] as String?,
    );

Map<String, dynamic> _$$KanjiMetaBankV3EntryImplToJson(
        _$KanjiMetaBankV3EntryImpl instance) =>
    <String, dynamic>{
      'kanji': instance.kanji,
      'type': instance.type,
      'freqValue': instance.freqValue,
      'freqDisplayValue': instance.freqDisplayValue,
    };
