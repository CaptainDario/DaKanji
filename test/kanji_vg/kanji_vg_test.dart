// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db/conversion/kanji_vg.dart';
import 'package:dakanji_db/database/dakanji_db.dart';
import '../../bin/paths.dart';
import 'kanji_vg_test_values.dart';

void main() async {

  test('KanjiVG conversion', () async {
    
    // setup 
    DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
    await db.clearDB();

    // convert kanjivg database
    Stopwatch s = Stopwatch()..start();
    await addKanjiVGToDB(kanjiVGPath, db);
    print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

    // test radical lookups
    for (final testCase in kanjiVGLookuptests) {

      s.reset();
      String? svg = await db.kanjiVGDao.getKanjiVG(testCase.item1);
      print("Looking up SVG of ${testCase.item1} took ${s.elapsedMilliseconds}ms");
      
      expect(svg?.length, testCase.item2);

      if(testCase.item2 != null){
        expect(svg!.contains(testCase.item1), true);
      }

    }

  });

}
