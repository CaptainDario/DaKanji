
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/audio/audio_parser.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_core/parsing/example_parser.dart';
import 'package:dakanji_db_core/parsing/kanji_vg_parser.dart';
import 'package:dakanji_db_core/parsing/radicals_parser.dart';
import 'package:dakanji_db_core/parsing/tatoeba_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:language_processing/language_processing.dart';
import 'package:language_processing/language_processor.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

import '../test/test_utils/db_files.dart';
import 'get_sources.dart';


enum DictsToUse {
  jmdict,
  jitendex,
} 

Map<DictsToUse, String Function()> dictNameToPath = {
  DictsToUse.jmdict: () => jmdictInputPath,
  DictsToUse.jitendex: () => jitendexInputPath,
};

/// The main function to build the DaKanji database
/// 
/// Args:
///   --use-jitendex : Use jitendex as dictionary instead of jmdict
///   --download-sources : Redownload all source files
///   --include-example-dict : Include the yomitan example dictionary
///   --convert-tatoeba : Convert the tatoeba example sentences and include them
///   --add-structured-content-json-definitions : Add structured content JSON-
///     definitions to the database
void main(List<String> args) async {

  // extract arguments
  bool useJitendexArg = args.contains('--use-jitendex');
  bool downloadSourcesArg = args.contains('--download-sources');
  bool includeExampleDictArg = args.contains('--include-example-dict');
  bool includeTatoebaExamplesArg = args.contains('--convert-tatoeba');
  bool addStructuredContentJsonDefs = args.contains('--add-structured-content-json-definitions');

  // check which dictionary to use 
  DictsToUse dictToUse = DictsToUse.jmdict;
  if(useJitendexArg) {
    print("Using jitendex as dictionary...");
    dictToUse = DictsToUse.jitendex;
  }
  
  // clear old sources and redownload
  if(downloadSourcesArg) {
    print("Redownloading source files...");
    await downloadSources(dictToUse, includeTatoebaExamplesArg);
  }

  // include yomitan example dictionary
  late String exampleDictPath;
  if(includeExampleDictArg) {
    print("Including example dictionary...");
    exampleDictPath = await createTmpZip(Directory(yomitanSampleDictionaryPath));
  }

  // check whether tatoeba examples should be included
  if(includeTatoebaExamplesArg) {
    File tatoeZip = File(tatoebaInputZipPath);
    if(tatoeZip.existsSync()) tatoeZip.deleteSync();

    print("Converting Tatoeba example sentences to DaKanji format...");
    await convertTatoebaDataSource(
      File(tatoebaLinksInputPath),
      File(tatoebaSentencesInputPath),
      tatoeZip,
      langsToInclude: {Iso639_3.eng, Iso639_3.deu}
    );
  }
  
  // setup 
  if(File(dakanjiDbPath).existsSync()) {
    print("Deleting old database at $dakanjiDbPath");
    File(dakanjiDbPath).deleteSync();
  }
  LanguageProcessor languageProcessor = JapaneseProcessor(
    mecabTransferableState: MecabTransferableState(
      libmecabPath: mecabDynamicLibPath,
      mecabDictDirPath: mecabDicPath,
      includeFeatures: true,
    )
  );
  await languageProcessor.init();
  DaKanjiDB db = DaKanjiDB(
    dbPath: dakanjiDbPath, inMemory: false, languageProcessor: languageProcessor);

  // add the default search profile
  await db.searchProfilesDao.createNewProfile(true);

  print("Importing pronunciation audio data...");
  //await importPronunciationData(db, mecab);

  print("Adding KanjiVG...");
  //await importKanjiVG(db);

  print("Adding radicals data...");
  //await importRadicals(db);

  print("Importing yomitan dicts...");
  await importYomitanDicts(db,
    [
      //(kanjidic2InputPath, "KanjiDic2"),
      //(jpdb2_2InputPath, "JPDB 2.2"),
      (dictNameToPath[dictToUse]!(), dictToUse.name),
      ?(includeExampleDictArg ? (exampleDictPath, "yomitan example dictionary"): null),
    ],
    addStructuredContentJsonDefs,
  );

  if(includeTatoebaExamplesArg){
    print("Adding tatoeba example sentences...");
    await importTatoebaExamples(db);
  }

  exit(0);

}

