// Dart imports:
import 'dart:convert';

import 'package:da_db/database/da_db.dart';
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

/// parses the given json's contents and adds it to the given [DaDb]
Future parseTagBankV3File(File tagJsonFile, DaDb db, int dictId) async {

  // read and decode the json
  String jsonString = tagJsonFile.readAsStringSync();

  await parseTagBankv3(jsonString, db, dictId);

}

/// parses the given json's contents and adds it to the given [DaDb]
Future parseTagBankv3(String json, DaDb db, int dictId) async {

  // Parse the given string
  List jsonList = jsonDecode(json);

  // List of all tags in the database file
  List<TagBankV3TableCompanion> tagComps = [];

  int maxTagId = await db.tagBankV3Dao.maxTagBankId();

  // iterate over the json and parse each entry
  for (var tag in jsonList) {    
    tagComps.add(TagBankV3TableCompanion(
      id: Value(++maxTagId),
      indexId: Value(dictId),
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
