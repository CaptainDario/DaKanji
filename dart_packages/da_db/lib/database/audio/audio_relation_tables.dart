
import 'package:da_db/database/audio/audio_tables.dart';
import 'package:da_db/database/general_tables/term_tables.dart';
import 'package:drift/drift.dart';



/// Contains media files included in dictionaries, such as audio files
@TableIndex(name: 'AudioTable_X_TermTable_termIdIndex', columns: {#termId})
// ignore: camel_case_types
class AudioTable_X_TermTable extends Table {
  
  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {audioId, termId};

  /// Link to the [AudioTable]
  IntColumn get audioId => integer()
    .references(AudioTable, #id, onDelete: KeyAction.cascade)();

  /// Link to the [TermTable]
  IntColumn get termId => integer()
    .references(TermTable, #id, onDelete: KeyAction.cascade)();

}
