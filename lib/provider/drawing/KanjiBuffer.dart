import 'package:flutter/foundation.dart';

/// Class which notifies its listeners always when [_value] changed.
class KanjiBuffer with ChangeNotifier{
  
  /// the current string of this class
  String _value = "";

  /// is the animation for adding a new character running
  bool runAnimation = false;

  /// initializes a new [KanjiBuffer] instance
  KanjiBuffer();

  /// returns the current value
  String get kanjiBuffer{
    return _value;
  }

  /// Append [value] at the end of the kanjiBuffer. If value has more than one 
  /// character only the first one will be used
  void addToKanjiBuffer(String value){
    _value += value[0];
    runAnimation = true;
    notifyListeners();
  }

  void clearKanjiBuffer(){
    _value = "";
    notifyListeners();
  }

  /// removes the last char from the current value and notifies listeners
  void removeLastChar(){
    if(_value.length < 1)
      return;
      
    _value = _value.substring(0, _value.length - 1);
    notifyListeners();
  }
}