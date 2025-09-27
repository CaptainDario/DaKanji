// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermMetaBankV3File(File termMetaBankFile, DaKanjiDB db, int dictId) async {

  String termMetaBankJson = termMetaBankFile.readAsStringSync();
  await parseTermMetaBankV3(termMetaBankJson, db, dictId);

}

/// Parses the given TermMetaBank and adds it to the given [DaKanjiDB]
Future parseTermMetaBankV3(String termMetaBankJson, DaKanjiDB db, int dictId) async {

  // decode json
  List jsonList = jsonDecode(termMetaBankJson);
  
  // read all necessary data from the db
  int currentMaxTermMetaId = await db.termMetaBankV3Dao.maxTermMetaBankV3TypeId();
  Map allTerms =
    { for (var e in await db.termDao.getAllTerms()) e.term : e.id };
  int currentMaxTermId = await db.termDao.maxTermId();
  Map allTypes =
    { for (var e in await db.termMetaBankV3Dao.getAllTypes()) e.type : e.id };
  int currentMaxTypeId = await db.termMetaBankV3Dao.maxTermMetaBankV3TypeId();
  Map allReadings =
    { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id };
  int currentMaxReadingId = await db.readingDao.maxReadingId();
  Map allTags =
    { for (var e in await db.termMetaBankV3Dao.getAllTags()) e.tag : e.id };
  int currentMaxTagId = await db.termMetaBankV3Dao.maxTermMetaBankV3TagId();
  int currentMaxPitchId = await db.termMetaBankV3Dao.maxTermMetaBankV3PitchId();
  int currentMaxIpaId = await db.termMetaBankV3Dao.maxTermMetaBankV3IpaId();
  

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
    currentMaxTermMetaId++;

    // parse term
    int termInsertId = allTerms[jsonEntry[0]] ?? ++currentMaxTermId;
    if(allTerms[jsonEntry[0]] == null){
      allTerms[jsonEntry[0]] = termInsertId;
      termComps.add(TermTableCompanion(
        id: Value(termInsertId),
        term: Value(jsonEntry[0])
      ));
    }

    // parse type
    int typeInsertId = allTypes[jsonEntry[1]] ?? ++currentMaxTypeId;
    if(allTypes[jsonEntry[1]] == null){
      allTypes[jsonEntry[1]] = typeInsertId;
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
        readingInsertId = allReadings[reading] ?? ++currentMaxReadingId;
        if(allReadings[reading] == null){
          allReadings[reading] = readingInsertId;
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

          pitchInsertId = ++currentMaxPitchId;
          
          termMetaBankPitchComps.add(TermMetaBankV3PitchTableCompanion(
            id: Value(pitchInsertId),
            position: Value(pitch["position"]),
            nasal: Value(pitch["nasal"]),
            devoice: Value(pitch["devoice"]),
          ));
          termMetaBankPitchRelsComps.add(TermMetaBankV3_X_PitchTableCompanion(
            pitchId: Value(pitchInsertId),
            termMetaId: Value(currentMaxTermMetaId),
          ));

          for (var tag in pitch["tags"] ?? []) {
            int tagInsertId = allTags[tag] ?? ++currentMaxTagId;
            if(allTags[tag] == null){
              allTags[tag] = tagInsertId;
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

          ipaInsertId = ++currentMaxIpaId;

          termMetaBankIpaComps.add(TermMetaBankV3IpaTableCompanion(
            id: Value(++ipaInsertId),
            ipa: Value(transcription["ipa"]),
          ));
          termMetaBankIpaRelsComps.add(TermMetaBankV3_X_IpaTableCompanion(
            ipaId: Value(ipaInsertId),
            termMetaId: Value(currentMaxTermMetaId),
          ));

          for (var tag in transcription["tags"] ?? []) {
            int tagInsertId = allTags[tag] ?? ++currentMaxTagId;
            if(allTags[tag] == null){
              allTags[tag] = tagInsertId;
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
      id: Value(currentMaxTermMetaId),
      termId: Value(termInsertId),
      typeId: Value(typeInsertId),
      dictId: Value(dictId),
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

