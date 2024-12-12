import 'dart:convert';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';



/// Parses the given KanjiMetaBank and adds it to the given [DaKanjiDB]
Future parseKanjiMetaBankV3File(File kanjiMetaBankFile, DaKanjiDB db, int dictId) async {

  String kanjiMetaBankJson = kanjiMetaBankFile.readAsStringSync();
  await parseKanjiMetaBankV3(kanjiMetaBankJson, db, dictId);

}

/// Parses the given KanjiMetaBank and adds it to the given [DaKanjiDB]
Future parseKanjiMetaBankV3(String kanjiMetaBankJson, DaKanjiDB db, int dictId) async {

  // decode json
  List jsonList = jsonDecode(kanjiMetaBankJson);
  
  // read all necessary data from the db
  Map allTypes =
    { for (var e in await db.kanjiMetaBankV3Dao.getAllTypes()) e.type : e.id };
  int currentMaxTypeId = await db.kanjiMetaBankV3Dao.maxKanjiMetaBankV3TypeId();

  // store data in list to bulk add them
  List<KanjiMetaBankV3TableCompanion> kanjiMetaBankComps = [];
  List<KanjiMetaBankV3TypeTableCompanion> kanjiMetaBankTypeComps = [];

  // parse the entires
  for (var jsonEntry in jsonList) {

    String kanji = jsonEntry[0]; String type = jsonEntry[1];

    int? value; String? displayValue;
    if(jsonEntry[2] is int){
      value = jsonEntry[2];
    }
    else if(jsonEntry[2] is String){
      displayValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is Map){
      value        = jsonEntry[2]['value'];
      displayValue = jsonEntry[2]['displayValue'];
    }

    // check if the type is already in the db
    int? typeId = allTypes[type];
    if(typeId == null){
      kanjiMetaBankTypeComps.add(
        KanjiMetaBankV3TypeTableCompanion(
          id: Value(++currentMaxTypeId), type: Value(type)
        )
      );
      typeId = currentMaxTypeId;
    }

    kanjiMetaBankComps.add(KanjiMetaBankV3TableCompanion(
      kanji: Value(kanji), typeId: Value(typeId), dictId: Value(dictId),
      value: value == null ? Value.absent() : Value(value),
      displayValue: displayValue == null ? Value.absent() : Value(displayValue)
    ));

  }

  // bulk insert all data
  await db.batch((batch) {
    batch.insertAll(db.kanjiMetaBankV3Table, kanjiMetaBankComps);
    batch.insertAll(db.kanjiMetaBankV3TypeTable, kanjiMetaBankTypeComps);
  },);

}
