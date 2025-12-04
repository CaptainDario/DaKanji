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

class IsoDateConverter extends TypeConverter<DateTime, String> {
  const IsoDateConverter();

  @override
  DateTime fromSql(String fromDb) {
    // 1. Parse into a temporary object to easily extract Y/M/D
    // (This creates a Local time, but the netxt step ignores the time/offset)
    final local = DateTime.parse(fromDb); 

    // 2. Reconstruct as STRICT UTC Midnight
    // This takes the numbers "2025", "5", "6" and forces them into UTC.
    return DateTime.utc(local.year, local.month, local.day);
  }

  @override
  String toSql(DateTime value) {
    
    // DateTime -> "2025-05-06"
    // anually format to ensure 0-padding (e.g. month 5 becomes '05')
    final year = value.year;
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    
    return '$year-$month-$day';
  }
}


class ForceUtcConverter extends TypeConverter<DateTime, DateTime> {
  const ForceUtcConverter();

  @override
  DateTime fromSql(DateTime fromDb) {
    // When reading back, ensure Dart knows it is UTC
    return fromDb.toUtc();
  }

  @override
  DateTime toSql(DateTime value) {
    // Force conversion to UTC before Drift saves it
    return value.toUtc();
  }
}