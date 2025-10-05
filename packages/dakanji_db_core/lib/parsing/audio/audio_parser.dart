// Dart imports:
import 'dart:convert';
import 'dart:math';

// Package imports:
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';


/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseAudioFile(File kanjiBankV3JsonFile, DaKanjiDB db, int dictId) async {

  String jsonString = kanjiBankV3JsonFile.readAsStringSync();

  await parseAudio(jsonString, db, dictId);

}

/// parses the given json's contents and adds it to the given [DaKanjiDB]
Future parseAudio(String kanjiBankV3Json, DaKanjiDB db, int dictId) async {

  // read and decode the json
  List jsonList = jsonDecode(kanjiBankV3Json)["audioSources"];
  print("Parsing ${jsonList.length} audio entries");

  // populate the companion lists
  Stopwatch s = Stopwatch()..start();
  
  List<AudioSourceListTableCompanion> audioEntries = jsonList.map((entry) {
    String name = entry["name"]!;
    String uri = entry["uri"] ?? entry["url"]!;
    bool isLocal = entry["local"] ?? false;
    return AudioSourceListTableCompanion.insert(
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
  print("Adding to DaKanjiDB took ${s.elapsedMilliseconds}ms");

}
