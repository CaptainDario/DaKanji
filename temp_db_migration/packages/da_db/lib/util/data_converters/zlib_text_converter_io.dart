// Dart imports:
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';

// Define a custom TypeConverter for compressed strings
class ZlibStringConverter extends TypeConverter<String, Uint8List> {
  const ZlibStringConverter();
  
  @override
  String fromSql(Uint8List fromDb) {
    // Decompress the bytes back to a string using dart:io
    final decompressed = ZLibCodec().decode(fromDb);
    return utf8.decode(decompressed);
  }

  @override
  Uint8List toSql(String value) {
    final bytes = utf8.encode(value);
    final compressed = ZLibCodec(level: 9).encode(bytes);
    return Uint8List.fromList(compressed);
  }
}