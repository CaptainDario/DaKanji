import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;



/// Class to manage frequently paths / directories and to bundle them
/// in one place
class PathManager {

  /// Applications documents directory
  late final Directory documentsDirectory;
  ///
  late final Directory dakanjiDocumentsDirectory;

  late final Directory dojgDirectory;

  late final Directory audiosDirectory;


  PathManager();

  Future<void> init() async {

    documentsDirectory = (await path_provider.getApplicationDocumentsDirectory());

    dakanjiDocumentsDirectory = Directory(p.joinAll([documentsDirectory.path, "DaKanji"]));

    audiosDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "audios"]));

    dojgDirectory = Directory(p.joinAll([dakanjiDocumentsDirectory.path, "dojg"]));

  }
 
}