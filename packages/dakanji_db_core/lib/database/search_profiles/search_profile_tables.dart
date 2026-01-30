import 'package:dakanji_db_core/helper/sort_order_converter.dart';
import 'package:dakanji_db_core/helper/sql_json_converter.dart';
import 'package:drift/drift.dart';



class SearchProfilesTable extends Table {
  
  // --- Identity Columns ---
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant('Standard'))();
  BoolColumn get isActiveProfile => boolean().withDefault(const Constant(false))();

  // --- Settings Columns ---

  /// 1st level sort order for search results.
  /// If an entry of [DaKanjiDbSearch1stSortOrder] is not included here, it
  /// will not be searched for.
  TextColumn get firstSortOrder => text().map(const FirstSortOrderConverter())();

  /// 2nd level sort order for search results.
  /// If an entry of [DakanjiDbSearchResult2ndSortOrder] is not included here, it
  /// will not be searched for.
  TextColumn get secondSortOrder => text().map(const SecondSortOrderConverter())();

  /// Whether to convert romaji to hiragana in normalized searches.
  BoolColumn get normalizeSearchConvertsRomajiToHiragana => boolean().withDefault(const Constant(true))();

  /// The grouping rules to apply to the search.
  TextColumn get groupingRules => text().map(const JsonConverter())();

  /// Whether to show the separation headers such as "Exact Matches",
  /// "Prefix Matches", etc.
  BoolColumn get showSearchResultSeparationHeaders => boolean().withDefault(const Constant(true))();

  /// Whether to show Kanji entries at the top search results when searching
  /// for single characters
  BoolColumn get showKanjiEntriesInSearchResults => boolean().withDefault(const Constant(true))();

  /// Whether to show tags in [DictionaryMatchWidget]s.
  BoolColumn get showTags => boolean().withDefault(const Constant(true))();

  /// Whether to show meta entries in [DictionaryMatchWidget]s.
  BoolColumn get showMetaEntries => boolean().withDefault(const Constant(true))();

  /// Maximum height for compact definitions.
  RealColumn get definitionsMaxHeight => real().withDefault(const Constant(60.0))();

  /// Whether to use katakana for furigana instead of hiragana.
  BoolColumn get useKatakanaForFurigana => boolean().withDefault(const Constant(false))();

  /// The maximum number of typo corrections to consider.
  IntColumn get spellfixMaxResults => integer().withDefault(const Constant(20))();

  /// The maximum cost for typo correction searches.
  IntColumn get spellfixMaxCost => integer().withDefault(const Constant(10))();

  /// Maximum number of results to return when search (does apply to each 
  /// of the four independent searches **separately**).
  IntColumn get searchResultLimit => integer().withDefault(const Constant(100))();
}