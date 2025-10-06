// Dart imports:
import 'dart:convert';

import 'package:dakanji_db_core/parsing/term/term_bank_v3_parser_import_context.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

import 'structured_content/parsed_term.dart';
import 'structured_content/structured_content_parser.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';



/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3File(
  File termMetaBankFile,
  TermBankV3ParserImportContext importContext,
  DaKanjiDB db,
  int dictId,
  bool addFullJsonDefinitions,
  Mecab mecab) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermBankV3(termMetaBankJson, importContext, db, dictId, addFullJsonDefinitions, mecab);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3(
  String termMetaBankJson,
  TermBankV3ParserImportContext iC,
  DaKanjiDB db,
  int dictId,
  bool addFullJsonDefinitions,
  Mecab mecab) async {

  // decode json
  Stopwatch s = Stopwatch()..start();
  List jsonList = jsonDecode(termMetaBankJson);
  //print("Decoded JSON in ${s.elapsedMilliseconds}ms");

  // lists to store all parsed data for insert
  List<TermBankV3TableCompanion> termBankComps = [];
  List<TermBankV3DefinitionJsonTableCompanion> termBankDefJsonComps = [];
  List<TermTableCompanion> termComps = [];
  List<ReadingTableCompanion> readingComps = [];
  List<TermBankV3DefinitionTagsTableCompanion> definitionTagComps = [];
  List<TermBankV3_X_DefinitionTagTableCompanion> definitionTagRelComps = [];
  List<TermBankV3RuleIdentifierTableCompanion> ruleIdentifiersComps = [];
  List<TermBankV3_X_RuleIdentifierTableCompanion> ruleIdentifiersRelComps = [];
  List<DefinitionTableCompanion> definitionComps = [];
  List<TermBankV3_X_DefinitionTableCompanion> definitionRelComps = [];
  List<TermBankV3_X_TagBankTableCompanion> tagRelComps = [];


  // --- parse the entires
  s..reset()..start();
  for (var jsonEntry in jsonList) {

    iC.currentMaxTermBankId++;

    // parse term
    int termInsertId = iC.allTerms[jsonEntry[0]] ?? ++iC.currentMaxTermId;
    String term = jsonEntry[0];
    if(iC.allTerms[term] == null){
      iC.allTerms[term] = termInsertId;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(term),
        termTokens: Value(() {
          List<String> tokens = mecab.parse(term).map((e) => e.surface).toList();
          tokens = tokens.sublist(0, tokens.length-1);
          String joinedTokens = tokens.join(" ");
          return joinedTokens == term ? null : joinedTokens;
        } ())
      ));
    }

    // parse reading
    int readingInsertId = iC.allReadings[jsonEntry[1]] ?? ++iC.currentMaxReadingId;
    if(iC.allReadings[jsonEntry[1]] == null){
      iC.allReadings[jsonEntry[1]] = readingInsertId;
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
        int defTagInsertId = iC.allDefTags[defTag] ?? ++iC.currentMaxDefTagId;
        if(iC.allDefTags[defTag] == null){
          iC.allDefTags[defTag] = defTagInsertId;
          definitionTagComps.add(TermBankV3DefinitionTagsTableCompanion(
            id: Value(defTagInsertId),
            definitionTag: Value(defTag)
          ));
        }
        // create relationship
        definitionTagRelComps.add(TermBankV3_X_DefinitionTagTableCompanion(
          definitionTagId: Value(defTagInsertId),
          termBankId: Value(iC.currentMaxTermBankId)
        ));
      }
    }

    // parse rule identifiers
    List<String> ruleIds = jsonEntry[3].split(" ");
    if(jsonEntry[3] != ""){
      for (var ruleId in ruleIds) {
        // get id from DB
        int ruleIdInsertId = iC.allRuleIdentifiers[ruleId] ?? ++iC.currentMaxRuleIdentifiersId;
        if(iC.allRuleIdentifiers[ruleId] == null){
          iC.allRuleIdentifiers[ruleId] = ruleIdInsertId;
          ruleIdentifiersComps.add(TermBankV3RuleIdentifierTableCompanion(
            id: Value(ruleIdInsertId),
            ruleIdentifier: Value(ruleId)
          ));
        }
        // create relationship
        ruleIdentifiersRelComps.add(TermBankV3_X_RuleIdentifierTableCompanion(
          ruleIdentifierId: Value(ruleIdInsertId),
          termBankId: Value(iC.currentMaxTermBankId)
        ));
      }
    }

    // Parse definitions
    List<ParsedTerm> parsedDefinitions = extractPlainTextDefinitions(jsonEntry[5]);
    List<int> definitionIds = [];
    for (var parsedDefinition in parsedDefinitions) {
      // escape special characters
      String text = parsedDefinition.text.replaceAll(RegExp(r'[\s\u00A0]+'), ' ').trim();
      // check if term is already in DB
      int definitionInsertId = iC.allDefinitions[text] ?? ++iC.currentMaxdefinitionId;
      if(iC.allDefinitions[text] == null){
        iC.allDefinitions[text] = definitionInsertId;
        definitionComps.add(DefinitionTableCompanion(
          id: Value(definitionInsertId),
          definition: Value(text)
        ));
      }
      definitionIds.add(definitionInsertId);
      // create relationship
      definitionRelComps.add(TermBankV3_X_DefinitionTableCompanion(
        definitionId: Value(definitionInsertId),
        termBankId: Value(iC.currentMaxTermBankId)
      ));
    }

    // Optionally: add full definition json to DB
    if(addFullJsonDefinitions) {
      iC.currentMaxDefinitionJsonId += 1;
      termBankDefJsonComps.add(TermBankV3DefinitionJsonTableCompanion(
        id: Value(iC.currentMaxDefinitionJsonId),
        definitionJson: Value(jsonEncode(jsonEntry[5]))
      ));
    }

    // create tag relations
    if(jsonEntry[7] != ""){
      for (var tag in jsonEntry[7].split(" ")) {
        // create relationship
        tagRelComps.add(TermBankV3_X_TagBankTableCompanion(
          tagBankId: Value(iC.allTags[tag]),
          termBankId: Value(iC.currentMaxTermBankId)
        ));
      }
    }

    // create TermBankEntry
    termBankComps.add(TermBankV3TableCompanion(
      id: Value(iC.currentMaxTermBankId),
      indexId: Value(dictId),
      termId: Value(termInsertId),
      definitionOrder: Value(definitionIds),
      definitionJsonId: Value(iC.currentMaxDefinitionJsonId),
      readingId: Value(readingInsertId),
      popularity: Value(jsonEntry[4]),
      sequenceNumber: Value(jsonEntry[6])
    ));
  }
  //print("Parsed ${jsonList.length} entries in ${s.elapsedMilliseconds}ms");

  // bulk insert all data
  s..reset()..start();
  await db.batch((batch) {

    batch.insertAll(db.termTable, termComps);
    batch.insertAll(db.readingTable, readingComps);

    batch.insertAll(db.termBankV3Table, termBankComps);
    batch.insertAll(db.termBankV3DefinitionJsonTable, termBankDefJsonComps);

    batch.insertAll(db.termBankV3DefinitionTagsTable, definitionTagComps);
    batch.insertAll(db.termBankV3XDefinitionTagTable, definitionTagRelComps);

    batch.insertAll(db.termBankV3RuleIdentifierTable, ruleIdentifiersComps);
    batch.insertAll(db.termBankV3XRuleIdentifierTable, ruleIdentifiersRelComps);

    batch.insertAll(db.definitionTable, definitionComps);
    batch.insertAll(db.termBankV3XDefinitionTable, definitionRelComps);

    batch.insertAll(db.termBankV3XTagBankTable, tagRelComps);
  },);
  //print("Inserted all entries in ${s.elapsedMilliseconds}ms");
}
