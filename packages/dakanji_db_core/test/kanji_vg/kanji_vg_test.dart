// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/conversion/kanji_vg.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import '../../../dakanji_db_shared/lib/paths.dart';
import 'kanji_vg_test_cases.dart';

void main() async {
  // setup 
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.clearDB();

  // convert kanjivg database
  Stopwatch s = Stopwatch()..start();
  await addKanjiVGToDB(kanjiVGInputPath, db);
  print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

  group('KanjiVG Lookups', () {
    // test radical lookups
    for (final testCase in kanjiVGLookuptests) {
      test('Looking up SVG of ${testCase.item1}', () async {
        s.reset();
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
