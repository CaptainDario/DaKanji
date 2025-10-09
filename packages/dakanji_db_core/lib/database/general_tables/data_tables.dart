// Package imports:
import 'package:dakanji_db_core/helper/zlib_bytes_converter.dart';
import 'package:drift/drift.dart';



/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'path', columns: {#path})
class MediaTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the path of this data file as found in the original data source
  TextColumn get path => text().unique().withLength(min: 1)();

  /// The actual data of the file
  BlobColumn get data => blob().map(const ZlibBytesConverter())();

}
