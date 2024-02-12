// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_provider;

/// Class to manage frequently used paths / directories and to bundle them
/// in one place
class PathManager {

  /// Applications documents directory
  late final Directory documentsDirectory;
  /// The folder in the documents directory where dakanji does store its files
  late final Directory dakanjiDocumentsDirectory;
  /// The folder in the documents directory in which all dictionary files are stored
  late final Directory dictionaryDirectory;
  /// The folder in the documents directory in which all wordlist files are stored
  late final File wordListsSqlFile;
  /// The folder in the documents directory that contains the stats sqlite DB
  late final Directory statsDirectory;
  /// The directory where the files of the DoJG are stored
  late final Directory dojgDirectory;
  /// The directory where the audios are stored
  late final Directory audiosDirectory;


  PathManager();

  Future<void> init() async {

    documentsDirectory = (await path_provider.getApplicationDocumentsDirectory());

    dakanjiDocumentsDirectory = Directory(p.joinAll([documentsDirectory.path, "DaKanji"]));

    statsDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "stats"]));

    dictionaryDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "assets", "dict"]));

    wordListsSqlFile = File(p.joinAll([dakanjiDocumentsDirectory.path, "wordlists.sqlite"]));

    audiosDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "audios"]));

    dojgDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "dojg"]));

  }
 
}
