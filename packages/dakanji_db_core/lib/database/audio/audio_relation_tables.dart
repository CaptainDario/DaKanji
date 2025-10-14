// Package imports:
import 'package:dakanji_db_core/database/audio/audio_tables.dart';
import 'package:dakanji_db_core/database/general_tables/term_tables.dart';
import 'package:drift/drift.dart';



/// Contains media files included in dictionaries, such as audio files
// ignore: camel_case_types
class AudioTable_X_TermTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// Link to the [AudioTable]
  IntColumn get audioId => integer().references(AudioTable, #id)();

  /// Link to the [TermTable]
  IntColumn get termId => integer().references(TermTable, #id)();

}
