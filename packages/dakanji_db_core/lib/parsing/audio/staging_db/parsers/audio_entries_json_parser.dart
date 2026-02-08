import 'dart:convert';

import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

class AudioEntriesJsonParser {

  /// Parses audio data source in format 3 (entries.json)
  Future<void> parse(
    Iterable<({String filePath, Uint8List fileContent})> dataSources,
    String jsonString,
    StagingDatabase db,
    Function(String) onStatus,
  ) async {

    // parse the original data into a more usable format
    final List jsonList = jsonDecode(jsonString);
    Map<String, ({List<String> term, String reading, int? pitchPattern})> fileData = {};
    onStatus("Parsing index data of ${jsonList.length} files");
    
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
    var audioRows = <AudioStagingTableCompanion>[];
    var mediaRows = <MediaStagingTableCompanion>[];

    for (final dataSource in dataSources) {
      onStatus("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
      
      String filePath = p.basename(dataSource.filePath);
      if (!fileData.containsKey(filePath)) continue;
      final entry = fileData[filePath]!;

      // Note: Original parser logic would create separate entries for each kanji term.
      // We replicate that here by inserting a row for every term in the list.
      for (final term in entry.term) {
        audioRows.add(AudioStagingTableCompanion(
          term: Value(term),
          reading: Value(entry.reading),
          pitchPattern: Value(entry.pitchPattern),
          originalFileName: Value(filePath),
        ));
      }

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