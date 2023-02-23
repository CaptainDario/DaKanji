import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_advanced.g.dart';



/// Class to store all settings in the advanced settings
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsAdvanced with ChangeNotifier {



  /// The default value for `useThanosSnap`
  @JsonKey(ignore: true)
  static const bool d_useThanosSnap = false;
  /// use a thanos like snap effect to dissolve the drawing from the screen
  @JsonKey(defaultValue: d_useThanosSnap)
  bool _useThanosSnap = d_useThanosSnap;
  /// use a thanos like snap effect to dissolve the drawing from the screen
  bool get useThanosSnap => _useThanosSnap;
  /// use a thanos like snap effect to dissolve the drawing from the screen
  set useThanosSnap(bool useThanosSnap) {
    _useThanosSnap = useThanosSnap;
    notifyListeners();
  }

  SettingsAdvanced();

  /// Instantiates a new instance from a json map
  factory SettingsAdvanced.fromJson(Map<String, dynamic> json) => _$SettingsAdvancedFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsAdvancedToJson(this);
}