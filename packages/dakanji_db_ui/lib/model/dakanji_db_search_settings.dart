import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_ui/model/dakanji_db_search_result_sort_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';



@Freezed()
class DaKanjiDbSearchSettings {

  /// Whether to convert romaji to hiragana in normalized searches.
  bool normalizeSearchConvertsRomajiToHiragana;

  /// 1st level sort order for search results.
  /// If an entry of [DaKanjiDbSearch1stSortOrder] is not included here, it
  /// will not be searched for.
  /// 
  /// Default is:
  /// - queryMatch
  /// - normalizedMatch
  /// - deconjugationMatch
  /// - spellfixMatch
  List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder = [
    (DakanjiDbSearchResult1stSortOrder.queryMatch, true),
    (DakanjiDbSearchResult1stSortOrder.normalizedMatch, true),
    (DakanjiDbSearchResult1stSortOrder.deconjugationMatch, true),
    (DakanjiDbSearchResult1stSortOrder.spellfixMatch, true),
  ];
  /// Whether to enable query match searches.
  bool get queryMatch =>
    firstSortOrder.where((e) => e.$1 == DakanjiDbSearchResult1stSortOrder.queryMatch)
      .first.$2;
  /// Whether to enable normalized searches.
  bool get normalizedSearch =>
    firstSortOrder.where((e) => e.$1 == DakanjiDbSearchResult1stSortOrder.normalizedMatch)
      .first.$2;
  /// Whether to enable variation searches.
  bool get deconjugationSearch =>
    firstSortOrder.where((e) => e.$1 == DakanjiDbSearchResult1stSortOrder.deconjugationMatch)
      .first.$2;
  /// Whether to enable fuzzy searches.
  bool get spellfixSearch =>
    firstSortOrder.where((e) => e.$1 == DakanjiDbSearchResult1stSortOrder.spellfixMatch)
      .first.$2;

  /// 2nd level sort order for search results.
  /// If an entry of [DakanjiDbSearchReesult2ndSortOrder] is not included here, it
  /// will not be searched for.
  /// 
  /// Default is:
  /// - exactMatch
  /// - prefixMatch
  /// - subwordMatch
  /// - wildcardMatch
  List<(DakanjiDbSearchReesult2ndSortOrder, bool)> secondSortOrder = [
    (DakanjiDbSearchReesult2ndSortOrder.exactMatch, true),
    (DakanjiDbSearchReesult2ndSortOrder.prefixMatch, true),
    (DakanjiDbSearchReesult2ndSortOrder.subwordMatch, true),
    (DakanjiDbSearchReesult2ndSortOrder.wildcardMatch, true),
  ];
  /// Whether to enable exact match searches.
  bool get exactMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchReesult2ndSortOrder.exactMatch)
      .first.$2;
  /// Whether to enable prefix match searches.
  bool get prefixMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchReesult2ndSortOrder.prefixMatch)
      .first.$2;
  /// Whether to enable subword match searches.
  bool get subwordMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchReesult2ndSortOrder.subwordMatch)
      .first.$2;
  /// Whether to enable wildcard match searches.
  bool get wildcardMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchReesult2ndSortOrder.wildcardMatch)
      .first.$2;

  /// The grouping rules to apply to the search.
  List<DictionaryGroupingRule> groupingRule;

  /// Whether to show the separation headers such as "Exact Matches",
  /// "Prefix Matches", etc.
  bool showSearchResultSeparationHeaders;
  /// Whether to show tags in [DictionaryMatchWidget]s.
  bool showTags;
  /// Whether to show meta entries in [DictionaryMatchWidget]s.
  bool showMetaEntries;
  /// Maximum height for compact definitions.
  double definitionsMaxHeight;

  /// Maximum number of results to return from each search.
  int searchResultLimit = 250;


  DaKanjiDbSearchSettings({
    this.normalizeSearchConvertsRomajiToHiragana = true,

    this.groupingRule = const [NoGroupingRule()],
    
    this.showSearchResultSeparationHeaders = true,
    this.showTags = true,
    this.showMetaEntries = true,
    this.definitionsMaxHeight = 60.0,

    List<(DakanjiDbSearchResult1stSortOrder, bool)>? firstSortOrder,
    List<(DakanjiDbSearchReesult2ndSortOrder, bool)>? secondSortOrder,
  }){
    if(firstSortOrder != null) this.firstSortOrder = firstSortOrder;
    if (secondSortOrder != null) this.secondSortOrder = secondSortOrder;
  }

}