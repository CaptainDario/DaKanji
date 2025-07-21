// Package imports:
import 'package:drift/drift.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
//import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';



Future parseExampleFileZip() async {

  // TODO

}

Future parseExampleFolder(Directory exampleDir, DaKanjiDB db) async {

  List<File> exampleFiles = exampleDir.listSync().whereType<File>().toList();

  Map<String, String> examples = {};
  for (var file in exampleFiles) {
    examples[p.basename(file.path)] = file.readAsStringSync();
  }

}

/// parses the given string and adds it to the given [DaKanjiDB]
Future parseExample(Map<String, String> examples, DaKanjiDB db) async {

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
    
  // create japanese
  String jap = examples["jpn"]!;
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
  for (MapEntry entry in examples.entries) {
    String locale = entry.key;
    String example = entry.value;

    if(allLanguageCodes[locale] == null){
      allLanguageCodes[locale] = ++maxLanguageCodeId;
      languageCodeComps.add(LanguageCodeTableCompanion(
        id: Value(maxLanguageCodeId), languageCode: Value(locale)
      ));
    }

    exampleTranslationComps.add(ExampleTranslationTableCompanion(
      id: Value(++maxExampleTransId),
      exampleTranslation: Value(example),
      languageCodeId: Value(allLanguageCodes[locale]!)
    ));

    exampleTransRelComps.add(ExampleTranslationRelationsTableCompanion(
      exampleId: Value(maxExampleId),
      translationId: Value(maxExampleTransId),
    ));

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
