import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';



class Settings with ChangeNotifier {
  /// The placeholder in the URL's which will be replaced by the predicted kanji
  String kanjiPlaceholder;

  /// The custom URL a user can define on the settings page.
  String customURL;

  /// The URL of the jisho website
  String jishoURL;

  /// The URL of the weblio website
  String wadokuURL;

  /// The URL of the weblio website
  String weblioURL;

  /// A list with all available dictionary options.
  List<String> dictionaries;

  /// The string representation of the dictionary which will be used (long press)
  String _selectedDictionary;
  
  /// The theme which the application will use.
  /// System will match the settings of the system.
  String _selectedTheme;

  /// A list with all available themes.
  List<String> themes;
  
  /// A Map from the string of a theme to the ThemeMode of the theme.
  Map<String, ThemeMode> themesDict;

  /// Should the behavior of long and short press be inverted
  bool _invertShortLongPress;

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool _emptyCanvasAfterDoubleTap;

  /// should the default app browser be used for opening predictions
  bool _useDefaultBrowser;

  /// the currently used locale
  Locale selectedLocale;

  /// The available backends for inference
  List<String> inferenceBackends;

  /// The inference backend used for the single character CNN
  String _backendCNNSingleChar;



  Settings() {
    kanjiPlaceholder = "%X%";
    
    dictionaries = [
      "jisho (web)",
      "wadoku (web)",
      "weblio (web)",
      "url (web)"
    ];
    if(Platform.isAndroid)
      dictionaries.addAll([
        "system (app)",
        "aedict (app)",
        "akebi (app)",
        "takoboto (app)", 
      ]);
    else if(Platform.isIOS)
      dictionaries.addAll([
        "shirabe jisho (app)",
        "imiwa? (app)",
        "Japanese (app)",
        "midori (app)",
      ]);

    themes = ["light", "dark", "system"];
    themesDict = {
      "light": ThemeMode.light,
      "dark": ThemeMode.dark,
      "system": ThemeMode.system
    };

    inferenceBackends = [
      "CPU",
    ];
    if(Platform.isAndroid)
      inferenceBackends.addAll([
        "GPU",
        "NNAPI",
      ]);
    //else if(Platform.isIOS)
    //  inferenceBackends.addAll([
    //    "Metal",
    //    "CoreML"
    //  ]);
    _backendCNNSingleChar = "";

    invertShortLongPress = false;
    emptyCanvasAfterDoubleTap = true;
    useWebview = true;

    _selectedDictionary = "";
    selectedTheme = "";

    jishoURL = "https://jisho.org/search/" + kanjiPlaceholder;
    wadokuURL = "https://www.wadoku.de/search/" + kanjiPlaceholder;
    weblioURL = "https://www.weblio.jp/content/" + kanjiPlaceholder;

    load();
    save();
  }

  String get selectedDictionary{
    return _selectedDictionary;
  }

  set selectedDictionary(String newDictionary){
    _selectedDictionary = newDictionary;
    notifyListeners();
  }

  get selectedTheme{
    return _selectedTheme;
  }

  ThemeMode selectedThemeMode() {
    return themesDict[_selectedTheme];
  }
  
  set selectedTheme(String newTheme){
    _selectedTheme = newTheme;
    notifyListeners();
  }
  
  bool get invertShortLongPress{
    return _invertShortLongPress;
  }

  set invertShortLongPress(bool invert){
    _invertShortLongPress = invert;
    notifyListeners();
  }

  bool get emptyCanvasAfterDoubleTap{
    return _emptyCanvasAfterDoubleTap;
  }
  
  set emptyCanvasAfterDoubleTap(bool empty){
    _emptyCanvasAfterDoubleTap = empty;
    notifyListeners();
  }
  
  bool get useWebview{
    return _useDefaultBrowser;
  }
  
  set useWebview(bool empty){
    _useDefaultBrowser = empty;
    notifyListeners();
  }

  String get backendCNNSingleChar{
    return _backendCNNSingleChar;
  }

  set backendCNNSingleChar(String newBackend){
    _backendCNNSingleChar = newBackend;
    notifyListeners();
  }

  /// Saves all settings to the SharedPreferences.
  void save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setBool('invertShortLongPress', invertShortLongPress);
    prefs.setBool('emptyCanvasAfterDoubleTap', emptyCanvasAfterDoubleTap);
    prefs.setBool('useWebview', useWebview);

    prefs.setString("backendCNNSingleChar", backendCNNSingleChar);
    prefs.setString('customURL', customURL);
    prefs.setString('selectedTheme', _selectedTheme);
    prefs.setString('selectedDictionary', selectedDictionary);
    prefs.setString('selectedLocale', selectedLocale.toString());
  }

  /// Load all saved settings from SharedPreferences.
  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    invertShortLongPress = prefs.getBool('invertShortLongPress') ?? false;
    emptyCanvasAfterDoubleTap = prefs.getBool('emptyCanvasAfterDoubleTap') ?? false;
    useWebview = prefs.getBool('useWebview') ?? false;
    
    backendCNNSingleChar = prefs.getString("backendCNNSingleChar") ?? 'CPU';
    customURL = prefs.getString('customURL') ?? '';
    _selectedTheme = prefs.getString('selectedTheme') ?? themes[2];
    selectedDictionary = prefs.getString('selectedDictionary') ?? dictionaries[0];
    var localeStr = prefs.getString('selectedLocale') ?? "en";
    selectedLocale = localeStr == null ? null : Locale(localeStr);
  }
}

