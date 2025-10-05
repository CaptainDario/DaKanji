// Project imports:
import '/database/dakanji_db.dart';

class TermBankV3ParserImportContext {

  int currentMaxTermBankId;

  int currentMaxTermId;
  Map allTerms;

  int currentMaxReadingId;
  Map allReadings;

  int currentMaxDefTagId;
  Map allDefTags;

  int currentMaxRuleIdentifiersId;
  Map allRuleIdentifiers;

  int currentMaxDefinitionJsonId;

  int currentMaxdefinitionId;
  Map allDefinitions;

  // tags are parsed from the meta bank and thus are ALWAYS in the DB
  Map allTags;


  TermBankV3ParserImportContext._({
    required this.currentMaxTermBankId,
    required this.currentMaxTermId,
    required this.allTerms,
    required this.currentMaxReadingId,
    required this.allReadings,
    required this.currentMaxDefTagId,
    required this.allDefTags,
    required this.currentMaxRuleIdentifiersId,
    required this.allRuleIdentifiers,
    required this.currentMaxDefinitionJsonId,
    required this.currentMaxdefinitionId,
    required this.allDefinitions,
    required this.allTags,
  });

  static Future<TermBankV3ParserImportContext> create(DaKanjiDB db) async {

    return TermBankV3ParserImportContext._(
      currentMaxTermBankId: await db.termBankV3Dao.maxTermBankV3Id(),
      currentMaxTermId: await db.termDao.maxTermId(),
      allTerms: { for (var e in await db.termDao.getAllTerms()) e.term : e.id },
      currentMaxReadingId: await db.readingDao.maxReadingId(),
      allReadings: { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id },
      currentMaxDefTagId: await db.termBankV3Dao.maxTermBankV3DefinitionTagId(),
      allDefTags: { for (var e in await db.termBankV3Dao.getAllDefinitionTags()) e.definitionTag : e.id },
      currentMaxRuleIdentifiersId: await db.termBankV3Dao.maxTermBankV3RuleIdentifierId(),
      allRuleIdentifiers: { for (var e in await db.termBankV3Dao.getAllRuleIdentifiers()) e.ruleIdentifier : e.id },
      currentMaxDefinitionJsonId: await db.termBankV3Dao.maxTermBankV3DefinitionJsonId(),
      currentMaxdefinitionId: await db.definitionDao.maxDefinitionId(),
      allDefinitions: { for (var e in await db.definitionDao.getAllDefinitions()) e.definition : e.id },
      allTags: { for (var e in await db.termBankV3Dao.getAllTags()) e.name : e.id },
    );

  }

}