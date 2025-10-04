// Package imports:
import 'package:dakanji_db_core/parsing/example/example_text_parser.dart';
import 'package:dakanji_db_core/parsing/parsing_util.dart';

import '/parsing/example/example_sentence_parser.dart';
import 'package:mecab_for_dart/mecab_dart.dart';


// Project imports:
import '/database/dakanji_db.dart';

/// Parses the given dakanji example folder
Future parseExampleDataSource(String exampleDir, DaKanjiDB db, Mecab mecab) async {

  Iterable<({String fileName, String fileContent})> dataSources = 
    dakanjiDBDataSourceIterator(archivePath: exampleDir);

  // parse the example bank files
   for (final ({String fileName, String fileContent}) data in dataSources) {

    if(data.fileName.endsWith(".txt")) {
      await parseExampleText(data.fileContent, db, mecab);
    }
    else if(data.fileName.endsWith(".json")) {
      await parseExampleSentence(data.fileContent, db, mecab);
    }

  }

}
