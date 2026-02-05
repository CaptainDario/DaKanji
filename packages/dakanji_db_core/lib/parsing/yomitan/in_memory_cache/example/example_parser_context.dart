


import 'package:dakanji_db_core/database/dakanji_db.dart';

class ExampleParserContext {

  Map<String, int> allLanguageCodes;

  int maxExampleId;
  int maxExampleTransId;
  int maxLanguageCodeId;

  ExampleParserContext._(
    this.allLanguageCodes,
    this.maxExampleId,
    this.maxExampleTransId,
    this.maxLanguageCodeId
  );

  static Future<ExampleParserContext> create(DaKanjiDB db) async {
    return ExampleParserContext._(
      { for (var e in await db.languageCodeDao.getAllLanguageCodes()) e.languageCode : e.id },
      await db.exampleDao.maxExampleId(),
      await db.exampleDao.maxExampleTranslationId(),
      await db.languageCodeDao.maxExampleTranslationId()
    );
  }

}