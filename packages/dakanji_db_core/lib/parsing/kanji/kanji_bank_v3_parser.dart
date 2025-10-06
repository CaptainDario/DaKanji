// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';
import '/database/kanji/kanji_bank_v3_tables.dart';

/// Simple class to keep track of the different IDs needed to parse a kanji dict
class KanjiBankV3ParserRefs {

  /// The SQLite id of the dictionary that is currently being parsed
  int dictId = 0;

  ///
  List<KanjiTableCompanion> kanjiCompanions = [];
  ///
  int kanjiId = 0;
  ///
  Map<String, int> kanjisInDB = {};

  /// List of [KanjiBankV3TableCompanion] that should be batch inserted
  List<KanjiBankV3TableCompanion> kanjiBankCompanions = [];
  /// The currently highest id in the [KanjiBankV3Table]
  int kanjiBankId = 0;

  /// List of [ReadingTableCompanion] that should be batch inserted
  List<ReadingTableCompanion> readingCompanions  = [];
  /// The currently highest id in the [ReadingTable]
  int readingId = 0;
  /// List of [KanjiBankV3_X_OnyomiReadingTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_OnyomiReadingTableCompanion> kanjiOnyomiReadingRelCompanions = [];
  /// List of [KanjiBankV3_X_KunyomiReadingTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_KunyomiReadingTableCompanion> kanjiKunyomiReadingRelCompanions = [];
  /// A local cache for readings. Every reading should only be looked up once
  /// in the database
  Map<String, int> readingsInDB = {};
  
  /// List of [KanjiBankV3_X_TagBankV3TableCompanion] that should be batch inserted
  List<KanjiBankV3_X_TagBankV3TableCompanion> tagRelCompanions = [];
  /// The currently highest id in the [KanjiBankV3TagsKanjiRelationsTableData]
  int tagId = 0;
  /// A local cache for tags. Every tag should only be looked up once
  /// in the database
  Map<String, int> tagsInDB = {};
  
  /// List of [DefinitionTableCompanion] that should be batch inserted
  List<DefinitionTableCompanion> definitionsCompanions  = [];
  /// The currently highest id in the [DefinitionTable]
  int definitionId = 0;
  /// List of [KanjiBankV3_X_DefinitionTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_DefinitionTableCompanion> definitionRelCompanions = [];
  /// A local cache for definitions. Every definition should only be looked up once
  /// in the database
  Map<String, int> definitionsInDB = {};

  /// List of [KanjiBankV3StatsTableCompanion] that should be batch inserted
  List<KanjiBankV3StatsTableCompanion> statCompanions = [];
  /// List of [KanjiBankV3StatNamesTableCompanion] that should be batch inserted
  List<KanjiBankV3StatNamesTableCompanion> statNamesCompanions  = [];
  /// List of [KanjiBankV3StatValuesTableCompanion] that should be batch inserted
  List<KanjiBankV3StatValuesTableCompanion> statValuesCompanions  = [];
  /// The currently highest id in the [KanjiBankV3StatsTable]
  int statsId = 0;
  /// The currently highest id in the [KanjiBankV3StatValuesTable]
  int statNamesId = 0;
  /// The currently highest id in the [KanjiBankV3StatNamesTable]
  int statValuesId = 0;
  /// List of [KanjiBankV3_X_KanjiBankV3StatsTableCompanion] that should be batch inserted
  List<KanjiBankV3_X_KanjiBankV3StatsTableCompanion> statValueRelCompanions = [];
  /// A local cache for stat names. Every stat name should only be looked up
  /// once in the database
  Map<String, int> statNamesInDB = {};
  /// A local cache for stat values. Every stat value should only be looked up
  /// once in the database
  Map<String, int> statValuesInDB = {};

}


