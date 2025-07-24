// Package imports:
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
//import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



/// matches full and half width punctuations
const String punctuations = "。|？|！|\\.|\\!|\\?";
/// matches japanese ending parantheses
const String japaneseParantheses = "』|」";
/// matches any whitespace
const String anyWhiteSpace = "\\s|　";
/// Regex that matches a sentence
RegExp sentenceRegex = RegExp(
  "(?:[^$anyWhiteSpace])+?(?:(?!($punctuations)$japaneseParantheses)$punctuations|\\n|\$)",
  multiLine: true
);

Future parseExampleTextFileZip() async {

  // TODO

}

/// parses the given file's contents and adds it to the given [DaKanjiDB]
Future parseExampleTextFile(File exampleTextPath, DaKanjiDB db) async {

  String jsonString = exampleTextPath.readAsStringSync();
  return await parseTextExample(jsonString, db);

}

/// parses the given string and adds it to the given [DaKanjiDB]
Future parseTextExample(String exampleText, DaKanjiDB db) async {

  // read values from current db
  int maxExampleId = await db.exampleDao.maxExampleId();
  Map<String, int> allTerms =
    { for (var e in await db.termDao.getAllTerms()) e.term : e.id };
  int maxTermId = await db.termDao.maxTermId();

  // read the examples
  List<ExampleTableCompanion> exampleComps = [];
  List<TermTableCompanion> termComps = [];

  // split text into sentences
  for (var match in sentenceRegex.allMatches(exampleText)) {

    final sentence = match.group(0)!;

    // add sentence to db
    exampleComps.add(ExampleTableCompanion(
      id: Value(++maxExampleId), exampleSentence: Value(sentence)
    ));


    // Parse sentence using mecab
    final mecab = Mecab();
    await mecab.init("mecab.dylib", "ipadic", true);
    List<String> terms = mecab.parse(sentence).map((e) => e.surface,).toList();
    for (var term in terms.sublist(0, terms.length-2)) {
      if(allTerms[term] == null){
        allTerms[term] = ++maxTermId;
        termComps.add(TermTableCompanion(
          id: Value(maxTermId), term: Value(term)
        ));
      }
    }

  }

  // bulk add all data
  await db.batch((batch) {

    db.exampleTable.insertAll(exampleComps);

    db.termTable.insertAll(termComps);

  },);

}
