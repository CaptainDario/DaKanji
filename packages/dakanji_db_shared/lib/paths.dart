
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

/// Finds the project root by searching upwards for a `melos.yaml` file.
///
/// Starts from the current directory and traverses up the file system.
/// Throws a StateError if the root is not found.
String findProjectRoot() {
  var dir = Directory.current;
  
  // The anchor file that identifies the project root.
  const anchorFileName = '.dakanji_db_mono_repo_root';

  while (true) {
    // Check if the anchor file exists in the current directory.
    final files = dir.listSync();
    if (files.any((file) => p.basename(file.path) == anchorFileName)) {
      return dir.path;
    }

    // If not found, move to the parent directory.
    final parent = dir.parent;

    // Check for the filesystem root to prevent an infinite loop.
    if (parent.path == dir.path) {
      throw StateError(
        'Could not find project root containing "$anchorFileName".',
      );
    }
    
    dir = parent;
  }
}

/// The root path of the DaKanji project.
final String dakanjiDbProjectRoot = findProjectRoot();

/// the tmp path of the project
final String tmpPath = p.joinAll([dakanjiDbProjectRoot, "tmp"]);

/// the path where the dakanji database should be created and populated
final dakanjiDbPath = p.joinAll([tmpPath,"dakanji.db"]);
/// Path to the folder that contains data files
final dataFilesPath = p.joinAll([dakanjiDbProjectRoot, "data"]);

/// --- MECAB FILES ------------------------------------------------------------
/// Path to the folder that contains the files for mecab
final mecabFilesPath = p.joinAll([dakanjiDbProjectRoot, "mecab"]);
/// Path to the mecab dynamic library
final mecabDynamicLibPath = p.joinAll([mecabFilesPath, "mecab.dylib"]);
/// Path to the mecab dictionary
final mecabDicPath = p.joinAll([mecabFilesPath, "unidic"]);


/// --- TESTING FILES ----------------------------------------------------------
/// Path to the folder that contains yomitan dictionary samples for development
final yomitanSampleDictionaryPath = p.joinAll([dataFilesPath, "yomitan"]);

/// Path to the folder that contains example sentences for development
final devExampleSentencesPath = p.joinAll([dataFilesPath, "example_sentences"]);
/// Path to the folder that contains example texts for development
final devExampleTextsPath = p.joinAll([dataFilesPath, "example_texts"]);

/// Path to the folder that contains audio list examples for development
final devExampleAudioListPath = p.joinAll([dataFilesPath, "example_audio_sources"]);

/// Path to the folder that contains audio examples (format 1, 2, 3) for development
/// - format 1: file name format
/// - format 2: index format
/// - format 3: entries format
final devExampleAudioPath = p.joinAll([dataFilesPath, "example_audio_files", ]);
/// Path to the folder that contains audio examples (format 1) for development
final devExampleAudio1Path = p.joinAll([devExampleAudioPath, "file_name_format"]);
/// Path to the folder that contains audio examples (format 2) for development
final devExampleAudio2Path = p.joinAll([devExampleAudioPath, "index_format"]);
/// Path to the folder that contains audio examples (format 3) for development
final devExampleAudio3Path = p.joinAll([devExampleAudioPath, "entries_format"]);


/// --- DAKANJI DB FILES -------------------------------------------------------
/// Path to the folder that contains the input files for creating DaKanji DB
final dakanjiDBInputFilesPath = p.joinAll([dataFilesPath, "dakanji_db_input_files"]);


/// JMdict input file name
final jmdictFileName = "JMdict";
/// KANJIDIC input file folder 'pattern'
final kanjidic2Pattern = "KANJIDIC";
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
final jmdictInputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(jmdictFileName))
  .first.path;
/// path to the kanjidic2 files input files that should be parsed
final kanjidic2InputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(kanjidic2Pattern))
  .first.path;
/// path to the kanjivg folder input files that should be parsed
final kanjiVGInputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(kanjiVGPathPattern))
  .first.path;
/// path to the krad file input files that should be parsed
final kradInputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(kradPathPattern))
  .first.path;
/// path to the radk file input files that should be parsed
final radkInputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(radkPathPattern))
  .first.path;
/// path to the tatoeba input files that should be parsed
final tatoebaLinksInputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(tatoebaLinksFilePattern))
  .first.path;
/// path to the tatoeba input files that should be parsed
final tatoebaSentencesInputPath = Directory(dakanjiDBInputFilesPath)
  .listSync().where((e) => p.basename(e.path).contains(tatoebaSentencesFilePattern))
  .first.path;

/// path to the tests folder
final coreTestsPath = p.joinAll([dakanjiDbProjectRoot, "packages", "dakanji_db_core", "test"]);