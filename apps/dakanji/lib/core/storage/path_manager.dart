// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_provider;

/// Class to manage frequently used paths / directories and to bundle them
/// in one place
class PathManager {

  /// The folder where dakanji does store its files
  late final Directory dakanjiSupportDirectory;

  /// The directory where the audios are stored
  late final Directory audiosDirectory;
  /// The folder in the support directory in which all dictionary files are stored
  late final Directory dictionaryDirectory;

  /// The path to the user data sqlite DB, this contains
  /// * word lists
  /// * search history
  /// * usage stats
  /// * time tracking data
  late final File userDataSqlite;

  /// directory that contains all files necessary for ml inference
  late final Directory mlDirectory;
  /// The directory for the single char recognition cnn
  late final Directory singleCharCNNDirectory;


  PathManager();

  Future<void> init() async {

    Directory supportDirectory = (await path_provider.getApplicationSupportDirectory());
    dakanjiSupportDirectory = Directory(p.joinAll([supportDirectory.path, "DaKanji"]));

    audiosDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "audios"]));
    dictionaryDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "assets", "dict"]));

    userDataSqlite = File(p.joinAll([dakanjiSupportDirectory.path, "user_data.sqlite"]));

    mlDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "assets", "ml"]));
    singleCharCNNDirectory = Directory(p.joinAll([mlDirectory.path, "CNN_single_char"]));

  }
 
}
