// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagBankEntryImpl _$$TagBankEntryImplFromJson(Map<String, dynamic> json) =>
    _$TagBankEntryImpl(
      name: json['name'] as String,
      categories: json['categories'] as String,
      sortingOrder: (json['sortingOrder'] as num).toInt(),
      notes: json['notes'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$$TagBankEntryImplToJson(_$TagBankEntryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categories': instance.categories,
      'sortingOrder': instance.sortingOrder,
      'notes': instance.notes,
      'score': instance.score,
    };
