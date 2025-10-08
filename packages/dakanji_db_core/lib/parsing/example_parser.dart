// Package imports:
import 'dart:async';
import 'dart:isolate';

import 'package:dakanji_db_core/parsing/example/example_text_parser.dart';
import 'package:dakanji_db_core/parsing/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/isolate.dart';

import '/parsing/example/example_sentence_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';


// Project imports:
import '/database/dakanji_db.dart';

/// Parses the given dakanji example folder
Future<Stream<String>> parseExampleDataSource(String examplesZipPath, DaKanjiDB db, Mecab mecab) async {

  // Use a stream to allow listening for progress and end of processing
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();
  String libmecabPath = mecab.libmecabPath;
  String mecabDicPath = mecab.dictDir;

  // setup isolate communication
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    if(message is String) controller.add(message);
    else if(message == null) {
      receivePort.close();
      controller.close();
    }
  });

  await Isolate.spawn(_parseExampleDataSource, (
    examplesZipPath: examplesZipPath,
    dbConnection: connection,
    libmecabPath: libmecabPath,
    mecabDictDir: mecabDicPath,
    mainIsolateSendPort: receivePort.sendPort
  ));

  return controller.stream;

}

/// Actual implementation of parsing the example data source using isolate
Future _parseExampleDataSource(({
  String examplesZipPath,
  DriftIsolate dbConnection,
  String libmecabPath,
  String mecabDictDir,
  SendPort mainIsolateSendPort
}) params) async {

  final db = DaKanjiDB(executor: await params.dbConnection.connect());
  final mecab = Mecab();
  await mecab.init(params.libmecabPath, params.mecabDictDir, true);

  Iterable<({String fileName, String fileContent})> dataSources =
    dakanjiDBDataSourceIterator(archivePath: params.examplesZipPath,
    fileOrder: ["index.json"]
  );

  // parse the index file -> get dict index
  final indexFile = dataSources.first;
  int indexId = await parseIndex(indexFile.fileContent, db);
  final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;

  // parse the example bank files
  int progressCounter = 1;
  for (final ({String fileName, String fileContent}) data in dataSources) {

    params.mainIsolateSendPort.send("Parsing ${data.fileName} ($progressCounter/${dataSources.length}) ...");

    if(data.fileName.endsWith(".txt")) {
      await parseExampleText(data.fileContent, db, mecab, indexEntry.id);
    }
    else if(data.fileName.endsWith(".json")) {
      await parseExampleSentence(data.fileContent, db, mecab, indexEntry.id);
    }

    progressCounter++;

  }

  mecab.destroy();

  // Optimize db
  await db.customStatement('VACUUM;');
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

  // close isolate communication
  params.mainIsolateSendPort.send(null);

}

