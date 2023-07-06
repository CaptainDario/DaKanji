import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_dictionary.g.dart';



/// Class to store all settings in the drawing settings '
/// 
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsDictionary with ChangeNotifier {

  /// The deafult value for `translationLanguageCodes`
  @JsonKey(includeFromJson: false, includeToJson: false)
  static const List<String> d_translationLanguageCodes = [
    "en", "de", "ru", "it", "fr", "es", "pl",
  ];
  /// All languages that are available in the dictionary in the useres order
  @JsonKey(defaultValue: d_translationLanguageCodes)
  List<String> translationLanguageCodes = d_translationLanguageCodes;
  

  /// All languages that are available in the dictionary
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, String> translationLanguagesToSvgPath = 
    Map<String, String>.fromIterable(
      (d_translationLanguageCodes),
      key : (item) => item,
      value : (item) => "assets/icons/$item.svg"
    );
  

  /// The default value for `selectedTranslationLanguagesDefault` 
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  static const bool d_showWordFruequency = false;
  @JsonKey(defaultValue: d_showWordFruequency)
  /// Should the word frequency be shown in the dict UI
  bool showWordFruequency = d_showWordFruequency;

  @JsonKey(includeFromJson: false, includeToJson: false)
  static const bool d_searchDeconjugate = true;
  @JsonKey(defaultValue: d_searchDeconjugate)
  /// Should the search term be deconjugated before searching
  bool searchDeconjugate = d_searchDeconjugate;

  @JsonKey(includeFromJson: false, includeToJson: false)
  static const bool d_convertToHiragana = true;
  @JsonKey(defaultValue: d_convertToHiragana)
  /// Should the search term be converted to kana if it is written in romaji
  /// before searching
  bool convertToHiragana = d_convertToHiragana;

  /// The deafult value for `selectedFallingWordsLevels`
  @JsonKey(includeFromJson: false, includeToJson: false)
  static const List<String> d_fallingWordsLevels = [
    "N5", "N4", "N3", "N2", "N1",
  ];
  /// All levels that can be selected for the falling words in the dictionary
  @JsonKey(defaultValue: const ["N5", "N4", "N3"])
  List<String> selectedFallingWordsLevels = ["N5", "N4", "N3"];



  SettingsDictionary();


  /// Instantiates a new instance from a json map
  factory SettingsDictionary.fromJson(Map<String, dynamic> json) => 
    _$SettingsDictionaryFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsDictionaryToJson(this);
}