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


  SettingsWordLists();


  /// Instantiates a new instance from a json map
  factory SettingsWordLists.fromJson(Map<String, dynamic> json) => 
    _$SettingsWordListsFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsWordListsToJson(this);
}
