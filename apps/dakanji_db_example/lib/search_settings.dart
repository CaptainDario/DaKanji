import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';

class SearchSettings {

  bool normalizedSearch;
  bool convertRomaji;
  bool deconjugation;
  bool spellfix;
  DictionaryGroupingRule groupingRule;

  bool useStructuredContentDefinitions = false;

  SearchSettings({
    this.normalizedSearch = true,
    this.convertRomaji = true,
    this.deconjugation = true,
    this.spellfix = true,
    this.groupingRule = const SequenceGroupingRule(
      sourceDictId: 3,
      targetDictIds: {3}
    ),
    useStructuredContentDefinitions = false,
  });

  // Helper to clone current settings so we don't mutate state directly until saved
  SearchSettings copy() => SearchSettings(
    normalizedSearch: normalizedSearch,
    convertRomaji: convertRomaji,
    deconjugation: deconjugation,
    spellfix: spellfix,
    groupingRule: groupingRule,
  );
}