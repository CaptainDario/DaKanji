
import 'package:dakanji_db_core/parsing/util/import_context.dart';

import '/database/dakanji_db.dart';

class TermBankV3ParserContext extends ParserContext{

  /// Current max id for term bank entries
  int currentMaxTermBankId;

  /// Current max id for terms
  int currentMaxTermId;
  /// Map of all terms to their ids
  Map<String, int> allTerms;

  /// Current max id for readings
  int currentMaxReadingId;
  /// Map of all readings to their ids
  Map<String, int> allReadings;

  /// Current max id for rule identifiers
  int currentMaxRuleIdentifiersId;
  /// Map of all rule identifiers to their ids
  Map<String, int> allRuleIdentifiers;

  /// Current max id for definition jsons
  int currentMaxDefinitionJsonId;

  /// Current max id for definitions
  int currentMaxdefinitionId;
  /// Map of all definitions to their ids
  Map<String, int> allDefinitions;

  /// Current max id for tags
  int currentMaxTagId;
  /// tags are parsed from the meta bank and thus are ALWAYS in the DB
  Map<String, int> allTags;


  TermBankV3ParserContext._({
    required this.currentMaxTermBankId,
    required this.currentMaxTermId,
    required this.allTerms,
    required this.currentMaxReadingId,
    required this.allReadings,
    required this.currentMaxRuleIdentifiersId,
    required this.allRuleIdentifiers,
    required this.currentMaxDefinitionJsonId,
    required this.currentMaxdefinitionId,
    required this.allDefinitions,
    required this.currentMaxTagId,
    required this.allTags,
  });

  static Future<TermBankV3ParserContext> create(DaKanjiDB db, int indexId) async {

    return TermBankV3ParserContext._(
      allTerms: { for (var e in await db.termDao.getAllTerms()) e.term : e.id },
      allReadings: { for (var e in await db.readingDao.getAllReadings()) e.reading : e.id },
      allRuleIdentifiers: { for (var e in await db.termBankV3Dao.getAllRuleIdentifiers()) e.ruleIdentifier : e.id },
      allDefinitions: { for (var e in await db.definitionDao.getAllDefinitions()) e.definition : e.id },
      allTags: { for (var e in await db.tagBankV3Dao.getAllTags(indexId)) e.name : e.id },

      currentMaxTermBankId: await db.termBankV3Dao.maxTermBankV3Id(),
      currentMaxTermId: await db.termDao.maxTermId(),
      currentMaxReadingId: await db.readingDao.maxReadingId(),
      currentMaxRuleIdentifiersId: await db.termBankV3Dao.maxTermBankV3RuleIdentifierId(),
      currentMaxDefinitionJsonId: await db.termBankV3Dao.maxTermBankV3DefinitionJsonId(),
      currentMaxdefinitionId: await db.definitionDao.maxDefinitionId(),
      currentMaxTagId: await db.tagBankV3Dao.maxTagBankId(),
    );

  }

}