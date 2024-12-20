// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future<int> parseIndexFile(File indexJsonPath, DaKanjiDB db) async {

  String jsonString = indexJsonPath.readAsStringSync();
  return await parseIndex(jsonString, db);

}

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future<int> parseIndex(String indexJson, DaKanjiDB db) async {

  // read and decode the json
  Map jsonMap = jsonDecode(indexJson);

  IndexTableCompanion comp = IndexTableCompanion(
    title: Value(jsonMap["title"]),
    revision: Value(jsonMap["revision"]),

    sequenced: Value(jsonMap["sequenced"]),
    format: Value(jsonMap["format"]),
    version: Value(jsonMap["version"]),
    author: Value(jsonMap["author"]),
    updatable: Value(jsonMap["updatable"]),
    indexUrl: Value(jsonMap["indexUrl"]),
    downloadUrl: Value(jsonMap["downloadUrl"]),
    url: Value(jsonMap["url"]),
    description: Value(jsonMap["description"]),
    attribution: Value(jsonMap["attribution"]),
    sourceLanguage: Value(jsonMap["sourceLanguage"]),
    targetLanguage: Value(jsonMap["targetLanguage"]),
    frequencyMode: Value(jsonMap["frequencyMode"]),
  );

  // insert into the db
  int id = await db.into(db.indexTable).insert(comp);

  return id;

}
