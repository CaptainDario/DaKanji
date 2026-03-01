import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'kanji_meta_bank_test_cases.dart';

void main() {
  
  late DaDb db;
   setUpAll(() async {
     db = await setupFreshDb(yomitanSampleDictionaryPath);
   });
   tearDownAll(() async {
     await db.close();
   });
  
  group("Test importing kanji meta bank", () {
    // Check some kanji bank queries
    for (var testCase in kanjiMetaBankTetsCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List result = (await db.kanjiMetaBankV3Dao.search(testCase))
          .map((e) => kanjiMetaBankEntryIgnoreDatabaseGeneratedData(e)).toList();
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
        print("result $result");
        print("Expectation $kanjiMetaBankTetsCaseExpectations");

        expect(result.isNotEmpty, true);
        for (var entry in result) {
          expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
        }
      });
    }
  });

}
