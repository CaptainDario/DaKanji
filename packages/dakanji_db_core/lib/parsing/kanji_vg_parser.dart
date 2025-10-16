
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';

import '/database/dakanji_db.dart';

/// Converts the KanjiVG data source at the given path and adds it to the given
/// [DaKanjiDB].
/// 
/// [dataSourcePath] Path to the folder containing the KanjiVG SVG files
/// can either be a folder or a zip file
Future<void> addKanjiVGToDB(String dataSourcePath, DaKanjiDB db) async {

  final connection = await db.attachedDatabase.serializableConnection();

  // spawn isolate
  bool inMemory = db.inMemory;
  await Isolate.run(() async {
    await _addKanjiVGToDB(dataSourcePath, connection, inMemory);
  });

  await optimizeDbAfterImport(db);
}


/// Actual implementation of the [_addKanjiVGToDB] that runs in an isolate
Future<void> _addKanjiVGToDB(
  String dataSourcePath, DriftIsolate dbConnection, bool inMemory
) async {

  // reconnect to the database
  final db = DaKanjiDB(
    executor: await dbConnection.connect(),
    inMemory: inMemory
  );

  // convert kanji vg to map
  Map<String, String> kanjiVGMap = {};
  Iterable<({String filePath, Uint8List fileContent})> dataSources = dakanjiDBDataSourceIterator(archivePath: dataSourcePath);
  for (final ({String filePath, Uint8List fileContent}) data in dataSources) {
    final (kanji, svg) = parseKanjiVGFile(utf8.decode(data.fileContent));
    kanjiVGMap[kanji] = svg;
  }

  // get all entries that are currently in the kanji db
  final kanjis = { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id };
  int maxKanjiId = await db.kanjiDao.maxKanjiId();

  List<KanjiTableCompanion> kanjiTableComps = [];
  List<KanjiVGTableCompanion> kanjiVGTableComps = [];
  for (var kanjiVG in kanjiVGMap.entries) {

    if(kanjis[kanjiVG.key] == null){

      kanjis[kanjiVG.key] = ++maxKanjiId;
      kanjiTableComps.add(KanjiTableCompanion(
        id: Value(maxKanjiId),
        kanji: Value(kanjiVG.key)
      ));
    
    }

    kanjiVGTableComps.add(
      KanjiVGTableCompanion(
        kanjiId: Value(kanjis[kanjiVG.key]!),
        svg: Value(kanjiVG.value)
      )
    );

  }

  await db.batch((batch) {
    batch.insertAll(db.kanjiTable, kanjiTableComps);
    batch.insertAll(db.kanjiVGTable, kanjiVGTableComps);
  },);

}

/// Parses a single KanjiVG file content and returns the kanji and the SVG content
(String kanji, String svg) parseKanjiVGFile(String kanjiVGFileContent){

  // Remove comments
  final commentRegExp = RegExp(r'<!--.*?-->', dotAll: true);
  String cleanedContent = kanjiVGFileContent.replaceAll(commentRegExp, '');

  // get the kanji
  final regex = RegExp(r'kvg:element="([^"]+)"');
  final kanji = regex.firstMatch(cleanedContent)!.group(1)!;

  return (kanji, cleanedContent);

}