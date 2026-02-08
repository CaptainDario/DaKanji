import 'dart:async';
import 'dart:isolate';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser.dart';
import 'package:dakanji_db_core/parsing/audio/in_memory_cache/audio_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;


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
