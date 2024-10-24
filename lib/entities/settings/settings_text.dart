// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'settings_text.g.dart';



/// Class to store all settings in the text settings
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsText with ChangeNotifier {


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

  /// Should the text screen open with the processed text maximized
  @JsonKey(defaultValue: false)
  bool _openInFullscreen = false;
  /// Should the text screen open with the processed text maximized
  bool get openInFullscreen => _openInFullscreen;
  /// Should the text screen open with the processed text maximized
  set openInFullscreen(bool openInFullscreen) {
    _openInFullscreen = openInFullscreen;
    notifyListeners();
  }

  /// Should the search term be deconjugated before searching
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_searchDeconjugate = true;
  @JsonKey(defaultValue: d_searchDeconjugate)
  /// Should the search term be deconjugated before searching
  bool searchDeconjugate = d_searchDeconjugate;

  
  SettingsText ();


  /// Instantiates a new instance from a json map
  factory SettingsText.fromJson(Map<String, dynamic> json) => _$SettingsTextFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsTextToJson(this);
}
