
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

import 'root_path.dart';


// --- DA DB PATHS -------------------------------------------------------------
final String daDbRootPath = p.join(monoRepoRoot, "dart_packages", "da_db");

/// path to the tests folder
final coreTestsPath = p.joinAll([daDbRootPath, "test"]);

/// the tmp path of the project
final String tmpPath = p.joinAll([daDbRootPath, "tmp"]);

/// the path where all generated assets will be stored
final String outPath = p.joinAll([daDbRootPath, "out"]);

/// Path to the folder that contains data files
final daDbDataFilesPath = p.joinAll([daDbRootPath, "data"]);

/// the path where the database should be created and populated for tests
final daDbTestPath = p.joinAll([tmpPath, "da.db"]);

/// Path to the folder that contains the generated database files for release
final dakanjiDbFinalPath = p.joinAll([outPath, "dakanji.db"]);

// --- TESTING FILES ----------------------------------------------------------
/// Path to the folder that contains yomitan dictionary samples for development
final yomitanSampleDictionaryPath = p.joinAll([daDbDataFilesPath, "yomitan"]);

/// Path to the folder that contains the example banks for development
final devExampleBanksPath = p.joinAll([daDbDataFilesPath, "example_banks"]);
/// Path to the folder that contains the example bank 1 for development
final devExampleBank1Path = p.joinAll([devExampleBanksPath, "example_bank_1"]);
/// Path to the folder that contains the example bank 2 for development
final devExampleBank2Path = p.joinAll([devExampleBanksPath, "example_bank_2"]);
/// Path to the folder that contains the example bank 3 for development
final devExampleBank3Path = p.joinAll([devExampleBanksPath, "example_bank_3"]);
/// Path to the folder that contains the example bank 4 for development
final devExampleBank4Path = p.joinAll([devExampleBanksPath, "example_bank_4"]);
/// Path to the folder that contains example texts for development
final devExampleTextsPath = p.joinAll([daDbDataFilesPath, "example_texts"]);

/// Path to the folder that contains audio list examples for development
final devExampleAudioListPath = p.joinAll([daDbDataFilesPath, "example_audio_sources"]);

/// Path to the folder that contains audio examples (format 1, 2, 3) for development
/// - format 1: file name format
/// - format 2: index format
/// - format 3: entries format
final devExampleAudioPath = p.joinAll([daDbDataFilesPath, "example_audio_files", ]);
/// Path to the folder that contains audio examples (format 1) for development
final devExampleAudioFileNameFormatPath = p.joinAll([devExampleAudioPath, "file_name_format"]);
/// Path to the folder that contains audio examples (format 2) for development
final devExampleAudioIndexFormatPath = p.joinAll([devExampleAudioPath, "index_format"]);
/// Path to the folder that contains audio examples (format 3) for development
final devExampleAudioEntriesFormatPath = p.joinAll([devExampleAudioPath, "entries_format"]);


// --- DAKANJI DB FILES -------------------------------------------------------
/// Path to the folder that contains the input files for creating DaKanji DB
final dakanjiDBInputFilesPath = p.joinAll([daDbDataFilesPath, "dakanji_db_input_files"]);


/// JMdict input zip file name
final jmdictFileName = "JMdict";
/// jitendex-yomitan input zip file name
final jitendexFileName = "jitendex-yomitan";
/// KANJIDIC input file zip 'pattern'
final kanjidic2Pattern = "KANJIDIC";
/// JPDB 2.2 input file zip 'pattern'
final jpdb2_2Pattern = "JPDB_v2.2_Frequency_Kana";
/// KanjiVG input file folder name
final kanjiVGPathPattern = "kanjivg";
/// Krad input file name
final kradPathPattern = "krad";
/// Radk input file name
final radkPathPattern = "radk";
/// Tatoeba input file (links) name
final tatoebaLinksFilePattern = "links";
/// Tatoeba input file (sentences) name
final tatoebaSentencesFilePattern = "sentences";
/// Suffix added to processed files
final processedSuffix = "_processed";


/// path to the jmdict input file that should be parsed
String get jmdictInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(jmdictFileName))
  .first.path;
/// path to the jitendex input zip that should be parsed
String get jitendexInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(jitendexFileName))
  .first.path;
/// path to the kanjidic2 input zip that should be parsed
String get kanjidic2InputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(kanjidic2Pattern))
  .first.path;
/// path to the jpdb2_2 input zip that should be parsed
String get jpdb2_2InputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(jpdb2_2Pattern))
  .first.path;
/// path to the kanjivg folder input files that should be parsed
String get kanjiVGInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(kanjiVGPathPattern))
  .first.path;
/// path to the krad file input files that should be parsed
String get kradInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(kradPathPattern))
  .first.path;
/// path to the radk file input files that should be parsed
String get radkInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(radkPathPattern))
  .first.path;
/// path to the tatoeba input files that should be parsed
String get tatoebaLinksInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(tatoebaLinksFilePattern))
  .first.path;
/// path to the tatoeba input files that should be parsed
String get tatoebaSentencesInputPath => Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(tatoebaSentencesFilePattern))
  .first.path;
String get tatoebaInputZipPath => p.join(dakanjiDBInputFilesPath, "tatoeba_converted.zip");
/// path to the audio input files that should be parsed
String get audioInputZipPath => p.join(dakanjiDBInputFilesPath, "japanese-vocabulary-pronunciation-audio-master-mp3.zip");