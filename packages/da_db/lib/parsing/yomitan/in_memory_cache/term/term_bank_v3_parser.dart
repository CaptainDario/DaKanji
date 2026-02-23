// Dart imports:
import 'dart:convert';

import 'package:da_db/parsing/yomitan/in_memory_cache/term/definition_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term/definition_parsing_classes.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term/term_bank_v3_parser_context.dart';
import 'package:drift/drift.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/language_processing.dart';
import 'package:universal_io/io.dart';

import '/database/da_db.dart';


/// Debug printing
bool d = true;

/// Parses the given TermMetaBank and adds it to the given [DaDb]
Future parseTermBankV3File(
  File termMetaBankFile,
  TermBankV3ParserContext pC,
  DaDb db,
  int dictId,
addFullJsonDefinitions) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermBankV3(termMetaBankJson, pC, db, dictId);

}

/// Parses the given TermMetaBank and adds it to the given [DaDb]
Future parseTermBankV3(
  String termMetaBankJson,
  TermBankV3ParserContext pC,
  DaDb db,
  int indexId,
) async {

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
  KanaKit k = KanaKit();
  for (var jsonEntry in jsonList) {

    pC.currentMaxTermBankId++;

    // parse term
    int termInsertId = pC.allTerms[jsonEntry[0]] ?? ++pC.currentMaxTermId;
    String term = jsonEntry[0];
    if(pC.allTerms[term] == null){
      pC.allTerms[term] = termInsertId;

      String? termNormalized = db.languageProcessor.normalize(term, ProcessorOptions()).firstOrNull;
      String? termTokens = term.isNotEmpty && k.isJapanese(term)
        ? db.languageProcessor.segment(term)
        : null;
      String? termTokensNormalized = termTokens==null
        ? null
        : db.languageProcessor.normalize(termTokens, ProcessorOptions()).firstOrNull;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(term),
        termNormalized: termNormalized!=term && termNormalized!=null
          ? Value(termNormalized)
          : const Value.absent(),
      ));
    }

    // parse reading
    int readingInsertId = pC.allReadings[jsonEntry[1]] ?? ++pC.currentMaxReadingId;
    if(pC.allReadings[jsonEntry[1]] == null){
      pC.allReadings[jsonEntry[1]] = readingInsertId;

      String? readingNormalized = db.languageProcessor.normalize(jsonEntry[1], ProcessorOptions()).firstOrNull;
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
        int tagInsertId = pC.allTags[defTag] ?? ++pC.currentMaxTagId;
        if(pC.allTags[defTag] == null){
          // add new tag to map
          pC.allTags[defTag] = tagInsertId;
          // insert tag
          tagComps.add(TagBankV3TableCompanion(
            id: Value(tagInsertId),
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
          definitionTagId: Value(tagInsertId),
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
    ParsedDefinitions? parsedDefinitions = YomitanDefinitionParser.parse(jsonEntry[5]);
    for (String parsedDefinition in parsedDefinitions.definitions) {
      // escape special characters
      String text = parsedDefinition.replaceAll(RegExp(r'[\s\u00A0]+'), ' ').trim();
      // check if term is already in DB
      int definitionInsertId = pC.allDefinitions[text] ?? ++pC.currentMaxdefinitionId;
      if(pC.allDefinitions[text] == null){
        pC.allDefinitions[text] = definitionInsertId;
        definitionComps.add(DefinitionTableCompanion(
          id: Value(definitionInsertId),
          definition: Value(text)
        ));
      }
      // create relationship
      definitionRelComps.add(TermBankV3_X_DefinitionTableCompanion(
        definitionId: Value(definitionInsertId),
        termBankId: Value(pC.currentMaxTermBankId)
      ));
    }

    // Optionally: add full definition json to DB
    int? jsonDefInsertId;
    String jsonString = jsonEncode(jsonEntry[5]);
    
    // Check if we already have this JSON in our new cache
    if (pC.allDefinitionJsons.containsKey(jsonString)) {
      jsonDefInsertId = pC.allDefinitionJsons[jsonString]!;
    } else {
      // Increment max ID, add to cache, and add to insert list
      jsonDefInsertId = ++pC.currentMaxDefinitionJsonId;
      pC.allDefinitionJsons[jsonString] = jsonDefInsertId;
      
      termBankDefJsonComps.add(TermBankV3DefinitionJsonTableCompanion(
        id: Value(jsonDefInsertId),
        definitionJson: Value(jsonString)
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
      definitionJsonId: jsonDefInsertId == null ? Value.absent() : Value(jsonDefInsertId),
      readingId: Value(readingInsertId),
      popularity: Value(jsonEntry[4]),
      sequenceNumber: Value(jsonEntry[6])
    ));
  }
  if(d) print("Parsed ${jsonList.length} entries in ${s.elapsedMilliseconds}ms");

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

    batch.insertAll(db.tagBankV3Table, tagComps);
    batch.insertAll(db.termBankV3XTagBankTable, tagRelComps);
  },);
  if(d) print("Inserted all entries in ${s.elapsedMilliseconds}ms");
}
