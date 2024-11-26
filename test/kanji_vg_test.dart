import 'package:dakanji_db/conversion/kanji_vg.dart';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

import '../bin/paths.dart';



/// List of kanjis of which the radicals should be looked up and the expected
/// result
List<Tuple2<String, int?>> kanjiVGLookuptests = [
  Tuple2("丂", null),
  Tuple2("漢", 3792),
  Tuple2("鬱", 6752),
  Tuple2("暚", null),
  Tuple2("A", 1334)
];


void main() {
  test('KanjiVG conversion', () async {
    
    // setup 
    DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
    await db.deleteDB();

    // convert krad / radk file
    Stopwatch s = Stopwatch()..start();
    await addKanjiVGToDB(kanjiVGPath, db);
    print("Converting svg took: ${s.elapsedMilliseconds}ms");

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
