import 'dart:convert';

// Make sure this import path is correct
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:json_annotation/json_annotation.dart';

class IndexEntryJsonConverter implements JsonConverter<IndexEntry, Object?> {
  const IndexEntryJsonConverter();

  @override
  IndexEntry fromJson(Object? json) {
    Map<String, dynamic> jsonMap;

    if (json is String) jsonMap = jsonDecode(json) as Map<String, dynamic>;
    else jsonMap = json as Map<String, dynamic>;
    
    return IndexEntry.fromJson(jsonMap);
  }

  @override
  Object? toJson(IndexEntry object) {
    // Use the IndexEntry's own toJson method
    return object.toJson();
  }
}