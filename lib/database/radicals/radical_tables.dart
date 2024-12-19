import 'package:dakanji_db/database/general_tables/kanji_tables.dart';
import 'package:drift/drift.dart';



/// Contains the kanji entries and links to the radicals table
class RadicalsKanjiTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// ID of the kanji character this radical belongs to
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();
}

/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'radical', columns: {#radical})
class RadicalsTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the radical character of this entry
  /// this column is indexed
  TextColumn get radical => text().withLength(min: 1)();

  /// Stroke count of this radical
  IntColumn get strokeCount => integer()();
}