// Package imports:
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/conversion/kanji_vg.dart';
import 'package:dakanji_db/conversion/radicals.dart';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'paths.dart';

void main() async {

  // setup 
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  await kanjiVG(db);

  await radicals(db);

  await kanjidic2(db);

  exit(0);

}

/// parses KanjiVG and adds it to the given [DaKanjiDB]
Future kanjiVG(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await addKanjiVGToDB(kanjiVGPath, db);
  print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

}

/// parses Radicals and adds it to the given [DaKanjiDB]
Future radicals(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await addRadicalsToDB(radicalsPath, db);
  print("Converting Radicals took: ${s.elapsedMilliseconds}ms");

}


/// parses the kanjidic2 and adds it to the given [DaKanjiDB]
Future kanjidic2(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(kanjidic2Path), db);
  print("Converting KanjiDic2 took: ${s.elapsedMilliseconds}ms");

}
