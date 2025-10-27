// Dart imports:
import 'dart:convert';

import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

import '/database/dakanji_db.dart';
import 'kanji_bank_v3_parser_context.dart';




/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3File(File kanjiBankV3JsonFile, KanjiBankV3ParserContext pC, DaKanjiDB db, int dictId) async {

  String jsonString = kanjiBankV3JsonFile.readAsStringSync();

  await parseKanjiBankV3(jsonString, pC, db, dictId);

}

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseKanjiBankV3(String kanjiBankV3Json, KanjiBankV3ParserContext pC, DaKanjiDB db, int dictId) async {

  // assure that the insert data is empty
  pC.clearInsertLists();

  // read and decode the json
  List jsonList = jsonDecode(kanjiBankV3Json);
  print("Parsing ${jsonList.length} kanji entries");

  // populate the companion lists
  Stopwatch s = Stopwatch()..start();
  for (var i = 0; i < jsonList.length; i++) {

    pC.maxKanjiBankId++;
    
    int kanjiInsertId = await parseKanji(jsonList[i][0], pC, db);
    await parseOnyomi(jsonList[i][1], pC, db);
    await parseKunyomi(jsonList[i][2], pC, db);
    await parseTag(jsonList[i][3], pC, db);
    await parseDefinition(List<String>.from(jsonList[i][4]), pC, db);
    await parseStats(Map<String, String>.from(jsonList[i][5]), pC, db);

    pC.kanjiBankCompanions.add(KanjiBankV3TableCompanion(
      id: Value(pC.maxKanjiBankId),
      kanjiId: Value(kanjiInsertId),
      indexId: Value(pC.indexId),
      onyomiOrder: Value(jsonEncode(pC.onyomisOrder)),
      kunyomiOrder: Value(jsonEncode(pC.kunyomisOrder)),
      definitionOrder: Value(jsonEncode(pC.definitionsOrder))
    ));

  }
  print("Parsing took ${s.elapsedMilliseconds}ms");

  // Perform the insertion inside a batch
  s.reset();
  await db.batch((batch) {
    
    batch.insertAll(db.kanjiTable, pC.kanjiCompanions);
    batch.insertAll(db.kanjiBankV3Table, pC.kanjiBankCompanions,);

    batch.insertAll(db.readingTable, pC.readingCompanions,);
    batch.insertAll(db.kanjiBankV3XKunyomiReadingTable, pC.kanjiKunyomiReadingRelCompanions,);
    batch.insertAll(db.kanjiBankV3XOnyomiReadingTable, pC.kanjiOnyomiReadingRelCompanions,);

    batch.insertAll(db.kanjiBankV3XTagBankV3Table, pC.tagRelCompanions,);

    batch.insertAll(db.definitionTable, pC.definitionsCompanions,);
    batch.insertAll(db.kanjiBankV3XDefinitionTable, pC.definitionRelCompanions,);
    
    batch.insertAll(db.kanjiBankV3StatsTable, pC.statCompanions,);
    batch.insertAll(db.kanjiBankV3StatValuesTable, pC.statValuesCompanions,);
    batch.insertAll(db.kanjiBankV3StatNamesTable, pC.statNamesCompanions,);
    batch.insertAll(db.kanjiBankV3XKanjiBankV3StatsTable, pC.statValueRelCompanions,);

  });
  print("Adding to DaKanjiDB took ${s.elapsedMilliseconds}ms");

}

/// Parses the given `jsonKanji` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<int> parseKanji(String jsonKanji, KanjiBankV3ParserContext pC, DaKanjiDB db) async {

  int? insertId = pC.kanjisInDB[jsonKanji];

  if(insertId == null){
    insertId = ++pC.maxKanjiId;
    pC.kanjisInDB[jsonKanji] = insertId;
    pC.kanjiCompanions.add(KanjiTableCompanion(
      id: Value(insertId),
      kanji: Value(jsonKanji),
    ));
  }

  return insertId;
}

/// Parses the given `jsonOnyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseOnyomi(String jsonOnyomi, KanjiBankV3ParserContext pC, DaKanjiDB db) async {

  pC.onyomisOrder = [];

  if(jsonOnyomi != ""){
    List<String> onyomis = jsonOnyomi.toString().split(" ");
    for (String onyomi in onyomis) {
      
      // is this onyomi already in the db?
      int? onyomiInsertId = pC.readingsInDB[onyomi];
      if(onyomiInsertId == null){
        onyomiInsertId = ++pC.maxReadingId;
        pC.readingsInDB[onyomi] = onyomiInsertId;

        String? onyomiNormalized = preprocessInput(onyomi, false).normalizedTerms.firstOrNull;
        pC.readingCompanions.add(ReadingTableCompanion(
          id: Value(onyomiInsertId),
          reading: Value(onyomi),
          readingNormalized: onyomiNormalized!=onyomi && onyomiNormalized!=null
            ? Value(onyomiNormalized)
            : const Value.absent(),
        ));
      }
      
      pC.onyomisOrder.add(onyomiInsertId);
      pC.kanjiOnyomiReadingRelCompanions.add(KanjiBankV3_X_OnyomiReadingTableCompanion(
        kanjiId: Value(pC.maxKanjiBankId), onyomiReadingId: Value(onyomiInsertId)
      ));
    
    }
  }
}

