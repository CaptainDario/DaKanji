// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_meta_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanjiMetaBankV3EntryImpl _$$KanjiMetaBankV3EntryImplFromJson(
        Map<String, dynamic> json) =>
    _$KanjiMetaBankV3EntryImpl(
      kanji: json['kanji'] as String,
      type: json['type'] as String,
      value: (json['value'] as num?)?.toInt(),
      displayValue: json['displayValue'] as String?,
    );

Map<String, dynamic> _$$KanjiMetaBankV3EntryImplToJson(
        _$KanjiMetaBankV3EntryImpl instance) =>
    <String, dynamic>{
      'kanji': instance.kanji,
      'type': instance.type,
      'value': instance.value,
      'displayValue': instance.displayValue,
    };
