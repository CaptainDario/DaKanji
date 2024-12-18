import 'dart:convert';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';



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

  // parse the entires
  for (var jsonEntry in jsonList) {

    List parsed = parseTermMetaBankEntry(jsonEntry);
    String term = parsed[0];
    String type = parsed[1];
    String? reading = parsed[2];
    int? freqValue = parsed[3];
    String? freqDisplayValue = parsed[4];

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
      term: Value(term),
      reading: Value(reading),
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

/// Parses one entry of a term_meta_bank and returns it as a [List<dynamic>].
/// The order in that list is
/// 
/// 1. term
/// 2. type
/// 3. reading
/// 4. freqValue
/// 5. freqDisplayValue
List<dynamic> parseTermMetaBankEntry(dynamic jsonEntry) {

  String term = jsonEntry[0];
  String type = jsonEntry[1];

  int? freqValue;
  String? freqDisplayValue;
  String? reading;

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

      if(freq is int){
        freqValue = freq;
      }
      else if(freq is String){
        freqDisplayValue = freq;
      }
      else if(freq is Map){
        freqValue        = jsonEntry[2]['value'];
        freqDisplayValue = jsonEntry[2]['displayValue'];
      }
      
    }
    else if(type == "pitch"){

    }
    else if (type == "ipa"){

    }
  }

  return [term, type, reading, freqValue, freqDisplayValue];
}
