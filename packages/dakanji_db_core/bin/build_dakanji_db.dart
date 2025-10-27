
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:dakanji_db_core/parsing/kanji_vg_parser.dart';
import 'package:dakanji_db_core/parsing/radicals_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

import 'get_sources.dart';

void main(List<String> args) async {

  // parse command line args
  bool downloadSourcesArg = args.contains('--download-sources');
  if(downloadSourcesArg) await downloadSources();
  
  // setup 
  if(File(dakanjiDbPath).existsSync()) {
    print("Deleting old database at $dakanjiDbPath");
    File(dakanjiDbPath).deleteSync();
  }
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: false);

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  print("Adding KanjiVG...");
  await kanjiVG(db);

  print("Adding radicals data...");
  await radicals(db);

  print("Adding KanjiDic2...");
  await kanjidic2(db, mecab);

  print("Adding JMDict");
  await jmdict(db, mecab);

  exit(0);

}

/// Downloads all source files into the input files directory
Future downloadSources() async {

  print("Cleaning up old source files...");
  Directory out = Directory(dakanjiDBInputFilesPath);
  out.listSync()
    .where((f) => p.basename(f.path) != ".gitkeep")
    .forEach((f) => f.deleteSync(recursive: true));

  print("Downloading source files...");
  final (kanjiVGDownloadInfo, kanjiVGFileName) =
    await getSourceFromGHRelease('KanjiVG', 'kanjivg', 'kanjivg', 'all.zip', out);

  final (radkDownloadInfo, radkFileName) =
    await getSourceFromGHRelease('scriptin', 'jmdict-simplified', 'radk', '.json.zip', out);
  final (kradDownloadInfo, kradFileName) =
    await getSourceFromGHRelease('scriptin', 'jmdict-simplified', 'krad', '.json.zip', out);

  final (jmdictDownloadInfo, jmdictFileName) =
    await getSourceFromGHRelease('yomidevs', 'jmdict-yomitan', 'JMdict', 'english.zip', out);
  final (kanjiDic2DownloadInfo, kanjiDic2FileName) =
    await getSourceFromGHRelease('yomidevs', 'jmdict-yomitan', 'KANJIDIC', 'english.zip', out);

  //final (tatoebaLinksDownloadInfo, tatoebaLinksFileName) =
  //  await getSourceFromUri(Uri.parse('https://downloads.tatoeba.org/exports/links.tar.bz2'), out);
  //final (tatoebaSentencesDownloadInfo, tatoebaSentencesFileName) =
  //  await getSourceFromUri(Uri.parse('https://downloads.tatoeba.org/exports/sentences.tar.bz2'), out);

  // TODO audio files

  print("All downloads completed, writing summary file.");
  File sourcesList = File(p.join(out.path, 'sources_list.txt'))..createSync();
  sourcesList.writeAsStringSync(
    'KanjiVG: $kanjiVGDownloadInfo\n'
    'Krad: $kradDownloadInfo\n'
    'Radk: $radkDownloadInfo\n'
    'JMDict: $jmdictDownloadInfo\n'
    'KanjiDic2: $kanjiDic2DownloadInfo\n'
    //'Tatoeba Links: $tatoebaLinksDownloadInfo\n'
    //'Tatoeba Sentences: $tatoebaSentencesDownloadInfo'
  );

  print("Converting files...");
  print("Tatoeba data");
  //await convertTatoebaDataSource(
  //  File(tatoebaLinksFileName), File(tatoebaSentencesFileName), out);

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
  Stream<String> kanjiDic2Progress = await parseDictionaryDataSource(
    dataSourcePath:  kanjidic2InputPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );

  await for (final progress in kanjiDic2Progress) {
    print(progress);
  }
  
  print("Converting KanjiDic2 took: ${s.elapsedMilliseconds}ms");

}

/// parses jmdict and adds it to the given [DaKanjiDB]
Future jmdict(DaKanjiDB db, Mecab mecab) async {

  Stopwatch s = Stopwatch()..start();
  Stream<String> jmdictProgress = await parseDictionaryDataSource(
    dataSourcePath: jmdictInputPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );

  await for (final progress in jmdictProgress) {
    print(progress);
  }

  print("Converting JMDict took: ${s.elapsedMilliseconds}ms");

}

/// parses tatoeba and adds it to the given [DaKanjiDB]
Future tatoeba(DaKanjiDB db, Mecab mecab) async {

  Stopwatch s = Stopwatch()..start();
  await parseExampleDataSource("", db, mecab);
  print("Converting Tatoeba took: ${s.elapsedMilliseconds}ms");

}
