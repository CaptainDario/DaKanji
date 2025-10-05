import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';



void main() async {

  if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);

  Stopwatch s = Stopwatch()..start();

  Stream<String> progressStream = await parseDictionaryDataSource(
    dataSourcePath: jmdictInputPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: Mecab()..init(mecabDynamicLibPath, mecabDicPath, true)
  );
  await for (final String progressMessage in progressStream) {
    print(progressMessage);
  }

  print("Done in ${s.elapsedMilliseconds}ms");

  exit(0);

}