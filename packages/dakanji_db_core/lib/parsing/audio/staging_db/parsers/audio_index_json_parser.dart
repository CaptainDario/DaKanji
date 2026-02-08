import 'dart:convert';

import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

class AudioIndexJsonParser {

  /// Parses audio data source in format 2 (index.json)
  Future<void> parse(
    Iterable<({String filePath, Uint8List fileContent})> dataSources,
    String jsonString,
    StagingDatabase db,
    Function(String) onStatus,
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
    onStatus("Parsing index data of ${files.length} files");
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
    var audioRows = <AudioStagingTableCompanion>[];
    var mediaRows = <MediaStagingTableCompanion>[];

    for (final dataSource in dataSources) {
      onStatus("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
      
      String filePath = p.basename(dataSource.filePath);
      if (!fileData.containsKey(filePath)) continue;
      
      ({String term, String reading, int? pitchPattern}) entry = fileData[filePath]!;
      String term = entry.term;
      String? reading = entry.reading;
      int? pitchPattern = entry.pitchPattern;

      audioRows.add(AudioStagingTableCompanion(
        term: Value(term),
        reading: Value(reading),
        pitchPattern: Value(pitchPattern),
        originalFileName: Value(filePath),
      ));

      mediaRows.add(MediaStagingTableCompanion(
        fileName: Value(filePath),
        content: Value(dataSource.fileContent),
      ));

      // if enough audios have been processed, import them into the DB
      if (audioRows.length >= 200) {
        await _flush(db, audioRows, mediaRows);
        audioRows.clear(); mediaRows.clear();
      }
    }
    await _flush(db, audioRows, mediaRows);
  }

  Future<void> _flush(
    StagingDatabase db,
    List<AudioStagingTableCompanion> audioRows,
    List<MediaStagingTableCompanion> mediaRows
  ) async {
    await db.batch((batch) {
      batch.insertAll(db.audioStagingTable, audioRows);
      batch.insertAll(db.mediaStagingTable, mediaRows);
    });
  }
}