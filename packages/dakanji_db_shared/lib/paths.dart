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

final String _projectRoot = findProjectRoot();

/// the path where the dakanji database should be created and populated
final dakanjiDbPath = p.joinAll([_projectRoot, "tmp", "dakanji.db"]);

/// Path to the folder that contains data files
final dataFilesPath = p.joinAll([_projectRoot, "data"]);
/// Path to the folder that contains the input files for creating DaKanji DB
final inputFilesPath = p.joinAll([dataFilesPath, "dakanji_db_input_files"]);

/// Path to the folder that contains yomitan dictionary samples for development
final yomitanSampleDictionaryPath = p.joinAll([dataFilesPath, "yomitan"]);
/// Path to the folder that contains example sentences for development
final devExampleSentencesPath = p.joinAll([dataFilesPath, "example_sentences"]);
/// Path to the folder that contains example texts for development
final devExampleTextsPath = p.joinAll([dataFilesPath, "example_texts"]);

/// path to the kanjidic2 files that should be parsed
final kanjidic2Path = p.joinAll([inputFilesPath, "KANJIDIC_english"]);
/// path to the kanjivg folder that should be parsed
final kanjiVGPath = p.joinAll([inputFilesPath, "kanji"]);
/// path to the radical files that should be parsed
final radicalsPath = p.joinAll([inputFilesPath, "radicals"]);

/// path to the tests folder
final testsPath = p.joinAll([Directory.current.path, "test"]);