import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';

import '../bin/paths.dart';


final testCases = [
  Tuple2(["打"], 0)
];


void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(samplesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    //await testKanjiBankV3(db);
  });
}

Future testKanjiBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in testCases) {
    Stopwatch s = Stopwatch()..start();
    List? result = await db.kanjiBankV3Dao.getKanjiBankEntriesFromKanji(testCase.item1);
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    // TODO ADD TEST
  }
}
