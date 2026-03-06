import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'term_meta_bank_test_cases.dart';

void main() {
  
  late DaDb db;
   setUpAll(() async {
     db = await setupFreshDb(yomitanSampleDictionaryPath, false);
   });
   tearDownAll(() async {
     await db.close();
   });
  
  group('Term meta bank import test', () {
    // Check some kanji bank queries
    for (int i = 0; i < termMetaBankTestCases.length; i++) {
    
      test('should return correct metadata for "${termMetaBankTestCases[i]}"', () async {
        Stopwatch s = Stopwatch()..start();
        final testCase = termMetaBankTestCases[i];
        final result = (await db.termMetaBankV3Dao.searchTermMetaBankV3Entries(testCase))
            .map((e) => termMetaBankV3EntryIgnoreDatabaseGeneratedData(e))
            .toList();
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

        print("\n\n$i: ${termMetaBankTestCases[i]}");
        for (var res in result) {
          print("Found element: $res");
        }
        expect(result.isNotEmpty , true);
        print("Expectaiton ${termMetaBankTestCaseExpectations[i]}");
        final pass = result.any((e) => termMetaBankTestCaseExpectations[i] == e);
        expect(pass, true);
      });
    }
  });

}
