import 'package:flutter/foundation.dart';

import 'package:da_kanji_mobile/helper/handle_predictions.dart';



/// Class which notifies its listeners always when [_chars] changed.
class DrawingLookup with ChangeNotifier{
  
  /// the character(s) which can be searched in a dictionary
  String _chars = "";
  /// the dictionary URL for looking up [_chars]
  String _url = "";
  /// are the characters which will be looked up from the kanjibuffer
  bool _buffer = false;
  /// was the lookup started with long press
  bool _longPress = false;


  /// initializes a new [KanjiBuffer] instance
  DrawingLookup();

  String get chars{
    return _chars;
  }

  String get url{
    return _url;
  }

  bool get buffer{
    return _buffer;
  }

  bool get longPress{
    return _longPress;
  }

  /// Set the current value to [value] and notify listeners
  /// [buffer] indicates if [value] is from the KanjiBuffer and [longPress]
  /// indicates if the lookup was started with a long press
  /// Notifies all listeners afterwards
  void setChar(String value,
    {bool buffer = false, bool longPress = false}){
    _chars = value;
    _buffer = buffer;
    _longPress = longPress;
    _url = openWithSelectedDictionary(_chars);
    notifyListeners();
  }

}