import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_dictionary.g.dart';



/// Class to store all settings in the drawing settings '
/// 
/// To update the toJson code run `flutter pub run build_runner build`
@JsonSerializable()
class SettingsDictionary with ChangeNotifier {

  /// All languages that are available in the dictionary
  @JsonKey(ignore: true)
  List<String> translationLanguages = [
    "eng",
    "dut",
    "fre",
    "ger",
    "hun",
    "rus",
    "slv",
    "spa",
    "swe"
  ];
  /// All languages that are selected to be shown in the dict UI
  List<String> _selectedTranslationLanguages = [];
  /// All languages that are selected to be shown in the dict UI
  List<String> get selectedTranslationLanguages => _selectedTranslationLanguages;
  /// All languages that are selected to be shown in the dict UI
  set selectedTranslationLanguages(List<String> selectedTranslationLanguages) {
    _selectedTranslationLanguages = selectedTranslationLanguages;
    notifyListeners();
  }


  SettingsDictionary();


  /// Instantiates a new instance from a json map
  factory SettingsDictionary.fromJson(Map<String, dynamic> json) => _$SettingsDictionaryFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsDictionaryToJson(this);
}