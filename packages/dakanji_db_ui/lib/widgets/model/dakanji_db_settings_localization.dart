class DakanjiDbSettingsLocalization {

  DakanjiDbSettingsLocalization({

    // --- Dictionary Management ---
    required this.dictionariesHeader,

    required this.defaultDictionary,
    required this.userDictionary,

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
    required this.sortByExactMatch,
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

    // --- Misc ---
    required this.miscTitle,

    required this.typoCorrectionMaxResultsTitle,
    required this.typoCorrectionMaxResultsSubtitle,
    required this.typoCorrecctionMaxCostTitle,
    required this.typoCorrectionMaxCostSubtitle,

    required this.exportDictionariesTitle,
    required this.importDictionariesTitle,
  });

  /// --- Dictionary Management ---
  String dictionariesHeader;

  String defaultDictionary;
  String userDictionary;

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

  String sortByExactMatch;
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

  /// --- Misc ---
  String miscTitle;

  String exportDictionariesTitle;
  String importDictionariesTitle;

  String typoCorrectionMaxResultsTitle ;
  String typoCorrectionMaxResultsSubtitle;
  String typoCorrecctionMaxCostTitle;
  String typoCorrectionMaxCostSubtitle;

}