/// Parses the given `jsonKunyomis` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseKunyomi(String jsonKunyomi, KanjiBankV3ParserContext pC, DaKanjiDB db) async {

  pC.kunyomisOrder = [];

  if(jsonKunyomi != ""){
    List<String> kunyomis = jsonKunyomi.toString().split(" ");
    for (String kunyomi in kunyomis) {
      
      // is this kunyomi already in the DB?
      int? kunyomiInsertId = pC.readingsInDB[kunyomi];
      if(kunyomiInsertId == null){
        kunyomiInsertId = ++pC.maxReadingId;
        pC.readingsInDB[kunyomi] = kunyomiInsertId;

        String? kunyomiNormalized = preprocessInput(kunyomi, false).normalizedTerms.firstOrNull;
        pC.readingCompanions.add(ReadingTableCompanion(
          id: Value(kunyomiInsertId),
          reading: Value(kunyomi),
          readingNormalized: kunyomiNormalized!=kunyomi && kunyomiNormalized!=null
            ? Value(kunyomiNormalized)
            : const Value.absent(),
        ));
      }
      pC.kunyomisOrder.add(kunyomiInsertId);
      pC.kanjiKunyomiReadingRelCompanions.add(KanjiBankV3_X_KunyomiReadingTableCompanion(
        kanjiId: Value(pC.maxKanjiBankId), kunyomiReadingId: Value(kunyomiInsertId)
      ));
    
    }
  }
}

/// Parses the given `jsonTag` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseTag(String jsonTag, KanjiBankV3ParserContext pC, DaKanjiDB db) async {

  if(jsonTag != ""){
    List<String> tags = jsonTag.toString().split(" ");
    for (String tag in tags) {
      
      int tagInsertId = pC.tagsInDB[tag]!;

      pC.tagRelCompanions.add(KanjiBankV3_X_TagBankV3TableCompanion(
        kanjiId: Value(pC.maxKanjiBankId), tagId: Value(tagInsertId)
      ));
    
    }
  }
}

/// Parses the given `definitions` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseDefinition(List<String> definitions, KanjiBankV3ParserContext pC, DaKanjiDB db) async {
  
  pC.definitionsOrder = [];
  if(definitions.isNotEmpty){
    for (String definition in definitions) {
      
      int? definitionInsertId = pC.definitionsInDB[definition];
      if(definitionInsertId == null){
        definitionInsertId = ++pC.maxDefinitionId;
        pC.definitionsInDB[definition] = definitionInsertId;

        pC.definitionsCompanions.add(DefinitionTableCompanion(
          id: Value(definitionInsertId), definition: Value(definition)
        ));
      }

      pC.definitionsOrder.add(definitionInsertId);
      pC.definitionRelCompanions.add(KanjiBankV3_X_DefinitionTableCompanion(
        kanjiId: Value(pC.maxKanjiBankId), definitionId: Value(definitionInsertId)
      ));
    
    }
  }
}

/// Parses the given `stats` from a kanji_bank dictionary
/// 
/// Caution: the results are store in the given `refs`
Future<void> parseStats(Map<String, String> stats, KanjiBankV3ParserContext pC, DaKanjiDB db) async {

  if(stats.isNotEmpty){

    for (MapEntry<String, String> stat in stats.entries) {

      pC.maxStatsId += 1;
      
      int? statValueInsertId = pC.statValuesInDB[stat.value];
      if(statValueInsertId == null){
        statValueInsertId = ++pC.maxStatValuesId;
        pC.statValuesInDB[stat.value] = statValueInsertId;

        pC.statValuesCompanions.add(KanjiBankV3StatValuesTableCompanion(
          id: Value(statValueInsertId),
          statValue: Value(stat.value)
        ));
      }
      
      int? statNameInsertId = pC.statNamesInDB[stat.key];
      if(statNameInsertId == null){
        statNameInsertId = ++pC.maxStatNamesId;
        pC.statNamesInDB[stat.key] = statNameInsertId;

        pC.statNamesCompanions.add(KanjiBankV3StatNamesTableCompanion(
          id: Value(statNameInsertId),
          statName: Value(stat.key)
        ));
      }

      pC.statCompanions.add(KanjiBankV3StatsTableCompanion(
        id: Value(pC.maxStatsId),
        statNameId: Value(statNameInsertId),
        statValueId: Value(statValueInsertId),
      ));
      pC.statValueRelCompanions.add(KanjiBankV3_X_KanjiBankV3StatsTableCompanion(
        kanjiId: Value(pC.maxKanjiBankId),
        statId: Value(pC.maxStatsId),
      ));
    
    }
  }
}
