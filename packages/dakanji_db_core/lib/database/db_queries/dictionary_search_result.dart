import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';


class DictionarySearchResults {

  final List<DictionarySearchResult> exactMatchs;
  final List<DictionarySearchResult> prefixMatchs;
  final List<DictionarySearchResult> tokenMatchs;
  final List<DictionarySearchResult> fuzzyMatchs;
  final List<DictionarySearchResult> wildcardMatchs;

  DictionarySearchResults({
    required this.exactMatchs,
    required this.prefixMatchs,
    required this.tokenMatchs,
    required this.fuzzyMatchs,
    required this.wildcardMatchs,
  });
}

class DictionarySearchResult {

  final String match;

  final TermBankV3Entry entry;

  DictionarySearchResult({
    required this.match,
    required this.entry
  });

}