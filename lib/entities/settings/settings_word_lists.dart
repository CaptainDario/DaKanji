// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

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

    /// The default value for `noTranslations`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_noTranslations = 3;
  /// When creating a new note, how many translations should be included
  @JsonKey(defaultValue: d_noTranslations)
  int _noTranslations = d_noTranslations;
  /// When creating a new note, how many translations should be included
  int get noTranslations => _noTranslations;
  /// When creating a new note, how many translations should be included
  set noTranslations(int value) {
    _noTranslations = value;
    notifyListeners();
  }


  SettingsWordLists();


  /// Instantiates a new instance from a json map
  factory SettingsWordLists.fromJson(Map<String, dynamic> json) => 
    _$SettingsWordListsFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsWordListsToJson(this);
}
