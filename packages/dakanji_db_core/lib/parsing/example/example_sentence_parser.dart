
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:language_processing/japanese/sentence_parsing.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

import '/database/dakanji_db.dart';



Future parseExampleSentence(
  String exampleSentenceJsonString, DaKanjiDB db, Mecab mecab, int indexId
) async {


  Map<String, dynamic> examples = jsonDecode(exampleSentenceJsonString);
  String jap = examples[Iso639_1.ja.name]!;

  // read values from current db
  int maxExampleId = await db.exampleDao.maxExampleId();
  int maxExampleTransId = await db.exampleDao.maxExampleTranslationId();
  Map<String, int> allLanguageCodes =
    { for (var e in await db.languageCodeDao.getAllLanguageCodes()) e.languageCode : e.id };
  int maxLanguageCodeId = await db.languageCodeDao.maxExampleTranslationId();

  // read the examples
  List<ExampleTableCompanion> exampleComps = [];
  List<LanguageCodeTableCompanion> languageCodeComps = [];
  List<ExampleTranslationTableCompanion> exampleTranslationComps = [];
  List<ExampleTable_X_ExampleTranslationTableCompanion> exampleTransRelComps = [];
    
  // Get tokens
  String tokenized = await parseSentenceUsingMecab(jap, mecab);

  // create japanese
  exampleComps.add(ExampleTableCompanion(
    id: Value(++maxExampleId),
    indexId: Value(indexId),
    exampleSentence: Value(jap),
    exampleSentenceTokenized: Value(tokenized)
  ));


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

    exampleTransRelComps.add(ExampleTable_X_ExampleTranslationTableCompanion(
      exampleId: Value(maxExampleId),
      translationId: Value(maxExampleTransId),
    ));

  }

  
  // bulk add all data
  await db.batch((batch) {

    db.exampleTable.insertAll(exampleComps);

    db.languageCodeTable.insertAll(languageCodeComps);
    db.exampleTranslationTable.insertAll(exampleTranslationComps);

    db.exampleTableXExampleTranslationTable.insertAll(exampleTransRelComps);

  },);

}
