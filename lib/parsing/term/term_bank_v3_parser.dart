// Dart imports:
import 'dart:convert';

// Package imports:
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
  
  // store data in list to bulk add them
  List<TermTableCompanion> termComps = [];
  List<ReadingTableCompanion> readingComps = [];
  List<TermBankV3TableCompanion> termBankComps = [];
  List<TermBankV3DefinitionTagsTableCompanion> definitionTagComps = [];
  List<TermBankV3DefinitionTagRelationsTableCompanion> definitionTagRelComps = [];
  List<TermBankV3RuleIdentifierTableCompanion> ruleIdentifiersComps = [];
  List<TermBankV3RuleIdentifierRelationsTableCompanion> ruleIdentifiersTelComps = [];

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
        int defTagInsertId = allDefTags[jsonEntry[2]] ?? ++currentMaxDefTagId;
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
      for (var ruleDef in jsonEntry[3].split(" ")) {
        // get tag from DB
        int ruleDefInsertId = allRuleIdentifiers[jsonEntry[3]] ?? ++currentMaxRuleIdentifiersId;
        if(allDefTags[ruleDef] == null){
          allDefTags[ruleDef] = ruleDefInsertId;
          ruleIdentifiersComps.add(TermBankV3RuleIdentifierTableCompanion(
            id: Value(ruleDefInsertId),
            ruleIdentifier: Value(ruleDef)
          ));
        }
        // create relationship
        ruleIdentifiersTelComps.add(TermBankV3RuleIdentifierRelationsTableCompanion(
          ruleIdentifierId: Value(ruleDefInsertId),
          termBankId: Value(currentMaxTermBankId)
        ));
      }
    }

    // TODO definitions

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
    batch.insertAll(db.termBankV3RuleIdentifierRelationsTable, ruleIdentifiersTelComps);
  },);

}

