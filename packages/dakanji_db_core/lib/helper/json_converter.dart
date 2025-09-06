import 'dart:convert';

import 'package:drift/drift.dart';

class JsonConverter extends TypeConverter<Object?, String> {
  const JsonConverter();

  @override
  Object? fromSql(String fromDb) => json.decode(fromDb);

  @override
  String toSql(Object? value) => json.encode(value);
}
