// Dart imports:
import 'dart:convert';

import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/util/data_converters/frequency_mode_conerter.dart';
import 'package:drift/drift.dart';
import 'package:language_processing/language_processing.dart';
import 'package:universal_io/io.dart';

import '/database/da_db.dart';

/// parses the given json's contents and adds it to the given [DaDb]
Future<int> parseAndInsertIndexFile(
  File indexJsonPath,
  DaDb db, 
  DictionaryTypes dictionaryType,
  bool isDefaultDictionary,
) async {

  String jsonString = indexJsonPath.readAsStringSync();
  return await parseAndInsertIndex(jsonString, db, dictionaryType, isDefaultDictionary);

}


/// parses the given json's contents and adds it to the given [DaDb]
Future<int> parseAndInsertIndex(
  String indexJson,
  DaDb db,
  DictionaryTypes dictionaryType,
  bool isDefaultDictionary,
) async {

  // read and decode the json
  Map jsonMap = jsonDecode(indexJson);
  IndexTableCompanion comp = IndexTableCompanion(

    isDefaultDictionary: Value(isDefaultDictionary),
    enabled: Value(true),
    dictionaryType: Value(dictionaryType),
    currentSortingOrder: Value(await db.indexDao.maxIndexId()+1),

    title: Value(jsonMap["title"]),
    revision: Value(jsonMap["revision"]),

    sequenced: Value(jsonMap["sequenced"]),
    format: Value(jsonMap["format"]),
    version: Value(jsonMap["version"]),
    author: Value(jsonMap["author"]),
    isUpdatable: Value(jsonMap["isUpdatable"]),
    indexUrl: Value(jsonMap["indexUrl"]),
    downloadUrl: Value(jsonMap["downloadUrl"]),
    url: Value(jsonMap["url"]),
    description: Value(jsonMap["description"]),
    attribution: Value(jsonMap["attribution"]),
    sourceLanguage: Value(parseToIso(jsonMap["sourceLanguage"]).iso3),
    targetLanguage: Value(parseToIso(jsonMap["targetLanguage"]).iso3),
    frequencyMode: Value(mapFrequencyMode(jsonMap["frequencyMode"])),
  );

  // insert into the db
  int id = await (db.into(db.indexTable).insert(comp));

  return id;

}
