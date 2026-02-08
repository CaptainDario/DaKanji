import 'dart:convert';
import 'dart:typed_data';

import 'package:dakanji_db_core/data/audio_data_source_formats.dart';
import 'package:dakanji_db_core/parsing/staging_db/staging_db.dart';
import 'package:path/path.dart' as p;

import 'audio/staging_db/parsers/audio_entries_json_parser.dart';
import 'audio/staging_db/parsers/audio_file_name_parser.dart';
import 'audio/staging_db/parsers/audio_index_json_parser.dart';

class AudioStagingParser {
  
  Future<void> parseAudioDataSource({
    required Iterable<({String filePath, Uint8List fileContent})> dataSources,
    required StagingDatabase db,
    required Function(String) onStatus,
  }) async {
    
    // add an index for the audio entries
    final indexFile = dataSources.first;
    if(p.basename(indexFile.filePath) != "yomitan_index.json") {
      throw Exception("First file in audio dict must be `/yomitan_index.json`");
    }

    // Skip yomitan_index.json for format detection
    var contentFiles = dataSources.skip(1);
    final nextFile = contentFiles.first;
    
    // find the format
    late AudioDataSourceFormats format;
    if(p.basename(nextFile.filePath) == "index.json") {
      format = AudioDataSourceFormats.indexJson;
    } else if(p.basename(nextFile.filePath) == "entries.json") {
      format = AudioDataSourceFormats.entriesJson;
    } else {
      format = AudioDataSourceFormats.filesNames;
    }

    // parse according to the format
    switch (format) {
      case AudioDataSourceFormats.filesNames:
        await AudioFileNameParser().parse(contentFiles, db, onStatus);
        break;
      case AudioDataSourceFormats.indexJson:
        String jsonString = utf8.decode(nextFile.fileContent);
        await AudioIndexJsonParser().parse(contentFiles.skip(1), jsonString, db, onStatus);
        break;
      case AudioDataSourceFormats.entriesJson:
        String jsonString = utf8.decode(nextFile.fileContent);
        await AudioEntriesJsonParser().parse(contentFiles.skip(1), jsonString, db, onStatus);
        break;
    }
  }
}