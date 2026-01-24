import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';

class DictionarySearchParams {


  /// The search query/term.
  String query;

  /// Whether to perform normalized search (ignoring small kana, prolonged sound
  /// marks, etc.)
  bool normalizedSearch;
  /// Whether to convert romaji to hiragana during normalization.
  bool normalizedSearchConvertsRomajiToHiragana;
  /// Whether to perform deconjugation search.
  bool deconjugationSearch;
  /// Whether to perform spellfix / fuzzy search.
  bool spellfixSearch;

  /// Specifies how the results should be grouped.
  /// Look at [SequenceGroupingRule], [TermAndReadingGroupingRule] and
  /// [TermGroupingRule] for more information.
  List<DictionaryGroupingRule> groupingRules;

  /// List of dictionary index IDs to include in the search.
  ///   If `null`, all indexes are included.
  ///   If `[]`, no indexes are included.
  List<int>? indexesToInclude;
  /// Weather to search only in enabled indexes.
  /// Note: if `True`, this overrides `indexesToInclude`.
  bool useOnlyEnabledIndexes;
  /// Weather to search only in default indexes.
  /// Note: if `True`, this overrides `indexesToInclude`.
  bool useOnlyDefaultIndexes;

  /// Maximum edit distance for spellfix search.
  int spellfixMaxCost;
  /// Maximum number of results for spellfix search.
  int spellfixMaxResults;
  /// Maximum number of results to return.
  int limit;
  /// Offset for pagination.
  int offset;

  DictionarySearchParams({
    required this.query,
    this.normalizedSearch = false,
    this.normalizedSearchConvertsRomajiToHiragana = false,
    this.deconjugationSearch = false,
    this.spellfixSearch = false,
    this.groupingRules = const [],
    this.indexesToInclude,
    this.useOnlyEnabledIndexes = false,
    this.useOnlyDefaultIndexes = false,
    this.spellfixMaxCost = 10,
    this.spellfixMaxResults = 20,
    this.limit = -1,
    this.offset = 0,
  });

}