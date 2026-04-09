import 'package:json_annotation/json_annotation.dart';

/// Converts a required [bool] to/from an [int] (0 or 1).
class BoolAsIntConverter implements JsonConverter<bool, int> {
  const BoolAsIntConverter();

  @override
  bool fromJson(int json) {
    // Read from DB/JSON: Convert 1 to true, anything else to false.
    return json == 1;
  }

  @override
  int toJson(bool object) {
    // Write to DB/JSON: Convert true to 1, false to 0.
    return object ? 1 : 0;
  }
}

/// Converts a nullable [bool] to/from a nullable [int] (0 or 1).
class NullableBoolAsIntConverter implements JsonConverter<bool?, int?> {
  const NullableBoolAsIntConverter();

  @override
  bool? fromJson(int? json) {
    // Read from DB/JSON
    if (json == null) return null;
    return json == 1;
  }

  @override
  int? toJson(bool? object) {
    // Write to DB/JSON
    if (object == null) return null;
    return object ? 1 : 0;
  }
}

/// A converter that gracefully handles both JSON booleans (true/false) 
/// and SQLite boolean integers (1/0).
class FlexibleNullableBoolConverter implements JsonConverter<bool?, dynamic> {
  const FlexibleNullableBoolConverter();

  @override
  bool? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is bool) return json;
    if (json is num) return json != 0;
    if (json is String) return json.toLowerCase() == 'true' || json == '1';
    return null;
  }

  @override
  dynamic toJson(bool? object) => object;
}