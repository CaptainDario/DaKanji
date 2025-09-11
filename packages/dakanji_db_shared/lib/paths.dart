// Package imports:
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

/// Finds the project root by searching upwards for a `melos.yaml` file.
///
/// Starts from the current directory and traverses up the file system.
/// Throws a StateError if the root is not found.
String findProjectRoot() {
  var dir = Directory.current;
  
  // The anchor file that identifies the project root.
  const anchorFileName = 'melos_dakanji_db_workspace.iml';

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

final String dakanjiDbProjectRoot = findProjectRoot();

/// the path where the dakanji database should be created and populated
final dakanjiDbPath = p.joinAll([dakanjiDbProjectRoot, "tmp", "dakanji.db"]);
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
/// Path to the folder that contains audio examples for development
final devExampleAudioPath = p.joinAll([dataFilesPath, "example_audio_sources"]);

/// --- DAKANJI DB FILES -------------------------------------------------------
/// Path to the folder that contains the input files for creating DaKanji DB
final dakanjiDBInputFilesPath = p.joinAll([dataFilesPath, "dakanji_db_input_files"]);

/// KANJIDIC input file folder name
final kanjidic2Name = "KANJIDIC_english";
/// KanjiVG input file folder name
final kanjiVGPathName = "kanji";
/// Radicals input file folder name
final radicalsPathName = "radicals";
/// Tatoeba input file folder name
final tatoebaFolderName = "tatoeba";
/// Suffix added to processed files
final processedSuffix = "_processed";

/// path to the kanjidic2 files input files that should be parsed
final kanjidic2InputPath = p.joinAll([dakanjiDBInputFilesPath, kanjidic2Name]);
/// path to the kanjivg folder input files that should be parsed
final kanjiVGInputPath = p.joinAll([dakanjiDBInputFilesPath, kanjiVGPathName]);
/// path to the radical files input files that should be parsed
final radicalsInputPath = p.joinAll([dakanjiDBInputFilesPath, radicalsPathName]);
/// path to the tatoeba input files that should be parsed
final tatoebaInputPath = p.joinAll([dakanjiDBInputFilesPath, tatoebaFolderName]);

/// path to the tatoeba input files that should be parsed
final tatoebaProcessedPath = p.joinAll([dakanjiDBInputFilesPath, tatoebaFolderName + processedSuffix]);

/// path to the tests folder
final testsPath = p.joinAll([Directory.current.path, "test"]);