


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
  /// default key binding for modifying a normal press to a long press
  final Set<LogicalKeyboardKey> kbLongPressModDefault = {LogicalKeyboardKey.keyN};
  /// current key binding for modifying a normal press to a long press
  late Set<LogicalKeyboardKey> kbLongPressMod;
  /// default key binding for modifying a normal press to a double press
  final Set<LogicalKeyboardKey> kbDoublePressModDefault = {LogicalKeyboardKey.keyM};
  /// current key binding for modifying a normal press to a double press
  late Set<LogicalKeyboardKey> kbDoublePressMod;

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
  /// default key binding forn1 deleting a character from the word bar
  final Set<LogicalKeyboardKey> kbWordBarDelCharDefault = {LogicalKeyboardKey.keyE};
  /// current key binding for deleting a character from the word bar
  late Set<LogicalKeyboardKey> kbWordBarDelChar;

  /// default key binding for tapping the first prediction
  final List<Set<LogicalKeyboardKey>> kbPredsDefaults = [
    {LogicalKeyboardKey.digit1}, {LogicalKeyboardKey.digit2},
    {LogicalKeyboardKey.digit3}, {LogicalKeyboardKey.digit4},
    {LogicalKeyboardKey.digit5}, {LogicalKeyboardKey.digit6},
    {LogicalKeyboardKey.digit7}, {LogicalKeyboardKey.digit8},
    {LogicalKeyboardKey.digit9}, {LogicalKeyboardKey.digit0},
  ];
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
    kbLongPressMod   = kbLongPressModDefault;
    kbDoublePressMod = kbDoublePressModDefault;

    kbClearCanvas    = kbClearCanvasDefault;
    kbUndoStroke     = kbUndoStrokeDefault;
    kbWordBar        = kbWordBarDefault;
    kbWordBarDelChar = kbWordBarDelCharDefault;

    kbPreds       = kbPredsDefaults;
  }

  void initFromMap(Map<String, dynamic> map){

    if(map['customURL'] != null)
      customURL                 = map['customURL'];
    if(map['selectedDictionary'] != null)
      selectedDictionary        = map['selectedDictionary'];
    if(map['invertShortLongPress'] != null)
      invertShortLongPress      = map['invertShortLongPress'];
    if(map['emptyCanvasAfterDoubleTap'] != null)
      emptyCanvasAfterDoubleTap = map['emptyCanvasAfterDoubleTap'];
    if(map['useWebview'] != null)
      useWebview                = map['useWebview'];

    if(map['kbLongPressMod'] != null)
      kbLongPressMod   = keyBindingStringToSet(map['kbLongPressMod']);
    if(map['kbDoublePressMod'] != null)
      kbDoublePressMod = keyBindingStringToSet(map['kbDoublePressMod']);

    if(map['kbClearCanvas'] != null)
      kbClearCanvas    = keyBindingStringToSet(map['kbClearCanvas']);
    if(map['kbUndoStroke'] != null)
      kbUndoStroke     = keyBindingStringToSet(map['kbUndoStroke']);
    if(map['kbWordBar'] != null)
      kbWordBar        = keyBindingStringToSet(map['kbWordBar']);
    if(map['kbWordBarDelChar'] != null)
      kbWordBarDelChar = keyBindingStringToSet(map['kbWordBarDelChar']);

    print("ASDJKLASDJKL: ${kbClearCanvas}");

    kbPreds = List.generate(10, (i) => 
      keyBindingStringToSet(map['kbPreds${i}'])
    );
  }

  void initFromJson(String jsonString) {
    initFromMap(json.decode(jsonString));
  }

  Map<String, dynamic> toMap(){
    var m = {

      'customURL'                 : customURL,
      'selectedDictionary'        : selectedDictionary,
      'invertShortLongPress'      : invertShortLongPress,
      'emptyCanvasAfterDoubleTap' : emptyCanvasAfterDoubleTap,
      'useWebview'                : useWebview,

      //'kbLongPressMod'   : kbLongPressMod.map((e) => e.keyId).toList(),
      //'kbDoublePressMod' : kbDoublePressMod.map((e) => e.keyId).toList(),

      'kbClearCanvas'    : kbClearCanvas.map((e) => e.keyId).toList(),
      'kbUndoStroke'     : kbUndoStroke.map((e) => e.keyId).toList(),
      'kbWordBar'        : kbWordBar.map((e) => e.keyId).toList(),
      'kbWordBarDelChar' : kbWordBarDelChar.map((e) => e.keyId).toList(),

    };

    for (var i = 0; i < 10; i++) {
      m['kbPreds${i}'] = kbPreds[i].map((e) => e.keyId).toList();
    }

    return m;
  }

  String toJson() => json.encode(toMap());

  /// converts a list of strings (values in list need to be strins!)
  /// to a set of keybindings
  Set<LogicalKeyboardKey> keyBindingStringToSet(List<dynamic> keyBindings) {

    Set<LogicalKeyboardKey> bindings = {};

    for (var keyBinding in keyBindings) {
      int a = int.parse(keyBinding.toString());
      if(LogicalKeyboardKey.findKeyByKeyId(a) == null){
        print("ID: ${a} not found");
        bindings.add(LogicalKeyboardKey.add);
      }
      else bindings.add(LogicalKeyboardKey.findKeyByKeyId(a)!);
    }

    return bindings;
  }
}