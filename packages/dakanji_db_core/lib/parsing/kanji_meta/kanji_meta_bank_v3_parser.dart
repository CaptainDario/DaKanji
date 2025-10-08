// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dakanji_db_core/parsing/kanji_meta/kanji_meta_bank_v3_parser_context.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// Parses the given KanjiMetaBank and adds it to the given [DaKanjiDB]
Future parseKanjiMetaBankV3File(File kanjiMetaBankFile, KanjiMetaBankV3ParserContext pC, DaKanjiDB db, int dictId) async {

  String kanjiMetaBankJson = kanjiMetaBankFile.readAsStringSync();
  await parseKanjiMetaBankV3(kanjiMetaBankJson, pC, db, dictId);

}

/// Parses the given KanjiMetaBank and adds it to the given [DaKanjiDB]
Future parseKanjiMetaBankV3(String kanjiMetaBankJson, KanjiMetaBankV3ParserContext pC, DaKanjiDB db, int dictId) async {

  // decode json
  List jsonList = jsonDecode(kanjiMetaBankJson);
  
  // store data in list to bulk add them
  List<KanjiMetaBankV3TableCompanion> kanjiMetaBankComps = [];
  List<KanjiMetaBankV3TypeTableCompanion> kanjiMetaBankTypeComps = [];
  List<KanjiTableCompanion> kanjiComps = [];

  // parse the entires
  for (var jsonEntry in jsonList) {

    String kanji = jsonEntry[0]; String type = jsonEntry[1];

    int? freqValue; String? freqDisplayValue;
    if(jsonEntry[2] is int){
      freqValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is String){
      freqDisplayValue = jsonEntry[2];
    }
    else if(jsonEntry[2] is Map){
      freqValue        = jsonEntry[2]['value'];
      freqDisplayValue = jsonEntry[2]['displayValue'];
    }

    // check if the type is already in the db
    int typeInsertId = pC.typesInDB[type] ?? ++pC.maxTypeId;
    if(pC.typesInDB[type] == null){
      pC.typesInDB[type] = typeInsertId;
      kanjiMetaBankTypeComps.add(
        KanjiMetaBankV3TypeTableCompanion(
          id: Value(typeInsertId), type: Value(type)
        )
      );
    }

    // check if the kanji is already in the db
    int kanjiInsertId = pC.kanjisInDB[kanji] ?? ++pC.maxKanjiId;
    if(pC.kanjisInDB[kanji] == null){
      pC.kanjisInDB[kanji] = kanjiInsertId;
      kanjiComps.add(
        KanjiTableCompanion(
          id: Value(kanjiInsertId), kanji: Value(kanji)
        )
      );
    }

    kanjiMetaBankComps.add(KanjiMetaBankV3TableCompanion(
      kanjiId: Value(kanjiInsertId),
      typeId: Value(typeInsertId),
      indexId: Value(dictId),
      freqValue: freqValue == null ? Value.absent() : Value(freqValue),
      freqDisplayValue: freqDisplayValue == null ? Value.absent() : Value(freqDisplayValue)
    ));

  }

  // bulk insert all data
  await db.batch((batch) {
    batch.insertAll(db.kanjiMetaBankV3Table, kanjiMetaBankComps);
    batch.insertAll(db.kanjiMetaBankV3TypeTable, kanjiMetaBankTypeComps);
  },);

}
