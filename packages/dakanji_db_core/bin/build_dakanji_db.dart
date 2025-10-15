// Package imports:
import 'package:dakanji_db_core/parsing/tatoeba_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/parsing/kanji_vg_parser.dart';
import 'package:dakanji_db_core/parsing/radicals_parser.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'get_sources.dart';
import 'package:path/path.dart' as p;

void main() async {

  await downloadSources();

  // setup 
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: false);
  await db.deleteDB();

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  //await kanjiVG(db);

  //await radicals(db);

  //await kanjidic2(db);

  //exit(0);

}

///
Future downloadSources() async {

  print("Cleaning up old source files...");
  Directory out = Directory(dakanjiDBInputFilesPath);
  out.listSync()
    .where((f) => p.basename(f.path) != ".gitkeep")
    .forEach((f) => f.deleteSync(recursive: true));

  print("Downloading source files...");
  String kanjiVGUri = await getSourceFromGHRelease('KanjiVG', 'kanjivg', 'kanjivg', 'all.zip', out);

  String radkUri = await getSourceFromGHRelease('scriptin', 'jmdict-simplified', 'radk', '.json.zip', out);
  String kradUri = await getSourceFromGHRelease('scriptin', 'jmdict-simplified', 'krad', '.json.zip', out);

  String jmdictUri = await getSourceFromGHRelease('yomidevs', 'jmdict-yomitan', 'JMdict', 'english.zip', out);
  String kanjiDic2Uri = await getSourceFromGHRelease('yomidevs', 'jmdict-yomitan', 'KANJIDIC', 'english.zip', out);

  String tatoebaLinksUri = await getSourceFromUri(Uri.parse('https://downloads.tatoeba.org/exports/links.tar.bz2'), out);
  String tatoebaSentencesUri = await getSourceFromUri(Uri.parse('https://downloads.tatoeba.org/exports/sentences.tar.bz2'), out);

  // TODO audio files

  print("All downloads completed, writing summary file.");
  File sourcesList = File(p.join(out.path, 'sources_list.txt'))..createSync();
  sourcesList.writeAsStringSync(
    'KanjiVG: $kanjiVGUri\n'
    'Krad: $kradUri\n'
    'Radk: $radkUri\n'
    'JMDict: $jmdictUri\n'
    'KanjiDic2: $kanjiDic2Uri\n'
    'Tatoeba Links: $tatoebaLinksUri\n'
    'Tatoeba Sentences: $tatoebaSentencesUri'
  );
  print("Done!");

}

/// parses KanjiVG and adds it to the given [DaKanjiDB]
Future kanjiVG(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await addKanjiVGToDB(kanjiVGInputPath, db);
  print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

}

/// parses Radicals and adds it to the given [DaKanjiDB]
Future radicals(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await addRadicalsToDB(radkInputPath, kradInputPath, db);
  print("Converting Radicals took: ${s.elapsedMilliseconds}ms");

}

/// parses the kanjidic2 and adds it to the given [DaKanjiDB]
Future kanjidic2(DaKanjiDB db, Mecab mecab) async {

  Stopwatch s = Stopwatch()..start();
  await parseDictionaryDataSource(
    dataSourcePath:  kanjidic2InputPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );
  print("Converting KanjiDic2 took: ${s.elapsedMilliseconds}ms");

}

/// parses tatoeba and adds it to the given [DaKanjiDB]
Future tatoeba(DaKanjiDB db, Mecab mecab) async {

  Stopwatch s = Stopwatch()..start();
  // TODO
  //await convertTatoebaFiles(
  //  Directory(tatoebaInputPath),
  //  Directory(tatoebaProcessedPath)
  //);
  print("Converting Tatoeba took: ${s.elapsedMilliseconds}ms");

}
