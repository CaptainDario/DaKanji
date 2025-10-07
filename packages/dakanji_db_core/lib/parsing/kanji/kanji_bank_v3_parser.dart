// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';
import 'package:path/path.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';
import 'kanji_bank_v3_parser_context.dart';




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

  KanjiBankV3ParserContext parsingContext = KanjiBankV3ParserContext()
    ..dictId = dictId;
  
  // get all ids and values from the db for O(1) access
  parsingContext.kanjisInDB =
    { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id };
  parsingContext.readingsInDB  =
    { for (var e in await db.kanjiBankV3Dao.getAllReadings()) e.reading : e.id };
  parsingContext.definitionsInDB =
    { for (var e in await db.definitionDao.getAllDefinitions()) e.definition : e.id };
  parsingContext.tagsInDB = 
    { for (var e in await db.tagBankV3Dao.getAllTags()) e.name : e.id };
  parsingContext.statNamesInDB = 
    { for (var e in await db.kanjiBankV3Dao.getAllStatNames()) e.statName : e.id };
  parsingContext.statValuesInDB =
    { for (var e in await db.kanjiBankV3Dao.getAllStatValues()) e.statValue : e.id };

  // get current maximum values
  parsingContext.kanjiId      = await db.kanjiDao.maxKanjiId();
  parsingContext.kanjiBankId  = await db.kanjiBankV3Dao.maxKanjiId();
  parsingContext.readingId    = await db.readingDao.maxReadingId();
  parsingContext.definitionId = await db.kanjiBankV3Dao.maxDefinitionId();
  parsingContext.statsId      = await db.kanjiBankV3Dao.maxStatsId();
  parsingContext.statValuesId = await db.kanjiBankV3Dao.maxStatsValueId();
  parsingContext.statNamesId  = await db.kanjiBankV3Dao.maxStatsNameId();

  // populate the companion lists
  Stopwatch s = Stopwatch()..start();
  for (var i = 0; i < jsonList.length; i++) {

    parsingContext.kanjiBankId++;
    
    await parseKanji(jsonList[i][0], parsingContext, db);
    await parseOnyomi(jsonList[i][1], parsingContext, db);
    await parseKunyomi(jsonList[i][2], parsingContext, db);
    await parseTag(jsonList[i][3], parsingContext, db);
    await parseDefinition(List<String>.from(jsonList[i][4]), parsingContext, db);
    await parseStats(Map<String, String>.from(jsonList[i][5]), parsingContext, db);

    parsingContext.kanjiBankCompanions.add(KanjiBankV3TableCompanion(
      id: Value(parsingContext.kanjiBankId),
      kanjiId: Value(parsingContext.kanjiId),
      indexId: Value(parsingContext.dictId),
      onyomiOrder: Value(jsonEncode(parsingContext.onyomisOrder)),
      kunyomiOrder: Value(jsonEncode(parsingContext.kunyomisOrder)),
      definitionOrder: Value(jsonEncode(parsingContext.definitionsOrder))
    ));

  }
  print("Parsing took ${s.elapsedMilliseconds}ms");

  // Perform the insertion inside a batch
  s.reset();
  await db.batch((batch) {
    
    batch.insertAll(db.kanjiTable, parsingContext.kanjiCompanions);
    batch.insertAll(db.kanjiBankV3Table, parsingContext.kanjiBankCompanions,);

    batch.insertAll(db.readingTable, parsingContext.readingCompanions,);
    batch.insertAll(db.kanjiBankV3XKunyomiReadingTable, parsingContext.kanjiKunyomiReadingRelCompanions,);
    batch.insertAll(db.kanjiBankV3XOnyomiReadingTable, parsingContext.kanjiOnyomiReadingRelCompanions,);

    batch.insertAll(db.kanjiBankV3XTagBankV3Table, parsingContext.tagRelCompanions,);

    batch.insertAll(db.definitionTable, parsingContext.definitionsCompanions,);
    batch.insertAll(db.kanjiBankV3XDefinitionTable, parsingContext.definitionRelCompanions,);
    
    batch.insertAll(db.kanjiBankV3StatsTable, parsingContext.statCompanions,);
    batch.insertAll(db.kanjiBankV3StatValuesTable, parsingContext.statValuesCompanions,);
    batch.insertAll(db.kanjiBankV3StatNamesTable, parsingContext.statNamesCompanions,);
    batch.insertAll(db.kanjiBankV3XKanjiBankV3StatsTable, parsingContext.statValueRelCompanions,);

  });
  print("Adding to DaKanjiDB took ${s.elapsedMilliseconds}ms");

}

/// Parses the given `jsonKanji` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseKanji(String jsonKanji, KanjiBankV3ParserContext parsingContext, DaKanjiDB db) async {

  if(parsingContext.kanjisInDB[jsonKanji] == null){

    parsingContext.kanjisInDB[jsonKanji] = ++parsingContext.kanjiId;
    parsingContext.kanjiCompanions.add(KanjiTableCompanion(
      id: Value(parsingContext.kanjiId),
      kanji: Value(jsonKanji),
    ));
  
  }
}

