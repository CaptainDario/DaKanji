
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/parsing/example/example_parser_context.dart';
import 'package:dakanji_db_core/parsing/example/example_text_parser.dart';
import 'package:dakanji_db_core/parsing/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processor.dart';

import '/database/dakanji_db.dart';
import '/parsing/example/example_sentence_parser.dart';

/// Parses the given dakanji example folder
Future<Stream<String>> parseExampleDataSource(
  {
    required String examplesZipPath,
    required  DaKanjiDB db,
    required bool isDefaultDictionary
  }
) async {

  // Use a stream to allow listening for progress and end of processing
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();

  // setup isolate communication
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    if(message is String) controller.add(message);
    else if(message == null) {
      receivePort.close();
      controller.close();
    }
    else controller.addError(message);
  });

  await Isolate.spawn(_parseExampleDataSource, (
    examplesZipPath: examplesZipPath,
    dbConnection: connection,
    languageProcessorJson: db.languageProcessor.toJsonString(),
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: db.inMemory,
    isDefaultDictionary: isDefaultDictionary
  ));

  return controller.stream;

}

/// Actual implementation of parsing the example data source using isolate
Future _parseExampleDataSource(({
  String examplesZipPath,
  DriftIsolate dbConnection,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary
}) params) async {

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );

  try {
    Iterable<({String filePath, Uint8List fileContent})> dataSources =
      dakanjiDBDataSourceIterator(
        archivePath: params.examplesZipPath, fileOrder: ["yomitan_index.json"]);

    final indexFile = dataSources.first;
    int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.fileContent), db, DictionaryTypes.examples, params.isDefaultDictionary);
    final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;
    dataSources = dataSources.skip(1);

    // get the parsing context
    ExampleParserContext context = await ExampleParserContext.create(db);

    // parse the example bank files
    int progressCounter = 1;
    int exampleSentenceChunkSize = 1000; List<String> currentSentencesBuffer = [];
    for (final ({String filePath, Uint8List fileContent}) data in dataSources) {

      params.mainIsolateSendPort.send("Parsing ${data.filePath} ($progressCounter/${dataSources.length}) ...");

      if(data.filePath.endsWith(".txt")) {
        await parseExampleText(utf8.decode(data.fileContent), db, indexId);
      }
      else if(data.filePath.endsWith(".json")) {
        currentSentencesBuffer.add(utf8.decode(data.fileContent));
        if(currentSentencesBuffer.length >= exampleSentenceChunkSize ||
          progressCounter == dataSources.length) {
          await parseExampleSentences(currentSentencesBuffer, db, indexId, context);
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

  db.languageProcessor.close();

  // close isolate communication
  params.mainIsolateSendPort.send(null);

}

