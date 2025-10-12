// Package imports:
import 'package:archive/archive_io.dart';
import 'package:dakanji_db_core/parsing/audio/audio_parser.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:universal_io/io.dart';
import '../util/db_files.dart';
import 'audio_test_cases.dart';



void main() async {

  print(coreTestsPath);
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath);
  db.clearDB();



  // parse the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(devExampleAudio1Path));
  // TODO update to isolate based parsing
  await parseAudioDataSource(
    audioDataSourceFile: dataSourceZipPath, db: db);
  //await for (final event in stream) {
  //  print(event);
  //}
  print("Conversion took ${s.elapsedMilliseconds} ms");

  await testExampleTexts(db);

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testExampleTexts(DaKanjiDB db) async {

  group("Test importing audios texts", () {
    // Check some kanji bank queries
    for (int i = 0; i < audioTestCases.length; i++) {
      test('Searching: ${audioTestCases[i]}', () async {

        Stopwatch s = Stopwatch()..start();
        // TODO look up
        print("Looking up XXX took ${s.elapsedMilliseconds}ms");

        // TODO expect

      });
    }
  });
}
