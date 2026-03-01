
import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../test_utils/setup_fresh_db.dart';
import 'audio_list_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaDb db = await setupFreshDb(p.join(daDbDataFilesPath, 'example_audio_sources'));
  
  // convert the test files
  Stopwatch s = Stopwatch()..start();
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testAudio(db);
  });

}

Future testAudio(DaDb db) async {
  
  final results = await db.audioSourceListDao.getAllAudioSources();

  for (int i = 0; i < audioListTestCases.length; i++) {
    expect(results.contains(audioListTestCases[i]), true);
  }
}
