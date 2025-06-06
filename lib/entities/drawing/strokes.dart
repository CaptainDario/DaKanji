// Flutter imports:
import 'package:flutter/widgets.dart';

class Strokes with ChangeNotifier{

  /// The path object of all strokes
  Path _path = Path();
  /// How many strokes are there
  int _strokeCount = 0;
  /// should the delete last stroke animation start 
  bool _playDeleteLastStrokeAnimation = false;
  /// should the delete all strokes animation start
  bool _playDeleteAllStrokesAnimation = false;
  /// if the animation to delete the last stroke is currently running
  bool deletingLastStroke = false;
  /// if the animation to delete all strokes is currently running
  bool deletingAllStrokes = false;



  Path get path {
    return _path;
  }

  set path (Path p){
    _path = p;

    notifyListeners();
  }
  
  bool get playDeleteLastStrokeAnimation {
    return _playDeleteLastStrokeAnimation;
  }

  set playDeleteLastStrokeAnimation (bool play){
    // do not play an animation if there are no strokes
    if(strokeCount > 0 && play){
      _playDeleteLastStrokeAnimation = true;
      notifyListeners();
    }
    else{
      _playDeleteLastStrokeAnimation = false;
    }
  }

  bool get playDeleteAllStrokesAnimation {
    return _playDeleteAllStrokesAnimation;
  }

  set playDeleteAllStrokesAnimation (bool play){
    // do not play an animation if there are no strokes
    if(strokeCount > 0 && play){
      _playDeleteAllStrokesAnimation = true;
      notifyListeners();
    }
    else{
      _playDeleteAllStrokesAnimation = false;
    }
  }

  /// Start a new sub stroke at ([x], [y])
  void moveTo(double x, double y){
    _path.moveTo(x, y);
      notifyListeners();
  }

  /// Draw a line from the current position to the position ([x], [y]).
  void lineTo(double x, double y){
    _path.lineTo(x, y);
    notifyListeners();
  }
  
  get strokeCount {
    return _strokeCount;
  }

  void incrementStrokeCount(){
    _strokeCount++;
  }
  
  void decrementStrokeCount(){
    _strokeCount--;
  }

  Strokes();
  
  /// Deletes all drawn strokes WITHOUT notifying listeners.
  void removeAllStrokes(){
    if(strokeCount > 0){
      _path.reset();
      _strokeCount = 0;
    }
  }

  /// Deletes the last stroke of all drawn strokes WITHOUT notifying listeners.
  void removeLastStroke(){

    if(strokeCount > 0 && _path.computeMetrics().isNotEmpty){
      // get all strokes except for the last one
      var p = _path.computeMetrics().take(_path.computeMetrics().length - 1);
      var newPath = Path();
      // copy the strokes to a new Path
      for (var element in p) {
        newPath.addPath(element.extractPath(0, double.infinity), Offset.zero);
      }
      _path = newPath;

      decrementStrokeCount();
    }
  }

  /// Deletes all drawn strokes and notifies all listeners.
  void deleteAllStrokes(){
    if(strokeCount > 0){
      removeAllStrokes();
      notifyListeners();
    }
  }

  /// Deletes the last stroke of all drawn strokes and notifies all listeners.
  void deleteLastStroke(){

    if(strokeCount > 0){
      removeAllStrokes();
      notifyListeners();
    }
  }

}
