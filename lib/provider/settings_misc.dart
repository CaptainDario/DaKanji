import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/screens.dart';

part 'settings_misc.g.dart';



/// Class to store all settings in the miscellanelous settings
/// 
/// To update the toJson code run `flutter pub run build_runner build`
@JsonSerializable()
class SettingsMisc with ChangeNotifier {

  /// the available options of themes
  @JsonKey(ignore: true)
  List<String> themesLocaleKeys = [
    LocaleKeys.General_light,
    LocaleKeys.General_dark,
    LocaleKeys.General_system
  ];
  
  /// A Map from the string of a theme to the ThemeMode of the theme.
  @JsonKey(ignore: true)
  Map<String, ThemeMode> themesDict = {
    LocaleKeys.General_light : ThemeMode.light,
    LocaleKeys.General_dark : ThemeMode.dark,
    LocaleKeys.General_system : ThemeMode.system
  };

  /// The startup screen options 
  @JsonKey(ignore: true)
  List<String> startupScreens = [
    Screens.drawing.name,
    Screens.dictionary.name,
    Screens.text.name,
  ];

  /// string deonting the screen that should be loaded at app start
  late String _selectedStartupScreen;
  /// string deonting the screen that should be loaded at app start
  String get selectedStartupScreen => _selectedStartupScreen;
  /// string deonting the screen that should be loaded at app start
  set selectedStartupScreen(String selectedStartupScreen) {
    _selectedStartupScreen = selectedStartupScreen;
    notifyListeners();
  }

  /// width of the current window
  int windowWidth = 480;
  /// height of the current window
  int windowHeight = 720;

  /// The theme which the application will use.
  /// System will match the settings of the system.
  late String _selectedTheme;
  /// The theme which the application will use.
  /// System will match the settings of the system.
  String get selectedTheme => _selectedTheme;
  /// The theme which the application will use.
  /// System will match the settings of the system.
  set selectedTheme(String selectedTheme) {
    _selectedTheme = selectedTheme;
    notifyListeners();
  }


  SettingsMisc (){
    selectedTheme = LocaleKeys.General_system;
    selectedStartupScreen = startupScreens[0];
  }

  ThemeMode? selectedThemeMode() {
    return themesDict[selectedTheme];
  }

  /// Instantiates a new instance from a json map
  factory SettingsMisc.fromJson(Map<String, dynamic> json) => _$SettingsMiscFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsMiscToJson(this);
}