// Package imports:
import 'package:dakanji_db/parsing/example_parser.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import '../bin/paths.dart';
import 'examples_test_values.dart';



void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseExampleFolder(Directory(samples_exampleSentencesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing examples', () async {
    await testExamplesV3(db);
  });

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExamplesV3(DaKanjiDB db) async {

  // Check some kanji bank queries
  for (int i = 0; i < examplesTestQueries.length; i++) {

    Stopwatch s = Stopwatch()..start();
    final result = (await db.exampleDao.searchExamples(examplesTestQueries[i]));
    print("Looking up ${examplesTestQueries[i]} took ${s.elapsedMilliseconds}ms");
    print(result);

    expect(result.isNotEmpty, true);
    final pass = result.where((r) => !examplesTestExpected.contains(r)).toList();
    expect(pass.isEmpty, true);

  }

}
