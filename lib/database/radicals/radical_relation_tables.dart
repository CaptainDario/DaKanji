import 'package:dakanji_db/database/radicals/radical_tables.dart';
import 'package:drift/drift.dart';



/// Contains the relationships between kanjis and radicals
class RadicalKanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated kanji reading
  IntColumn get kanjiId => integer().references(RadicalsKanjiTable, #id)();
  /// the id of the associated radical
  IntColumn get radicalId => integer().references(RadicalsTable, #id)();

}