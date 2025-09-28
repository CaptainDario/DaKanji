import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';



/// Utility class representing the overall results from a dictionary search.
/// It groups results based on whether they matched the search term directly,
/// matched the hiragana form of the term (romaji converted to hiragana), or
/// matched pre-processed variants of the term (e.g., 食べます→食べる).
class DictionarySearchResult {

  /// Matches from the original search term.
  final SearchMatchGroup termMatches;
  /// Matches from the hiragana-converted search term.
  final SearchMatchGroup hiraganaMatches;
  /// Matches from pre-processed variants of the search term.
  /// For example, de-conjugated forms.
  final List<SearchMatchGroup> variantTermMatches;

  DictionarySearchResult({
    required this.termMatches,
    required this.hiraganaMatches,
    required this.variantTermMatches,
  });
  
}

/// Utility class representing a grouped set of search results from the
/// dictionary search. It bundles [DictionaryMatch] objects into
/// categories based on the type of match.
class SearchMatchGroup {

  /// Matches that exactly match the search term.
  /// E.g., searching for 'でんしゃ' returns '電車 (densha)'. 
  final List<DictionaryMatch> exactMatchs;
  /// Matches that start with the search term.
  /// E.g., searching for 'でんしゃ' returns '電車賃 (denshachin)'.
  final List<DictionaryMatch> prefixMatchs;
  /// Matches that contain the search term as a token.
  /// E.g., searching for 'でんしゃ' returns '満員電車 (man'in densha)'.
  final List<DictionaryMatch> tokenMatchs;
  /// Matches that are similar to the search term (fuzzy).
  /// E.g., searching for 'でんさ' returns '電車 (densha)'.
  final List<DictionaryMatch> fuzzyMatchs;
  /// Matches that fit wildcard patterns.
  /// E.g., searching for 'で*しゃ' returns '電車 (densha)'.
  final List<DictionaryMatch> wildcardMatchs;

  SearchMatchGroup({
    required this.exactMatchs,
    required this.prefixMatchs,
    required this.tokenMatchs,
    required this.fuzzyMatchs,
    required this.wildcardMatchs,
  });

  SearchMatchGroup.empty() : 
    exactMatchs = [],
    prefixMatchs = [],
    tokenMatchs = [],
    fuzzyMatchs = [],
    wildcardMatchs = [];

  factory SearchMatchGroup.fromDictionaryMatchList(List<DictionarySearchFts5DriftResult> matches) {

    List<DictionaryMatch> exactMatches = [], prefixMatches = [], tokenMatches = [];
    for (var driftResult in matches) {
      DictionaryMatch r = DictionaryMatch(
        match: driftResult.highlightedText!,
        entry: TermBankV3Entry.fromSearchTermDriftResult(driftResult)
      );

      if(driftResult.matchTypePriority == 1) exactMatches.add(r);
      else if(driftResult.matchTypePriority == 2) prefixMatches.add(r);
      else if(driftResult.matchTypePriority == 3) tokenMatches.add(r);

    }

    return SearchMatchGroup(
      exactMatchs: exactMatches,
      prefixMatchs: prefixMatches,
      tokenMatchs: tokenMatches,
      fuzzyMatchs: [],
      wildcardMatchs: []
    );
  }

}

/// Utility class representing a single search result from the dictionary search.
class DictionaryMatch {

  /// The text that was matched (e.g., 食べるラー油 -> 食べる).
  final String match;
  /// The full dictionary entry that was matched.
  final TermBankV3Entry entry;

  DictionaryMatch({
    required this.match,
    required this.entry
  });

  @override
  String toString() {
    return '<<Instance of \'DictionarySearchResult\'> with '
           '`match`: \'$match\' and '
           '`entry.term`: \'${entry.term}\' and '
           '`entry.reading`: \'${entry.reading}\' and '
           '`entry.definitions`: ${entry.definitions}>';
  }

}