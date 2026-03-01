// Dart imports:
import 'dart:convert';

import 'package:universal_io/io.dart';

import '/database/da_db.dart';


/// parses the given json's contents and adds it to the given [DaDb]
Future parseAudioListFile(File audioListJsonFile, DaDb db, int dictId) async {

  String jsonString = audioListJsonFile.readAsStringSync();

  await parseAudioList(jsonString, db, dictId);

}

/// parses the given json's contents and adds it to the given [DaDb]
Future parseAudioList(String audioListJson, DaDb db, int indexId) async {

  // read and decode the json
  List jsonList = jsonDecode(audioListJson)["audioSources"];
  print("Parsing ${jsonList.length} audio entries");

  // populate the companion lists
  Stopwatch s = Stopwatch()..start();
  
  List<AudioSourceListTableCompanion> audioEntries = jsonList.map((entry) {
    String name = entry["name"]!;
    String uri = entry["uri"] ?? entry["url"]!;
    return AudioSourceListTableCompanion.insert(
      indexId: indexId,
      name: name.trim(),
      uri: uri.trim(),
    );
  }).toList();

  print("Parsing took ${s.elapsedMilliseconds}ms");

  // Perform the insertion inside a batch
  s.reset();
  await db.batch((batch) {
    
    batch.insertAll(db.audioSourceListTable, audioEntries);

  });
  print("Adding to DaDb took ${s.elapsedMilliseconds}ms");

}
