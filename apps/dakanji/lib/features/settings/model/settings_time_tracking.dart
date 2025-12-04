// Flutter imports:
import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';

part 'settings_time_tracking.g.dart';



/// Class to store all settings related to the anki integration
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsTimeTracking with ChangeNotifier {

  /// The default value for `sessionLength`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_sessionLength = 25;
  /// When creating a new note, how many examples should be included
  @JsonKey(defaultValue: d_sessionLength)
  int _sessionLength = d_sessionLength;
  /// How long should a study session be in minutes
  int get sessionLength => _sessionLength;
  /// How long should a study session be in minutes
  set sessionLength(int value) {
    _sessionLength = value;
    notifyListeners();
  }

  /// The default value for `breakLength`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_breakLength = 5;
  /// How long should a break be in minutes
  @JsonKey(defaultValue: d_breakLength)
  int _breakLength = d_breakLength;
  /// How long should a break be in minutes
  int get breakLength => _breakLength;
  set breakLength(int value) {
    _breakLength = value;
    notifyListeners();
  }



  SettingsTimeTracking();

  /// Instantiates a new instance from a json map
  factory SettingsTimeTracking.fromJson(Map<String, dynamic> json) => _$SettingsTimeTrackingFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsTimeTrackingToJson(this);
}
