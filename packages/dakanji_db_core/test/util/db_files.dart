import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:path/path.dart' as p;

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:universal_io/io.dart';


/// For some tests it is desirable to only import a subset of the dictionary
/// files. This function copies the yomitan test dictionary files to a temporary
/// location excluding the desired files (e.g. term_bank_1.json) and then
/// initializes the database with only those files.
Future<void> partialInit(
  DaKanjiDB db,
  bool Function(File) shouldIncludeFile,
  String folderName,
  {
    List<File> otherFilesToCopy = const [],
  }
) async {

  print("Copying neccessary files to tmp location...");
  Directory d = Directory(p.joinAll([tmpPath, folderName]));
  if(d.existsSync()) d.deleteSync(recursive: true);
  d.createSync();
  for (var file in Directory(yomitanSampleDictionaryPath).listSync()) {
    if (file is File && shouldIncludeFile(file)) {
      await file.copy(p.joinAll([d.path, p.basename(file.path)]));
    }
  }

  for (var file in otherFilesToCopy) {
    await file.copy(p.joinAll([d.path, p.basename(file.path)]));
  }

  print("Setting up test database...");
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(d, db, true);
  print("Database setup and conversion took ${s.elapsedMilliseconds} ms.");

}