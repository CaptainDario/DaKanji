import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart';
import 'package:dakanji_db_core/parsing/audio/audio_data_source_formats.dart';
import 'package:dakanji_db_core/parsing/audio/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/media/media_importer.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;



Future parseAudioDataSource({
  String? audioDataSourceFile,
  Uint8List? audioDataSourceBytes,
  required bool isDefaultDictionary,
  required String audioSourceName,
  required DaKanjiDB db,
  required Mecab mecab
  }) async {

  assert((audioDataSourceFile != null) ^ (audioDataSourceBytes != null));

  // Stream so that the 'outside' can listen to the progress
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

  await Isolate.spawn(_parseAudioDataSource, (
    audioDataSourceFile: audioDataSourceFile,
    audioDataSourceBytes: audioDataSourceBytes,
    audioSourceName: audioSourceName,
    dbConnection: connection,
    libmecabPath: libmecabPath,
    mecabDictDir: mecabDicPath,
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
  String audioSourceName,
  DriftIsolate dbConnection,
  String libmecabPath,
  String mecabDictDir,
  SendPort mainIsolateSendPort,
  bool isDefaultDictionary,
  bool inMemory
}) params) async {

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory
  );
  final mecab = Mecab();
  await mecab.init(params.libmecabPath, params.mecabDictDir, true);

  // Read the neccessary data from the DB
  AudioParserContext aC = await AudioParserContext.create(db);

  /// Iterator over the files in the data source zip
  Iterable<({String filePath, Uint8List fileContent})> dataSources =
    dakanjiDBDataSourceIterator(
      archivePath: params.audioDataSourceFile,
      archiveBytes: params.audioDataSourceBytes,
      fileOrder: ["yomitan_index.json", r"^index.json", "entries.json"]
  );

  // add an index for the audio entries
  final indexFile = dataSources.first;
  int indexId = await parseAndInsertIndex(
    utf8.decode(indexFile.fileContent), db, DictionaryTypes.audio, params.isDefaultDictionary);
  final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;
  dataSources = dataSources.skip(1);

  try {
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
        await parseAudioDataSourceFormat1(
          dataSources, db, indexId, aC, mecab, params.mainIsolateSendPort);
        break;
      case AudioDataSourceFormats.indexJson:
        String jsonString = utf8.decode(dataSources.first.fileContent);
        await parseAudioDataSourceFormat2(
          dataSources.skip(1), db, indexId, jsonString, aC, mecab, params.mainIsolateSendPort);
        break;
      case AudioDataSourceFormats.entriesJson:
        String jsonString = utf8.decode(dataSources.first.fileContent);
        await parseAudioDataSourceFormat3(
          dataSources.skip(1), db, indexId, jsonString, aC, mecab, params.mainIsolateSendPort);
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
  
  mecab.destroy();
  params.mainIsolateSendPort.send(null);

}

Future parseAudioDataSourceEntry(
  List<String> terms,
  String? reading,
  int? pitchPattern,
  int indexId,
  DaKanjiDB db,
  AudioParserContext aC,
  Mecab mecab
) async {

  aC.currentMaxAudioId++;
  
  for (final term in terms) {
    int? termId = aC.allTerms[term];
    if(termId == null){
      termId = ++aC.currentMaxTermId;

      String? termNormalized = preprocessInput(term, false).normalizedTerms.firstOrNull;
      String? termTokens = getMecabSurfacesOrNull(mecab, term);
      String? termTokensNormalized = termTokens==null
        ? null
        : preprocessInput(termTokens, false).normalizedTerms.firstOrNull;
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

      String? readingNormalized = preprocessInput(reading, false).normalizedTerms.firstOrNull;
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
Future parseAudioDataSourceFormat1(
  Iterable<({String filePath, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  AudioParserContext aC,
  Mecab mecab,
  SendPort mainIsolate
) async {
  final int noEntries = dataSources.length;
  int i = 0;
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
    await importMediaFile(
      dataSource.filePath, dataSource.fileContent, indexId, db, ++aC.currentMaxMediaId);

    String term = p.basenameWithoutExtension(dataSource.filePath);
    await parseAudioDataSourceEntry([term], null, null, indexId, db, aC, mecab);
  }
}

/// Parses audio data source in format 2 (index.json)
Future parseAudioDataSourceFormat2(
  Iterable<({String filePath, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  String jsonString,
  AudioParserContext aC,
  Mecab mecab,
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
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
    await importMediaFile(
      dataSource.filePath, dataSource.fileContent, indexId, db, ++aC.currentMaxMediaId);

    String filePath = p.basename(dataSource.filePath);
    ({String term, String reading, int? pitchPattern}) entry = fileData[filePath]!;
    String term = entry.term;
    String? reading = entry.reading;
    int? pitchPattern = entry.pitchPattern;
    await parseAudioDataSourceEntry([term], reading, pitchPattern, indexId, db, aC, mecab);
  }
}

/// Parses audio data source in format 3 (entries.json)
Future parseAudioDataSourceFormat3(
  Iterable<({String filePath, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  String jsonString,
  AudioParserContext aC,
  Mecab mecab,
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
        reading: accent["accent"][0]["pronunciation"] as String,
        pitchPattern: accent["accent"][0]["pitchAccent"],
      );
    }
  }

  // import the files into the DB
  int noEntries = dataSources.length; int i = 0;
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
    await importMediaFile(
      dataSource.filePath, dataSource.fileContent, indexId, db, ++aC.currentMaxMediaId);

    String filePath = p.basename(dataSource.filePath);
    final entry = fileData[filePath]!;

    await parseAudioDataSourceEntry(
      entry.term,
      entry.reading,
      entry.pitchPattern,
      indexId,
      db,
      aC,
      mecab
    );
  }
}