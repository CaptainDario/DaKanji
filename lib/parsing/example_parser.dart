// Package imports:
import 'package:dakanji_db/parsing/example/example_sentence_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



/// Parses the given yomitan dictionary zip
Future parseExampleSentenceZip (File dictZip, DaKanjiDB db, Mecab mecab) async {

  // TODO

}

/// Parses the given dakanji example folder
Future parseExampleSentenceFolder(Directory exampleDir, DaKanjiDB db, Mecab mecab) async {

  /// Get all folders that contain examples
  List<Directory> exampleFolders = exampleDir.listSync()
    .whereType<Directory>().toList();

  // parse the example bank files
  for (var folder in exampleFolders) {
    
    await parseExample(folder, db, mecab);

  }

}
