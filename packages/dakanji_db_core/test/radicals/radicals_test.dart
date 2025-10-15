// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/parsing/radicals_parser.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:universal_io/io.dart';
import 'radicals_test_cases.dart';

void main() async {

  Stopwatch s = Stopwatch();
  late DaKanjiDB db;
   setUpAll(() async {
     db = await setupFreshDB();
   });
   tearDownAll(() async {
     await db.close();
   });


  group('Radical Lookups', () {
    // test radical lookups
    for (final testCase in radicalLookuptests) {
      test('Looking up radicals of ${testCase.item1}', () async {
        s.reset();
        List<String> radicals = await db.radicalDao.getKanjiRadicals(testCase.item1);
        print("Looking up radicals of ${testCase.item1} took ${s.elapsedMilliseconds}ms");
        
        expect(radicals, testCase.item2);

      }); 
    }
  });

  group("Lookup Kanji by radical", () {
    // test kanji lookup from radicals
    for (var testCase in kanjiLookuptests) {
      test('Looking up kanjis that use ${testCase.item1}', () async {
        s.reset();
        List<String> kanjis = await db.radicalDao.getKanjisThatUseRadicals(testCase.item1);
        print("Looking up kanjis that use ${testCase.item1} took ${s.elapsedMilliseconds}ms");

        if(testCase.item2 is int){
          expect(kanjis.length, testCase.item2);
        }
        else if(testCase.item2 is String){
          expect(kanjis.first, testCase.item2);
        }
      });
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // setup 
  if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);

  // convert krad / radk file
  Stopwatch s = Stopwatch()..start();
  await addRadicalsToDB(radkInputPath, kradInputPath, db);
  print("Converting radicals took: ${s.elapsedMilliseconds}ms");

  return db;

}
