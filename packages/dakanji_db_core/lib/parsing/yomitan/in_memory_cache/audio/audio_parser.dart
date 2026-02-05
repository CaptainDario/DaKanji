import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/audio/audio_data_source_formats.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/audio/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processor.dart';
import 'package:language_processing/language_processor_options.dart';
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

/// Parses audio data source in format 1 (file names)
Future parseAudioDataSourceFileNameFormat(
  Iterable<({String filePath, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  AudioParserContext aC,
  SendPort mainIsolate
) async {
  final int noEntries = dataSources.length;
  int i = 0;

  // pattern to extract term, reading and pitch from file name
  final RegExp pattern = RegExp(r'^(.+?)(?:\s*[\[【](.+?)[\]】])?(?:\s*[\(（](\d+)[\)）])?$');

  List<({String filePath, Uint8List mediaContent, int indexId, int? insertId})> filesToInsert = [];
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
    filesToInsert.add((filePath: dataSource.filePath, mediaContent: dataSource.fileContent,
      indexId: indexId, insertId: ++aC.currentMaxMediaId));

    String fileName = p.basenameWithoutExtension(dataSource.filePath);

    String term = fileName;
    String? reading;
    int? pitch;

    final Match? match = pattern.firstMatch(fileName);
    if (match != null) {
      // 1. Term (Trim whitespace in case user put "Word [Read]")
      term = match.group(1)!.trim();

      // 2. Reading (Exists only if [] or 【】 were found)
      if (match.group(2) != null) reading = match.group(2)!.trim();

      // 3. Pitch (Exists only if () or （） were found)
      if (match.group(3) != null) pitch = int.tryParse(match.group(3)!);
    }

    // Pass extracted data to the entry parser
    await parseAudioDataSourceEntry(
      [term], reading, pitch, indexId, db, aC);

    // if enough audios have been processed, import them into the DB
    if(i % noFilesToBatchInsert == 0 || i == noEntries) {
      await importMediaFiles(db, filesToInsert);
      filesToInsert.clear();
    }
  }
}

/// Parses audio data source in format 2 (index.json)
Future parseAudioDataSourceIndexFormat(
  Iterable<({String filePath, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  String jsonString,
  AudioParserContext aC,
  SendPort mainIsolate
) async {

  // get data from json
  Map jsonMap = jsonDecode(jsonString);
  //String mediaDir = jsonMap["meta"]["media_dir"];
  Map<String, List<String>> headwords = (jsonMap['headwords'] as Map).map(
    (key, value) => MapEntry(key, List<String>.from(value)),
  );
  Map<String, Map<String, String>> files = (jsonMap["files"] as Map).map(
    (key, value) => MapEntry(key, Map<String, String>.from(value)),
  );

  /// parse the original data into a more usable format
  Map<String, ({String term, String reading, int? pitchPattern})> fileData = {};
  mainIsolate.send("Parsing index data of ${files.length} files");
  headwords.forEach((headword, fileList) {
    for (final file in fileList) {
      Map<String, String> fileDetails = files[file]!;
      String pitchPattern = fileDetails["pitch_number"]!;
      fileData[file] = (
        term: headword,
        reading: fileDetails["kana_reading"]!,
        pitchPattern: int.tryParse(pitchPattern),
      );
    }
  });

  // import the files into the DB
  int noEntries = dataSources.length; int i = 0;
  List<({String filePath, Uint8List mediaContent, int indexId, int? insertId})> filesToInsert = [];
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
    filesToInsert.add((filePath: dataSource.filePath, mediaContent: dataSource.fileContent,
      indexId: indexId, insertId: ++aC.currentMaxMediaId));

    String filePath = p.basename(dataSource.filePath);
    if (!fileData.containsKey(filePath)) continue;
    ({String term, String reading, int? pitchPattern}) entry = fileData[filePath]!;
    String term = entry.term;
    String? reading = entry.reading;
    int? pitchPattern = entry.pitchPattern;
    await parseAudioDataSourceEntry([term], reading, pitchPattern, indexId, db, aC);

    // if enough audios have been processed, import them into the DB
    if(i % noFilesToBatchInsert == 0 || i == noEntries) {
      await importMediaFiles(db, filesToInsert);
      filesToInsert.clear();
    }
  }
}

/// Parses audio data source in format 3 (entries.json)
Future parseAudioDataSourceEntriesFormat(
  Iterable<({String filePath, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  String jsonString,
  AudioParserContext aC,
  SendPort mainIsolate
) async {

  // parse the original data into a more usable format
  final List jsonList = jsonDecode(jsonString);
  Map<String, ({List<String> term, String reading, int? pitchPattern})> fileData = {};
  mainIsolate.send("Parsing index data of ${jsonList.length} files");
  
  for (final entry in jsonList){
    List<String> kanjis = List<String>.from(entry["kanji"]);
    for (final accent in entry["accents"]) {

      if(accent["soundFile"] == null) continue;

      fileData[accent["soundFile"]] = (
        term: kanjis,
        reading: (accent["accent"][0]["pronunciation"] as String),
        pitchPattern: accent["accent"][0]["pitchAccent"],
      );
    }
  }

  // import the files into the DB
  int noEntries = dataSources.length; int i = 0;
  List<({String filePath, Uint8List mediaContent, int indexId, int? insertId})> filesToInsert = [];
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
    filesToInsert.add((filePath: dataSource.filePath, mediaContent: dataSource.fileContent,
      indexId: indexId, insertId: ++aC.currentMaxMediaId));

    String filePath = p.basename(dataSource.filePath);
    if (!fileData.containsKey(filePath)) continue;
    final entry = fileData[filePath]!;

    await parseAudioDataSourceEntry(
      entry.term, entry.reading, entry.pitchPattern, indexId, db, aC);

    // if enough audios have been processed, import them into the DB
    if(i % noFilesToBatchInsert == 0 || i == noEntries) {
      await importMediaFiles(db, filesToInsert);
      filesToInsert.clear();
    }
  }
}