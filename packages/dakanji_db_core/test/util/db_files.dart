import 'package:archive/archive_io.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';


/// For some tests it is desirable to only import a subset of the dictionary
/// files. This function copies the yomitan test dictionary files to a temporary
/// location excluding the desired files (e.g. term_bank_1.json) and then
/// initializes the database with only those files.
Future<void> partialInit(
  DaKanjiDB db,
  bool Function(File) shouldIncludeFile,
  String folderName,
  Mecab mecab,
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

  await ZipFileEncoder().zipDirectory(
    d, filename: "${d.path}.zip", level: 1,);

  print("Setting up test database...");
  Stopwatch s = Stopwatch()..start();
  Stream<String> parsingProgress = await parseDictionaryDataSource(
    dataSourcePath: "${d.path}.zip",
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );
  await for (final progress in parsingProgress) {
    print(progress);
  }
  print("Database setup and conversion took ${s.elapsedMilliseconds} ms.");

}

/// Create a temporary zip file from the base data for testing purposes
/// 
/// Returns the path to the created zip file
Future<String> createTmpZip(Directory dicrectoryToZip) async {

  // create a temporary zip folder form the base data
  final encoder = ZipFileEncoder();
  String zipFilePath = p.joinAll([tmpPath, "${p.basename(dicrectoryToZip.path)}.zip"]);
  await encoder.zipDirectory(dicrectoryToZip, filename: zipFilePath);

  return zipFilePath;

}