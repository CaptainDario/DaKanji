// Package imports:
import 'dart:io';

import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/parsing/kanji_vg_parser.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
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
      test('Looking up SVG of ${testCase.item1}', () async {
        Stopwatch s = Stopwatch()..start();
        String? svg = await db.kanjiVGDao.getKanjiVG(testCase.item1);
        print("Looking up SVG of ${testCase.item1} took ${s.elapsedMilliseconds}ms");
        
        expect(svg?.length, testCase.item2);

        if(testCase.item2 != null){
          expect(svg!.contains(testCase.item1), true);
        }
      });  
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if (File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();

  // setup 
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);

  // convert kanjivg database
  Stopwatch s = Stopwatch()..start();
  await addKanjiVGToDB(kanjiVGInputPath, db);
  print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

  return db;

}
