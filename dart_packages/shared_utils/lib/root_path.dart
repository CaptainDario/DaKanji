
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

/// Finds the project root by searching upwards for a `anchorFileName` file.
///
/// Starts from the current directory and traverses up the file system.
/// Throws a StateError if the root is not found.
String findProjectRoot(String anchorFileName) {
  var dir = Directory.current;

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
final String monoRepoRoot = findProjectRoot(".mono_repo_root");

// --- MECAB FILES ------------------------------------------------------------
/// Path to the folder that contains the files for mecab
final mecabFilesPath = p.joinAll([monoRepoRoot, "mecab"]);
/// Path to the mecab dictionary
final mecabDicPath = p.joinAll([mecabFilesPath, "unidic"]);