/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3File(File kanjiBankV3JsonFile, DaKanjiDB db, int dictId) async {

  String jsonString = kanjiBankV3JsonFile.readAsStringSync();

  await parseKanjiBankV3(jsonString, db, dictId);

}

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3(String kanjiBankV3Json, DaKanjiDB db, int dictId) async {

  // read and decode the json
  List jsonList = jsonDecode(kanjiBankV3Json);
  print("Parsing ${jsonList.length} kanji entries");

  KanjiBankV3ParserRefs refs = KanjiBankV3ParserRefs()
    ..dictId = dictId;
  
  // get all ids and values from the db for O(1) access
  refs.kanjisInDB =
    { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id };
  refs.readingsInDB  =
    { for (var e in await db.kanjiBankV3Dao.getAllReadings()) e.reading : e.id };
  refs.definitionsInDB =
    { for (var e in await db.definitionDao.getAllDefinitions()) e.definition : e.id };
  refs.tagsInDB = 
    { for (var e in await db.tagBankV3Dao.getAllTags()) e.name : e.id };
  refs.statNamesInDB = 
    { for (var e in await db.kanjiBankV3Dao.getAllStatNames()) e.statName : e.id };
  refs.statValuesInDB =
    { for (var e in await db.kanjiBankV3Dao.getAllStatValues()) e.statValue : e.id };

  // get current maximum values
  refs.kanjiId      = await db.kanjiDao.maxKanjiId();
  refs.kanjiBankId  = await db.kanjiBankV3Dao.maxKanjiId();
  refs.readingId    = await db.readingDao.maxReadingId();
  refs.definitionId    = await db.kanjiBankV3Dao.maxDefinitionId();
  refs.statsId      = await db.kanjiBankV3Dao.maxStatsId();
  refs.statValuesId = await db.kanjiBankV3Dao.maxStatsValueId();
  refs.statNamesId  = await db.kanjiBankV3Dao.maxStatsNameId();

  // populate the companion lists
  Stopwatch s = Stopwatch()..start();
  for (var i = 0; i < jsonList.length; i++) {
    
    await parseKanji(jsonList[i][0], refs, db);
    await parseOnyomi(jsonList[i][1], refs, db);
    await parseKunyomi(jsonList[i][2], refs, db);
    await parseTag(jsonList[i][3], refs, db);
    await parseDefinition(List<String>.from(jsonList[i][4]), refs, db);
    await parseStats(Map<String, String>.from(jsonList[i][5]), refs, db);
    
  }
  print("Parsing took ${s.elapsedMilliseconds}ms");

  // Perform the insertion inside a batch
  s.reset();
  await db.batch((batch) {
    
    batch.insertAll(db.kanjiTable, refs.kanjiCompanions);
    batch.insertAll(db.kanjiBankV3Table, refs.kanjiBankCompanions,);

    batch.insertAll(db.readingTable, refs.readingCompanions,);
    batch.insertAll(db.kanjiBankV3XKunyomiReadingTable, refs.kanjiKunyomiReadingRelCompanions,);
    batch.insertAll(db.kanjiBankV3XOnyomiReadingTable, refs.kanjiOnyomiReadingRelCompanions,);

    batch.insertAll(db.kanjiBankV3XTagBankV3Table, refs.tagRelCompanions,);

    batch.insertAll(db.definitionTable, refs.definitionsCompanions,);
    batch.insertAll(db.kanjiBankV3XDefinitionTable, refs.definitionRelCompanions,);
    
    batch.insertAll(db.kanjiBankV3StatsTable, refs.statCompanions,);
    batch.insertAll(db.kanjiBankV3StatValuesTable, refs.statValuesCompanions,);
    batch.insertAll(db.kanjiBankV3StatNamesTable, refs.statNamesCompanions,);
    batch.insertAll(db.kanjiBankV3XKanjiBankV3StatsTable, refs.statValueRelCompanions,);

  });
  print("Adding to DaKanjiDB took ${s.elapsedMilliseconds}ms");

}

/// Parses the given `jsonKanji` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseKanji(String jsonKanji, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(refs.kanjisInDB[jsonKanji] == null){

    refs.kanjisInDB[jsonKanji] = ++refs.kanjiId;
    refs.kanjiCompanions.add(KanjiTableCompanion(
      id: Value(++refs.kanjiId),
      kanji: Value(jsonKanji)
    ));
  
  }

  refs.kanjiBankCompanions.add(KanjiBankV3TableCompanion(
    id: Value(++refs.kanjiBankId),
    kanjiId: Value(refs.kanjiId),
    indexId: Value(refs.dictId)
  ));

}

