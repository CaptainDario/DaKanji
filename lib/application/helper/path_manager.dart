import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;



/// Class to manage frequently paths / directories and to bundle them
/// in one place
class PathManager {

  /// Applications documents directory
  late final Directory documentsDirectory;
  /// The folder in the documents directory where dakanji does store its files
  late final Directory dakanjiDocumentsDirectory;
  /// The directory where the files of the DoJG are stored
  late final Directory dojgDirectory;
  /// The directory where the audios are stored
  late final Directory audiosDirectory;


  PathManager();

  Future<void> init() async {

    documentsDirectory = (await path_provider.getApplicationDocumentsDirectory());

    dakanjiDocumentsDirectory = Directory(p.joinAll([documentsDirectory.path, "DaKanji"]));

    audiosDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "audios"]));

    dojgDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "dojg"]));

  }
 
}