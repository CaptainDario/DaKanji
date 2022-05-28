


import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:universal_io/io.dart';



/// Class to store all settings in the drawing settings 
class SettingsDrawing {

  /// The placeholder in the URL's which will be replaced by the predicted kanji
  final String kanjiPlaceholder = "%X%";

  /// The URL of the jisho website
  late String jishoURL;

  /// The URL of the weblio website
  late String wadokuURL;

  /// The URL of the weblio website
  late String weblioURL;
  
  /// A list with all web dictionaries
  List<String> webDictionaries = [
    "jisho (web)",
    "wadoku (web)",
    "weblio (web)",
    "url"
  ];

  /// A list with all available dictionary options.
  late List<String> dictionaries;



  /// The custom URL a user can define on the settings page.
  String customURL = "";

  /// The string representation of the dictionary which will be used (long press)
  late String selectedDictionary;

  /// Should the behavior of long and short press be inverted
  bool invertShortLongPress = false;

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool emptyCanvasAfterDoubleTap = true;

  /// should the default app browser be used for opening predictions or a webview
  bool useWebview = false;

  // KEY BINDING (kb)
  /// default key binding for clearing the canvas
  final Set<LogicalKeyboardKey> kbLongPressModDefault = {LogicalKeyboardKey.shiftLeft};
  /// key binding for clearing the canvas
  late Set<LogicalKeyboardKey> kbLongPressMod;
  /// default key binding for clearing the canvas
  final Set<LogicalKeyboardKey> kbDoubleTapModDefault = {LogicalKeyboardKey.controlLeft};
  /// current key binding for clearing the canvas
  late Set<LogicalKeyboardKey> kbDoubleTapMod;

  /// default key binding for clearing the canvas
  final Set<LogicalKeyboardKey> kbClearCanvasDefault = {LogicalKeyboardKey.keyD};
  /// key binding for clearing the canvas
  late Set<LogicalKeyboardKey> kbClearCanvas;
  /// default key binding for clearing the canvas
  final Set<LogicalKeyboardKey> kbUndoStrokeDefault = {LogicalKeyboardKey.keyU};
  /// current key binding for clearing the canvas
  late Set<LogicalKeyboardKey> kbUndoStroke;
  /// default key binding for tapping the word bar
  final Set<LogicalKeyboardKey> kbWordBarDefault = {LogicalKeyboardKey.keyW};
  /// current key binding for tapping the wordbar
  late Set<LogicalKeyboardKey> kbWordBar;

  /// default key binding for tapping the first prediction
  late final List<Set<LogicalKeyboardKey>> kbPredsDefaults;
  /// current key binding for tapping the first prediction
  late List<Set<LogicalKeyboardKey>> kbPreds;
    


  SettingsDrawing (){
    jishoURL = "https://www.jisho.org/search/" + kanjiPlaceholder;
    wadokuURL = "https://www.wadoku.de/search/" + kanjiPlaceholder;
    weblioURL = "https://www.weblio.jp/content/" + kanjiPlaceholder;

    dictionaries = webDictionaries;

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

    selectedDictionary = dictionaries[0];

    // key bindings
    kbLongPressMod = kbLongPressModDefault;
    kbDoubleTapMod = kbDoubleTapModDefault;

    kbClearCanvas = kbClearCanvasDefault;
    kbUndoStroke  = kbUndoStrokeDefault;
    kbWordBar     = kbWordBarDefault;

    kbPredsDefaults = List.generate(9,(i) =>
      {
        LogicalKeyboardKey.findKeyByKeyId(LogicalKeyboardKey.digit1.keyId + i)!,
      }
    )..add({LogicalKeyboardKey.digit0});
    kbPreds = kbPredsDefaults;

  }

  void initFromMap(Map<String, dynamic> map){

    customURL                 = map['customURL'];
    selectedDictionary        = map['selectedDictionary'];
    invertShortLongPress      = map['invertShortLongPress'];
    emptyCanvasAfterDoubleTap = map['emptyCanvasAfterDoubleTap'];
    useWebview                = map['useWebview'];

    kbLongPressMod = keyBindingStringToSet(map['kbLongPressMod']);
    kbDoubleTapMod = keyBindingStringToSet(map['kbDoubleTapMod']);

    kbClearCanvas  = keyBindingStringToSet(map['kbClearCanvas']);
    kbUndoStroke   = keyBindingStringToSet(map['kbUndoStroke']);
    kbWordBar      = keyBindingStringToSet(map['kbWordBar']);
  }

  void initFromJson(String jsonString) =>
    initFromMap(json.decode(jsonString));
  

  Map<String, dynamic> toMap(){
    var m = {
      'customURL'                 : customURL,
      'selectedDictionary'        : selectedDictionary,
      'invertShortLongPress'      : invertShortLongPress,
      'emptyCanvasAfterDoubleTap' : emptyCanvasAfterDoubleTap,
      'useWebview'                : useWebview,

      'kbLongPressMod' : kbLongPressMod.map((e) => e.keyId).toList(),
      'kbDoubleTapMod' : kbDoubleTapMod.map((e) => e.keyId).toList(),

      'kbClearCanvas' : kbClearCanvas.map((e) => e.keyId).toList(),
      'kbUndoStroke'  : kbUndoStroke.map((e) => e.keyId).toList(),
      'kbWordBar'     : kbWordBar.map((e) => e.keyId).toList(),
    };

    return m;
  }

  String toJson() => json.encode(toMap());

  /// converts a list of strings (values in list need to be strins!)
  /// to a set of keybindings
  Set<LogicalKeyboardKey> keyBindingStringToSet(List<dynamic> keyBindings) {

    Set<LogicalKeyboardKey> b = {};

    for (var keyBinding in keyBindings) {
      int a = int.parse(keyBinding.toString());
      b.add(LogicalKeyboardKey.findKeyByKeyId(a)!);
    }

    return b;
  }
}