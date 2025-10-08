// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dakanji_db_core/parsing/term_meta/term_meta_bank_v3_parser_context.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermMetaBankV3File(File termMetaBankFile, TermMetaBankV3ParserContext pC, DaKanjiDB db, int indexId) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermMetaBankV3(termMetaBankJson, pC, db, indexId);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermMetaBankV3(String termMetaBankJson, TermMetaBankV3ParserContext pC, DaKanjiDB db, int indexId) async {

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
    int termInsertId = pC.allTerms[jsonEntry[0]] ?? ++pC.currentMaxTermId;
    if(pC.allTerms[jsonEntry[0]] == null){
      pC.allTerms[jsonEntry[0]] = termInsertId;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(jsonEntry[0])
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
          readingComps.add(ReadingTableCompanion(
            id: Value(readingInsertId!),
            reading: Value(reading)
          ));
        }
      }

      if(jsonEntry[1] == "freq"){

        final freq = jsonEntry[2];

        if(freq is int){ freqValue = freq; }
        else if(freq is String){ freqDisplayValue = freq; }
        else if(freq is Map){

          freqValue        = jsonEntry[2]['value'];
          freqDisplayValue = jsonEntry[2]['displayValue'];

          final frequency = freq["frequency"];
          if(frequency is int){ freqValue = frequency; }
          else if(frequency is String){ freqDisplayValue = frequency; }
          else if(frequency is Map) {
            freqValue        = jsonEntry[2]['value'];
            freqDisplayValue = jsonEntry[2]['displayValue'];
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

