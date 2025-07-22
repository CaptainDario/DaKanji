// Package imports:
import 'package:dakanji_db/parsing/example/example_bank_parser.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



/// Parses the given yomitan dictionary zip
Future parseExampleZip (File dictZip, DaKanjiDB db) async {

  // TODO

}

/// Parses the given dakanji example folder
Future parseExampleFolder(Directory exampleDir, DaKanjiDB db) async {

  /// Get all folders that contain examples
  List<Directory> exampleFolders = exampleDir.listSync()
    .whereType<Directory>().toList();

  // parse the example bank files
  for (var folder in exampleFolders) {
    
    await parseExample(folder, db);

  }

}
