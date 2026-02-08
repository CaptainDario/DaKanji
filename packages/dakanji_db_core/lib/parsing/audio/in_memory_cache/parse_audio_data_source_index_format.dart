import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

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