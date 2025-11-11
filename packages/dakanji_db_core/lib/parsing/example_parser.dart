
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/parsing/example/example_text_parser.dart';
import 'package:dakanji_db_core/parsing/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

import '/database/dakanji_db.dart';
import '/parsing/example/example_sentence_parser.dart';

/// Parses the given dakanji example folder
Future<Stream<String>> parseExampleDataSource(String examplesZipPath, DaKanjiDB db, Mecab mecab) async {

  // Use a stream to allow listening for progress and end of processing
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();
  String libmecabPath = mecab.libmecabPath!;
  String mecabDicPath = mecab.mecabDictDirPath!;

  // setup isolate communication
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    if(message is String) controller.add(message);
    else if(message is Exception) controller.addError(message);
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
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: db.inMemory
  ));

  return controller.stream;

}

/// Actual implementation of parsing the example data source using isolate
Future _parseExampleDataSource(({
  String examplesZipPath,
  DriftIsolate dbConnection,
  String libmecabPath,
  String mecabDictDir,
  SendPort mainIsolateSendPort,
  bool inMemory
}) params) async {

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory
  );
  final mecab = Mecab();
  await mecab.init(params.libmecabPath, params.mecabDictDir, true);

  try {
    Iterable<({String filePath, Uint8List fileContent})> dataSources =
      dakanjiDBDataSourceIterator(
        archivePath: params.examplesZipPath, fileOrder: ["yomitan_index.json"]);

    final indexFile = dataSources.first;
    int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.fileContent), db, DictionaryTypes.examples);
    final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;
    dataSources = dataSources.skip(1);

    // parse the example bank files
    int progressCounter = 1;
    int exampleSentenceChunkSize = 1000; List<String> currentSentencesBuffer = [];
    for (final ({String filePath, Uint8List fileContent}) data in dataSources) {

      params.mainIsolateSendPort.send("Parsing ${data.filePath} ($progressCounter/${dataSources.length}) ...");

      if(data.filePath.endsWith(".txt")) {
        await parseExampleText(utf8.decode(data.fileContent), db, mecab, indexId);
      }
      else if(data.filePath.endsWith(".json")) {
        currentSentencesBuffer.add(utf8.decode(data.fileContent));
        if(currentSentencesBuffer.length >= exampleSentenceChunkSize ||
          progressCounter == dataSources.length) {
          await parseExampleSentences(currentSentencesBuffer, db, mecab, indexId);
          currentSentencesBuffer = [];
        }
      }

      progressCounter++;

    }

    await optimizeDbAfterImport(db);
  }
  catch (e) {
    params.mainIsolateSendPort.send(e);
  }

  mecab.destroy();

  // close isolate communication
  params.mainIsolateSendPort.send(null);

}

