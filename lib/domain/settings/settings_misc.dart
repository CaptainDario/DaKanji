import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/screens.dart';

part 'settings_misc.g.dart';



/// Class to store all settings in the miscellanelous settings
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsMisc with ChangeNotifier {

  /// the available options of themes
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> themesLocaleKeys = [
    LocaleKeys.General_light,
    LocaleKeys.General_dark,
    LocaleKeys.General_system
  ];
  
  /// A Map from the string of a theme to the ThemeMode of the theme.
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, ThemeMode> themesDict = {
    LocaleKeys.General_light : ThemeMode.light,
    LocaleKeys.General_dark : ThemeMode.dark,
    LocaleKeys.General_system : ThemeMode.system
  };

  /// The startup screen options 
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> startupScreensLocales = [
    LocaleKeys.DrawScreen_title,
    LocaleKeys.DictionaryScreen_title,
    LocaleKeys.TextScreen_title,
  ];
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Screens> startupScreens = [
    Screens.drawing,
    Screens.dictionary,
    Screens.text,
  ];

  /// The default for the startup screen
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_selectedStartupScreen = 2;
  /// string denoting the screen that should be loaded at app start
  @JsonKey(defaultValue: d_selectedStartupScreen)
  late int _selectedStartupScreen = d_selectedStartupScreen;
  /// string deonting the screen that should be loaded at app start
  int get selectedStartupScreen => _selectedStartupScreen;
  /// string deonting the screen that should be loaded at app start
  set selectedStartupScreen(int selectedStartupScreen) {
    _selectedStartupScreen = selectedStartupScreen;
    notifyListeners();
  }


  /// The default value for `windowWidth`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_windowWidth = 480;
  /// width of the current window
  @JsonKey(defaultValue: d_windowWidth)
  int windowWidth = d_windowWidth;


  /// The default value for `windowHeight`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_windowHeight = 720;
  /// height of the current window
  @JsonKey(defaultValue: d_windowWidth)
  int windowHeight = 720;


  /// The default value for `selectedTheme` 
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const String d_selectedTheme = LocaleKeys.General_system;
  /// The theme which the application will use.
  /// System will match the settings of the system.
  @JsonKey(defaultValue: d_selectedTheme)
  String _selectedTheme = d_selectedTheme;
  /// The theme which the application will use.
  /// System will match the settings of the system.
  String get selectedTheme => _selectedTheme;
  /// The theme which the application will use.
  /// System will match the settings of the system.
  set selectedTheme(String selectedTheme) {
    _selectedTheme = selectedTheme;
    notifyListeners();
  }


  /// should this window always be shown on top of other windows
  @JsonKey(defaultValue: false)
  bool _alwaysOnTop = false;
  /// should this window always be shown on top of other windows
  bool get alwaysOnTop => _alwaysOnTop;
  /// should this window always be shown on top of other windows
  set alwaysOnTop(bool alwaysOnTop) {
    _alwaysOnTop = alwaysOnTop;
    notifyListeners();
  }


  /// The window's opacity
  @JsonKey(defaultValue: 1.0)
  double _windowOpacity = 1.0;
  /// The window's opacity
  double get windowOpacity => _windowOpacity;
  /// The window's opacity
  set windowOpacity(double windowOpacity) {
    _windowOpacity = windowOpacity;
    notifyListeners();
  }

  /// Order of the items in the drawer
  @JsonKey(defaultValue: [])
  List<int> drawerItemOrder = [];
  /// Order of the items in the drawer
  /// // ignore: constant_identifier_names
  //List<int> get drawerItemOrder => _drawerItemOrder;
  /// Order of the items in the drawer
  //set drawerItemOrder(List<int> newOrder){
  //  _drawerItemOrder = newOrder;
  //  notifyListeners();
  //}


  SettingsMisc (){
    selectedTheme = LocaleKeys.General_system;
    selectedStartupScreen = 1;
  }

  ThemeMode? selectedThemeMode() {
    return themesDict[selectedTheme];
  }

  /// Instantiates a new instance from a json map
  factory SettingsMisc.fromJson(Map<String, dynamic> json) => _$SettingsMiscFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsMiscToJson(this);
}