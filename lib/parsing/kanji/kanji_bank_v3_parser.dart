import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';



/// Simple class to keep track of the different IDs needed to parse a kanji dict
class KanjiBankV3ParserRefs {

  /// The SQLite id of the dictionary that is currently being parsed
  int dictId = 0;

  ///
  List<KanjiBankV3TableCompanion> kanjiCompanions = [];
  /// 
  int kanjiId = 0;
  /// 
  int kanjiInsertId = 0;

  ///
  List<KanjiBankV3OnyomisTableCompanion> onyomiCompanions  = [];
  /// 
  int onyomiId = 0;
  ///
  List<KanjiBankV3OnyomiKanjiRelationsTableCompanion> onyomiRelCompanions = [];
  ///
  Map<String, int> seenOnyomis = {};
  
  ///
  List<KanjiBankV3KunyomisTableCompanion> kunyomiCompanions  = [];
  /// 
  int kunyomiId = 0;
  ///
  List<KanjiBankV3KunyomiKanjiRelationsTableCompanion> kunyomiRelCompanions = [];
  ///
  Map<String, int> seenKunyomis = {};

  ///
  List<KanjiBankV3TagsTableCompanion> tagCompanions  = [];
  /// 
  int tagId = 0;
  ///
  List<KanjiBankV3TagsKanjiRelationsTableCompanion> tagRelCompanions = [];
  ///
  Map<String, int> seenTags = {};

  ///
  List<KanjiBankV3MeaningsTableCompanion> meaningsCompanions  = [];
  /// 
  int meaningId = 0;
  ///
  List<KanjiBankV3MeaningsKanjiRelationsTableCompanion> meaningRelCompanions = [];
  ///
  Map<String, int> seenMeanings = {};


  ///
  List<KanjiBankV3StatNamesTableCompanion> statNamesCompanions  = [];
  ///
  List<KanjiBankV3StatValuesTableCompanion> statValuesCompanions  = [];
  ///
  int statNamesId = 0;
  ///
  int statValuesId = 0;
  ///
  List<KanjiBankV3StatKanjiRelationsTableCompanion> statValueRelCompanions = [];
  ///
  Map<String, int> seenStatNames = {};
  ///
  Map<String, int> seenStatValues = {};

}

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3(File kanjiBankV3JsonPath, DaKanjiDB db, int dictId) async {

  // read and decode the json
  String jsonString = kanjiBankV3JsonPath.readAsStringSync();
  List jsonList = jsonDecode(jsonString);
  print(jsonList.length);

  KanjiBankV3ParserRefs refs = KanjiBankV3ParserRefs()
    ..dictId = dictId;

  refs.kanjiId = await db.kanjiBankV3Dao.maxKanjiId();
  refs.onyomiId = await db.kanjiBankV3Dao.maxOnyomiId();
  refs.meaningId = await db.kanjiBankV3Dao.maxMeaningId();

  // populate the companion lists
  for (var i = 0; i < jsonList.length; i++) {
    
    await parseKanji(jsonList[i][0], refs, db);
    await parseOnyomi(jsonList[i][1], refs, db);
    await parseKunyomi(jsonList[i][2], refs, db);
    await parseTag(jsonList[i][3], refs, db);
    await parseMeaning(List<String>.from(jsonList[i][4]), refs, db);
    await parseStats(Map<String, String>.from(jsonList[i][5]), refs, db);
    
  }

  // Perform the insertion inside a transaction
  await db.batch((batch) {
    
    batch.insertAll(db.kanjiBankV3Table, refs.kanjiCompanions,
      mode: InsertMode.insertOrIgnore);

    batch.insertAll(db.kanjiBankV3OnyomisTable, refs.onyomiCompanions,
      mode: InsertMode.insertOrIgnore);
    batch.insertAll(db.kanjiBankV3OnyomiKanjiRelationsTable, refs.onyomiRelCompanions,
      mode: InsertMode.insertOrIgnore);

    batch.insertAll(db.kanjiBankV3KunyomisTable, refs.kunyomiCompanions,
      mode: InsertMode.insertOrIgnore);
    batch.insertAll(db.kanjiBankV3KunyomiKanjiRelationsTable, refs.kunyomiRelCompanions,
      mode: InsertMode.insertOrIgnore);

    batch.insertAll(db.kanjiBankV3TagsTable, refs.tagCompanions,
      mode: InsertMode.insertOrIgnore);
    batch.insertAll(db.kanjiBankV3TagsKanjiRelationsTable, refs.tagRelCompanions,
      mode: InsertMode.insertOrIgnore);

    batch.insertAll(db.kanjiBankV3MeaningsTable, refs.meaningsCompanions,
      mode: InsertMode.insertOrIgnore);
    batch.insertAll(db.kanjiBankV3MeaningsKanjiRelationsTable, refs.meaningRelCompanions,
      mode: InsertMode.insertOrIgnore);
    
    batch.insertAll(db.kanjiBankV3StatValuesTable, refs.statValuesCompanions,
      mode: InsertMode.insertOrIgnore);
    batch.insertAll(db.kanjiBankV3StatNamesTable, refs.statNamesCompanions,
      mode: InsertMode.insertOrIgnore);
      batch.insertAll(db.kanjiBankV3StatKanjiRelationsTable, refs.statValueRelCompanions,
      mode: InsertMode.insertOrIgnore);

  });

}

