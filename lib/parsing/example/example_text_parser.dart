// Package imports:
import 'package:dakanji_db/parsing/japanese_processing/mecab_parsing.dart';
import 'package:dakanji_db/parsing/japanese_processing/sentence_finding.dart';
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
//import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



Future parseExampleTextFileZip() async {

  // TODO

}

Future parseExampleTextFolder(Directory exampleTextDirectory, DaKanjiDB db, Mecab mecab) async {

  List<File> exampleFiles = exampleTextDirectory.listSync().whereType<File>().toList();

  for (File file in exampleFiles) {
    await parseExampleTextFile(file, db, mecab);
  }

}

/// parses the given file's contents and adds it to the given [DaKanjiDB]
Future parseExampleTextFile(File exampleTextPath, DaKanjiDB db, Mecab mecab) async {

  String jsonString = exampleTextPath.readAsStringSync();
  return await parseTextExample(jsonString, db, mecab);

}

/// parses the given string and adds it to the given [DaKanjiDB]
Future parseTextExample(String exampleText, DaKanjiDB db, Mecab mecab) async {

  // read values from current db
  int maxExampleId = await db.exampleDao.maxExampleId();
  // read the examples
  List<ExampleTableCompanion> exampleComps = [];

  // split text into sentences
  for (var sentence in findSentencesRegexp(exampleText)) {

    // Parse sentence using mecab
    String tokenized = await parseSentenceUsingMecab(sentence, mecab);

    // add sentence to db
    exampleComps.add(ExampleTableCompanion(
      id: Value(++maxExampleId), exampleSentence: Value(sentence),
      exampleSentenceTokenized: Value(tokenized)
    ));

  }

  // bulk add all data
  await db.batch((batch) {

    db.exampleTable.insertAll(exampleComps);

  },);

}
