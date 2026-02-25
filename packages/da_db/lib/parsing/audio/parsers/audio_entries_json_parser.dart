import 'dart:convert';

import 'package:archive/archive_io.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio/util/audio_staging_helper.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:path/path.dart' as p;



class AudioEntriesJsonParser {

  /// Parses audio data source in format 3 (entries.json)
  Future<void> parse(
    Iterable<ArchiveFile> dataSources,
    String jsonString,
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

    final List jsonList = jsonDecode(jsonString);
    Map<String, ({List<String> term, String reading, int? pitchPattern})> fileData = {};
    
    onStatus("Parsing index data of ${jsonList.length} files");
    
    for (final entry in jsonList) {
      List<String> kanjis = List<String>.from(entry["kanji"]);
      
      for (final accent in entry["accents"]) {
        if (accent["soundFile"] == null) continue;

        fileData[accent["soundFile"]] = (
          term: kanjis,
          reading: (accent["accent"][0]["pronunciation"] as String),
          pitchPattern: accent["accent"][0]["pitchAccent"],
        );
      }
    }

    int noEntries = dataSources.length; 
    int i = 0;

    for (final dataSource in dataSources) {
      if (++i % 50 == 0) {
        onStatus("Processing audio source file: ${dataSource.name} $i/$noEntries");
      }
      
      // Lookup Key
      String filePath = p.basename(dataSource.name);
      
      if (!fileData.containsKey(filePath)) {
        
         await helper.addEntry(
            terms: [], // No terms
            reading: null,
            pitchPattern: null,
            originalFilePath: dataSource.name,
            fileContent: dataSource.content,
         );
         continue;
      }
      
      final entry = fileData[filePath]!;

      // Replaces: parseAudioDataSourceEntry(...)
      await helper.addEntry(
        terms: entry.term,
        reading: entry.reading,
        pitchPattern: entry.pitchPattern,
        originalFilePath: dataSource.name,
        fileContent: dataSource.content,
      );
    }

    // Final batch flush
    await helper.flush();
  }
}