/// Parses the given `jsonKanji` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseKanji(String jsonKanji, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  refs.kanjiInsertId = await db.kanjiBankV3Dao.getKanjiId(jsonKanji) ?? ++refs.kanjiId;
  refs.kanjiCompanions.add(KanjiBankV3TableCompanion(
    id: Value(refs.kanjiInsertId),
    kanji: Value(jsonKanji)
  ));

}

/// Parses the given `jsonOnyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseOnyomi(String jsonOnyomi, KanjiBankV3ParserRefs refs, DaKanjiDB db) async {

  if(jsonOnyomi != ""){
    List<String> onyomis = jsonOnyomi.toString().split(" ");
    for (String onyomi in onyomis) {
      
      int? onyomiInsertId = refs.seenOnyomis[onyomi];
      if(onyomiInsertId == null){
        onyomiInsertId = await db.kanjiBankV3Dao.getOnyomiId(onyomi) ?? ++refs.onyomiId;
        refs.seenOnyomis[onyomi] = onyomiInsertId;
      }
      refs.onyomiCompanions.add(KanjiBankV3OnyomisTableCompanion(
        id: Value(onyomiInsertId),
        dictId: Value(refs.dictId),
        //kanjiBankV3ID: Value(refs.kanjiInsertId),
        onyomi: Value(onyomi)
      ));
      refs.onyomiRelCompanions.add(KanjiBankV3OnyomiKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiInsertId),
        onyomiId: Value(onyomiInsertId)
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
      
      int? kunyomiInsertId = refs.seenKunyomis[kunyomi];
      if(kunyomiInsertId == null){
        kunyomiInsertId = await db.kanjiBankV3Dao.getKunyomiId(kunyomi) ?? ++refs.kunyomiId;
        refs.seenKunyomis[kunyomi] = kunyomiInsertId;
      }
      refs.kunyomiCompanions.add(KanjiBankV3KunyomisTableCompanion(
        id: Value(kunyomiInsertId),
        dictId: Value(refs.dictId),
        //kanjiBankV3ID: Value(refs.kanjiInsertId),
        kunyomi: Value(kunyomi)
      ));
      refs.kunyomiRelCompanions.add(KanjiBankV3KunyomiKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiInsertId),
        kunyomiId: Value(kunyomiInsertId)
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
      
      int tagInsertId = (await db.tagBankV3Dao.getTagId(tag))!;

      refs.tagCompanions.add(KanjiBankV3TagsTableCompanion(
        id: Value(tagInsertId),
        dictId: Value(refs.dictId),
        //kanjiBankV3ID: Value(refs.kanjiInsertId),
        tag: Value(tag)
      ));
      refs.tagRelCompanions.add(KanjiBankV3TagsKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiInsertId),
        tagId: Value(tagInsertId)
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
      
      int? meaningInsertId = refs.seenMeanings[meaning];
      if(meaningInsertId == null){
        meaningInsertId = await db.kanjiBankV3Dao.getMeaningId(meaning) ?? ++refs.meaningId;
        refs.seenMeanings[meaning] = meaningInsertId;
      }
      refs.meaningsCompanions.add(KanjiBankV3MeaningsTableCompanion(
        id: Value(meaningInsertId),
        dictId: Value(refs.dictId),
        //kanjiBankV3ID: Value(refs.kanjiInsertId),
        meaning: Value(meaning)
      ));
      refs.meaningRelCompanions.add(KanjiBankV3MeaningsKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiInsertId),
        meaningId: Value(meaningInsertId)
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
      
      int? statValueInsertId = refs.seenStatValues[stat.value];
      if(statValueInsertId == null){
        statValueInsertId = await db.kanjiBankV3Dao.getStatsValueId(stat.value) ?? ++refs.statValuesId;
        refs.seenStatValues[stat.value] = statValueInsertId;
      }
      int? statNameInsertId = refs.seenStatNames[stat.key];
      if(statNameInsertId == null){
        statNameInsertId = await db.kanjiBankV3Dao.getStatsNameId(stat.key) ?? ++refs.statNamesId;
        refs.seenStatNames[stat.key] = statNameInsertId;
      }

      refs.statValuesCompanions.add(KanjiBankV3StatValuesTableCompanion(
        id: Value(statValueInsertId),
        statValue: Value(stat.value)
      ));
      refs.statNamesCompanions.add(KanjiBankV3StatNamesTableCompanion(
        id: Value(statNameInsertId),
        statName: Value(stat.key)
      ));
      refs.statValueRelCompanions.add(KanjiBankV3StatKanjiRelationsTableCompanion(
        kanjiId: Value(refs.kanjiInsertId),
        statValueId: Value(statValueInsertId)
      ));
    
    }
  }
}
