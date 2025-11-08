
import "package:drift/drift.dart";

import "/database/kanji/kanji_bank_v3_entry.dart";
import "/database/kanji/kanji_bank_v3_relation_tables.dart";
import "/database/kanji/kanji_bank_v3_tables.dart";
import "../dakanji_db.dart";

part 'kanji_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(
  tables: [
    KanjiBankV3Table,
    KanjiBankV3_X_KunyomiReadingTable, KanjiBankV3_X_OnyomiReadingTable,
    KanjiBankV3_X_TagBankV3Table,
    KanjiBankV3_X_DefinitionTable,
    KanjiBankV3StatsTable, KanjiBankV3_X_KanjiBankV3StatsTable,
    KanjiBankV3StatNamesTable, KanjiBankV3StatValuesTable, 
  ],
)
class KanjiBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$KanjiBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiBankV3Dao(super.db);
  

  /// Returns all kanji entries that 
  Future<List<KanjiBankV3Entry>> search(String kanji) async {

    List<KanjiBankV3Entry> searchResults =
      (await db.kanji_bank_v3_search_drift(kanji).get())
        .map((e) => KanjiBankV3Entry.fromKanjiBankV3EntryViewData(e))
        .toList();

    return searchResults;

  }

  // ---------------------------------------------------------------------------
  /// Get all readings and their ids 
  Future<List<ReadingTableData>> getAllReadings() async {
    return await select(readingTable).get();
  }

  /// Get all stat values and their ids 
  Future<List<KanjiBankV3StatValuesTableData>> getAllStatValues() async {
    return await select(kanjiBankV3StatValuesTable).get();
  }

  /// Get all stat names and their ids 
  Future<List<KanjiBankV3StatNamesTableData>> getAllStatNames() async {
    return await select(kanjiBankV3StatNamesTable).get();
  }

  // ---------------------------------------------------------------------------
  /// Checks if the given `kanji` is already present in the database
  Future<int?> getKanjiId(String kanji) async {

    final result = await db.managers.kanjiTable
      .filter((f) => f.kanji(kanji))
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

  // ---------------------------------------------------------------------------
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
    final query = selectOnly(readingTable)
        ..addColumns([readingTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(readingTable.id.max()) ?? 0;
  }

  /// Get the maximum id of the definitions table
  Future<int> maxDefinitionId() async {
    final query = selectOnly(definitionTable)
        ..addColumns([definitionTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(definitionTable.id.max()) ?? 0;
  }

  /// Get the maximum id of the stats table
  Future<int> maxStatsId() async {
    final query = selectOnly(kanjiBankV3StatsTable)
      ..addColumns([kanjiBankV3StatsTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(kanjiBankV3StatsTable.id.max()) ?? 0;
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
