// Package imports:
import 'package:drift/drift.dart';
//import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';

/// parses the given file's contents and adds it to the given [DaKanjiDB]
Future parseMultiExampleFile(File indexJsonPath, DaKanjiDB db) async {

  String jsonString = indexJsonPath.readAsStringSync();
  return await parseMultiExample(jsonString, db);

}

/// parses the given string and adds it to the given [DaKanjiDB]
Future parseMultiExample(String indexJson, DaKanjiDB db) async {

  //Mecab mecab = Mecab();
  //await mecab.init("./ipadic", true);

  List<String> lines = indexJson.split('\n');

  // read the header
  List<String> header = lines.first.split("\t");

  // read values from current db
  int maxExampleId = await db.exampleDao.maxExampleId();
  int maxExampleTransId = await db.exampleDao.maxExampleTranslationId();
  Map<String, int> allLanguageCodes =
    { for (var e in await db.languageCodeDao.getAllLanguageCodes()) e.languageCode : e.id };
  int maxLanguageCodeId = await db.languageCodeDao.maxExampleTranslationId();
  Map<String, int> allTerms =
    { for (var e in await db.termDao.getAllTerms()) e.term : e.id };
  int maxTermId = await db.termDao.maxTermId();

  // read the examples
  List<ExampleTableCompanion> exampleComps = [];
  List<TermTableCompanion> termComps = [];
  List<ExampleTermRelationsTableCompanion> exampleTermRelComps = [];
  List<LanguageCodeTableCompanion> languageCodeComps = [];
  List<ExampleTranslationTableCompanion> exampleTranslationComps = [];
  List<ExampleTranslationRelationsTableCompanion> exampleTransRelComps = [];
  for (var i = 1; i < lines.length; i++) {
    
    // split languages
    List<String> line = lines[i].split("\t");

    // create japanese 
    String jap = line.first;
    exampleComps.add(ExampleTableCompanion(
      id: Value(++maxExampleId), exampleSentence: Value(jap)
    ));

    // TODO parse sentence using mecab
    /*List<String> terms = mecab.parse(jap).map((e) => e.surface,).toList();
    for (var term in terms) {
      if(allTerms[term] == null){
        allTerms[term] = ++maxTermId;
        termComps.add(TermTableCompanion(
          id: Value(maxTermId), term: Value(term)
        ));
      }
      exampleTermRelComps.add(ExampleTermRelationsTableCompanion(
        exampleId: Value(maxExampleId), termId: Value(allTerms[term]!)
      ));
    }*/

    // parse all translations and create links between japanese and translation
    for (var i = 1; i < line.length; i++) {

      if(allLanguageCodes[header[i]] == null){
        allLanguageCodes[header[i]] = ++maxLanguageCodeId;
        languageCodeComps.add(LanguageCodeTableCompanion(
          id: Value(maxLanguageCodeId), languageCode: Value(header[i])
        ));
      }

      exampleTranslationComps.add(ExampleTranslationTableCompanion(
        id: Value(++maxExampleTransId),
        exampleTranslation: Value(line[i]),
        languageCodeId: Value(allLanguageCodes[header[i]]!)
      ));

      exampleTransRelComps.add(ExampleTranslationRelationsTableCompanion(
        exampleId: Value(maxExampleId),
        translationId: Value(maxExampleTransId),
      ));

    }

  }

  // bulk add all data
  await db.batch((batch) {

    db.exampleTable.insertAll(exampleComps);

    db.termTable.insertAll(termComps);
    db.exampleTermRelationsTable.insertAll(exampleTermRelComps);

    db.languageCodeTable.insertAll(languageCodeComps);
    db.exampleTranslationTable.insertAll(exampleTranslationComps);

    db.exampleTermRelationsTable.insertAll(exampleTermRelComps);
    db.exampleTranslationRelationsTable.insertAll(exampleTransRelComps);

  },);

}
