import 'package:universal_io/io.dart';

import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:drift/drift.dart';



/// Converts the KanjiVG folder at the given path and adds it to the given
/// [DaKanjiDB]
Future<void> addKanjiVGToDB(String folderPath, DaKanjiDB db) async {

  Map<String, String> kanjiVGMap = convertKanjiVGFolderToMap(folderPath);

  await db.transaction(() async {
    for (var kanjiVG in kanjiVGMap.entries) {
      await db.into(db.kanjiVGTable).insert(
        KanjiVGTableCompanion(
          kanjiVGKanji: Value(kanjiVG.key),
          kanjiVGSVG: Value(kanjiVG.value)
        )
      );
    }
  },);

}

/// Reads all files at the given paths and returns a map of the associated
/// 
/// **Notes**
/// * Removes the copyright header to save space
Map<String, String> convertKanjiVGFolderToMap(String folderPath){

  // Open the file and read its contents with a specific encoding
  final folder = Directory(folderPath);
  final entities = folder.listSync();

  Map<String, String> kanjiToSVG = {};
  for (var entity in entities) {
    
    // read the file
    final file = File(entity.path);
    final content = file.readAsStringSync();

    // Remove comments
    final commentRegExp = RegExp(r'<!--.*?-->', dotAll: true);
    String cleanedContent = content.replaceAll(commentRegExp, '');

    // get the kanji
    final regex = RegExp(r'kvg:element="([^"]+)"');
    final kanji = regex.firstMatch(cleanedContent)!.group(1)!;

    kanjiToSVG[kanji] = cleanedContent;

  }

  return kanjiToSVG;

}