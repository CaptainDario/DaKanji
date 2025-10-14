// Package imports:
import 'package:dakanji_db_core/database/general_tables/reading_tables.dart';
import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:drift/drift.dart';



/// Contains media files included in dictionaries, such as audio files
class AudioTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// The id of the reading this audio is associated with
  IntColumn get readingId => integer().references(ReadingTable, #id).nullable()();

  /// The id of the media file in the media table
  IntColumn get mediaId => integer()();

  /// The pitch accent pattern number
  IntColumn get pitchAccentPattern => integer().nullable()();

}