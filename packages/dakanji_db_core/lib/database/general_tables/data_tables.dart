// Package imports:
import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:drift/drift.dart';



/// Contains media files included in dictionaries, such as audio files
@TableIndex(name: 'path', columns: {#path})
class MediaTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// the path of this data file as found in the original data source
  TextColumn get path => text().unique().withLength(min: 1)();

  /// The actual data of the file
  BlobColumn get dataCompressed => blob()();

}
