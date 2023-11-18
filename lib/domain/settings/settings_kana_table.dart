// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'settings_kana_table.g.dart';



/// Class to store all settings for the kana table screen
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsKanaTable with ChangeNotifier {


  /// the default value for `kanjiCategory`
  // ignore: constant_identifier_names
  static const bool d_playAudio = true;
  /// The category of which kanji should be shown
  @JsonKey(defaultValue: d_playAudio)
  bool playAudio = d_playAudio;



  SettingsKanaTable();

  /// Instantiates a new instance from a json map
  factory SettingsKanaTable.fromJson(Map<String, dynamic> json) => _$SettingsKanaTableFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsKanaTableToJson(this);
}
