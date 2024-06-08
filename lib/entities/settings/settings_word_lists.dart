// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';

part 'settings_word_lists.g.dart';



/// Class to store all settings in the drawing settings '
/// 
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsWordLists with ChangeNotifier {

  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_showWordFruequency = false;
  @JsonKey(defaultValue: d_showWordFruequency)
  /// Should the word frequency be shown in the dict UI
  bool showWordFruequency = d_showWordFruequency;

  /// When exporting a word list, which languages should be included
  @JsonKey(defaultValue: [true])
  List<bool> _includedLanguages = [true];
  /// When creating a new note, which languages should be included
  List<bool> get includedLanguages => _includedLanguages;
  /// When creating a new note, which languages should be included
  set includedLanguages(List<bool> value) {
    _includedLanguages = value;
    notifyListeners();
  }
  void setIncludeLanguagesItem(bool value, int index){
    _includedLanguages[index] = value;
    notifyListeners();
  }

  /// Based on the given `selectedTranslationLanguages` (the languages selected
  /// in the dictionary) returns the languages that should be included when
  /// exporting a word list
  List<String> langsToInclude (List<String> selectedTranslationLanguages) => 
    selectedTranslationLanguages
      .whereIndexed((index, element) => includedLanguages[index])
      .map((e) => isoToiso639_2B[e]!.name)
      .toList();

  /// The default value for `quickAddLists`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<int> d_quickAddListIDs = [];
  /// IDs of the Lists to add to when quick adding
  @JsonKey(defaultValue: d_quickAddListIDs)
  List<int> _quickAddListIDs = d_quickAddListIDs;
  /// IDs of the Lists to add to when quick adding
  List<int> get quickAddListIDs => _quickAddListIDs;
  /// IDs of the Lists to add to when quick adding
  set quickAddListIDs(List<int> value) {
    _quickAddListIDs = value;
    notifyListeners();
  }

  /// The default value for `pdfMaxMeaningsPerVocabulary`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_pdfMaxMeaningsPerVocabulary = 3;
  /// When creating a new note, how many translations should be included
  @JsonKey(defaultValue: d_pdfMaxMeaningsPerVocabulary)
  int _pdfMaxMeaningsPerVocabulary = d_pdfMaxMeaningsPerVocabulary;
  /// When creating a new note, how many translations should be included
  int get pdfMaxMeaningsPerVocabulary => _pdfMaxMeaningsPerVocabulary;
  /// When creating a new note, how many translations should be included
  set pdfMaxMeaningsPerVocabulary(int value) {
    _pdfMaxMeaningsPerVocabulary = value;
    notifyListeners();
  }

  /// The default value for `pdfMaxWordsPerMeaning`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_pdfMaxWordsPerMeaning = 3;
  /// When exporting to PDF, how many words should one meaning have at max
  @JsonKey(defaultValue: d_pdfMaxWordsPerMeaning)
  int _pdfMaxWordsPerMeaning = d_pdfMaxWordsPerMeaning;
  /// When exporting to PDF, how many words should one meaning have at max
  int get pdfMaxWordsPerMeaning => _pdfMaxWordsPerMeaning;
  /// When exporting to PDF, how many words should one meaning have at max
  set pdfMaxWordsPerMeaning (int value) {
    _pdfMaxWordsPerMeaning = value;
    notifyListeners();
  }

  /// The default value for `pdfMaxLinesPerMeaning`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_pdfMaxLinesPerMeaning = 2;
  /// When exporting to PDF, how many lines should one meaning occupy at max
  @JsonKey(defaultValue: d_pdfMaxLinesPerMeaning)
  int _pdfMaxLinesPerMeaning = d_pdfMaxLinesPerMeaning;
  /// When exporting to PDF, how many lines should one meaning occupy at max
  int get pdfMaxLinesPerMeaning => _pdfMaxLinesPerMeaning;
  /// When exporting to PDF, how many lines should one meaning occupy at max
  set pdfMaxLinesPerMeaning (int value) {
    _pdfMaxLinesPerMeaning = value;
    notifyListeners();
  }
  
  /// The default value for `pdfIncludeKana`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_pdfIncludeKana = true;
  /// When exporting to PDF, should kana be included
  @JsonKey(defaultValue: d_pdfIncludeKana)
  bool _pdfIncludeKana = d_pdfIncludeKana;
  /// When exporting to PDF, should kana be included
  bool get pdfIncludeKana => _pdfIncludeKana;
  /// When exporting to PDF, should kana be included
  set pdfIncludeKana (bool value) {
    _pdfIncludeKana = value;
    notifyListeners();
  }


  /// The default value for `screenSaverSecondsToStart`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_autoStartScreensaver = false;
  /// Should the screen saver start automatically after the set time
  @JsonKey(defaultValue: d_autoStartScreensaver)
  bool _autoStartScreensaver = d_autoStartScreensaver;
  /// Should the screen saver start automatically after the set time
  bool get autoStartScreensaver => _autoStartScreensaver;
  /// Should the screen saver start automatically after the set time
  set autoStartScreensaver (bool value) {
    _autoStartScreensaver = value;
    notifyListeners();
  }

  /// The default value for `screenSaverWordList`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<int> d_screenSaverWordLists = [];
  /// The word lists that should be included in the screen saver
  @JsonKey(defaultValue: d_screenSaverWordLists)
  List<int> _screenSaverWordLists = d_screenSaverWordLists;
  /// The word lists that should be included in the screen saver
  List<int> get screenSaverWordLists => _screenSaverWordLists;
  /// The word lists that should be included in the screen saver
  set screenSaverWordLists (List<int> value) {
    _screenSaverWordLists = value;
    notifyListeners();
  }

  /// The default value for `screenSaverSecondsToStart`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_screenSaverSecondsToStart = 60*2;
  /// How many seconds until the screen saver starts
  @JsonKey(defaultValue: d_screenSaverSecondsToStart)
  int _screenSaverSecondsToStart = d_screenSaverSecondsToStart;
  /// How many seconds until the screen saver starts
  int get screenSaverSecondsToStart => _screenSaverSecondsToStart;
  /// How many seconds until the screen saver starts
  set screenSaverSecondsToStart (int value) {
    _screenSaverSecondsToStart = value;
    notifyListeners();
  }

  /// The default value for `screenSaverSecondsToNextCard`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_screenSaverSecondsToNextCard = 10;
  /// How many seconds one card should be visible in screen saver mode
  @JsonKey(defaultValue: d_screenSaverSecondsToNextCard)
  int _screenSaverSecondsToNextCard = d_screenSaverSecondsToNextCard;
  /// How many seconds one card should be visible in screen saver mode
  int get screenSaverSecondsToNextCard => _screenSaverSecondsToNextCard;
  /// How many seconds one card should be visible in screen saver mode
  set screenSaverSecondsToNextCard (int value) {
    _screenSaverSecondsToNextCard = value;
    notifyListeners();
  }


  SettingsWordLists();


  /// Instantiates a new instance from a json map
  factory SettingsWordLists.fromJson(Map<String, dynamic> json) => 
    _$SettingsWordListsFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsWordListsToJson(this);
}
