// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/dictionary_search_priority_interface.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

part 'settings_text.g.dart';



/// Class to store all settings in the text settings
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsText with ChangeNotifier implements DictionarySearchPriorityInterface{


  /// are the text selection buttons enabled
  @JsonKey(defaultValue: true)
  bool _selectionButtonsEnabled = true;
  /// are the text selection buttons enabled
  bool get selectionButtonsEnabled => _selectionButtonsEnabled;
  /// are the text selection buttons enabled
  set selectionButtonsEnabled(bool selectionButtonsEnabled) {
    _selectionButtonsEnabled = selectionButtonsEnabled;
    notifyListeners();
  }

  /// The deafult value for `searchResultSearchPriorities`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const List<String> d_searchResultSortPriorities = [
    LocaleKeys.SettingsScreen_dict_term,
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
  /// Should search terms be deconjugated when searching
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get deconjugateBeforeSearch => selectedSearchResultSortPriorities
    .contains(LocaleKeys.SettingsScreen_dict_base_form);

  /// The default value for `windowWidth`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_windowWidth = 480;
  /// width of the popup window
  @JsonKey(defaultValue: d_windowWidth)
  int windowWidth = d_windowWidth;

  /// The default value for `windowHeight`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_windowHeight = 720;
  /// height of the popup window
  @JsonKey(defaultValue: d_windowHeight)
  int windowHeight = d_windowHeight;

  /// The default value for `windowPosX`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_windowPosX = 0;
  /// the x position where the popup window should be created
  @JsonKey(defaultValue: d_windowPosX)
  int windowPosX = d_windowPosX;

  /// The default value for `windowPosY`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_windowPosY = 0;
  /// the y position where the popup window should be created
  @JsonKey(defaultValue: d_windowPosY)
  int windowPosY = d_windowPosY;

  
  SettingsText ();


  /// Instantiates a new instance from a json map
  factory SettingsText.fromJson(Map<String, dynamic> json) => _$SettingsTextFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsTextToJson(this);
}
