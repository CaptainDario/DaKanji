
import 'package:dakanji_db_core/parsing/util/import_context.dart';

import '/database/dakanji_db.dart';
import '/database/kanji/kanji_bank_v3_tables.dart';



/// Simple class to keep track of the different IDs needed to parse a kanji dict
class KanjiBankV3ParserContext extends ParserContext {

  /// The SQLite id of the dictionary that is currently being parsed
  int indexId = 0;

  /// List of [KanjiTableCompanion] that should be batch inserted
  List<KanjiTableCompanion> kanjiCompanions = [];
  /// The currently highest id in the [KanjiTable]
  int maxKanjiId = 0;
  /// A local cache for kanjis. This way lookups are O(1)
  Map<String, int> kanjisInDB = {};

  /// List of [KanjiBankV3TableCompanion] that should be batch inserted
  List<KanjiBankV3TableCompanion> kanjiBankCompanions = [];
  /// The currently highest id in the [KanjiBankV3Table]
  int maxKanjiBankId = 0;

  /// List of [ReadingTableCompanion] that should be batch inserted
  List<ReadingTableCompanion> readingCompanions  = [];
  /// The currently highest id in the [ReadingTable]
  int maxReadingId = 0;
  /// List of [KanjiBankV3_X_OnyomiReadingTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_OnyomiReadingTableCompanion> kanjiOnyomiReadingRelCompanions = [];
  /// The order of onyomis for the current kanji being parsed
  List<int> onyomisOrder = [];
  /// List of [KanjiBankV3_X_KunyomiReadingTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_KunyomiReadingTableCompanion> kanjiKunyomiReadingRelCompanions = [];
  /// The order of kunyomis for the current kanji being parsed
  List<int> kunyomisOrder = [];
  /// A local cache for readings. Every reading should only be looked up once
  /// in the database
  Map<String, int> readingsInDB = {};
  
  /// List of [KanjiBankV3_X_TagBankV3TableCompanion] that should be batch inserted
  List<KanjiBankV3_X_TagBankV3TableCompanion> tagRelCompanions = [];
  /// The currently highest id in the [KanjiBankV3TagsKanjiRelationsTableData]
  int maxTagId = 0;
  /// A local cache for tags. Every tag should only be looked up once
  /// in the database
  Map<String, int> tagsInDB = {};
  
  /// List of [DefinitionTableCompanion] that should be batch inserted
  List<DefinitionTableCompanion> definitionsCompanions  = [];
  /// The currently highest id in the [DefinitionTable]
  int maxDefinitionId = 0;
  /// List of [KanjiBankV3_X_DefinitionTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_DefinitionTableCompanion> definitionRelCompanions = [];
  /// A local cache for definitions. Every definition should only be looked up once
  /// in the database
  Map<String, int> definitionsInDB = {};
  /// The order of definitions for the current kanji being parsed
  List<int> definitionsOrder = [];

  /// List of [KanjiBankV3StatsTableCompanion] that should be batch inserted
  List<KanjiBankV3StatsTableCompanion> statCompanions = [];
  /// List of [KanjiBankV3StatNamesTableCompanion] that should be batch inserted
  List<KanjiBankV3StatNamesTableCompanion> statNamesCompanions  = [];
  /// List of [KanjiBankV3StatValuesTableCompanion] that should be batch inserted
  List<KanjiBankV3StatValuesTableCompanion> statValuesCompanions  = [];
  /// The currently highest id in the [KanjiBankV3StatsTable]
  int maxStatsId = 0;
  /// The currently highest id in the [KanjiBankV3StatValuesTable]
  int maxStatNamesId = 0;
  /// The currently highest id in the [KanjiBankV3StatNamesTable]
  int maxStatValuesId = 0;
  /// List of [KanjiBankV3_X_KanjiBankV3StatsTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_KanjiBankV3StatsTableCompanion> statValueRelCompanions = [];
  /// A local cache for stat names. Every stat name should only be looked up
  /// once in the database
  Map<String, int> statNamesInDB = {};
  /// A local cache for stat values. Every stat value should only be looked up
  /// once in the database
  Map<String, int> statValuesInDB = {};

  KanjiBankV3ParserContext._({
    required this.indexId,
    required this.maxKanjiId,
    required this.kanjisInDB,
    required this.maxKanjiBankId,
    required this.maxReadingId,
    required this.readingsInDB,
    required this.tagsInDB,
    required this.maxDefinitionId,
    required this.definitionsInDB,
    required this.maxStatsId,
    required this.maxStatNamesId,
    required this.maxStatValuesId,
    required this.statNamesInDB,
    required this.statValuesInDB,
  });

  static Future<KanjiBankV3ParserContext> create(DaKanjiDB db, int dictId) async {

    return KanjiBankV3ParserContext._(
      indexId: dictId,

      kanjisInDB: { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id },
      readingsInDB: { for (var e in await db.kanjiBankV3Dao.getAllReadings()) e.reading : e.id },
      definitionsInDB: { for (var e in await db.definitionDao.getAllDefinitions()) e.definition : e.id },
      tagsInDB: { for (var e in await db.tagBankV3Dao.getAllTags()) e.name : e.id },
      statNamesInDB: { for (var e in await db.kanjiBankV3Dao.getAllStatNames()) e.statName : e.id },
      statValuesInDB: { for (var e in await db.kanjiBankV3Dao.getAllStatValues()) e.statValue : e.id },

      // get current maximum values
      maxKanjiId:       await db.kanjiDao.maxKanjiId(),
      maxKanjiBankId:   await db.kanjiBankV3Dao.maxKanjiId(),
      maxReadingId:     await db.readingDao.maxReadingId(),
      maxDefinitionId:  await db.kanjiBankV3Dao.maxDefinitionId(),
      maxStatsId:       await db.kanjiBankV3Dao.maxStatsId(),
      maxStatValuesId:  await db.kanjiBankV3Dao.maxStatsValueId(),
      maxStatNamesId:   await db.kanjiBankV3Dao.maxStatsNameId()
    );
  }

  void clearInsertLists() {
    kanjiCompanions.clear();
    kanjiBankCompanions.clear();
    readingCompanions.clear();
    kanjiOnyomiReadingRelCompanions.clear();
    kanjiKunyomiReadingRelCompanions.clear();
    tagRelCompanions.clear();
    definitionsCompanions.clear();
    definitionRelCompanions.clear();
    statCompanions.clear();
    statNamesCompanions.clear();
    statValuesCompanions.clear();
    statValueRelCompanions.clear();
  }

}