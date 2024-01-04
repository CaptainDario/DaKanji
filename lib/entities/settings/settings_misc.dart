


// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

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
    LocaleKeys.DojgScreen_title,
    LocaleKeys.ClipboardScreen_title
  ];
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Screens> startupScreens = [
    Screens.drawing,
    Screens.dictionary,
    Screens.text,
    Screens.dojg,
    Screens.clipboard,
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

  /// The currently selected locale
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const String d_selectedLocale = "en";
  /// The currently selected locale
  @JsonKey(defaultValue: d_selectedTheme)
  String _selectedLocale = d_selectedLocale;
  /// The currently selected locale
  String get selectedLocale => _selectedLocale;
  /// The currently selected locale
  set selectedLocale(String locale) {
    _selectedLocale = locale;
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


  /// All valid values for `sharingScheme`
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<String> sharingSchemes = [g_AppLinkHttps, g_AppLinkDaKanji];
  /// The default value for `sharingScheme`
  @JsonKey(includeToJson: false, includeFromJson: false)
  // ignore: constant_identifier_names
  static const String d_sharingScheme = g_AppLinkHttps;
  /// The currently selected sharing scheme, defaults to `https://` on all
  /// platforms excepet linux
  @JsonKey(defaultValue: d_sharingScheme)
  String _sharingScheme = d_sharingScheme;
  /// The currently selected sharing scheme, defaults to `https://` on all
  /// platforms excepet linux
  String get sharingScheme => _sharingScheme;
  /// The currently selected sharing scheme, defaults to `https://` on all
  /// platforms excepet linux
  set sharingScheme(String newSharingScheme){
    if(!sharingSchemes.contains(newSharingScheme)){
      throw Exception("$newSharingScheme is not a valid scheme, use one of $sharingSchemes");
    }

    _sharingScheme = newSharingScheme;
    notifyListeners();
  }
  


  SettingsMisc (){
    selectedTheme = LocaleKeys.General_system;
    selectedStartupScreen = 1;

    if(Platform.isLinux){
      sharingScheme = sharingSchemes[1];
    }
  }

  ThemeMode? selectedThemeMode() {
    return themesDict[selectedTheme];
  }

  /// Instantiates a new instance from a json map
  factory SettingsMisc.fromJson(Map<String, dynamic> json) => _$SettingsMiscFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsMiscToJson(this);
}
