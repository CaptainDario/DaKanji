import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:da_kanji_mobile/domain/kanji_table/kanji_category.dart';
import 'package:da_kanji_mobile/domain/kanji_table/kanji_sorting.dart';
part 'settings_kanji_table.g.dart';



/// Class to store all settings for the kanji table screen
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsKanjiTable with ChangeNotifier {


  /// the default value for `kanjiCategory`
  // ignore: constant_identifier_names
  static const KanjiCategory d_kanjiCategory = KanjiCategory.jlpt;
  /// The category of which kanji should be shown
  @JsonKey(defaultValue: d_kanjiCategory)
  KanjiCategory kanjiCategory = d_kanjiCategory;

  /// the default value for `kanjiCategoryLevel`
  // ignore: constant_identifier_names
  static const String d_kanjiCategoryLevel = "5";
  /// The level of `kanjiCategory` of which kanji should be shown
  @JsonKey(defaultValue: d_kanjiCategoryLevel)
  String kanjiCategoryLevel = d_kanjiCategoryLevel;

  /// the default value for `kanjiSorting`
  // ignore: constant_identifier_names
  static const KanjiSorting d_kanjiSorting = KanjiSorting.strokesAsc;
  /// The way to sort the shown kanji
  @JsonKey(defaultValue: d_kanjiSorting)
  KanjiSorting kanjiSorting = d_kanjiSorting;


  SettingsKanjiTable();

  /// Instantiates a new instance from a json map
  factory SettingsKanjiTable.fromJson(Map<String, dynamic> json) => _$SettingsKanjiTableFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsKanjiTableToJson(this);
}