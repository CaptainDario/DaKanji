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


/// This converter only stores the date part of a DateTime (year, month, day),
/// ignoring the time part (hours, minutes, seconds).
class DateOnlyConverter extends TypeConverter<DateTime, int> {
  const DateOnlyConverter();

  @override
  DateTime fromSql(int fromDb) {
    return DateTime.fromMillisecondsSinceEpoch(fromDb);
  }

  @override
  int toSql(DateTime value) {
    // Strip time components to ensure uniqueness works on the Day level
    final dateOnly = DateTime(value.year, value.month, value.day);
    return dateOnly.millisecondsSinceEpoch;
  }
}