// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagBankV3EntryImpl _$$TagBankV3EntryImplFromJson(Map<String, dynamic> json) =>
    _$TagBankV3EntryImpl(
      name: json['name'] as String,
      categories: json['categories'] as String,
      sortingOrder: (json['sortingOrder'] as num).toInt(),
      notes: json['notes'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$$TagBankV3EntryImplToJson(
        _$TagBankV3EntryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categories': instance.categories,
      'sortingOrder': instance.sortingOrder,
      'notes': instance.notes,
      'score': instance.score,
    };
