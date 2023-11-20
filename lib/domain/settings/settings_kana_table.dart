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

  /// When opening the kana popup, should the animation be played
  @JsonKey(defaultValue: true)
  bool playKanjiAnimationWhenOpened = true;
  /// How many strokes should be drawn during the animation
  @JsonKey(defaultValue: 2)
  double kanjiAnimationStrokesPerSecond = 2;
  /// When swipe to scroll to modify the kana animation, should the animation
  /// continue playing
  @JsonKey(defaultValue: false)
  bool resumeAnimationAfterStopSwipe = false;

  /// SETTINGS THAT ARE AUTOMATICALLY SET DURING USAGE
  /// Are currently hiragana being shown
  @JsonKey(defaultValue: true)
  bool isHiragana = true;
  /// Are romaji being shown
  @JsonKey(defaultValue: true)
  bool showRomaji = true;
  /// Are dakuten being shown
  @JsonKey(defaultValue: false)
  bool showDaku = false;
  /// Are yoon being shown
  @JsonKey(defaultValue: false)
  bool showYoon = false;
  /// Are special yoon being shown
  @JsonKey(defaultValue: false)
  bool showSpecial = false;



  SettingsKanaTable();

  /// Instantiates a new instance from a json map
  factory SettingsKanaTable.fromJson(Map<String, dynamic> json) => _$SettingsKanaTableFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsKanaTableToJson(this);
}
