
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/parsing/example/example_parser_context.dart';
import 'package:da_db/parsing/example/example_text_parser.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';

import '/database/da_db.dart';
import 'example/example_sentence_parser.dart';

/// Parses the given DaDb example folder
Future<Stream<String>> parseExampleDataSource(
  {
    required String examplesZipPath,
    required  DaDb db,
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

  final db = DaDb(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );

  try {
    Iterable<ArchiveFile> dataSources = daDbDataSourceIterator(
      archivePath: params.examplesZipPath, fileOrder: ["yomitan_index.json"]);

    final indexFile = dataSources.firstOrNull;
    if (indexFile == null) throw Exception("Missing index file");
    int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.content), db, DictionaryTypes.examples, params.isDefaultDictionary);
    final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;
    dataSources = dataSources.skip(1);

    // get the parsing context
    ExampleParserContext context = await ExampleParserContext.create(db);

    // parse the example bank files
    int progressCounter = 1;
    int exampleSentenceChunkSize = 1000; List<String> currentSentencesBuffer = [];
    for (final ArchiveFile file in dataSources) {

      params.mainIsolateSendPort.send("Parsing ${file.name} ($progressCounter/${dataSources.length}) ...");

      if(file.name.endsWith(".txt")) {
        await parseExampleText(utf8.decode(file.content), db, indexId);
      }
      else if(file.name.endsWith(".json")) {
        currentSentencesBuffer.add(utf8.decode(file.content));
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