/// Parses the given `jsonOnyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseOnyomi(String jsonOnyomi, KanjiBankV3ParserContext parsingContext, DaKanjiDB db) async {

  if(jsonOnyomi != ""){
    List<String> onyomis = jsonOnyomi.toString().split(" ");
    parsingContext.onyomisOrder = [];
    for (String onyomi in onyomis) {
      
      // is this onyomi already in the db?
      int? onyomiInsertId = parsingContext.readingsInDB[onyomi];
      if(onyomiInsertId == null){
        onyomiInsertId = ++parsingContext.readingId;
        parsingContext.readingsInDB[onyomi] = onyomiInsertId;

        parsingContext.readingCompanions.add(ReadingTableCompanion(
          id: Value(onyomiInsertId), reading: Value(onyomi)
        ));
      }
      
      parsingContext.onyomisOrder.add(onyomiInsertId);
      parsingContext.kanjiOnyomiReadingRelCompanions.add(KanjiBankV3_X_OnyomiReadingTableCompanion(
        kanjiId: Value(parsingContext.kanjiBankId), onyomiReadingId: Value(onyomiInsertId)
      ));
    
    }
  }
}

/// Parses the given `jsonKunyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseKunyomi(String jsonKunyomi, KanjiBankV3ParserContext parsingContext, DaKanjiDB db) async {

  if(jsonKunyomi != ""){
    List<String> kunyomis = jsonKunyomi.toString().split(" ");
    parsingContext.kunyomisOrder = [];
    for (String kunyomi in kunyomis) {
      
      // is this kunyomi already in the DB?
      int? kunyomiInsertId = parsingContext.readingsInDB[kunyomi];
      if(kunyomiInsertId == null){
        kunyomiInsertId = ++parsingContext.readingId;
        parsingContext.readingsInDB[kunyomi] = kunyomiInsertId;

        parsingContext.readingCompanions.add(ReadingTableCompanion(
          id: Value(kunyomiInsertId), reading: Value(kunyomi)
        ));
      }
      parsingContext.kunyomisOrder.add(kunyomiInsertId);
      parsingContext.kanjiKunyomiReadingRelCompanions.add(KanjiBankV3_X_KunyomiReadingTableCompanion(
        kanjiId: Value(parsingContext.kanjiBankId), kunyomiReadingId: Value(kunyomiInsertId)
      ));
    
    }
  }
}

/// Parses the given `jsonTag` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseTag(String jsonTag, KanjiBankV3ParserContext parsingContext, DaKanjiDB db) async {

  if(jsonTag != ""){
    List<String> tags = jsonTag.toString().split(" ");
    for (String tag in tags) {
      
      int tagInsertId = parsingContext.tagsInDB[tag]!;

      parsingContext.tagRelCompanions.add(KanjiBankV3_X_TagBankV3TableCompanion(
        kanjiId: Value(parsingContext.kanjiBankId), tagId: Value(tagInsertId)
      ));
    
    }
  }
}

/// Parses the given `definitions` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseDefinition(List<String> definitions, KanjiBankV3ParserContext parsingContext, DaKanjiDB db) async {

  if(definitions.isNotEmpty){
    for (String definition in definitions) {
      
      int? definitionInsertId = parsingContext.definitionsInDB[definition];
      parsingContext.definitionsOrder = [];
      if(definitionInsertId == null){
        definitionInsertId = ++parsingContext.definitionId;
        parsingContext.definitionsInDB[definition] = definitionInsertId;

        parsingContext.definitionsCompanions.add(DefinitionTableCompanion(
          id: Value(definitionInsertId), definition: Value(definition)
        ));
      }

      parsingContext.definitionsOrder.add(definitionInsertId);
      parsingContext.definitionRelCompanions.add(KanjiBankV3_X_DefinitionTableCompanion(
        kanjiId: Value(parsingContext.kanjiBankId), definitionId: Value(definitionInsertId)
      ));
    
    }
  }
}

/// Parses the given `stats` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseStats(Map<String, String> stats, KanjiBankV3ParserContext parsingContext, DaKanjiDB db) async {

  if(stats.isNotEmpty){

    for (MapEntry<String, String> stat in stats.entries) {

      parsingContext.statsId += 1;
      
      int? statValueInsertId = parsingContext.statValuesInDB[stat.value];
      if(statValueInsertId == null){
        statValueInsertId = ++parsingContext.statValuesId;
        parsingContext.statValuesInDB[stat.value] = statValueInsertId;

        parsingContext.statValuesCompanions.add(KanjiBankV3StatValuesTableCompanion(
          id: Value(statValueInsertId),
          statValue: Value(stat.value)
        ));
      }
      
      int? statNameInsertId = parsingContext.statNamesInDB[stat.key];
      if(statNameInsertId == null){
        statNameInsertId = ++parsingContext.statNamesId;
        parsingContext.statNamesInDB[stat.key] = statNameInsertId;

        parsingContext.statNamesCompanions.add(KanjiBankV3StatNamesTableCompanion(
          id: Value(statNameInsertId),
          statName: Value(stat.key)
        ));
      }

      parsingContext.statCompanions.add(KanjiBankV3StatsTableCompanion(
        id: Value(parsingContext.statsId),
        statNameId: Value(statNameInsertId),
        statValueId: Value(statValueInsertId),
      ));
      parsingContext.statValueRelCompanions.add(KanjiBankV3_X_KanjiBankV3StatsTableCompanion(
        kanjiId: Value(parsingContext.kanjiBankId),
        statId: Value(parsingContext.statsId),
      ));
    
    }
  }
}
