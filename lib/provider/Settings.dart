import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/provider/SettingsDrawing.dart';
import 'package:da_kanji_mobile/provider/SettingsAdvanced.dart';
import 'package:da_kanji_mobile/provider/SettingsMisc.dart';



/// Class to store all settings of DaKanji
class Settings with ChangeNotifier {

  late SettingsDrawing settingsDrawing;

  late SettingsMisc settingsMisc;

  late SettingsAdvanced settingsAdvanced;



  Settings() {

    settingsDrawing  = SettingsDrawing();
    settingsMisc     = SettingsMisc();
    settingsAdvanced = SettingsAdvanced();

  }

  // #region DRAWING SETTINGS 
  /// The custom URL a user can define on the settings page.
  String get customURL {
    return this.settingsDrawing.customURL;
  }
  set customURL(String newValue){
    this.settingsDrawing.customURL = newValue;
    notifyListeners();
  }

  /// The string representation of the dictionary which will be used (long press)
  String get selectedDictionary {
    return this.settingsDrawing.selectedDictionary;
  }
  set selectedDictionary(String newValue){
    this.settingsDrawing.selectedDictionary = newValue;
    notifyListeners();
  }

  /// Should the behavior of long and short press be inverted
  bool get invertShortLongPress {
    return this.settingsDrawing.invertShortLongPress;
  }
  set invertShortLongPress(bool newValue){
    this.settingsDrawing.invertShortLongPress = newValue;
    notifyListeners();
  }

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool get emptyCanvasAfterDoubleTap {
    return this.settingsDrawing.emptyCanvasAfterDoubleTap;
  }
  set emptyCanvasAfterDoubleTap(bool newValue){
    this.settingsDrawing.emptyCanvasAfterDoubleTap = newValue;
    notifyListeners();
  }

  /// should the default app browser be used for opening predictions or a webview
  bool get useWebview {
    return this.settingsDrawing.useWebview;
  }
  set useWebview(bool newValue){
    this.settingsDrawing.useWebview = newValue;
    notifyListeners();
  }
  // #endregion

  // #region MISC SETTINGS
  String get selectedTheme{
    return this.settingsMisc.selectedTheme;
  }
  set selectedTheme(String newValue){
    this.settingsMisc.selectedTheme = newValue;
    notifyListeners();
  }

  ThemeMode? selectedThemeMode() {
    return this.settingsMisc.themesDict[selectedTheme];
  }
  // #endregion

  // #region ADVANCED SETTINGS
  String get inferenceBackend{
    return this.settingsAdvanced.inferenceBackend;
  }
  set inferenceBackend(String newValue){
    this.settingsAdvanced.inferenceBackend = newValue;
    notifyListeners();
  }

  bool get useThanosSnap{
    return this.settingsAdvanced.useThanosSnap;
  }
  set useThanosSnap(bool newValue){
    this.settingsAdvanced.useThanosSnap = newValue;
    notifyListeners();
  }
  // #endregion

  /// Saves all settings to the SharedPreferences.
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('settingsDrawing', settingsDrawing.toJson());
    prefs.setString('settingsMisc', settingsMisc.toJson());
    prefs.setString('settingsAdvanced', settingsAdvanced.toJson());
  }

  /// Load all saved settings from SharedPreferences.
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // drawing screen
    String tmp = prefs.getString('settingsDrawing') ?? "";
    if(tmp != "")
      settingsDrawing.initFromJson(tmp);
    
    tmp = prefs.getString('settingsMisc') ?? "";
    if(tmp != "")
      settingsMisc.initFromJson(tmp);

    tmp = prefs.getString('settingsAdvanced') ?? "";
    if(tmp != "")
      settingsAdvanced.initFromJson(tmp);
  }
}

