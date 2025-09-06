// Package imports:
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';

void main() async {

  // setup 
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init("mecab.dylib", "ipadic", true);

  // convert the yomitan test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(yomitanSampleDictionaryPath), db, true);
  print("Converting yomitan dict took ${s.elapsedMilliseconds} ms");

  // convert the example bank test files
  s = Stopwatch()..reset()..start();
  await parseExampleSentenceFolder(Directory(devExampleSentencesPath), db, mecab);
  print("Converting examples took ${s.elapsedMilliseconds} ms");

  exit(0);

}
