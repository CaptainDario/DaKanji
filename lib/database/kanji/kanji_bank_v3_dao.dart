import "package:dakanji_db/database/kanji/kanji_bank_v3_relation_tables.dart";
import "package:dakanji_db/database/kanji/kanji_bank_v3_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'kanji_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    KanjiBankV3Table,
    KanjiBankV3OnyomisTable, KanjiBankV3KunyomiKanjiRelationsTable,
    KanjiBankV3KunyomisTable, KanjiBankV3KunyomiKanjiRelationsTable,
    KanjiBankV3TagsTable, KanjiBankV3TagsKanjiRelationsTable,
    KanjiBankV3MeaningsTable, KanjiBankV3MeaningsKanjiRelationsTable,
    KanjiBankV3StatsTable, KanjiBankV3StatsKanjiRelationsTable
])
class KanjiBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$KanjiBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiBankV3Dao(super.db);

    /// Checks if the any of the given `kanjis` is already present in the database
  Future<int?> getKanjiId(String kanji) async {

    final result = await db.managers.kanjiBankV3Table
      .filter((f) => f.kanji(kanji))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the any of the given `kanjis` is already present in the database
  Future<int?> getOnyomiId(String onyomi) async {

    final result = await db.managers.kanjiBankV3OnyomisTable
      .filter((f) => f.onyomi(onyomi))
      .getSingleOrNull();

    return result?.id;

  }

  /// Get the maximum id of the kanji table
  Future<int> maxKanjiId() async {
    
    final query = await (selectOnly(kanjiBankV3Table)
        ..addColumns([kanjiBankV3Table.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(kanjiBankV3Table.id.max()) ?? 0;

  }

  /// Get the maximum id of the onyomi table
  Future<int> maxOnyomiId() async {
    final query = selectOnly(kanjiBankV3OnyomisTable)
        ..addColumns([kanjiBankV3OnyomisTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3OnyomisTable.id.max()) ?? 0;
  }
  
}