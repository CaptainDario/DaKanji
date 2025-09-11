// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:language_processing/japanese/conjugation/conjugate.dart';
import 'package:language_processing/japanese/conjugation/conjugation_data/conj.dart';
import 'package:language_processing/japanese/conjugation/conjugation_data/kwpos.dart';

import 'parsed_term.dart';
import 'structured_content_parser.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';



/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3File(
  File termMetaBankFile,
  DaKanjiDB db,
  int dictId,
  bool addFullJsonDefinitions) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermBankV3(termMetaBankJson, db, dictId, addFullJsonDefinitions);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3(
  String termMetaBankJson,
  DaKanjiDB db,
  int dictId,
  bool addFullJsonDefinitions) async {

  // decode json
  List jsonList = jsonDecode(termMetaBankJson);
  
  // read all necessary data from the db
  int currentMaxTermBankId = await db.termBankV3Dao.maxTermBankV3Id();
  List<TermBankV3TableCompanion> termBankComps = [];

  int currentMaxTermId = await db.termDao.maxTermId();
  Map allTerms =
    { for (var e in await db.termDao.getAllTerms()) e.term : e.id };
  List<TermTableCompanion> termComps = [];
  
  int currentMaxConjugationId = await db.conjugationDao.maxConjugationsId();
  Map allConjugations =
    { for (var e in await db.conjugationDao.getAllConjugations()) e.conjugation : e.id };
  List<ConjugationTableCompanion> conjugationComps = [];
  List<ConjugationXTermTableCompanion> conjugationsXTermComps = [];

  int currentMaxReadingId = await db.readingDao.maxReadingId();
  Map allReadings =
    { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id };
  List<ReadingTableCompanion> readingComps = [];
  
  int currentMaxDefTagId = await db.termBankV3Dao.maxTermBankV3DefinitionTagId();
  Map allDefTags =
    { for (var e in await db.termBankV3Dao.getAllDefinitionTags()) e.definitionTag : e.id };
  List<TermBankV3DefinitionTagsTableCompanion> definitionTagComps = [];
  List<TermBankV3DefinitionTagRelationsTableCompanion> definitionTagRelComps = [];

  int currentMaxRuleIdentifiersId = await db.termBankV3Dao.maxTermBankV3RuleIdentifierId();
  Map allRuleIdentifiers =
    { for (var e in await db.termBankV3Dao.getAllRuleIdentifiers()) e.ruleIdentifier : e.id };
  List<TermBankV3RuleIdentifierTableCompanion> ruleIdentifiersComps = [];
  List<TermBankV3RuleIdentifierRelationsTableCompanion> ruleIdentifiersRelComps = [];

  int currentMaxDefinitionJsonId = await db.termBankV3Dao.maxTermBankV3DefinitionJsonId();
  List<TermBankV3DefinitionJsonTableCompanion> termBankDefJsonComps = [];

  int currentMaxdefinitionId = await db.definitionDao.maxDefinitionId();
  Map allDefinitions =
    { for (var e in await db.definitionDao.getAllDefinitions()) e.definition : e.id };
  List<DefinitionTableCompanion> definitionComps = [];
  List<TermBankV3DefinitionsRelationsTableCompanion> definitionRelComps = [];

  // tags are parsed from the meta bank and thus are ALWAYS in the DB
  Map allTags =
    { for (var e in await db.termBankV3Dao.getAllTags()) e.name : e.id };
  List<TermBankV3TagBankRelationsTableCompanion> tagRelComps = [];


  // --- parse the entires
  for (var jsonEntry in jsonList) {

    currentMaxTermBankId++;

    // parse term
    int termInsertId = allTerms[jsonEntry[0]] ?? ++currentMaxTermId;
    String term = jsonEntry[0];
    if(allTerms[term] == null){
      allTerms[term] = termInsertId;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(term)
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
    List<String> defTags = jsonEntry[2].split(" ");
    if(jsonEntry[2] != ""){
      for (var defTag in defTags) {
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
    List<String> ruleIds = jsonEntry[3].split(" ");
    if(jsonEntry[3] != ""){
      for (var ruleId in ruleIds) {
        // get id from DB
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

    // add conjugations if there are any
    print(ruleIds);
    for (String ruleId in ruleIds) {
      Pos? pos = posStringToPosEnum[ruleId];
      if(pos == null) continue;

      List<String> conjos = getAllConjugations(term, pos);
      for (String conjo in conjos) {
        int conjoInsertId = allConjugations[conjo] ?? ++currentMaxConjugationId;
        if(allConjugations[conjo] == null){
          allConjugations[conjo] = conjoInsertId;
          conjugationComps.add(ConjugationTableCompanion(
            id: Value(conjoInsertId),
            conjugation: Value(conjo)
          ));
        }
        // create relationships
        conjugationsXTermComps.add(ConjugationXTermTableCompanion(
          conjugationId: Value(conjoInsertId),
          termId: Value(termInsertId)
        ));
      }
    }

    // Parse definitions
    List<ParsedTerm> parsedDefinitions = extractPlainTextDefinitions(jsonEntry);
    List<int> definitionIds = [];
    for (var parsedDefinition in parsedDefinitions) {
      String text = parsedDefinition.text;
      // check if term is already in DB
      int definitionInsertId = allDefinitions[text] ?? ++currentMaxdefinitionId;
      if(allDefinitions[text] == null){
        allDefinitions[text] = definitionInsertId;
        definitionComps.add(DefinitionTableCompanion(
          id: Value(definitionInsertId),
          definition: Value(text)
        ));
      }
      definitionIds.add(definitionInsertId);
      // create relationship
      definitionRelComps.add(TermBankV3DefinitionsRelationsTableCompanion(
        definitionId: Value(definitionInsertId),
        termBankId: Value(currentMaxTermBankId)
      ));
    }

    // Optionally: add full definition json to DB
    if(addFullJsonDefinitions) {
      currentMaxDefinitionJsonId += 1;
      termBankDefJsonComps.add(TermBankV3DefinitionJsonTableCompanion(
        id: Value(currentMaxDefinitionJsonId),
        definitionJson: Value(jsonEncode(jsonEntry[5]))
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
      definitionOrder: Value(definitionIds),
      definitionJsonId: Value(currentMaxDefinitionJsonId),
      readingId: Value(readingInsertId),
      popularity: Value(jsonEntry[4]),
      sequenceNumber: Value(jsonEntry[6])
    ));
  }

  // bulk insert all data
  await db.batch((batch) {
    batch.insertAll(db.termTable, termComps);
    batch.insertAll(db.readingTable, readingComps);

    batch.insertAll(db.conjugationTable, conjugationComps);
    batch.insertAll(db.conjugationXTermTable, conjugationsXTermComps);

    batch.insertAll(db.termBankV3Table, termBankComps);
    batch.insertAll(db.termBankV3DefinitionJsonTable, termBankDefJsonComps);

    batch.insertAll(db.termBankV3DefinitionTagsTable, definitionTagComps);
    batch.insertAll(db.termBankV3DefinitionTagRelationsTable, definitionTagRelComps);

    batch.insertAll(db.termBankV3RuleIdentifierTable, ruleIdentifiersComps);
    batch.insertAll(db.termBankV3RuleIdentifierRelationsTable, ruleIdentifiersRelComps);

    batch.insertAll(db.definitionTable, definitionComps);
    batch.insertAll(db.termBankV3DefinitionsRelationsTable, definitionRelComps);

    batch.insertAll(db.termBankV3TagBankRelationsTable, tagRelComps);
  },);

}
