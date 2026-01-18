import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_ui/model/dakanji_db_search_result_sort_order.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dakanji_db_settings.freezed.dart';
part 'dakanji_db_settings.g.dart';



class DaKanjiDbSettings with ChangeNotifier {

  DaKanjiDbSettingsInternal _settings;

  Function? onSettingsChanged;

  DaKanjiDbSettings(
      DaKanjiDbSettingsInternal settings,
      {
        this.onSettingsChanged
      }
    )
    : _settings = settings;

  /// Access the current settings.
  DaKanjiDbSettingsInternal get settings => _settings;

  /// Shortcut to access the internal settings.
  DaKanjiDbSettingsInternal get s => _settings;

  /// Update the settings and notify listeners.
  /// 
  /// Note: Use `this.s.copyWith(...)` to create a modified copy of the
  /// current settings and pass it to this method.
  void update(DaKanjiDbSettingsInternal newSettings) {
    _settings = newSettings;
    notifyListeners();
    onSettingsChanged?.call();
  }

}

@Freezed(toJson: true, fromJson: true, )
abstract class DaKanjiDbSettingsInternal with _$DaKanjiDbSettingsInternal {
  const DaKanjiDbSettingsInternal._();

  const factory DaKanjiDbSettingsInternal({
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
    /// If an entry of [DakanjiDbSearchReesult2ndSortOrder] is not included here, it
    /// will not be searched for.
    /// 
    /// Default is:
    /// - exactMatch
    /// - prefixMatch
    /// - subwordMatch
    /// - wildcardMatch
    @Default([
      (DakanjiDbSearchReesult2ndSortOrder.exactMatch, true),
      (DakanjiDbSearchReesult2ndSortOrder.prefixMatch, true),
      (DakanjiDbSearchReesult2ndSortOrder.subwordMatch, true),
      (DakanjiDbSearchReesult2ndSortOrder.wildcardMatch, true),
    ])
    List<(DakanjiDbSearchReesult2ndSortOrder, bool)> secondSortOrder,

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

    /// Maximum number of results to return when search (does apply to each 
    /// of the four independent searches **separately**).
    @Default(100)
    int searchResultLimit,
  }) = _DaKanjiDbSettings;

  factory DaKanjiDbSettingsInternal.fromJson(Map<String, dynamic> json) => 
      _$DaKanjiDbSettingsFromJson(json);

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
}