import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;


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