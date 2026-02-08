import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/data/audio_data_source_formats.dart';
import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/parse_audio_data_source_entries_format.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/parse_audio_data_source_file_name_format.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/parse_audio_data_source_index_format.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;


int noFilesToBatchInsert = 200;

Future parseAudioDataSource({
  String? audioDataSourceFile,
  Uint8List? audioDataSourceBytes,
  required bool isDefaultDictionary,
  required DaKanjiDB db,
  }) async {

  assert((audioDataSourceFile != null) ^ (audioDataSourceBytes != null));

  // Stream so that the 'outside' can listen to the progress
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();
  final processorJson = db.languageProcessor.toJsonString();

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

  await Isolate.spawn(_parseAudioDataSource, (
    audioDataSourceFile: audioDataSourceFile,
    audioDataSourceBytes: audioDataSourceBytes,
    dbConnection: connection,
    processorJson: processorJson,
    mainIsolateSendPort: receivePort.sendPort,
    isDefaultDictionary: isDefaultDictionary,
    inMemory: db.inMemory,
  ));

  return controller.stream;

}

/// Actual implementation of [parseAudioDataSource] that runs in an
/// isolate.
Future _parseAudioDataSource(({
  String? audioDataSourceFile,
  Uint8List? audioDataSourceBytes,
  DriftIsolate dbConnection,
  String processorJson,
  SendPort mainIsolateSendPort,
  bool isDefaultDictionary,
  bool inMemory
}) params) async {

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.processorJson),
  );
  await db.languageProcessor.init();

  // Read the neccessary data from the DB
  AudioParserContext aC = await AudioParserContext.create(db);

  /// Iterator over the files in the data source zip
  Iterable<({String filePath, Uint8List fileContent})> dataSources =
    dakanjiDBDataSourceIterator(
      archivePath: params.audioDataSourceFile,
      archiveBytes: params.audioDataSourceBytes,
      fileOrder: ["yomitan_index.json", r"^index.json", "entries.json"]
  );

  try {

    // add an index for the audio entries
    final indexFile = dataSources.first;
    if(p.basename(indexFile.filePath) != "yomitan_index.json")
      throw Exception("First file in audio dict must be `/yomitan_index.json`");

    int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.fileContent), db, DictionaryTypes.audio, params.isDefaultDictionary);
    final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;
    dataSources = dataSources.skip(1);

    // find the format
    late AudioDataSourceFormats format;
    if(dataSources.first.filePath == "index.json") {
      format = AudioDataSourceFormats.indexJson;
    } else if(dataSources.first.filePath == "entries.json") {
      format = AudioDataSourceFormats.entriesJson;
    } else {
      format = AudioDataSourceFormats.filesNames;
    }

    // parse according to the format
    switch (format) {
      case AudioDataSourceFormats.filesNames:
        await parseAudioDataSourceFileNameFormat(
          dataSources, db, indexId, aC, params.mainIsolateSendPort);
        break;
      case AudioDataSourceFormats.indexJson:
        String jsonString = utf8.decode(dataSources.first.fileContent);
        await parseAudioDataSourceIndexFormat(
          dataSources.skip(1), db, indexId, jsonString, aC, params.mainIsolateSendPort);
        break;
      case AudioDataSourceFormats.entriesJson:
        String jsonString = utf8.decode(dataSources.first.fileContent);
        await parseAudioDataSourceEntriesFormat(
          dataSources.skip(1), db, indexId, jsonString, aC, params.mainIsolateSendPort);
        break;
    }

    await db.batch((batch) {
      batch.insertAll(db.termTable, aC.termComps);
      batch.insertAll(db.audioTable, aC.audioComps);
      batch.insertAll(db.readingTable, aC.readingComps);
      batch.insertAll(db.audioTableXTermTable, aC.audioXTermComps);
    });

    // finish import by optimizing db and freeing resources
    await optimizeDbAfterImport(db);
  }
  catch (e) {
    params.mainIsolateSendPort.send(e);
  }
  
  db.languageProcessor.close();
  params.mainIsolateSendPort.send(null);

}

Future parseAudioDataSourceEntry(
  List<String> terms,
  String? reading,
  int? pitchPattern,
  int indexId,
  DaKanjiDB db,
  AudioParserContext aC,
) async {

  aC.currentMaxAudioId++;
  
  for (final term in terms) {
    int? termId = aC.allTerms[term];
    if(termId == null){
      termId = ++aC.currentMaxTermId;

      String? termNormalized = db.languageProcessor.normalize(term, ProcessorOptions()).firstOrNull;
      String? termTokens = db.languageProcessor.segment(term);
      String? termTokensNormalized = termTokens==null
        ? null
        :  db.languageProcessor.normalize(termTokens, ProcessorOptions()).firstOrNull;
      aC.termComps.add(TermTableCompanion(
        id: Value(termId),
        term: Value(term),
        termNormalized: termNormalized!=term && termNormalized!=null
          ? Value(termNormalized)
          : const Value.absent(),
        termTokens: termTokens != term && termTokens!=null
          ? Value(termTokens)
          : const Value.absent(),
        termTokensNormalized: termTokensNormalized!=termTokens && termTokensNormalized!=null
          ? Value(termTokensNormalized)
          : const Value.absent(),
      ));
      aC.allTerms[term] = termId;
    }
    aC.audioXTermComps.add(AudioTable_X_TermTableCompanion(
      audioId: Value(aC.currentMaxAudioId),
      termId: Value(termId),
    ));
  }

  int? readingId;
  if(reading != null) {
    readingId = aC.allReadings[reading];
    if(readingId == null) {
      readingId = ++aC.currentMaxReadingId;

      String? readingNormalized = db.languageProcessor.normalize(reading, ProcessorOptions()).firstOrNull;
      aC.readingComps.add(ReadingTableCompanion(
        id: Value(readingId),
        reading: Value(reading),
        readingNormalized: readingNormalized!=reading && readingNormalized!=null
          ? Value(readingNormalized)
          : const Value.absent(),
      ));
      aC.allReadings[reading] = readingId;
    }
  }

  aC.audioComps.add(AudioTableCompanion(
    id: Value(aC.currentMaxAudioId),
    indexId: Value(indexId),
    readingId: Value(readingId),
    mediaId: Value(aC.currentMaxMediaId),
    pitchAccentPattern: Value(pitchPattern),
  ));

}
