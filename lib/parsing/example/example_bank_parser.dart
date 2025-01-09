// Package imports:
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
//import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



Future parseExampleFileZip() async {

  // TODO

}

/// parses the given file's contents and adds it to the given [DaKanjiDB]
Future parseExampleFile(File exampleBankJsonPath, DaKanjiDB db) async {

  String jsonString = exampleBankJsonPath.readAsStringSync();
  return await parseExample(jsonString, db);

}

/// parses the given string and adds it to the given [DaKanjiDB]
Future parseExample(String exampleBankJson, DaKanjiDB db) async {

  List<String> lines = exampleBankJson.split('\n');

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
    
    // split languages and check that valid data is contained
    List<String> line = lines[i].split("\t");
    if(line.length != header.length || line.isEmpty) continue;

    // create japanese 
    String jap = line.first;
    exampleComps.add(ExampleTableCompanion(
      id: Value(++maxExampleId), exampleSentence: Value(jap)
    ));

    // Parse sentence using mecab
    final mecab = Mecab();
    await mecab.init("mecab.dylib", "ipadic", true);
    List<String> terms = mecab.parse(jap).map((e) => e.surface,).toList();
    for (var term in terms.sublist(0, terms.length-1)) {
      if(allTerms[term] == null){
        allTerms[term] = ++maxTermId;
        termComps.add(TermTableCompanion(
          id: Value(maxTermId), term: Value(term)
        ));
      }
      exampleTermRelComps.add(ExampleTermRelationsTableCompanion(
        exampleId: Value(maxExampleId), termId: Value(allTerms[term]!)
      ));
    }

    // parse all translations and create links between japanese and translation
    for (var i = 1; i < line.length; i++) {

      // skip if there is no translation for a sentence
      if(line[i] == "") continue;

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
