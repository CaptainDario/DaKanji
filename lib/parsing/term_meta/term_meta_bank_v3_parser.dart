// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_v3_tables.dart';

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
  Map allTypes =
    { for (var e in await db.termMetaBankV3Dao.getAllTypes()) e.type : e.id };
  int currentMaxTypeId = await db.termMetaBankV3Dao.maxTermMetaBankV3TypeId();

  // store data in list to bulk add them
  List<TermMetaBankV3TableCompanion> termMetaBankComps = [];
  List<TermMetaBankV3TypeTableCompanion> termMetaBankTypeComps = [];
  List<TermMetaBankV3PitchTableCompanion> termMetaBankPitchComps = [];
  List<TermMetaBankV3IpaTableCompanion> termMetaBankIpaComps = [];

  // parse the entires
  for (var jsonEntry in jsonList) {

    String term = jsonEntry[0];
    String type = jsonEntry[1];

    String? reading;

    int? freqValue; String? freqDisplayValue;


    if(jsonEntry[2] is int){
      freqValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is String){
      freqDisplayValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is Map){

      reading = jsonEntry[2]["reading"];

      if(type == "freq"){

        final freq = jsonEntry[2]["frequency"];

        if(freq is int){ freqValue = freq; }
        else if(freq is String){ freqDisplayValue = freq; }
        else if(freq is Map){
          freqValue        = jsonEntry[2]['value'];
          freqDisplayValue = jsonEntry[2]['displayValue'];
        }
        
      }
      else if(type == "pitch"){
        for (var pitch in jsonEntry[2]["pitches"]) {
          termMetaBankPitchComps.add(TermMetaBankV3PitchTableCompanion(
            id: Value(0),
            position: Value(pitch["position"]),
            tagId: pitch[""],
            nasal: Value(pitch["nasal"]),
            devoice: pitch[""],
          ));
        }
      }
      else if (type == "ipa"){
        for (var ipa in jsonEntry[2]["transcriptions"]) {
          termMetaBankIpaComps.add(TermMetaBankV3IpaTableCompanion(
            id: Value(0),
            ipa: Value(ipa["ipa"])
          ));
        }
      }
    }

    // check if the type is already in the db
    int? typeId = allTypes[type];
    if(typeId == null){
      termMetaBankTypeComps.add(
        TermMetaBankV3TypeTableCompanion(
          id: Value(++currentMaxTypeId), type: Value(type)
        )
      );
      typeId = currentMaxTypeId;
    }

    termMetaBankComps.add(TermMetaBankV3TableCompanion(
      typeId: Value(typeId), dictId: Value(dictId),
      // TODO use termId
      termId: Value(0),
      readingId: Value(0),
      freqValue: Value(freqValue),
      freqDisplayValue: Value(freqDisplayValue),
    ));

  }

  // bulk insert all data
  await db.batch((batch) {
    batch.insertAll(db.termMetaBankV3Table, termMetaBankComps);
    batch.insertAll(db.termMetaBankV3TypeTable, termMetaBankTypeComps);
  },);

}

