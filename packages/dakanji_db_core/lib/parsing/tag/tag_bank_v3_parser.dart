// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseTagBankV3File(File indexJsonFile, DaKanjiDB db) async {

  // read and decode the json
  String jsonString = indexJsonFile.readAsStringSync();

  await parseTagBankv3(jsonString, db);

}

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseTagBankv3(String json, DaKanjiDB db) async {

  // Parse the given string
  List jsonList = jsonDecode(json);

  // List of all tags in the database file
  List<TagBankV3TableCompanion> tagComps = [];

  int maxTagId = await db.tagBankV3Dao.maxTagId();

  // iterate over the json and parse each entry
  for (var tag in jsonList) {    
    tagComps.add(TagBankV3TableCompanion(
      id: Value(++maxTagId),
      name: Value(tag[0]),
      category: Value(tag[1]),
      sortingOrder: Value(tag[2]),
      notes: Value(tag[3]),
      score: Value(tag[4])
    ));

  }

  // insert into the db
  await db.batch((batch) {
    batch.insertAll(db.tagBankV3Table, tagComps);
  },);

}
