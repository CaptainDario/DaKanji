import 'package:dakanji_db_core/data/dakanji_db_search_result_sort_order.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:language_processing/language_processing.dart';

part 'search_profiles_entry.freezed.dart';
part 'search_profiles_entry.g.dart';



@Freezed(toJson: true, fromJson: true, )
abstract class SearchProfilesEntry with _$SearchProfilesEntry {
  const SearchProfilesEntry._();

  const factory SearchProfilesEntry({

    /// The unique ID of the profile.
    @Default(0)
    int id,

    /// The name of the profile.
    @Default('')
    String name,

    /// Whether this profile is the active profile.
    @Default(false)
    bool isActiveProfile,

    @Default(1)
    int sortOrder,

    /// 1st level sort order for search results.
    /// If an entry of [DaKanjiDbSearch1stSortOrder] is not included here, it
    /// will not be searched for.
    /// 
    /// Default is:
    /// - queryMatch
    /// - normalizedMatch
    /// - deconjugationMatch
    /// - spellfixMatch
    @Default([
      (DakanjiDbSearchResult1stSortOrder.queryMatch, true),
      (DakanjiDbSearchResult1stSortOrder.normalizedMatch, true),
      (DakanjiDbSearchResult1stSortOrder.deconjugationMatch, true),
      (DakanjiDbSearchResult1stSortOrder.spellfixMatch, true),
    ])
    List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,

    /// 2nd level sort order for search results.
    /// If an entry of [DakanjiDbSearchResult2ndSortOrder] is not included here, it
    /// will not be searched for.
    /// 
    /// Default is:
    /// - exactMatch
    /// - prefixMatch
    /// - subwordMatch
    /// - wildcardMatch
    @Default([
      (DakanjiDbSearchResult2ndSortOrder.exactMatch, true),
      (DakanjiDbSearchResult2ndSortOrder.prefixMatch, true),
      (DakanjiDbSearchResult2ndSortOrder.subwordMatch, true),
      (DakanjiDbSearchResult2ndSortOrder.wildcardMatch, true),
    ])
    List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,

    /// Whether to convert romaji to hiragana in normalized searches.
    @Default(true)
    bool normalizeSearchConvertsRomajiToHiragana,

    /// The grouping rules to apply to the search.
    @Default([])
    List<DictionaryGroupingRule> groupingRules,

    /// Whether to show the separation headers such as "Exact Matches",
    /// "Prefix Matches", etc.
    @Default(true)
    bool showSearchResultSeparationHeaders,

    /// Whether to show Kanji entries at the top search results when searching
    /// for single characters
    @Default(true)
    bool showKanjiEntriesInSearchResults,

    /// Whether to show tags in [DictionaryMatchWidget]s.
    @Default(true)
    bool showTags,

    /// Whether to show meta entries in [DictionaryMatchWidget]s.
    @Default(true)
    bool showMetaEntries,

    /// Maximum height for compact definitions.
    @Default(60.0)
    double definitionsMaxHeight,

    /// Whether to use katakana for furigana instead of hiragana.
    @Default(false)
    bool useKatakanaForFurigana,

    /// The maximum number of typo corrections to consider.
    @Default(20)
    int spellfixMaxResults,

    /// The maximum cost for typo correction searches.
    @Default(10)
    int spellfixMaxCost,

    /// Maximum number of results to return when search (does apply to each 
    /// of the four independent searches **separately**).
    @Default(100)
    int searchResultLimit,
  }) = _SearchProfilesEntry;

  factory SearchProfilesEntry.fromJson(Map<String, dynamic> json) => 
    _$SearchProfilesEntryFromJson(json);

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

  /// Whether to enable exact match searches.
  bool get exactMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchResult2ndSortOrder.exactMatch)
      .first.$2;
  /// Whether to enable prefix match searches.
  bool get prefixMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchResult2ndSortOrder.prefixMatch)
      .first.$2;
  /// Whether to enable subword match searches.
  bool get subwordMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchResult2ndSortOrder.subwordMatch)
      .first.$2;
  /// Whether to enable wildcard match searches.
  bool get wildcardMatch =>
    secondSortOrder.where((e) => e.$1 == DakanjiDbSearchResult2ndSortOrder.wildcardMatch)
      .first.$2;

  DictionarySearchParams toDictionarySearchParams({
    required String searchInput,
    List<String> tags = const [],
    List<String> pos = const [],
    List<int>? indexesToInclude,
    int offset = 0,
    ProcessorOptions? options,
  }) {
    return DictionarySearchParams(
      searchInput: searchInput,
      normalizedSearch: normalizedSearch,
      deconjugationSearch: deconjugationSearch,
      spellfixSearch: spellfixSearch,
      groupingRules: groupingRules,
      indexesToInclude: indexesToInclude,
      spellfixMaxCost: spellfixMaxCost,
      spellfixMaxResults: spellfixMaxResults,
      limit: searchResultLimit,
      offset: offset,
      options: ProcessorOptions(
        japaneseNormalizationConvertsRomajiToHiragana: normalizeSearchConvertsRomajiToHiragana,
      )
    );
  }

  SearchProfilesTableData toSearchProfilesTableData() {
    return SearchProfilesTableData(
      id: id,
      name: name,
      isActiveProfile: isActiveProfile,
      sortOrder: sortOrder,
      firstSortOrder: firstSortOrder,
      secondSortOrder: secondSortOrder,
      normalizeSearchConvertsRomajiToHiragana: normalizeSearchConvertsRomajiToHiragana,
      groupingRules: groupingRules,
      showSearchResultSeparationHeaders: showSearchResultSeparationHeaders,
      showKanjiEntriesInSearchResults: showKanjiEntriesInSearchResults,
      showTags: showTags,
      showMetaEntries: showMetaEntries,
      definitionsMaxHeight: definitionsMaxHeight,
      useKatakanaForFurigana: useKatakanaForFurigana,
      spellfixMaxResults: spellfixMaxResults,
      spellfixMaxCost: spellfixMaxCost,
      searchResultLimit: searchResultLimit,
    );
  }

  factory SearchProfilesEntry.fromSearchProfilesTableData(SearchProfilesTableData data) {
    
    return SearchProfilesEntry(
      id: data.id,
      name: data.name,
      isActiveProfile: data.isActiveProfile,
      sortOrder: data.sortOrder,
      firstSortOrder: data.firstSortOrder,
      secondSortOrder: data.secondSortOrder,
      normalizeSearchConvertsRomajiToHiragana: data.normalizeSearchConvertsRomajiToHiragana,
      groupingRules: (data.groupingRules as List<dynamic>?)
        ?.map((e) => DictionaryGroupingRule.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
      showSearchResultSeparationHeaders: data.showSearchResultSeparationHeaders,
      showKanjiEntriesInSearchResults: data.showKanjiEntriesInSearchResults,
      showTags: data.showTags,
      showMetaEntries: data.showMetaEntries,
      definitionsMaxHeight: data.definitionsMaxHeight,
      useKatakanaForFurigana: data.useKatakanaForFurigana,
      spellfixMaxResults: data.spellfixMaxResults,
      spellfixMaxCost: data.spellfixMaxCost,
      searchResultLimit: data.searchResultLimit,
    );

  }

}
