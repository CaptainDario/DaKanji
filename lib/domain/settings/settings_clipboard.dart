// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'settings_clipboard.g.dart';



/// Class to store all settings for the clipboard screen
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsClipboard with ChangeNotifier {


  /// Should the search term be deconjugated before searching
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_searchDeconjugate = true;
  @JsonKey(defaultValue: d_searchDeconjugate)
  /// Should the search term be deconjugated before searching
  bool searchDeconjugate = d_searchDeconjugate;

  
  SettingsClipboard ();


  /// Instantiates a new instance from a json map
  factory SettingsClipboard.fromJson(Map<String, dynamic> json) => _$SettingsClipboardFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsClipboardToJson(this);
}
