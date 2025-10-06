// Package imports:
import 'package:language_processing/japanese/sentence_parsing.dart';
import 'package:language_processing/japanese/sentence_finding.dart';
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

// Project imports:
import '/database/dakanji_db.dart';


/// parses the given file's contents and adds it to the given [DaKanjiDB]
Future parseExampleText(String exampleText, DaKanjiDB db, Mecab mecab, int indexId) async {

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
      id: Value(++maxExampleId),
      indexId: Value(indexId),
      exampleSentence: Value(sentence),
      exampleSentenceTokenized: Value(tokenized)
    ));

  }

  // bulk add all data
  await db.batch((batch) {

    db.exampleTable.insertAll(exampleComps);

  },);

}
