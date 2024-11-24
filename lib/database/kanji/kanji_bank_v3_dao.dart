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
    KanjiBankV3OnyomisTable, KanjiBankV3OnyomiKanjiRelationsTable,
    KanjiBankV3KunyomisTable, KanjiBankV3KunyomiKanjiRelationsTable,
    KanjiBankV3TagsKanjiRelationsTable,
    KanjiBankV3MeaningsTable, KanjiBankV3MeaningsKanjiRelationsTable,
    KanjiBankV3StatsTable, KanjiBankV3StatKanjiRelationsTable,
    KanjiBankV3StatNamesTable, KanjiBankV3StatValuesTable, 
])
class KanjiBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$KanjiBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiBankV3Dao(super.db);

  /// Checks if the given `kanji` is already present in the database
  Future<int?> getKanjiId(String kanji, int dictId) async {

    final result = await db.managers.kanjiBankV3Table
      .filter((f) => f.dictionaryKanji(kanji) & f.dictId.id(dictId))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the given `onyomi` is already present in the database
  Future<int?> getOnyomiId(String onyomi) async {

    final result = await db.managers.kanjiBankV3OnyomisTable
      .filter((f) => f.onyomi(onyomi))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the given `kunyomi` is already present in the database
  Future<int?> getKunyomiId(String kunyomi) async {

    final result = await db.managers.kanjiBankV3KunyomisTable
      .filter((f) => f.kunyomi(kunyomi))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the given `meaning` is already present in the database
  Future<int?> getMeaningId(String meaning) async {

    final result = await db.managers.kanjiBankV3MeaningsTable
      .filter((f) => f.meaning(meaning))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the given `statsName` is already present in the database
  Future<int?> getStatsNameId(String statsName) async {

    final result = await db.managers.kanjiBankV3StatNamesTable
      .filter((f) => f.statName(statsName))
      .getSingleOrNull();

    return result?.id;

  }

  /// Checks if the given `statsValue` is already present in the database
  Future<int?> getStatsValueId(String statsValue) async {

    final result = await db.managers.kanjiBankV3StatValuesTable
      .filter((f) => f.statValue(statsValue))
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

  /// Get the maximum id of the kunyomi table
  Future<int> maxKunyomiId() async {
    final query = selectOnly(kanjiBankV3KunyomisTable)
        ..addColumns([kanjiBankV3KunyomisTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3KunyomisTable.id.max()) ?? 0;
  }

  /// Get the maximum id of the meanings table
  Future<int> maxMeaningId() async {
    final query = selectOnly(kanjiBankV3MeaningsTable)
        ..addColumns([kanjiBankV3MeaningsTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3MeaningsTable.id.max()) ?? 0;
  }

  /// Get the maximum id of the stats name table
  Future<int> maxStatsNameId() async {
    final query = selectOnly(kanjiBankV3StatNamesTable)
        ..addColumns([kanjiBankV3StatNamesTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3StatNamesTable.id.max()) ?? 0;
  }

  /// Get the maximum id of the stats name table
  Future<int> maxStatsValueId() async {
    final query = selectOnly(kanjiBankV3StatValuesTable)
        ..addColumns([kanjiBankV3StatValuesTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3StatValuesTable.id.max()) ?? 0;
  }
  
}