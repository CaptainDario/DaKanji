// Package imports:
import 'package:dakanji_db_core/parsing/audio/audio_source_list_parser.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'audio_list_test_cases.dart';
import 'package:path/path.dart' as p;

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseAudioFile(File(p.join(devExampleAudioPath, "audio_list.json")), db, 1);
  //await parseDictionaryFolder(Directory(devExampleAudioPath), db, true);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testAudio(db);
  });

}

/// tests the termBankV3 import of the sample database from the yomitan dictionary
Future testAudio(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (int i = 0; i < audioTestCases.length; i++) {
   
  }
}
