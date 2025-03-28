// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/dictionary_search_priority_interface.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

part 'settings_dictionary.g.dart';



/// Class to store all settings in the drawing settings '
/// 
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsDictionary with ChangeNotifier implements  DictionarySearchPriorityInterface{

  /// The deafult value for `translationLanguageCodes`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<String> d_translationLanguageCodes = [
    "en", "de", "ru", "it", "fr", "es", "pl",
  ];
  /// All languages that are available in the dictionary in the useres order
  @JsonKey(defaultValue: d_translationLanguageCodes)
  List<String> translationLanguageCodes = d_translationLanguageCodes;
  

  /// All languages that are available in the dictionary
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, String> translationLanguagesToSvgPath = 
    { for (var item in d_translationLanguageCodes) item : "assets/icons/$item.svg" };
  

  /// The default value for `selectedTranslationLanguagesDefault` 
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<String> d_selectedTranslationLanguages = ["en"];
  /// All languages that are selected to be shown in the dict UI
  @JsonKey(defaultValue: d_selectedTranslationLanguages)
  List<String> _selectedTranslationLanguages = ["en"];
  /// All languages that are selected to be shown in the dict UI
  List<String> get selectedTranslationLanguages => _selectedTranslationLanguages;
  /// All languages that are selected to be shown in the dict UI
  set selectedTranslationLanguages(List<String> selectedTranslationLanguages) {
    _selectedTranslationLanguages = selectedTranslationLanguages;
    notifyListeners();
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_showSearchMatchSeparation = true;
  @JsonKey(defaultValue: d_showSearchMatchSeparation)
  /// Should the search results have a separating header depending on how the
  /// result matched
  bool showSearchMatchSeparation = d_showSearchMatchSeparation;

  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_addToAnkiFromSearchResults = false;
  @JsonKey(defaultValue: d_addToAnkiFromSearchResults)
  /// Should the word frequency be shown in the dict UI
  bool addToAnkiFromSearchResults = d_addToAnkiFromSearchResults;

  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_addToListFromSearchResults = false;
  @JsonKey(defaultValue: d_addToAnkiFromSearchResults)
  /// Should the word frequency be shown in the dict UI
  bool addToListFromSearchResults = d_addToListFromSearchResults;

  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_showWordFruequency = false;
  @JsonKey(defaultValue: d_showWordFruequency)
  /// Should the word frequency be shown in the dict UI
  bool showWordFruequency = d_showWordFruequency;

  /// The deafult value for `searchResultSearchPriorities`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<String> d_searchResultSortPriorities = [
    LocaleKeys.SettingsScreen_dict_term,
    LocaleKeys.SettingsScreen_dict_convert_to_kana,
    LocaleKeys.SettingsScreen_dict_base_form,
  ];
  /// The search result sort priorities
  @JsonKey(defaultValue: d_searchResultSortPriorities)
  @override
  List<String> searchResultSortPriorities = d_searchResultSortPriorities;

  /// The default value for `selectedSearchResultSortPriorities` 
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<String> d_selectedSearchResultSortPriorities = d_searchResultSortPriorities;
  /// The search result sorting order priorities that are selected
  @JsonKey(defaultValue: d_selectedSearchResultSortPriorities)
  List<String> _selectedSearchResultSortPriorities = d_searchResultSortPriorities;
  /// The search result sorting order priorities that are selected
  @override
  List<String> get selectedSearchResultSortPriorities => _selectedSearchResultSortPriorities;
  /// The search result sorting order priorities that are selected
  @override
  set selectedSearchResultSortPriorities(List<String> searchResultSortPriorities) {
    _selectedSearchResultSortPriorities = searchResultSortPriorities;
    notifyListeners();
  }
  /// Should search terms be converted to hiragana when searching
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get convertToHiraganaBeforeSearch => selectedSearchResultSortPriorities
    .contains(LocaleKeys.SettingsScreen_dict_convert_to_kana);
  /// Should search terms be deconjugated when searching
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get deconjugateBeforeSearch => selectedSearchResultSortPriorities
    .contains(LocaleKeys.SettingsScreen_dict_base_form);

  /// The deafult value for `selectedFallingWordsLevels`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<String> d_fallingWordsLevels = [
    "N5", "N4", "N3", "N2", "N1",
  ];
  /// All levels that can be selected for the falling words in the dictionary
  @JsonKey(defaultValue: ["N5", "N4", "N3"])
  List<String> selectedFallingWordsLevels = ["N5", "N4", "N3"];

  /// When opening the kanji page, should the animation be played
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_playKanjiAnimationWhenOpened = true;
  /// When opening the kanji page, should the animation be played
  @JsonKey(defaultValue: d_playKanjiAnimationWhenOpened)
  bool playKanjiAnimationWhenOpened = d_playKanjiAnimationWhenOpened;

  /// Should the dictionary search results be limited to improve performance
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_limitSearchResults = 100;
  /// Should the dictionary search results be limited to improve performance
  @JsonKey(defaultValue: d_limitSearchResults)
  int limitSearchResults = d_limitSearchResults;

  /// How many strokes should be drawn during the animation
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const double d_kanjiAnimationStrokesPerSecond = 5;
  /// How many strokes should be drawn during the animation
  @JsonKey(defaultValue: d_kanjiAnimationStrokesPerSecond)
  double kanjiAnimationStrokesPerSecond = d_kanjiAnimationStrokesPerSecond;

  /// When stopping to swipe to modify the kanji animation, should the animation
  /// continue playing
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_resumeAnimationAfterStopSwipe = false;
  /// When swipe to scroll to modify the kanji animation, should the animation
  /// continue playing
  @JsonKey(defaultValue: d_resumeAnimationAfterStopSwipe)
  bool resumeAnimationAfterStopSwipe = d_resumeAnimationAfterStopSwipe;

  /// Query to use in google image search
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const String d_googleImageSearchQuery = "%X%";
  /// Query to use in google image search
  @JsonKey(defaultValue: d_googleImageSearchQuery)
  String googleImageSearchQuery = d_googleImageSearchQuery;


  SettingsDictionary();


  /// Instantiates a new instance from a json map
  factory SettingsDictionary.fromJson(Map<String, dynamic> json) => 
    _$SettingsDictionaryFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsDictionaryToJson(this);
}
