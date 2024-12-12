// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_meta_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanjiMetaBankEntryImpl _$$KanjiMetaBankEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$KanjiMetaBankEntryImpl(
      term: json['term'] as String,
      category: json['category'] as String,
      value: (json['value'] as num?)?.toInt(),
      displayValue: json['displayValue'] as String?,
    );

Map<String, dynamic> _$$KanjiMetaBankEntryImplToJson(
        _$KanjiMetaBankEntryImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'category': instance.category,
      'value': instance.value,
      'displayValue': instance.displayValue,
    };
