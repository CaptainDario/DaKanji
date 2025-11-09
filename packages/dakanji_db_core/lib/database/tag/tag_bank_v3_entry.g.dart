// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TagBankV3Entry _$TagBankV3EntryFromJson(Map<String, dynamic> json) =>
    _TagBankV3Entry(
      id: (json['id'] as num).toInt(),
      indexEntry: const IndexEntryConverter().fromJson(json['indexEntry']),
      name: json['name'] as String,
      category: json['category'] as String,
      sortingOrder: (json['sortingOrder'] as num).toInt(),
      notes: json['notes'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$TagBankV3EntryToJson(_TagBankV3Entry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexEntry': const IndexEntryConverter().toJson(instance.indexEntry),
      'name': instance.name,
      'category': instance.category,
      'sortingOrder': instance.sortingOrder,
      'notes': instance.notes,
      'score': instance.score,
    };
