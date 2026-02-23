import 'dart:typed_data';

import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio/util/audio_staging_helper.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:path/path.dart' as p;



class AudioFileNameParser {
  
  /// Parses audio data source in format 1 (file names)
  Future<void> parse(
    Iterable<({String filePath, Uint8List fileContent})> dataSources,
    StagingDatabase stagingDb,
    DaDb mainDb,
    Function(String) onStatus,
  ) async {
    // helper for parsing json and inserting into staging
    final helper = AudioStagingHelper(
      stagingDb: stagingDb, 
      mainDb: mainDb, 
      onStatus: onStatus
    );

    final int noEntries = dataSources.length;
    int i = 0;

    // Pattern: Term [Reading] (Pitch)
    final RegExp pattern = RegExp(r'^(.+?)(?:\s*[\[【](.+?)[\]】])?(?:\s*[\(（](\d+)[\)）])?$');

    for (final dataSource in dataSources) {
      if (++i % 50 == 0) {
        onStatus("Processing audio source file: ${dataSource.filePath} $i/$noEntries");
      }
      
      String fileName = p.basenameWithoutExtension(dataSource.filePath);
      
      String term = fileName;
      String? reading;
      int? pitch;

      final Match? match = pattern.firstMatch(fileName);
      if (match != null) {
        term = match.group(1)!.trim();
        if (match.group(2) != null) reading = match.group(2)!.trim();
        if (match.group(3) != null) pitch = int.tryParse(match.group(3)!);
      }

      await helper.addEntry(
        terms: [term], // Wrap single term in list
        reading: reading,
        pitchPattern: pitch,
        originalFilePath: dataSource.filePath,
        fileContent: dataSource.fileContent,
      );
    }
    
    await helper.flush();
  }
}