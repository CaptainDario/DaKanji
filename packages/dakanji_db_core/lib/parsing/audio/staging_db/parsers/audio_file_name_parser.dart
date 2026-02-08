import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

class AudioFileNameParser {
  
  /// Parses audio data source in format 1 (file names)
  Future<void> parse(
    Iterable<({String filePath, Uint8List fileContent})> dataSources,
    StagingDatabase db,
    Function(String) onStatus,
  ) async {
    final int noEntries = dataSources.length;
    int i = 0;

    // pattern to extract term, reading and pitch from file name
    final RegExp pattern = RegExp(r'^(.+?)(?:\s*[\[【](.+?)[\]】])?(?:\s*[\(（](\d+)[\)）])?$');

    var audioRows = <AudioStagingTableCompanion>[];
    var mediaRows = <MediaStagingTableCompanion>[];

    for (final dataSource in dataSources) {
      onStatus("Processing audio source file: ${dataSource.filePath} ${++i}/$noEntries");
      
      String fileName = p.basenameWithoutExtension(dataSource.filePath);
      String fullName = p.basename(dataSource.filePath);

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

      audioRows.add(AudioStagingTableCompanion(
        term: Value(term),
        reading: Value(reading),
        pitchPattern: Value(pitch),
        originalFileName: Value(fullName),
      ));

      mediaRows.add(MediaStagingTableCompanion(
        fileName: Value(fullName),
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