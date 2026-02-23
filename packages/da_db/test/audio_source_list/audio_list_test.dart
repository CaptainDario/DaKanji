
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/audio_source_list/audio_source_list_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../dictionary_test_variables.dart';
import 'audio_list_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaDb db = DaDb(
    dbPath: daDbTestPath, inMemory: true, languageProcessor: await japaneseProcessor);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseAudioFile(File(p.join(devExampleAudioListPath, "audio_list.json")), db, 1);
  //await parseDictionaryFolder(Directory(devExampleAudioPath), db, true);
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
