import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/screens.dart';



/// Class to store all settings in the miscellanelous settings 
class SettingsMisc with ChangeNotifier {

  /// the available options of themes
  List<String> themesLocaleKeys = [
    LocaleKeys.General_light,
    LocaleKeys.General_dark,
    LocaleKeys.General_system
  ];
  
  /// A Map from the string of a theme to the ThemeMode of the theme.
  Map<String, ThemeMode> themesDict = {
    LocaleKeys.General_light : ThemeMode.light,
    LocaleKeys.General_dark : ThemeMode.dark,
    LocaleKeys.General_system : ThemeMode.system
  };

  /// The startup screen options 
  List<String> startupScreenOptions = [
    Screens.drawing.name,
    Screens.dictionary.name,
    Screens.text.name,
  ];

  /// width of the current window
  int windowWidth = 480;
  /// height of the current window
  int windowHeight = 720;

  /// The theme which the application will use.
  /// System will match the settings of the system.
  late String selectedTheme;


  SettingsMisc (){
    selectedTheme = LocaleKeys.General_system;
  }


  ThemeMode? selectedThemeMode() {
    return themesDict[selectedTheme];
  }


  void initFromMap(Map<String, dynamic> map){

    selectedTheme      = map['selectedTheme'];
    windowWidth        = map['windowWidth'];
    windowHeight       = map['windowHeight'];

  }

  void initFromJson(String jsonString) =>
    initFromMap(json.decode(jsonString));
  

  Map<String, dynamic> toMap() => {
    'selectedTheme' : selectedTheme,
    'windowWidth'   : windowWidth,
    'windowHeight'  : windowHeight,
  };

  String toJson() => json.encode(toMap());
}