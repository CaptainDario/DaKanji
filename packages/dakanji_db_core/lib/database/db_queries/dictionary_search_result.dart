import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';



/// Helper class to encapsulate the results of a term search.
class DictionarySearchResults {

  final DictionarySearchResult termMatches;
  final DictionarySearchResult hiraganaTermMatches;
  final List<DictionarySearchResult> preprocessedTermsMatches;

  DictionarySearchResults({
    required this.termMatches,
    required this.hiraganaTermMatches,
    required this.preprocessedTermsMatches,
  });

}

class DictionarySearchResult {

  final List<TermBankV3Entry> exactMatch;
  final List<TermBankV3Entry> prefixMatch;
  final List<TermBankV3Entry> tokenMatch;
  final List<TermBankV3Entry> wildcardMatch;

  DictionarySearchResult({
    required this.exactMatch,
    required this.prefixMatch,
    required this.tokenMatch,
    required this.wildcardMatch,
  });
}
