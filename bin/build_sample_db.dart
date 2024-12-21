// Package imports:
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import 'paths.dart';

void main() async {

  // setup 
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(samplesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");

  exit(0);

}
