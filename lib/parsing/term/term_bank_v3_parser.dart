// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dakanji_db/parsing/term/structured_content_parser.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3File(File termMetaBankFile, DaKanjiDB db, int dictId) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermBankV3(termMetaBankJson, db, dictId);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3(String termMetaBankJson, DaKanjiDB db, int dictId) async {

  // decode json
  List jsonList = jsonDecode(termMetaBankJson);
  
  // read all necessary data from the db
  int currentMaxTermBankId = await db.termBankV3Dao.maxTermBankV3Id();
  int currentMaxTermId = await db.termDao.maxTermId();
  Map allTerms =
    { for (var e in await db.termDao.getAllTerms()) e.term : e.id };
  int currentMaxReadingId = await db.readingDao.maxReadingId();
  Map allReadings =
    { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id };
  int currentMaxDefTagId = await db.termBankV3Dao.maxTermBankV3DefinitionTagId();
  Map allDefTags =
    { for (var e in await db.termBankV3Dao.getAllDefinitionTags()) e.definitionTag : e.id };
  int currentMaxRuleIdentifiersId = await db.termBankV3Dao.maxTermBankV3RuleIdentifierId();
  Map allRuleIdentifiers =
    { for (var e in await db.termBankV3Dao.getAllRuleIdentifiers()) e.ruleIdentifier : e.id };
  int currentMaxMeaningId = await db.meaningDao.maxMeaningId();
  Map allMeanings =
    { for (var e in await db.meaningDao.getAllMeanings()) e.meaning : e.id };
  // tags are parsed from the meta bank and thus are already present
  Map allTags =
    { for (var e in await db.termBankV3Dao.getAllTags()) e.name : e.id };
  
  // store data in list to bulk add them
  List<TermTableCompanion> termComps = [];
  List<ReadingTableCompanion> readingComps = [];
  List<TermBankV3TableCompanion> termBankComps = [];
  List<TermBankV3DefinitionTagsTableCompanion> definitionTagComps = [];
  List<TermBankV3DefinitionTagRelationsTableCompanion> definitionTagRelComps = [];
  List<TermBankV3RuleIdentifierTableCompanion> ruleIdentifiersComps = [];
  List<TermBankV3RuleIdentifierRelationsTableCompanion> ruleIdentifiersRelComps = [];
  List<MeaningTableCompanion> meaningComps = [];
  List<TermBankV3MeaningsRelationsTableCompanion> meaningRelComps = [];
  List<TermBankV3TagBankRelationsTableCompanion> tagRelComps = [];

  // parse the entires
  for (var jsonEntry in jsonList) {

    currentMaxTermBankId++;

    // parse term
    int termInsertId = allTerms[jsonEntry[0]] ?? ++currentMaxTermId;
    if(allTerms[jsonEntry[0]] == null){
      allTerms[jsonEntry[0]] = termInsertId;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(jsonEntry[0])
      ));
    }

    // parse reading
    int readingInsertId = allReadings[jsonEntry[1]] ?? ++currentMaxReadingId;
    if(allReadings[jsonEntry[1]] == null){
      allReadings[jsonEntry[1]] = readingInsertId;
      readingComps.add(ReadingTableCompanion(
        id: Value(readingInsertId),
        reading: Value(jsonEntry[1])
      ));
    }

    // parse definition tags
    if(jsonEntry[2] != ""){
      for (var defTag in jsonEntry[2].split(" ")) {
        // get tag from DB
        int defTagInsertId = allDefTags[defTag] ?? ++currentMaxDefTagId;
        if(allDefTags[defTag] == null){
          allDefTags[defTag] = defTagInsertId;
          definitionTagComps.add(TermBankV3DefinitionTagsTableCompanion(
            id: Value(defTagInsertId),
            definitionTag: Value(defTag)
          ));
        }
        // create relationship
        definitionTagRelComps.add(TermBankV3DefinitionTagRelationsTableCompanion(
          definitionTagId: Value(defTagInsertId),
          termBankId: Value(currentMaxTermBankId)
        ));
      }
    }

    // parse rule identifiers
    if(jsonEntry[3] != ""){
      for (var ruleId in jsonEntry[3].split(" ")) {
        // get tag from DB
        int ruleIdInsertId = allRuleIdentifiers[ruleId] ?? ++currentMaxRuleIdentifiersId;
        if(allRuleIdentifiers[ruleId] == null){
          allRuleIdentifiers[ruleId] = ruleIdInsertId;
          ruleIdentifiersComps.add(TermBankV3RuleIdentifierTableCompanion(
            id: Value(ruleIdInsertId),
            ruleIdentifier: Value(ruleId)
          ));
        }
        // create relationship
        ruleIdentifiersRelComps.add(TermBankV3RuleIdentifierRelationsTableCompanion(
          ruleIdentifierId: Value(ruleIdInsertId),
          termBankId: Value(currentMaxTermBankId)
        ));
      }
    }

    // Parse definitions
    List<String> parsedDefinition = extractPlainTextDefinitions(jsonEntry)
      .map((e) => e.text)
      .toList();
    for (var definition in parsedDefinition) {
        // get tag from DB
        int meaningInsertId = allMeanings[definition] ?? ++currentMaxMeaningId;
        if(allMeanings[definition] == null){
          allMeanings[definition] = meaningInsertId;
          meaningComps.add(MeaningTableCompanion(
            id: Value(meaningInsertId),
            meaning: Value(definition)
          ));
        }
        // create relationship
        meaningRelComps.add(TermBankV3MeaningsRelationsTableCompanion(
          meaningId: Value(meaningInsertId),
          termBankId: Value(currentMaxTermBankId)
        ));
      }

    // create tag relations
    if(jsonEntry[7] != ""){
      for (var tag in jsonEntry[7].split(" ")) {
        // create relationship
        tagRelComps.add(TermBankV3TagBankRelationsTableCompanion(
          tagBankId: Value(allTags[tag]),
          termBankId: Value(currentMaxTermBankId)
        ));
      }
    }

    // create TermBankEntry
    termBankComps.add(TermBankV3TableCompanion(
      id: Value(currentMaxTermBankId),
      termId: Value(termInsertId),
      readingId: Value(readingInsertId),
      popularity: Value(jsonEntry[4]),
      sequenceNumber: Value(jsonEntry[6])
    ));
  }

  // bulk insert all data
  await db.batch((batch) {
    batch.insertAll(db.termTable, termComps);
    batch.insertAll(db.readingTable, readingComps);

    batch.insertAll(db.termBankV3Table, termBankComps);

    batch.insertAll(db.termBankV3DefinitionTagsTable, definitionTagComps);
    batch.insertAll(db.termBankV3DefinitionTagRelationsTable, definitionTagRelComps);

    batch.insertAll(db.termBankV3RuleIdentifierTable, ruleIdentifiersComps);
    batch.insertAll(db.termBankV3RuleIdentifierRelationsTable, ruleIdentifiersRelComps);

    batch.insertAll(db.meaningTable, meaningComps);
    batch.insertAll(db.termBankV3MeaningsRelationsTable, meaningRelComps);

    batch.insertAll(db.termBankV3TagBankRelationsTable, tagRelComps);
  },);

}
