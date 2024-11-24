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

List<Tuple2<List<String>, dynamic>> kanjiLookuptests = [
  Tuple2(["一"], 2713),
  Tuple2(["一", "勹"], 111),
  Tuple2(["⺡", "⺾", "口", "一", "大", "二"], "漢"),
  Tuple2(["缶", "木", "冖", "凵", "匕", "彡", "鬯"], "鬱"),
  Tuple2(["凵", "山", "日", "曰", "爪", "缶"], "暚"),
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