/// Downloads all source files into the input files directory
Future downloadSources(DictsToUse dictToUse, bool downloadTatoeba) async {

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

  String? jmdictDownloadInfo, jmdictFileName;
  if(dictToUse == DictsToUse.jmdict) {
    (jmdictDownloadInfo, jmdictFileName) =
      await getSourceFromGHRelease('yomidevs', 'jmdict-yomitan', 'JMdict', 'english.zip', out);
  }
  final (kanjiDic2DownloadInfo, kanjiDic2FileName) =
    await getSourceFromGHRelease('yomidevs', 'jmdict-yomitan', 'KANJIDIC', 'english.zip', out);

  String? jitendexDownloadInfo, jitendexFileName;
  if(dictToUse == DictsToUse.jitendex) {
    (jitendexDownloadInfo, jitendexFileName) = 
      await getSourceFromUri(
        Uri.parse('https://github.com/stephenmk/stephenmk.github.io/releases/latest/download/jitendex-yomitan.zip'), out);
  }

  final (jpdb2_2FreqDownloadInfo, jpdb2_2FreqFileName) = 
    await getSourceFromUri(
      Uri.parse('https://github.com/Kuuuube/yomitan-dictionaries/raw/main/dictionaries/JPDB_v2.2_Frequency_Kana_2024-10-13.zip'), out);

  
  String? tatoebaLinksDownloadInfo, tatoebaLinksFileName;
  String? tatoebaSentencesDownloadInfo, tatoebaSentencesFileName;
  if(downloadTatoeba){
    await getSourceFromUri(Uri.parse('https://downloads.tatoeba.org/exports/links.tar.bz2'), out);
    await getSourceFromUri(Uri.parse('https://downloads.tatoeba.org/exports/sentences.tar.bz2'), out);
  }

  final (pronounciationDataDownloadInfo, pronunciationDataFileName) =
    await getSourceFromUri(Uri.parse("https://github.com/CaptainDario/DaKanji-Data/releases/download/v4.0.0/japanese-vocabulary-pronunciation-audio-master-mp3.zip"), out);

  print("All downloads completed, writing summary file.");
  File sourcesList = File(p.join(out.path, 'sources_list.txt'))..createSync();
  sourcesList.writeAsStringSync(
    'KanjiVG: $kanjiVGDownloadInfo\n'
    'Krad: $kradDownloadInfo\n'
    'Radk: $radkDownloadInfo\n'
    '${jmdictDownloadInfo!=null ? 'JMDict: $jmdictDownloadInfo\n' : ''}'
    '${jitendexDownloadInfo!=null ? 'jitendex: $jitendexDownloadInfo\n' : ''}'
    'KanjiDic2: $kanjiDic2DownloadInfo\n'
    'JPDB v2.2 Frequency Kana: $jpdb2_2FreqDownloadInfo\n'
    'Tatoeba Links: $tatoebaLinksDownloadInfo\n'
    'Tatoeba Sentences: $tatoebaSentencesDownloadInfo'
    'Pronunciation Data: $pronounciationDataDownloadInfo\n'
  );
  print("Done!");

}

/// parses KanjiVG and adds it to the given [DaKanjiDB]
Future importKanjiVG(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await addKanjiVGToDB(kanjiVGInputPath, db);
  print("Converting KanjiVG took: ${s.elapsedMilliseconds}ms");

}

/// parses Radicals and adds it to the given [DaKanjiDB]
Future importRadicals(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  await addRadicalsToDB(radkInputPath, kradInputPath, db);
  print("Converting Radicals took: ${s.elapsedMilliseconds}ms");

}

/// parses the kanjidic2 and adds it to the given [DaKanjiDB]
Future importYomitanDicts(
  DaKanjiDB db,
  List<(String path, String name)> inputs,
  bool addStructuredContentJsonDefs,
) async {

  for (var i = 0; i < inputs.length; i++) {

    print(" --- Importing ${inputs[i]}... ---");
    
    Stopwatch s = Stopwatch()..start();
    Stream<String> progress = await parseDictionaryDataSource(
      dataSourcePath:  inputs[i].$1,
      db: db,
      addStructuredContentJsonDefs: addStructuredContentJsonDefs,
      isDefaultDictionary: true
    );

    await for (final progress in progress) {
      print(progress);
    }
    
    print("Imported ${inputs[i].$2} in: ${s.elapsedMilliseconds}ms"); 
  }

}

/// parses tatoeba and adds it to the given [DaKanjiDB]
Future importTatoebaExamples(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  final progress = await parseExampleDataSource(
    examplesZipPath: tatoebaInputZipPath,
    db: db,
    isDefaultDictionary: true
  );

  await for (final progress in progress) {
    print(progress);
  }
  
  print("Import Tatoeba took: ${s.elapsedMilliseconds}ms");

}

/// Import the audio data into the given [DaKanjiDB]
Future importPronunciationData(DaKanjiDB db) async {

  Stopwatch s = Stopwatch()..start();
  final progress = await parseAudioDataSource(
    audioDataSourceFile: audioInputZipPath,
    db: db,
    isDefaultDictionary: true
  );

  await for (final progress in progress) {
    print(progress);
  }
  print("Importing pronunciation data took: ${s.elapsedMilliseconds}ms");

}