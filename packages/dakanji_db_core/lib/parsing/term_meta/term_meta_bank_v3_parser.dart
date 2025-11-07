// Dart imports:
import 'dart:convert';

import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart';
import 'package:dakanji_db_core/parsing/term_meta/term_meta_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

import '/database/dakanji_db.dart';

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermMetaBankV3File(
  File termMetaBankFile,
  TermMetaBankV3ParserContext pC,
  DaKanjiDB db,
  int indexId,
  Mecab mecab
) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermMetaBankV3(termMetaBankJson, pC, db, indexId, mecab);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermMetaBankV3(
  String termMetaBankJson,
  TermMetaBankV3ParserContext pC,
  DaKanjiDB db,
  int indexId,
  Mecab mecab
) async {

  // decode json
  List jsonList = jsonDecode(termMetaBankJson);
  
  // store data in list to bulk add them
  List<TermTableCompanion> termComps = [];
  List<TermMetaBankV3TableCompanion> termMetaBankComps = [];
  List<TermMetaBankV3TypeTableCompanion> termMetaBankTypeComps = [];
  List<ReadingTableCompanion> readingComps = [];
  List<TermMetaBankV3TagTableCompanion> termMetaBankV3TagTableComps = [];

  List<TermMetaBankV3IpaTableCompanion> termMetaBankIpaComps = [];
  List<TermMetaBankV3_X_IpaTagTableCompanion> termMetaBankIpaTagRelsComps = [];
  List<TermMetaBankV3_X_IpaTableCompanion> termMetaBankIpaRelsComps = [];

  List<TermMetaBankV3PitchTableCompanion> termMetaBankPitchComps = [];
  List<TermMetaBankV3_X_PitchTagTableCompanion> termMetaBankPitchTagRelsComps = [];
  List<TermMetaBankV3_X_PitchTableCompanion> termMetaBankPitchRelsComps = [];

  // parse the entires
  for (var jsonEntry in jsonList) {
    pC.currentMaxTermMetaId++;

    // parse term
    String term = jsonEntry[0];
    int termInsertId = pC.allTerms[term] ?? ++pC.currentMaxTermId;
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

    // parse type
    int typeInsertId = pC.allTypes[jsonEntry[1]] ?? ++pC.currentMaxTypeId;
    if(pC.allTypes[jsonEntry[1]] == null){
      pC.allTypes[jsonEntry[1]] = typeInsertId;
      termMetaBankTypeComps.add(TermMetaBankV3TypeTableCompanion(
        id: Value(typeInsertId),
        type: Value(jsonEntry[1])
      ));
    }
    
    String? reading; int? freqValue; String? freqDisplayValue;
    int? readingInsertId; int? pitchInsertId; int? ipaInsertId;
    if(jsonEntry[2] is int){
      freqValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is String){
      freqDisplayValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is Map){

      reading = jsonEntry[2]["reading"];
      // parse reading
      if(reading != null){
        readingInsertId = pC.allReadings[reading] ?? ++pC.currentMaxReadingId;
        if(pC.allReadings[reading] == null){
          pC.allReadings[reading] = readingInsertId;

          String? normalizedReading = preprocessInput(reading, false).normalizedTerms.firstOrNull;
          readingComps.add(ReadingTableCompanion(
            id: Value(readingInsertId!),
            reading: Value(reading),
            readingNormalized: normalizedReading!=reading && normalizedReading!=null
              ? Value(normalizedReading)
              : const Value.absent(),
          ));
        }
      }

      if(jsonEntry[1] == "freq"){

        final freq = jsonEntry[2];

        if(freq is int) freqValue = freq;
        else if(freq is String) freqDisplayValue = freq;
        else if(freq is Map){

          freqValue        = freq['value'];
          freqDisplayValue = freq['displayValue'];

          final frequency = freq["frequency"];
          if(frequency is int){ freqValue = frequency; }
          else if(frequency is String){ freqDisplayValue = frequency; }
          else if(frequency is Map) {
            freqValue        = frequency['value'];
            freqDisplayValue = frequency['displayValue'];
          }
        }      
      }
      else if(jsonEntry[1] == "pitch"){
        for (var pitch in jsonEntry[2]["pitches"]) {

          pitchInsertId = ++pC.currentMaxPitchId;
          
          termMetaBankPitchComps.add(TermMetaBankV3PitchTableCompanion(
            id: Value(pitchInsertId),
            position: Value(pitch["position"]),
            nasal: Value(pitch["nasal"]),
            devoice: Value(pitch["devoice"]),
          ));
          termMetaBankPitchRelsComps.add(TermMetaBankV3_X_PitchTableCompanion(
            pitchId: Value(pitchInsertId),
            termMetaId: Value(pC.currentMaxTermMetaId),
          ));

          for (var tag in pitch["tags"] ?? []) {
            int tagInsertId = pC.allTags[tag] ?? ++pC.currentMaxTagId;
            if(pC.allTags[tag] == null){
              pC.allTags[tag] = tagInsertId;
              termMetaBankV3TagTableComps.add(TermMetaBankV3TagTableCompanion(
                id: Value(tagInsertId), tag: Value(tag)
              ));
            }
            termMetaBankPitchTagRelsComps.add(TermMetaBankV3_X_PitchTagTableCompanion(
              pitchId: Value(pitchInsertId),
              tagId: Value(tagInsertId)
            ));
          }
        }
      }
      else if (jsonEntry[1] == "ipa"){
        for (var transcription in jsonEntry[2]["transcriptions"]) {

          ipaInsertId = ++pC.currentMaxIpaId;

          termMetaBankIpaComps.add(TermMetaBankV3IpaTableCompanion(
            id: Value(++ipaInsertId),
            ipa: Value(transcription["ipa"]),
          ));
          termMetaBankIpaRelsComps.add(TermMetaBankV3_X_IpaTableCompanion(
            ipaId: Value(ipaInsertId),
            termMetaId: Value(pC.currentMaxTermMetaId),
          ));

          for (var tag in transcription["tags"] ?? []) {
            int tagInsertId = pC.allTags[tag] ?? ++pC.currentMaxTagId;
            if(pC.allTags[tag] == null){
              pC.allTags[tag] = tagInsertId;
              termMetaBankV3TagTableComps.add(TermMetaBankV3TagTableCompanion(
                id: Value(tagInsertId), tag: Value(tag)
              ));
            }
            termMetaBankIpaTagRelsComps.add(TermMetaBankV3_X_IpaTagTableCompanion(
              ipaId: Value(ipaInsertId),
              tagId: Value(tagInsertId)
            ));
          }
        }
      }
    }

    termMetaBankComps.add(TermMetaBankV3TableCompanion(
      id: Value(pC.currentMaxTermMetaId),
      termId: Value(termInsertId),
      typeId: Value(typeInsertId),
      indexId: Value(indexId),
      readingId: Value(readingInsertId),
      freqValue: Value(freqValue),
      freqDisplayValue: Value(freqDisplayValue),
    ));

  }

  // bulk insert all data
  await db.batch((batch) {
    batch.insertAll(db.termTable, termComps);
    batch.insertAll(db.termMetaBankV3Table, termMetaBankComps);
    batch.insertAll(db.termMetaBankV3TypeTable, termMetaBankTypeComps);

    batch.insertAll(db.readingTable, readingComps);

    batch.insertAll(db.termMetaBankV3TagTable, termMetaBankV3TagTableComps);

    batch.insertAll(db.termMetaBankV3PitchTable, termMetaBankPitchComps);
    batch.insertAll(db.termMetaBankV3XPitchTagTable, termMetaBankPitchTagRelsComps);
    batch.insertAll(db.termMetaBankV3XPitchTable, termMetaBankPitchRelsComps);

    batch.insertAll(db.termMetaBankV3IpaTable, termMetaBankIpaComps);
    batch.insertAll(db.termMetaBankV3XIpaTagTable, termMetaBankIpaTagRelsComps);
    batch.insertAll(db.termMetaBankV3XIpaTable, termMetaBankIpaRelsComps);
  },);

}

