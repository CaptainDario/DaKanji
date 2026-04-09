
import 'package:da_db/database/general_tables/kanji_tables.dart';
import 'package:da_db/database/radicals/radical_tables.dart';
import 'package:drift/drift.dart';

/// Contains the relationships between kanjis and radicals
@TableIndex(name: 'Radical_X_KanjiRelationsTable_radicalIdIndex', columns: {#radicalId})
// ignore: camel_case_types
class Radical_X_KanjiRelationsTable extends Table {

  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {kanjiId, radicalId};

  /// the id of the associated kanji
  IntColumn get kanjiId => integer()
    .references(KanjiTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the associated radical
  IntColumn get radicalId => integer()
    .references(RadicalsTable, #id, onDelete: KeyAction.cascade)();

}
