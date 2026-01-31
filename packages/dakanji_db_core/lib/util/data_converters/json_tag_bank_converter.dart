import 'dart:convert';

import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:json_annotation/json_annotation.dart';

class TagBankV3EntryConverter implements JsonConverter<TagBankV3Entry, Object?> {
  const TagBankV3EntryConverter();

  @override
  TagBankV3Entry fromJson(Object? json) {
    Map<String, dynamic> jsonMap;

    if (json is String) jsonMap = jsonDecode(json) as Map<String, dynamic>;
    else jsonMap = json as Map<String, dynamic>;
    
    return TagBankV3Entry.fromJson(jsonMap);
  }

  @override
  Object? toJson(TagBankV3Entry object) => object.toJson();
}