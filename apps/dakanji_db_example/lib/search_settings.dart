import 'package:dakanji_db_core/database/db_queries/grouping_strategy.dart';

class SearchSettings {
  bool normalizedSearch;
  bool convertRomaji;
  bool deconjugation;
  bool spellfix;
  GroupingStrategy groupingStrategy;

  SearchSettings({
    this.normalizedSearch = true,
    this.convertRomaji = true,
    this.deconjugation = true,
    this.spellfix = true,
    this.groupingStrategy = GroupingStrategy.bySequence,
  });

  // Helper to clone current settings so we don't mutate state directly until saved
  SearchSettings copy() => SearchSettings(
    normalizedSearch: normalizedSearch,
    convertRomaji: convertRomaji,
    deconjugation: deconjugation,
    spellfix: spellfix,
    groupingStrategy: groupingStrategy
  );
}