import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_anki.g.dart';



/// Class to store all settings related to the anki integration
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsAnki with ChangeNotifier {

  /// The default value for `includeGoogleImage`
  @JsonKey(ignore: true)
  static const bool d_includeGoogleImage = false;
  /// When creating a new note, download and include a google image of the vocabulary
  @JsonKey(defaultValue: d_includeGoogleImage)
  bool _includeGoogleImage = d_includeGoogleImage;
  /// When creating a new note, download and include a google image of the vocabulary
  bool get includeGoogleImage => _includeGoogleImage;
  /// When creating a new note, download and include a google image of the vocabulary
  set includeGoogleImage(bool value) {
    _includeGoogleImage = value;
    notifyListeners();
  }

  /// The default value for `includeAudio`
  @JsonKey(ignore: true)
  static const bool d_includeAudio = false;
  /// should an audio file be downloaded and included in the card
  @JsonKey(defaultValue: d_includeAudio)
  bool includeAudio = d_includeAudio;

  /// The default value for `includeScreenshot`
  @JsonKey(ignore: true)
  static const bool d_includeScreenshot = false;
  /// Include a screenshot of the current screen in the card
  @JsonKey(defaultValue: d_includeScreenshot)
  bool includeScreenshot = d_includeScreenshot;


  SettingsAnki();

  /// Instantiates a new instance from a json map
  factory SettingsAnki.fromJson(Map<String, dynamic> json) => _$SettingsAnkiFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsAnkiToJson(this);
}