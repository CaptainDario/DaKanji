
import 'package:dakanji_db_core/database/general_tables/media_tables.dart';
import 'package:dakanji_db_core/database/general_tables/reading_tables.dart';
import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:drift/drift.dart';



/// Contains media files included in dictionaries, such as audio files
@TableIndex(name: 'AudioTable_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'AudioTable_readingIdIndex', columns: {#readingId})
@TableIndex(name: 'AudioTable_mediaIdIndex', columns: {#mediaId})
class AudioTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// The id of the reading this audio is associated with
  IntColumn get readingId => integer().references(ReadingTable, #id).nullable()();

  /// The id of the media file in the media table
  IntColumn get mediaId => integer()
    .references(MediaTable, #id, onDelete: KeyAction.cascade)();

  /// The pitch accent pattern number
  IntColumn get pitchAccentPattern => integer().nullable()();

}