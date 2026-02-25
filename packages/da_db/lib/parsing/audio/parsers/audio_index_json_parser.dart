import 'dart:convert';

import 'package:archive/archive_io.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio/util/audio_staging_helper.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:path/path.dart' as p;



class AudioIndexJsonParser {

  /// Parses audio data source in format 2 (index.json)
  Future<void> parse(
    Iterable<ArchiveFile> dataSources,
    String jsonString,
    StagingDatabase stagingDb,
    DaDb mainDb,
    Function(String) onStatus,
  ) async {
    final helper = AudioStagingHelper(
      stagingDb: stagingDb, 
      mainDb: mainDb, 
      onStatus: onStatus
    );

    // 1. Parse JSON Metadata
    Map jsonMap = jsonDecode(jsonString);
    
    Map<String, List<String>> headwords = (jsonMap['headwords'] as Map).map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );
    Map<String, Map<String, String>> files = (jsonMap["files"] as Map).map(
      (key, value) => MapEntry(key, Map<String, String>.from(value)),
    );

    // 2. Pre-process Metadata Map
    Map<String, ({String term, String reading, int? pitchPattern})> fileData = {};
    onStatus("Parsing index data of ${files.length} files");
    
    headwords.forEach((headword, fileList) {
      for (final file in fileList) {
        if (!files.containsKey(file)) continue;

        Map<String, String> fileDetails = files[file]!;
        String? pitchStr = fileDetails["pitch_number"];
        
        fileData[file] = (
          term: headword,
          reading: fileDetails["kana_reading"] ?? "", 
          pitchPattern: int.tryParse(pitchStr ?? ""),
        );
      }
    });

    // 3. Process Files
    int noEntries = dataSources.length; 
    int i = 0;

    for (final dataSource in dataSources) {
      if (++i % 50 == 0) {
        onStatus("Processing audio source file: ${dataSource.name} $i/$noEntries");
      }
      
      String fileName = p.basename(dataSource.name);
      if (!fileData.containsKey(fileName)) continue;
      
      final entry = fileData[fileName]!;

      await helper.addEntry(
        terms: [entry.term], // Wrap single term in list
        reading: entry.reading,
        pitchPattern: entry.pitchPattern,
        originalFilePath: dataSource.name,
        fileContent: dataSource.content,
      );
    }
    
    await helper.flush();
  }
}