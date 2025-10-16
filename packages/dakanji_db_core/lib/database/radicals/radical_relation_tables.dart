
import 'package:drift/drift.dart';

import '/database/general_tables/kanji_tables.dart';
import '/database/radicals/radical_tables.dart';

/// Contains the relationships between kanjis and radicals
class Radical_X_KanjiRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated kanji
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();
  /// the id of the associated radical
  IntColumn get radicalId => integer().references(RadicalsTable, #id)();

}
