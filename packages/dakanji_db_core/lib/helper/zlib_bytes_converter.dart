// Dart imports:
import 'dart:io';

// Package imports:
import 'package:drift/drift.dart';

// Define a custom TypeConverter for compressed strings
class ZlibBytesConverter extends TypeConverter<List<int>, Uint8List> {
  const ZlibBytesConverter();
  
  @override
  List<int> fromSql(Uint8List fromDb) {
    return zlib.decode(fromDb);
  }

  @override
  Uint8List toSql(List<int> bytes) {
    final compressed = zlib.encode(bytes);
    return Uint8List.fromList(compressed);
  }
}