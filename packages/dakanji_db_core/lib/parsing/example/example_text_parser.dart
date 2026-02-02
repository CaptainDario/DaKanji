
import 'package:drift/drift.dart';
import 'package:language_processing/japanese/sentence_finding.dart';

import '/database/dakanji_db.dart';


/// parses the given file's contents and adds it to the given [DaKanjiDB]
Future parseExampleText(String exampleText, DaKanjiDB db, int indexId) async {

  /// list of examples to add
  List<ExampleTableCompanion> exampleComps = [];

  // split text into sentences
  for (var sentence in findSentencesRegexp(exampleText)) {

    // Parse sentence using mecab
    String tokenized = db.languageProcessor.getReadings(sentence);

    // add sentence to db
    exampleComps.add(ExampleTableCompanion(
      indexId: Value(indexId),
      exampleSentence: Value(sentence),
      exampleSentenceTokenized: Value(tokenized)
    ));

  }

  // bulk add all data
  await db.batch((batch) {
    db.exampleTable.insertAll(exampleComps, mode: InsertMode.insertOrIgnore);
  },);

}
