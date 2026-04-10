
import 'package:da_db/database/da_db.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../../shared_utils/lib/da_db_paths.dart';
import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'audio_list_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaDb db = await setupFreshDb(
    p.join(daDbDataFilesPath, 'example_audio_sources'), true);
  
  // convert the test files
  Stopwatch s = Stopwatch()..start();
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testAudio(db);
  });

}

Future testAudio(DaDb db) async {
  
  final results = (await db.audioSourceListDao.getAllAudioSources())
    .map(((e) => audioSourceListEntryIgnoreDatabaseGeneratedData(e)))
    .toList();
  final testCases = audioListTestCases
    .map(((e) => audioSourceListEntryIgnoreDatabaseGeneratedData(e)))
    .toList();

  expect(results.length, testCases.length);

  for (int i = 0; i < testCases.length; i++) {
    
    expect(results.contains(testCases[i]), true);
  }
}
