import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/provider/settings_drawing.dart';
import 'package:da_kanji_mobile/provider/settings_advanced.dart';
import 'package:da_kanji_mobile/provider/settings_misc.dart';
import 'package:da_kanji_mobile/provider/settings_dictionary.dart';



/// Class to store all settings of DaKanji
class Settings with ChangeNotifier {

  late SettingsDrawing _drawing;

  late SettingsMisc _misc;

  late SettingsAdvanced _advanced;

  late SettingsDictionary _dictionary;



  Settings() {

    _drawing  = SettingsDrawing();
    _drawing.addListener(() => notifyListeners());

    _misc     = SettingsMisc();
    _misc.addListener(() => notifyListeners());

    _advanced = SettingsAdvanced();
    _advanced.addListener(() => notifyListeners());

    _dictionary = SettingsDictionary();
    _dictionary.addListener(() => notifyListeners());

  }

  SettingsDrawing get drawing {
    return _drawing;
  }

  SettingsMisc get misc {
    return _misc;
  }

  SettingsAdvanced get advanced {
    return _advanced;
  }

  SettingsDictionary get dictionary {
    return _dictionary;
  }


  String get inferenceBackend{
    return advanced.inferenceBackend;
  }
  set inferenceBackend(String newValue){
    advanced.inferenceBackend = newValue;
    notifyListeners();
  }

  bool get useThanosSnap{
    return advanced.useThanosSnap;
  }
  set useThanosSnap(bool newValue){
    advanced.useThanosSnap = newValue;
    notifyListeners();
  }
  // #endregion

  /// Saves all settings to the SharedPreferences.
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('settingsDrawing', drawing.toJson());
    prefs.setString('settingsMisc', misc.toJson());
    prefs.setString('settingsAdvanced', advanced.toJson());
  }

  /// Load all saved settings from SharedPreferences.
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // drawing screen
    String tmp = prefs.getString('settingsDrawing') ?? "";
    if(tmp != "") {
      drawing.initFromJson(tmp);
    }
    
    tmp = prefs.getString('settingsMisc') ?? "";
    if(tmp != "") {
      misc.initFromJson(tmp);
    }

    tmp = prefs.getString('settingsAdvanced') ?? "";
    if(tmp != "") {
      advanced.initFromJson(tmp);
    }
  }
}

