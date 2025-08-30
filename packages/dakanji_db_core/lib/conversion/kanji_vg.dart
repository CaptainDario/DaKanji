// Package imports:
import 'package:drift/drift.dart';
import 'package:universal_io/io.dart';

// Project imports:
import '/database/dakanji_db.dart';

/// Converts the KanjiVG folder at the given path and adds it to the given
/// [DaKanjiDB]
Future<void> addKanjiVGToDB(String folderPath, DaKanjiDB db) async {

  // convert kanji vg to map
  Map<String, String> kanjiVGMap = convertKanjiVGFolderToMap(folderPath);

  // get all entries that are currently in the kanji db
  final kanjis = { for (var e in await db.kanjiDao.getAllKanjis()) e.kanji : e.id };
  int maxKanjiId = await db.kanjiDao.maxKanjiId();

  List<KanjiTableCompanion> kanjiTableComps = [];
  List<KanjiVGTableCompanion> kanjiVGTableComps = [];
  for (var kanjiVG in kanjiVGMap.entries) {

    if(kanjis[kanjiVG.key] == null){

      kanjis[kanjiVG.key] = ++maxKanjiId;
      kanjiTableComps.add(KanjiTableCompanion(
        id: Value(maxKanjiId),
        kanji: Value(kanjiVG.key)
      ));
    
    }

    kanjiVGTableComps.add(
      KanjiVGTableCompanion(
        kanjiId: Value(kanjis[kanjiVG.key]!),
        kanjiVGSVG: Value(kanjiVG.value)
      )
    );

  }

  await db.batch((batch) {
    batch.insertAll(db.kanjiTable, kanjiTableComps);
    batch.insertAll(db.kanjiVGTable, kanjiVGTableComps);
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
