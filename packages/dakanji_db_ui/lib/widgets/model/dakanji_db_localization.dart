class DakanjiDbLocalization {

  DakanjiDbLocalization({
    // --- Search results ---
    required this.sortByExactMatch,
    required this.sortByFlexibleMatch,
    required this.sortBySmartGrammarMatch,
    required this.sortByTypoCorrectionMatch,

    required this.thenByExactMatch,
    required this.thenByStartsWithMatch,
    required this.thenBySubwordMatch,
    required this.thenByWildcardMatch,
  });

  /// --- Search results ---
  String sortByExactMatch;
  String sortByFlexibleMatch;
  String sortBySmartGrammarMatch;
  String sortByTypoCorrectionMatch;

  String thenByExactMatch;
  String thenByStartsWithMatch;
  String thenBySubwordMatch;
  String thenByWildcardMatch;

}