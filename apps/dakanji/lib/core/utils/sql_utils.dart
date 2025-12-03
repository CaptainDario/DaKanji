// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';



// stores preferences as strings
class ListIntConverter extends TypeConverter<List<int>, String> {
  const ListIntConverter();

  @override
  List<int> fromSql(String fromDb) {
    return List<int>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(List<int> value) {
    return jsonEncode(value);
  }
}
