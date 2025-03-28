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
  /// The folder in the support directory in which all dictionary files are stored
  late final Directory dictionaryDirectory;
  /// The sqlite file in the support directory in which all wordlists are stored
  late final File wordListsSqlFile;
  /// The sqlite file in the support directory in which the search history is stored
  late final File searchHistorySqlFile;
  /// The folder in the support directory that contains the stats sqlite DB
  late final Directory statsDirectory;
  /// The directory where the files of the DoJG are stored
  late final Directory dojgDirectory;
  /// The directory where the audios are stored
  late final Directory audiosDirectory;
  /// directory that contains all files necessary for ml inference
  late final Directory mlDirectory;
  /// The directory for the single char recognition cnn
  late final Directory singleCharCNNDirectory;


  PathManager();

  Future<void> init() async {

    Directory supportDirectory = (await path_provider.getApplicationSupportDirectory());

    dakanjiSupportDirectory = Directory(p.joinAll([supportDirectory.path, "DaKanji"]));

    statsDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "stats"]));

    dictionaryDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "assets", "dict"]));

    wordListsSqlFile = File(p.joinAll([dakanjiSupportDirectory.path, "wordlists.sqlite"]));

    searchHistorySqlFile = File(p.joinAll([dakanjiSupportDirectory.path, "searchhistory.sqlite"]));

    audiosDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "audios"]));

    dojgDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "dojg"]));

    mlDirectory = Directory(p.joinAll([dakanjiSupportDirectory.path, "assets", "ml"]));

    singleCharCNNDirectory = Directory(p.joinAll([mlDirectory.path, "CNN_single_char"]));

  }
 
}
