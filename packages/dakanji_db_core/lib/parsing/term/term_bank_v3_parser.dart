// Dart imports:
import 'dart:convert';

import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart';
import 'package:dakanji_db_core/parsing/term/term_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

import '/database/dakanji_db.dart';
import 'structured_content/parsed_term.dart';
import 'structured_content/structured_content_parser.dart';



/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3File(
  File termMetaBankFile,
  TermBankV3ParserContext pC,
  DaKanjiDB db,
  int dictId,
  bool addFullJsonDefinitions,
  Mecab mecab) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermBankV3(termMetaBankJson, pC, db, dictId, addFullJsonDefinitions, mecab);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermBankV3(
  String termMetaBankJson,
  TermBankV3ParserContext pC,
  DaKanjiDB db,
  int indexId,
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
  List<TermBankV3_X_DefinitionTagTableCompanion> definitionTagRelComps = [];
  List<TermBankV3RuleIdentifierTableCompanion> ruleIdentifiersComps = [];
  List<TermBankV3_X_RuleIdentifierTableCompanion> ruleIdentifiersRelComps = [];
  List<DefinitionTableCompanion> definitionComps = [];
  List<TermBankV3_X_DefinitionTableCompanion> definitionRelComps = [];
  List<TagBankV3TableCompanion> tagComps = [];
  List<TermBankV3_X_TagBankTableCompanion> tagRelComps = [];


  // --- parse the entires
  s..reset()..start();
  for (var jsonEntry in jsonList) {

    pC.currentMaxTermBankId++;

    // parse term
    int termInsertId = pC.allTerms[jsonEntry[0]] ?? ++pC.currentMaxTermId;
    String term = jsonEntry[0];
    if(pC.allTerms[term] == null){
      pC.allTerms[term] = termInsertId;

      String? termNormalized = preprocessInput(term, false).normalizedTerms.firstOrNull;
      String? termTokens = getMecabSurfacesOrNull(mecab, term);
      String? termTokensNormalized = termTokens==null
        ? null
        : preprocessInput(termTokens, false).normalizedTerms.firstOrNull;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(term),
        termNormalized: termNormalized!=term && termNormalized!=null
          ? Value(termNormalized)
          : const Value.absent(),
        termTokens: termTokens != term && termTokens!=null
          ? Value(termTokens)
          : const Value.absent(),
        termTokensNormalized: termTokensNormalized!=termTokens && termTokensNormalized!=null
          ? Value(termTokensNormalized)
          : const Value.absent(),
      ));
    }

    // parse reading
    int readingInsertId = pC.allReadings[jsonEntry[1]] ?? ++pC.currentMaxReadingId;
    if(pC.allReadings[jsonEntry[1]] == null){
      pC.allReadings[jsonEntry[1]] = readingInsertId;

      String? readingNormalized = preprocessInput(jsonEntry[1], false).normalizedTerms.firstOrNull;
      readingComps.add(ReadingTableCompanion(
        id: Value(readingInsertId),
        reading: Value(jsonEntry[1]),
        readingNormalized: readingNormalized!=jsonEntry[1] && readingNormalized!=null
          ? Value(readingNormalized)
          : const Value.absent()
      ));
    }

    // parse definition tags
    List<String> defTags = jsonEntry[2].split(" ");
    if(jsonEntry[2] != ""){
      for (var defTag in defTags) {
        if(pC.allTags[defTag] == null){
          // add new tag to map
          pC.allTags[defTag] = ++pC.currentMaxTagId;
          // insert tag
          tagComps.add(TagBankV3TableCompanion(
            id: Value(pC.currentMaxTagId),
            indexId: Value(indexId),
            name: Value(defTag),
            category: Value(""),
            sortingOrder: Value(0),
            notes: Value(""),
            score: Value(0)
          ));
        }
        // create relationship
        definitionTagRelComps.add(TermBankV3_X_DefinitionTagTableCompanion(
          definitionTagId: Value(pC.allTags[defTag]!),
          termBankId: Value(pC.currentMaxTermBankId)
        ));
      }
    }

    // parse rule identifiers
    List<String> ruleIds = jsonEntry[3].split(" ");
    if(jsonEntry[3] != ""){
      for (var ruleId in ruleIds) {
        // get id from DB
        int ruleIdInsertId = pC.allRuleIdentifiers[ruleId] ?? ++pC.currentMaxRuleIdentifiersId;
        if(pC.allRuleIdentifiers[ruleId] == null){
          pC.allRuleIdentifiers[ruleId] = ruleIdInsertId;
          ruleIdentifiersComps.add(TermBankV3RuleIdentifierTableCompanion(
            id: Value(ruleIdInsertId),
            ruleIdentifier: Value(ruleId)
          ));
        }
        // create relationship
        ruleIdentifiersRelComps.add(TermBankV3_X_RuleIdentifierTableCompanion(
          ruleIdentifierId: Value(ruleIdInsertId),
          termBankId: Value(pC.currentMaxTermBankId)
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
      int definitionInsertId = pC.allDefinitions[text] ?? ++pC.currentMaxdefinitionId;
      if(pC.allDefinitions[text] == null){
        pC.allDefinitions[text] = definitionInsertId;
        definitionComps.add(DefinitionTableCompanion(
          id: Value(definitionInsertId),
          definition: Value(text)
        ));
      }
      definitionIds.add(definitionInsertId);
      // create relationship
      definitionRelComps.add(TermBankV3_X_DefinitionTableCompanion(
        definitionId: Value(definitionInsertId),
        termBankId: Value(pC.currentMaxTermBankId)
      ));
    }

    // Optionally: add full definition json to DB
    if(addFullJsonDefinitions) {
      pC.currentMaxDefinitionJsonId += 1;
      termBankDefJsonComps.add(TermBankV3DefinitionJsonTableCompanion(
        id: Value(pC.currentMaxDefinitionJsonId),
        definitionJson: Value(jsonEncode(jsonEntry[5]))
      ));
    }

    // create tag relations
    if(jsonEntry[7] != ""){
      for (var tag in jsonEntry[7].split(" ")) {
        // create relationship
        tagRelComps.add(TermBankV3_X_TagBankTableCompanion(
          tagBankId: Value(pC.allTags[tag]!),
          termBankId: Value(pC.currentMaxTermBankId)
        ));
      }
    }

    // create TermBankEntry
    termBankComps.add(TermBankV3TableCompanion(
      id: Value(pC.currentMaxTermBankId),
      indexId: Value(indexId),
      termId: Value(termInsertId),
      definitionOrder: Value(definitionIds),
      definitionJsonId: Value(pC.currentMaxDefinitionJsonId),
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

    batch.insertAll(db.termBankV3XDefinitionTagTable, definitionTagRelComps);

    batch.insertAll(db.termBankV3RuleIdentifierTable, ruleIdentifiersComps);
    batch.insertAll(db.termBankV3XRuleIdentifierTable, ruleIdentifiersRelComps);

    batch.insertAll(db.definitionTable, definitionComps);
    batch.insertAll(db.termBankV3XDefinitionTable, definitionRelComps);

    batch.insertAll(db.termBankV3XTagBankTable, tagRelComps);
  },);
  //print("Inserted all entries in ${s.elapsedMilliseconds}ms");
}
