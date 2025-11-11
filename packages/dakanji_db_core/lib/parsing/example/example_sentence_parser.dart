
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:language_processing/japanese/sentence_parsing.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

import '/database/dakanji_db.dart';



Future parseExampleSentences(
  List<String> exampleSentenceJsonString, DaKanjiDB db, Mecab mecab, int indexId
) async {


  List<Map<String, dynamic>> examples = exampleSentenceJsonString.map((e)
    => jsonDecode(e) as Map<String, dynamic>)
  .toList();
  

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
    

  for (final example in examples) {

    String jap = example[Iso639_1.ja.name]!;

    // Get tokens
    String tokenized = await parseSentenceUsingMecab(jap, mecab);

    // create japanese
    exampleComps.add(ExampleTableCompanion(
      id: Value(++maxExampleId),
      indexId: Value(indexId),
      exampleSentence: Value(jap),
      exampleSentenceTokenized: Value(tokenized)
    ));

    // parse all translations
    for (MapEntry entry in example.entries) {
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

  }

  // check for duplicates
  final Map<int, int> updatedExamples = {};
  final duplicates = await db.exampleDao.getExampleIdMap(
    exampleComps.map((e) => e.exampleSentence.value
  ).toSet());
  for (var i = 0; i < exampleComps.length; i++) {
    int? dupKey = duplicates[(exampleComps[i]).exampleSentence.value];
    if(dupKey != null) {
      updatedExamples[exampleComps[i].id.value] = dupKey;
      exampleComps[i] = exampleComps[i].copyWith(id: Value(dupKey));
    }
  }

  // check of for duplicates in the translations
  final Map<int, int> updatedExampleTranslations = {};
  final transDuplicates = await db.exampleDao.getTranslationIdMap(
    exampleTranslationComps.map((e) =>
      (langId: e.languageCodeId.value, text: e.exampleTranslation.value)
  ).toSet());
  for (var i = 0; i < exampleTranslationComps.length; i++) {
    int? dupKey = transDuplicates[(
      langId: exampleTranslationComps[i].languageCodeId.value,
      text: exampleTranslationComps[i].exampleTranslation.value
    )];
    if(dupKey != null) {
      updatedExampleTranslations[exampleTranslationComps[i].id.value] = dupKey;
      exampleTranslationComps[i] = exampleTranslationComps[i].copyWith(id: Value(dupKey));
    }
  }

  // Update links between japanese and translation
  for (var i = 0; i < exampleTransRelComps.length; i++) {
    int updatedExampleId =
      updatedExamples[exampleTransRelComps[i].exampleId.value] ??
      exampleTransRelComps[i].exampleId.value;
    int updatedExampleTransId =
      updatedExampleTranslations[exampleTransRelComps[i].translationId.value] ??
      exampleTransRelComps[i].translationId.value;
    exampleTransRelComps[i] = exampleTransRelComps[i].copyWith(
      exampleId: Value(updatedExampleId),
      translationId: Value(updatedExampleTransId),
    );
  }

  // bulk add all data
  await db.batch((batch) {

    db.exampleTable.insertAll(exampleComps,
      mode: InsertMode.insertOrIgnore);

    db.languageCodeTable.insertAll(languageCodeComps,
      mode: InsertMode.insertOrIgnore);
    db.exampleTranslationTable.insertAll(exampleTranslationComps,
      mode: InsertMode.insertOrIgnore);

    db.exampleTableXExampleTranslationTable.insertAll(exampleTransRelComps,
      mode: InsertMode.insertOrIgnore);

  },);

}