/// Parses the given `jsonOnyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseOnyomi(String jsonOnyomi, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(jsonOnyomi != ""){
    List<String> onyomis = jsonOnyomi.toString().split(" ");
    for (String onyomi in onyomis) {
      
      // is this onyomi already in the db?
      if(refs.readingsInDB[onyomi] == null){
        refs.readingsInDB[onyomi] = ++refs.readingId;

        refs.readingCompanions.add(ReadingTableCompanion(
          id: Value(refs.readingId), reading: Value(onyomi)
        ));
      }
      
      refs.kanjiOnyomiReadingRelCompanions.add(KanjiBankV3_X_OnyomiReadingTableCompanion(
        kanjiId: Value(refs.kanjiBankId), onyomiReadingId: Value(refs.readingId)
      ));
    
    }
  }
}

/// Parses the given `jsonKunyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseKunyomi(String jsonKunyomi, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(jsonKunyomi != ""){
    List<String> kunyomis = jsonKunyomi.toString().split(" ");
    for (String kunyomi in kunyomis) {
      
      // is this kunyomi already in the DB?
      if(refs.readingsInDB[kunyomi] == null){
        refs.readingsInDB[kunyomi] = ++refs.readingId;

        refs.readingCompanions.add(ReadingTableCompanion(
          id: Value(refs.readingId), reading: Value(kunyomi)
        ));
      }
      refs.kanjiKunyomiReadingRelCompanions.add(KanjiBankV3_X_KunyomiReadingTableCompanion(
        kanjiId: Value(refs.kanjiBankId), kunyomiReadingId: Value(refs.readingId)
      ));
    
    }
  }
}

/// Parses the given `jsonTag` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseTag(String jsonTag, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(jsonTag != ""){
    List<String> tags = jsonTag.toString().split(" ");
    for (String tag in tags) {
      
      int tagInsertId = refs.tagsInDB[tag]!;

      refs.tagRelCompanions.add(KanjiBankV3_X_TagBankV3TableCompanion(
        kanjiId: Value(refs.kanjiBankId), tagId: Value(tagInsertId)
      ));
    
    }
  }
}

/// Parses the given `definitions` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseDefinition(List<String> definitions, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(definitions.isNotEmpty){
    for (String definition in definitions) {
      
      int? definitionInsertId = refs.definitionsInDB[definition];
      if(definitionInsertId == null){
        definitionInsertId = ++refs.definitionId;
        refs.definitionsInDB[definition] = definitionInsertId;

        refs.definitionsCompanions.add(DefinitionTableCompanion(
          id: Value(definitionInsertId), definition: Value(definition)
        ));
      }
      refs.definitionRelCompanions.add(KanjiBankV3_X_DefinitionTableCompanion(
        kanjiId: Value(refs.kanjiBankId), definitionId: Value(definitionInsertId)
      ));
    
    }
  }
}

/// Parses the given `stats` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseStats(Map<String, String> stats, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(stats.isNotEmpty){

    for (MapEntry<String, String> stat in stats.entries) {

      refs.statsId += 1;
      
      int? statValueInsertId = refs.statValuesInDB[stat.value];
      if(statValueInsertId == null){
        statValueInsertId = ++refs.statValuesId;
        refs.statValuesInDB[stat.value] = statValueInsertId;

        refs.statValuesCompanions.add(KanjiBankV3StatValuesTableCompanion(
          id: Value(statValueInsertId),
          statValue: Value(stat.value)
        ));
      }
      
      int? statNameInsertId = refs.statNamesInDB[stat.key];
      if(statNameInsertId == null){
        statNameInsertId = ++refs.statNamesId;
        refs.statNamesInDB[stat.key] = statNameInsertId;

        refs.statNamesCompanions.add(KanjiBankV3StatNamesTableCompanion(
          id: Value(statNameInsertId),
          statName: Value(stat.key)
        ));
      }

      refs.statCompanions.add(KanjiBankV3StatsTableCompanion(
        id: Value(refs.statsId),
        statNameId: Value(statNameInsertId),
        statValueId: Value(statValueInsertId),
      ));
      refs.statValueRelCompanions.add(KanjiBankV3_X_KanjiBankV3StatsTableCompanion(
        kanjiId: Value(refs.kanjiBankId),
        statId: Value(refs.statsId),
      ));
    
    }
  }
}
