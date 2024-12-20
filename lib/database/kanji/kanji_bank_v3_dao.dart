import "package:dakanji_db/database/kanji/kanji_bank_entry.dart";
import "package:dakanji_db/database/kanji/kanji_bank_entry_stat.dart";
import "package:dakanji_db/database/kanji/kanji_bank_v3_relation_tables.dart";
import "package:dakanji_db/database/kanji/kanji_bank_v3_tables.dart";
import "package:dakanji_db/database/tag/tag_bank_entry.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'kanji_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    KanjiBankV3Table,
    KanjiBankV3KunyomiReadingRelationsTable, KanjiBankV3OnyomiReadingRelationsTable,
    KanjiBankV3TagsKanjiRelationsTable,
    KanjiBankV3MeaningsKanjiRelationsTable,
    KanjiBankV3StatsTable, KanjiBankV3StatKanjiRelationsTable,
    KanjiBankV3StatNamesTable, KanjiBankV3StatValuesTable, 
])
class KanjiBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$KanjiBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiBankV3Dao(super.db);
  

  /// Returns all kanji entries that match contain any of the given Kanji
  Future<List<KanjiBankEntry>?> getKanjiBankEntriesFromKanji(List<String> kanji) async {

    final onyomiT  = alias(readingTable, 'onyomi');
    final kunyomiT = alias(readingTable, 'kunyomi');

    final query = (selectOnly(kanjiBankV3Table)
      .join([
        // kanji
        innerJoin(
          kanjiTable,
          kanjiTable.id.equalsExp(kanjiBankV3Table.kanjiId)
        ),
        // onyomi
        innerJoin(
          kanjiBankV3OnyomiReadingRelationsTable,
          kanjiBankV3OnyomiReadingRelationsTable.kanjiId.equalsExp(kanjiBankV3Table.id)
        ),
        innerJoin(
          onyomiT,
          kanjiBankV3OnyomiReadingRelationsTable.onyomiReadingId.equalsExp(onyomiT.id)
        ),
        // kunyomi
        innerJoin(
          kanjiBankV3KunyomiReadingRelationsTable,
          kanjiBankV3KunyomiReadingRelationsTable.kanjiId.equalsExp(kanjiBankV3Table.id)
        ),
        innerJoin(
          kunyomiT,
          kanjiBankV3KunyomiReadingRelationsTable.kunyomiReadingId.equalsExp(kunyomiT.id)
        ),
        // tags
        innerJoin(
          kanjiBankV3TagsKanjiRelationsTable,
          kanjiBankV3TagsKanjiRelationsTable.kanjiId.equalsExp(kanjiBankV3Table.id)
        ),
        innerJoin(
          tagBankV3Table,
          kanjiBankV3TagsKanjiRelationsTable.tagId.equalsExp(tagBankV3Table.id)
        ),
        // meanings
        innerJoin(
          kanjiBankV3MeaningsKanjiRelationsTable,
          kanjiBankV3MeaningsKanjiRelationsTable.kanjiId.equalsExp(kanjiBankV3Table.id)
        ),
        innerJoin(
          meaningTable,
          kanjiBankV3MeaningsKanjiRelationsTable.meaningId.equalsExp(meaningTable.id)
        ),
        // Stat names / values
        innerJoin(
          kanjiBankV3StatKanjiRelationsTable,
          kanjiBankV3StatKanjiRelationsTable.kanjiId.equalsExp(kanjiBankV3Table.id)
        ),
        innerJoin(
          kanjiBankV3StatsTable,
          kanjiBankV3StatKanjiRelationsTable.statId.equalsExp(kanjiBankV3StatsTable.id)
        ),
        innerJoin(
          kanjiBankV3StatNamesTable,
          kanjiBankV3StatNamesTable.id.equalsExp(kanjiBankV3StatsTable.statNameId,),
        ),
        innerJoin(
          kanjiBankV3StatValuesTable,
          kanjiBankV3StatValuesTable.id.equalsExp(kanjiBankV3StatsTable.statValueId,),
        ),
      ]))
      ..where(kanjiTable.kanji.isIn(kanji))
      ..addColumns([
        kanjiTable.kanji,
        onyomiT.reading.groupConcat(distinct: true),
        kunyomiT.reading.groupConcat(distinct: true),
        tagBankV3Table.name.groupConcat(distinct: true),
        //kanjiBankV3MeaningsTable.meaning.groupConcat(distinct: true),

        kanjiBankV3StatValuesTable.statValue.groupConcat(distinct: true),
        kanjiBankV3StatNamesTable.statName.groupConcat(distinct: true)
      ]);

    // Fetching data from the query
    final result = await query.get();
    print(result.first.rawData.data);

    // Process and return the result
    return (await Future.wait(result.map((row) async {
      final kanji = row.read<String>(kanjiTable.kanji);
      print(kanji);
      
      // Read the concatenated results
      final onyomi     = row.read(
        onyomiT.reading.groupConcat(distinct: true))
        ?.split(",");
      final kunyomi    = row.read(
        kunyomiT.reading.groupConcat(distinct: true))
        ?.split(",");
      var tags         = await Future.wait((row.read(
        tagBankV3Table.name.groupConcat(distinct: true))
        ?.split(","))
        !.map((e) async => await db.tagBankV3Dao.getTagByName(e),));
      //final meaning    = row.read(
      //  kanjiBankV3MeaningsTable.meaning.groupConcat(distinct: true))
      //  ?.split(",");
      final statValues = row.read(
        kanjiBankV3StatValuesTable.statValue.groupConcat(distinct: true))
        ?.split(",");
      final statNames  = row.read(
        kanjiBankV3StatNamesTable.statName.groupConcat(distinct: true))
        ?.split(",");

      return KanjiBankEntry(
        kanji: kanji!,
        onyomis: onyomi,
        kunyomis: kunyomi,
        tags: tags,
        //TODO update
        meanings: [],
        stats: statValues != null && statNames != null
          ? List.generate(statValues.length, (i) => KanjiBankEntryStat(
            name: statNames[i],
            value: statValues[i],
          ))
          : []
      );
    }))).toList();

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

  /// Get the maximum id of the meanings table
  Future<int> maxMeaningId() async {
    final query = selectOnly(meaningTable)
        ..addColumns([meaningTable.id.max()]);
    final result = await query.getSingle();

    // Extract the value of the max column using the alias
    return result.read(meaningTable.id.max()) ?? 0;
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