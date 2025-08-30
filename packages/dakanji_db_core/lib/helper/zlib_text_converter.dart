// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:archive/archive.dart';
import 'package:drift/drift.dart';

// Define a custom TypeConverter for compressed strings
class ZlibStringConverter extends TypeConverter<String, Uint8List> {
  const ZlibStringConverter();
  
  @override
  String fromSql(Uint8List fromDb) {
    // Decompress the bytes back to a string
    final decompressed = ZLibDecoder().decodeBytes(fromDb);
    return utf8.decode(decompressed);
  }

  @override
  Uint8List toSql(String value) {
    // Convert string to bytes and compress
    final bytes = utf8.encode(value);
    final compresssed = ZLibEncoder().encode(bytes);
    return Uint8List.fromList(compresssed);
  }
}
