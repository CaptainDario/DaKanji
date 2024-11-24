import 'dart:io';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';
import 'package:euc/euc.dart';
import 'package:tuple/tuple.dart';



/// Converts the radk and krad file at the given paths and adds them to the
/// given DaKanji db
Future convertRadicals(String radkPath, String kradPath, DaKanjiDB db) async {

  // load krad - example entry:
  //    丂 : [, 一, 勹]
  final kradMap = convertKradToMap(kradPath);
  // load radk: example entry
  //    一: [1, [亜, 唖, 阿, 姶, 悪, 芦, 或, 袷, 夷, 椅, 畏, ...]
  final radkMap = convertRadkToMap(radkPath);
  Map<String, int> radicalIds = {};

  // add all radicals to sqlite and get their ID
  for (MapEntry<String, Tuple2<int, List<String>>> radkItem in radkMap.entries) {
      
    int id = await db.into(db.radicalsTable).insert(
      RadicalsTableCompanion(
        radical: Value(radkItem.key), strokeCount: Value(radkItem.value.item1))
    );
    radicalIds[radkItem.key] = id;

  }

  // add all kanji and the links between kanji <--> radical
  for (var kradItem in kradMap.entries) {
    
    // add the kanji into the db
    int id = await db.into(db.radicalsKanjiTable).insert(
      RadicalsKanjiTableCompanion(radicalKanji: Value(kradItem.key))
    );

    // create the realtionships between kanji and radical
    for (var radical in kradItem.value) {

      if(["", " "].contains(radical)) continue;
      
      await db.into(db.radicalKanjiRelationsTable).insert(
        RadicalKanjiRelationsTableCompanion(
          kanjiId: Value(id),
          radicalId: Value(radicalIds[radical]!)
        )
      );

    }

  }

}

/// Reads the Radk file at the given `filePath` and returns a map containing
/// its contents
Map<String, Tuple2<int, List<String>>> convertRadkToMap(String filePath){

  // Open the file and read its contents with a specific encoding
  final file = File(filePath);
  final content = file.readAsBytesSync();
  final decoded = EucJP().decode(content);
  final lines = decoded.split("\n");

  Map<String, Tuple2<int, List<String>>> radicalToKanji = {};
  for (var i = 0; i < lines.length; i++) {
    
    String line = lines[i];
    List<String> lineSplit = line.split(" ");

    if(line.startsWith("#")){
      continue;
    }
    else if(line.startsWith("\$")){
      radicalToKanji[lineSplit[1]] = Tuple2(
        int.parse(lineSplit[2]), lines[++i].split(""));
    }
    
  }

  return radicalToKanji;

}

/// Reads the Krad file at the given `filePath` and returns a map containing
/// its contents
Map<String, List<String>> convertKradToMap(String filePath){

  // Open the file and read its contents with a specific encoding
  final file = File(filePath);
  final content = file.readAsBytesSync();
  final decoded = EucJP().decode(content);
  final lines = decoded.split("\n");

  Map<String, List<String>> kanjiToRadical = {};
  for (var i = 0; i < lines.length; i++) {

    String line = lines[i];

    if(line.startsWith("#") || line == ""){
      continue;
    }
    
    List<String> lineSplit = line.split(":");
    String kanji = lineSplit[0];
    List<String> radicals = lineSplit[1].split(" ");
    
    kanjiToRadical[kanji] = radicals;
    
  }

  return kanjiToRadical;

}