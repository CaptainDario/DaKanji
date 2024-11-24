import 'dart:io';

import 'package:dakanji_db/conversion/radicals.dart';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

import '../bin/dev/setup_conversion.dart';



/// List of kanjis of which the radicals should be looked up and the expected
/// result
List<Tuple2<String, List<String>>> radicalLookuptests = [
  Tuple2("丂", ["一", "勹"]),
  Tuple2("漢", ["⺡", "⺾", "口", "一", "大", "二"]),
  Tuple2("鬱", ["缶", "木", "冖", "凵", "匕", "彡", "鬯"]),
  Tuple2("暚", ["凵", "山", "日", "曰", "爪", "缶"]),
];

void main() {
  test('Radical conversion', () async {
    
    // setup 
    Tuple2<Directory, DaKanjiDB> t = setupConversion(ConversionTarget.sample);
    final DaKanjiDB db = t.item2;

    // convert krad / radk file
    final radicalsPath = 'input_files/';
    Stopwatch s = Stopwatch()..start();
    await convertRadicals(radicalsPath, db);
    print("Converting radicals took: ${s.elapsedMilliseconds}ms");

    // test radical lookups
    for (final testCase in radicalLookuptests) {

      List<String> radicals = await db.radicalDao.getKanjiRadicals(testCase.item1);
      expect(radicals, testCase.item2);

    }

    // test kanji lookup from radicals

  });
}
