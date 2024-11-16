import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db/database/dakanji_db.dart';



/// parses the given json's contents and adds it to the given [DaKanjiDB]
void parseKanjiBankV3(File kanjiBankV3JsonPath, DaKanjiDB db) async {

  // read and decode the json
  String jsonString = kanjiBankV3JsonPath.readAsStringSync();
  List jsonList = jsonDecode(jsonString);

  //
  print(jsonList.first);

  await db.into(db.kanjiBankV3Table).insert(KanjiBankV3TableCompanion.insert(
    kanji: jsonList.first[0]
  ));

}