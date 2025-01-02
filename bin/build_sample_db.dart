// Package imports:
import 'package:dakanji_db/parsing/example_parser.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'paths.dart';

void main() async {

  // setup 
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  // convert the yomitan test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(yomitanSamplePath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");

  // convert the example test files
  s = Stopwatch()..reset()..start();
  await parseExampleFolder(Directory(exampleSamplePath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");

  exit(0);

}
