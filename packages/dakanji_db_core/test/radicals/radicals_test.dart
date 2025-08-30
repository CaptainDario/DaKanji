// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/conversion/radicals.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import '../../bin/paths.dart';
import 'radicals_test_values.dart';

void main() {

  test('Radical conversion', () async {
    
    // setup 
    DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
    await db.clearDB();

    // convert krad / radk file
    Stopwatch s = Stopwatch()..start();
    await addRadicalsToDB(radicalsPath, db);
    print("Converting radicals took: ${s.elapsedMilliseconds}ms");

    // test radical lookups
    for (final testCase in radicalLookuptests) {

      s.reset();
      List<String> radicals = await db.radicalDao.getKanjiRadicals(testCase.item1);
      print("Looking up radicals of ${testCase.item1} took ${s.elapsedMilliseconds}ms");
      
      expect(radicals, testCase.item2);

    }

    // test kanji lookup from radicals
    for (var testCase in kanjiLookuptests) {
      
      s.reset();
      List<String> kanjis = await db.radicalDao.getKanjisThatUseRadicals(testCase.item1);
      print("Looking up kanjis that use ${testCase.item1} took ${s.elapsedMilliseconds}ms");

      if(testCase.item2 is int){
        expect(kanjis.length, testCase.item2);
      }
      else if(testCase.item2 is String){
        expect(kanjis.first, testCase.item2);
      }
      
    }

  });

}
