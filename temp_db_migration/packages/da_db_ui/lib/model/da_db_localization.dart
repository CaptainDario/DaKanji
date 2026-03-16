class DaDbLocalization {

  DaDbLocalization({

    // --- SEARCH UI ---
    required this.noResultsFound,

    // --- SETTINGS ---
    // --- Dictionary Management ---
    required this.dictionariesHeader,

    required this.defaultDictionary,
    required this.userDictionary,

    required this.importDictionary,
    required this.updateDictionary,
    required this.deleteDictionary,

    // --- Display ---
    required this.displayHeader,

    required this.showSeparatorsTitle,
    required this.showSeparatorsSubtitle,
    
    required this.showTagsTitle,
    required this.showTagsSubtitle,
    
    required this.showMetaEntriesTitle,
    required this.showMetaEntriesSubtitle,
    
    required this.useCompactDefinitionsTitle,
    required this.useCompactDefinitionsSubtitle,

    required this.useKatakanaForFuriganaTitle,

    // --- Sort Order ---
    required this.sortOrderTitle,
    required this.sortByTitle,
    required this.sortByText,
    required this.sortByDirectMatch,
    required this.sortByFlexibleMatch,
    required this.sortBySmartGrammarMatch,
    required this.sortByTypoCorrectionMatch,
    required this.thenByTitle,
    required this.thenByText,
    required this.thenByExactMatch,
    required this.thenByStartsWithMatch,
    required this.thenBySubwordMatch,
    required this.thenByWildcardMatch,

    // --- Grouping ---
    required this.groupingTitle,
    required this.groupingExplanation,

    required this.configureGroupingTitle,
    required this.groupby,
    required this.source,
    required this.targets,
    required this.select,
    required this.delteRule,
    required this.addRule,

    required this.targetDictSelectDialogTitle,
    required this.targetDictSelectDialogNoIndexes,
    required this.targetDictSelectDialogUsedInOtherRule,
    required this.targetDictSelectDialogCancel,
    required this.targetDictSelectDialogOK,

    // --- Misc ---
    required this.miscTitle,

    required this.typoCorrectionMaxResultsTitle,
    required this.typoCorrectionMaxResultsSubtitle,
    required this.typoCorrecctionMaxCostTitle,
    required this.typoCorrectionMaxCostSubtitle,

    required this.exportDictionariesTitle,
    required this.importDictionariesTitle,
  });


  /// --- SEARCH UI ---
  String noResultsFound;

  /// --- SETTINGS ---
  /// --- Dictionary Management ---
  String dictionariesHeader;

  String defaultDictionary;
  String userDictionary;

  String importDictionary;
  String updateDictionary;
  String deleteDictionary;

  /// --- Display ---
  String displayHeader;

  String showSeparatorsTitle;
  String showSeparatorsSubtitle;

  String showTagsTitle;
  String showTagsSubtitle;

  String showMetaEntriesTitle;
  String showMetaEntriesSubtitle;

  String useCompactDefinitionsTitle;
  String useCompactDefinitionsSubtitle;

  String useKatakanaForFuriganaTitle;

  /// --- Sort Order ---
  String sortOrderTitle;
  
  String sortByTitle;
  String sortByText;

  String sortByDirectMatch;
  String sortByFlexibleMatch;
  String sortBySmartGrammarMatch;
  String sortByTypoCorrectionMatch;


  String thenByTitle;
  String thenByText;

  String thenByExactMatch;
  String thenByStartsWithMatch;
  String thenBySubwordMatch;
  String thenByWildcardMatch;

  /// --- Grouping ---
  String groupingTitle;
  String groupingExplanation;

  String configureGroupingTitle;
  String groupby;
  String source;
  String targets;
  String select;
  String delteRule;
  String addRule;

  String targetDictSelectDialogTitle;
  String targetDictSelectDialogNoIndexes;
  String targetDictSelectDialogUsedInOtherRule;
  String targetDictSelectDialogCancel;
  String targetDictSelectDialogOK;

  /// --- Misc ---
  String miscTitle;

  String exportDictionariesTitle;
  String importDictionariesTitle;

  String typoCorrectionMaxResultsTitle ;
  String typoCorrectionMaxResultsSubtitle;
  String typoCorrecctionMaxCostTitle;
  String typoCorrectionMaxCostSubtitle;

}