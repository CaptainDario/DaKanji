import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/kanji_vg_parser.dart';
import 'package:da_db_shared/da_db_shared.dart';
import 'package:test/test.dart';

import '../dictionary_test_variables.dart';
import 'kanji_vg_test_cases.dart';

void main() {

  late DaKanjiDB db;
   setUpAll(() async {
     db = await setupFreshDB();
   });
   tearDownAll(() async {
     await db.close();
   });
  
  group('KanjiVG Lookups', () {
    // test radical lookups
    for (final testCase in kanjiVGLookuptests) {
      test('Looking up SVG of ${testCase.$1}', () async {
        Stopwatch s = Stopwatch()..start();
        List<KanjiVgSearchDriftResult> svgs = await db.kanjiVGDao.getKanjiVG(testCase.$1);
        print("Looking up SVG of ${testCase.$1} took ${s.elapsedMilliseconds}ms");
        
        // assure the expected number of results
        expect(svgs.length, testCase.$2.length);
        // check each expected result
        for (int i = 0; i < svgs.length; i++) {
          expect(svgs[i].kanji, testCase.$1);
          expect(svgs[i].svg.length, testCase.$2[i]);
        }

      });  
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if (File(dakanjiDbTestPath).existsSync()) File(dakanjiDbTestPath).deleteSync();

  // setup 
  DaKanjiDB db = DaKanjiDB(
    dbPath: dakanjiDbTestPath, inMemory: true, languageProcessor: await japaneseProcessor);

  // convert kanjivg database
  Stopwatch s = Stopwatch()..start();
  await addKanjiVGToDB(kanjiVGInputPath, db);
  print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

  return db;

}
