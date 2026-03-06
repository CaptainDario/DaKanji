import 'dart:convert';

import 'package:drift/drift.dart';

class NullableJsonConverter extends TypeConverter<Object?, String?> {
  const NullableJsonConverter();

  @override
  Object? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return json.decode(fromDb);
  }

  @override
  String? toSql(Object? value) {
    if (value == null) return null;
    return json.encode(value);
  }
}