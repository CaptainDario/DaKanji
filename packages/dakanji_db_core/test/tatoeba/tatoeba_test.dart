import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/tatoeba_parser.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

void main() async {

  return;

  late DaKanjiDB db;
   setUpAll(() async {
     db = await setupFreshDB();
   });
   tearDownAll(() async {
     await db.close();
   });

  /*
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
  */
}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);

  // convert krad / radk file
  Stopwatch s = Stopwatch()..start();
  Directory tatoebaConvertedDir = Directory(p.join(tmpPath, "tatoeba"));
  tatoebaConvertedDir.createSync();

  await convertTatoebaDataSource(
    File(tatoebaLinksInputPath), File(tatoebaSentencesInputPath), tatoebaConvertedDir);
  print("Converting radicals took: ${s.elapsedMilliseconds}ms");

  return db;

}