import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_dictionary.g.dart';



/// Class to store all settings in the drawing settings '
/// 
/// To update the toJson code run `flutter pub run build_runner build`
@JsonSerializable()
class SettingsDictionary with ChangeNotifier {

  /// The deafult value for `translationLanguageCodes`
  @JsonKey(ignore: true)
  static const List<String> d_translationLanguageCodes = [
    "eng", "ger", "fre", "rus", "spa", "hun", "slv", "dut"
  ];
  /// All languages that are available in the dictionary in the useres order
  @JsonKey(defaultValue: d_translationLanguageCodes)
  List<String> translationLanguageCodes = d_translationLanguageCodes;
  

  /// All languages that are available in the dictionary
  @JsonKey(ignore: true)
  Map<String, String> translationLanguagesToSvgPath = {
    "eng" : "assets/icons/eng.svg",
    "ger" : "assets/icons/ger.svg",
    "fre" : "assets/icons/fre.svg",
    "rus" : "assets/icons/rus.svg",
    "spa" : "assets/icons/spa.svg",
    "hun" : "assets/icons/hun.svg",
    "slv" : "assets/icons/slv.svg",
    "dut" : "assets/icons/dut.svg"
  };
  

  /// The default value for `selectedTranslationLanguagesDefault` 
  @JsonKey(ignore: true)
  static const List<String> d_selectedTranslationLanguages = ["eng"];
  /// All languages that are selected to be shown in the dict UI
  @JsonKey(defaultValue: d_selectedTranslationLanguages)
  List<String> _selectedTranslationLanguages = d_selectedTranslationLanguages;
  /// All languages that are selected to be shown in the dict UI
  List<String> get selectedTranslationLanguages => _selectedTranslationLanguages;
  /// All languages that are selected to be shown in the dict UI
  set selectedTranslationLanguages(List<String> selectedTranslationLanguages) {
    _selectedTranslationLanguages = selectedTranslationLanguages;
    notifyListeners();
  }


  SettingsDictionary();


  /// Instantiates a new instance from a json map
  factory SettingsDictionary.fromJson(Map<String, dynamic> json) => 
    _$SettingsDictionaryFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsDictionaryToJson(this);
}