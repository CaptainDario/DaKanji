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

}