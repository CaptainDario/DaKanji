import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/provider/settings/settings_drawing.dart';
import 'package:da_kanji_mobile/provider/settings/settings_advanced.dart';
import 'package:da_kanji_mobile/provider/settings/settings_misc.dart';
import 'package:da_kanji_mobile/provider/settings/settings_dictionary.dart';



/// Class to store all settings of DaKanji
class Settings with ChangeNotifier {

  /// All settings related to the drawing part of the app
  late SettingsDrawing _drawing;
  /// All miscellaneous settings of the app
  late SettingsMisc _misc;
  /// All miscellaneous settings of the app
  late SettingsAdvanced _advanced;
  /// All settings related to the dictionary part of the app
  late SettingsDictionary _dictionary;


  Settings(){
    _drawing    = SettingsDrawing();
    _misc       = SettingsMisc(); 
    _advanced   = SettingsAdvanced();
    _dictionary = SettingsDictionary();
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

  /// Saves all settings to the SharedPreferences.
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('settingsDrawing', json.encode(drawing.toJson()));
    prefs.setString('settingsMisc', json.encode(misc.toJson()));
    prefs.setString('settingsAdvanced', json.encode(advanced.toJson()));
    prefs.setString('settingsDictionary', json.encode(dictionary.toJson()));
  }

  /// Load all saved settings from SharedPreferences.
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // drawing screen
    String tmp = prefs.getString('settingsDrawing') ?? "";
    if(tmp != "") {_drawing = SettingsDrawing.fromJson(json.decode(tmp));}
    else {_drawing = SettingsDrawing();}
    _drawing.addListener(() => notifyListeners());
    

    tmp = prefs.getString('settingsMisc') ?? "";
    if(tmp != "") {_misc = SettingsMisc.fromJson(json.decode(tmp));}
    else {_misc = SettingsMisc();}
    _misc.addListener(() => notifyListeners());


    tmp = prefs.getString('settingsAdvanced') ?? "";
    if(tmp != "") {_advanced = SettingsAdvanced.fromJson(json.decode(tmp));}
    else {_advanced = SettingsAdvanced();}
    _advanced.addListener(() => notifyListeners());


    tmp = prefs.getString('settingsDictionary') ?? "";
    if(tmp != "") {_dictionary = SettingsDictionary.fromJson(json.decode(tmp));}
    else {_dictionary = SettingsDictionary();}
    _dictionary.addListener(() => notifyListeners());
  }
}

