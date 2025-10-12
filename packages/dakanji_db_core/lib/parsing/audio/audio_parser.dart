import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/audio_data_source_formats.dart';
import 'package:dakanji_db_core/parsing/audio/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/media/media_importer.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;



Future parseAudioDataSource({
  String? audioDataSourceFile,
  Uint8List? audioDataSourceBytes,
  required String audioSourceName,
  required DaKanjiDB db,
  required Mecab mecab
  }) async {

  assert(audioDataSourceFile != null && audioDataSourceBytes != null);

  // Stream so that the 'outside' can listen to the progress
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

  await Isolate.spawn(_parseAudioDataSource, (
    audioDataSourceFile: audioDataSourceFile,
    audioDataSourceBytes: audioDataSourceBytes,
    audioSourceName: audioSourceName,
    dbConnection: connection,
    libmecabPath: libmecabPath,
    mecabDictDir: mecabDicPath,
    mainIsolateSendPort: receivePort.sendPort
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
  SendPort mainIsolateSendPort
}) params) async {

  final db = DaKanjiDB(executor: await params.dbConnection.connect());
  final mecab = Mecab();
  await mecab.init(params.libmecabPath, params.mecabDictDir, true);

  // Read the neccessary data from the DB
  AudioParserContext aC = await AudioParserContext.create(db);

  /// Iterator over the files in the data source zip
  Iterable<({String fileName, Uint8List fileContent})> dataSources =
    dakanjiDBDataSourceIterator(
      archivePath: params.audioDataSourceFile,
      archiveBytes: params.audioDataSourceBytes,
      fileOrder: ["index.json", "entries.json"]
  );

  // find the format
  late AudioDataSourceFormats format;
  if(dataSources.first.fileName == "index.json") {
    format = AudioDataSourceFormats.indexJson;
  } else if(dataSources.first.fileName == "entries.json") {
    format = AudioDataSourceFormats.entriesJson;
  } else {
    format = AudioDataSourceFormats.filesNames;
  }

  // add an index for the audio entries
  int indexId = await db.into(db.indexTable).insert(IndexTableCompanion(
    title: Value(params.audioSourceName),
    revision: Value("1.0"),
    format: Value(format.index),
    updatable: Value(false),
    description: Value("Audio data source, parsed from ${params.audioSourceName}.zip using format ${format.name}"),
  ));

  // parse according to the format
  switch (format) {
    case AudioDataSourceFormats.filesNames:
      await parseAudioDataSource1(
        dataSources, db, indexId, aC, mecab, params.mainIsolateSendPort);
      break;
    case AudioDataSourceFormats.indexJson:
      
      break;
    case AudioDataSourceFormats.entriesJson:
      
      break;
  }

  await db.batch((batch) {
    batch.insertAll(db.termTable, aC.termComps);
    batch.insertAll(db.audioTable, aC.audioComps);
  });

  // finish import by optimizing db and freeing resources
  await optimizeDbAfterImport(db);
  mecab.destroy();
  params.mainIsolateSendPort.send(null);

}

/// 
Future parseAudioDataSource1(
  Iterable<({String fileName, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId,
  AudioParserContext aC,
  Mecab mecab,
  SendPort mainIsolate
) async {
  final int noEntries = dataSources.length;
  int i = 0;
  for (final dataSource in dataSources) {
    mainIsolate.send("Processing audio source file: ${dataSource.fileName} ${++i}/$noEntries");
    int mediaId = await importMediaFile(
      dataSource.fileName, dataSource.fileContent, indexId, db);

    String termOrReading = p.basenameWithoutExtension(dataSource.fileName);
    int? termId = aC.allTerms[termOrReading];
    int? readingId = aC.allReadings[termOrReading];
    if(termId == null && readingId == null){
      aC.termComps.add(TermTableCompanion(
        id: Value(++aC.currentMaxTermId),
        term: Value(termOrReading),
        termTokens: Value(getMecabSurfacesOrNull(mecab, termOrReading)),
      ));
      aC.allTerms[termOrReading] = aC.currentMaxTermId;
      termId = aC.currentMaxTermId;
    }

    aC.audioComps.add(AudioTableCompanion(
      indexId: Value(indexId),
      termId: Value(termId),
      readingId: Value(readingId),
      mediaId: Value(mediaId),
      pitchAccentPattern: Value(null),
    ));
  }
}

Future parseAudioDataSource2(
  String jsonString,
  DaKanjiDB db,
  int indexId
) async {

  Map jsonMap = jsonDecode(jsonString);
  // parse meta
  jsonMap["meta"];
  // parse headwords
  List headwords = jsonMap["headwords"];
  headwords = [];
  // parse file contents
  List files = jsonMap["files"];

}

Future parseAudioDataSource3(
  Iterable<({String fileName, Uint8List fileContent})> dataSources,
  DaKanjiDB db,
  int indexId
) async {
  for (final dataSource in dataSources) {
    print("Processing audio source file: ${dataSource.fileName}");
    await importMediaFile(dataSource.fileName, dataSource.fileContent, 3, db);
  }
}