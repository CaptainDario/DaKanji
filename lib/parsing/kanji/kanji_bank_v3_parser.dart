import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/database/kanji/kanji_bank_v3_tables.dart';
import 'package:drift/drift.dart';



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

  /// List of [KanjiBankV3OnyomisTableCompanion] that should be batch inserted
  List<KanjiBankV3OnyomisTableCompanion> onyomiCompanions  = [];
  /// The currently highest id in the [KanjiBankV3OnyomisTable]
  int onyomiId = 0;
  /// List of [KanjiBankV3OnyomiKanjiRelationsTableCompanion] that should be batch inserted
  List<KanjiBankV3OnyomiKanjiRelationsTableCompanion> onyomiRelCompanions = [];
  /// A local cache for onyomis. Every onyomi should only be looked up once
  /// in the database
  Map<String, int> onyomisInDB = {};
  
  /// List of [KanjiBankV3KunyomisTableCompanion] that should be batch inserted
  List<KanjiBankV3KunyomisTableCompanion> kunyomiCompanions  = [];
  /// The currently highest id in the [KanjiBankV3KunyomisTable]
  int kunyomiId = 0;
  /// List of [KanjiBankV3KunyomiKanjiRelationsTableCompanion] that should be batch inserted
  List<KanjiBankV3KunyomiKanjiRelationsTableCompanion> kunyomiRelCompanions = [];
  /// A local cache for kunyomis. Every kunyomi should only be looked up once
  /// in the database
  Map<String, int> kunyomisInDB = {};
  
  /// List of [KanjiBankV3TagsKanjiRelationsTableCompanion] that should be batch inserted
  List<KanjiBankV3TagsKanjiRelationsTableCompanion> tagRelCompanions = [];
  /// The currently highest id in the [KanjiBankV3TagsKanjiRelationsTableData]
  int tagId = 0;
  /// A local cache for tags. Every tag should only be looked up once
  /// in the database
  Map<String, int> tagsInDB = {};
  
  /// List of [KanjiBankV3MeaningsTableCompanion] that should be batch inserted
  List<KanjiBankV3MeaningsTableCompanion> meaningsCompanions  = [];
  /// The currently highest id in the [KanjiBankV3MeaningsTable]
  int meaningId = 0;
  /// List of [KanjiBankV3MeaningsKanjiRelationsTableCompanion] that should be batch inserted
  List<KanjiBankV3MeaningsKanjiRelationsTableCompanion> meaningRelCompanions = [];
  /// A local cache for meanings. Every meaning should only be looked up once
  /// in the database
  Map<String, int> meaningsInDB = {};

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
  /// List of [KanjiBankV3StatKanjiRelationsTableCompanion] that should be batch inserted
  List<KanjiBankV3StatKanjiRelationsTableCompanion> statValueRelCompanions = [];
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
  refs.onyomisInDB  =
    { for (var e in await db.kanjiBankV3Dao.getAllOnyomis()) e.onyomi : e.id };
  refs.kunyomisInDB =
    { for (var e in await db.kanjiBankV3Dao.getAllKunyomis()) e.kunyomi : e.id };
  refs.meaningsInDB =
    { for (var e in await db.kanjiBankV3Dao.getAllMeanings()) e.meaning : e.id };
  refs.tagsInDB = 
    { for (var e in await db.kanjiBankV3Dao.getAllTags()) e.name : e.id };
  refs.statNamesInDB = 
    { for (var e in await db.kanjiBankV3Dao.getAllStatNames()) e.statName : e.id };
  refs.statValuesInDB =
    { for (var e in await db.kanjiBankV3Dao.getAllStatValues()) e.statValue : e.id };

  // get current maximum values
  refs.kanjiId      = await db.kanjiDao.maxKanjiId();
  refs.kanjiBankId  = await db.kanjiBankV3Dao.maxKanjiId();
  refs.kunyomiId    = await db.kanjiBankV3Dao.maxKunyomiId();
  refs.onyomiId     = await db.kanjiBankV3Dao.maxOnyomiId();
  refs.meaningId    = await db.kanjiBankV3Dao.maxMeaningId();
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
    await parseMeaning(List<String>.from(jsonList[i][4]), refs, db);
    await parseStats(Map<String, String>.from(jsonList[i][5]), refs, db);
    
  }
  print("Parsing took ${s.elapsedMilliseconds}ms");

  // Perform the insertion inside a batch
  s.reset();
  await db.batch((batch) {
    
    batch.insertAll(db.kanjiBankV3Table, refs.kanjiBankCompanions,);

    batch.insertAll(db.kanjiBankV3OnyomisTable, refs.onyomiCompanions,);
    batch.insertAll(db.kanjiBankV3OnyomiKanjiRelationsTable, refs.onyomiRelCompanions,);

    batch.insertAll(db.kanjiBankV3KunyomisTable, refs.kunyomiCompanions,);
    batch.insertAll(db.kanjiBankV3KunyomiKanjiRelationsTable, refs.kunyomiRelCompanions,);

    batch.insertAll(db.kanjiBankV3TagsKanjiRelationsTable, refs.tagRelCompanions,);

    batch.insertAll(db.kanjiBankV3MeaningsTable, refs.meaningsCompanions,);
    batch.insertAll(db.kanjiBankV3MeaningsKanjiRelationsTable, refs.meaningRelCompanions,);
    
    batch.insertAll(db.kanjiBankV3StatsTable, refs.statCompanions,);
    batch.insertAll(db.kanjiBankV3StatValuesTable, refs.statValuesCompanions,);
    batch.insertAll(db.kanjiBankV3StatNamesTable, refs.statNamesCompanions,);
    batch.insertAll(db.kanjiBankV3StatKanjiRelationsTable, refs.statValueRelCompanions,);

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
    dictId: Value(refs.dictId)
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
      int? onyomiInsertId = refs.onyomisInDB[onyomi];
      if(onyomiInsertId == null){
        onyomiInsertId = ++refs.onyomiId;
        refs.onyomisInDB[onyomi] = onyomiInsertId;

        refs.onyomiCompanions.add(KanjiBankV3OnyomisTableCompanion(
          id: Value(onyomiInsertId), onyomi: Value(onyomi)
        ));
      }
      
      refs.onyomiRelCompanions.add(KanjiBankV3OnyomiKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiBankId), onyomiId: Value(onyomiInsertId)
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
      int? kunyomiInsertId = refs.kunyomisInDB[kunyomi];
      if(kunyomiInsertId == null){
        kunyomiInsertId = ++refs.kunyomiId;
        refs.kunyomisInDB[kunyomi] = kunyomiInsertId;

        refs.kunyomiCompanions.add(KanjiBankV3KunyomisTableCompanion(
          id: Value(kunyomiInsertId), kunyomi: Value(kunyomi)
        ));
      }
      refs.kunyomiRelCompanions.add(KanjiBankV3KunyomiKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiBankId), kunyomiId: Value(kunyomiInsertId)
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

      refs.tagRelCompanions.add(KanjiBankV3TagsKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiBankId), tagId: Value(tagInsertId)
      ));
    
    }
  }
}

/// Parses the given `meanings` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseMeaning(List<String> meanings, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(meanings.isNotEmpty){
    for (String meaning in meanings) {
      
      int? meaningInsertId = refs.meaningsInDB[meaning];
      if(meaningInsertId == null){
        meaningInsertId = ++refs.meaningId;
        refs.meaningsInDB[meaning] = meaningInsertId;

        refs.meaningsCompanions.add(KanjiBankV3MeaningsTableCompanion(
          id: Value(meaningInsertId), meaning: Value(meaning)
        ));
      }
      refs.meaningRelCompanions.add(KanjiBankV3MeaningsKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiBankId),meaningId: Value(meaningInsertId)
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
      refs.statValueRelCompanions.add(KanjiBankV3StatKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiBankId),
        statId: Value(refs.statsId),
      ));
    
    }
  }
}
