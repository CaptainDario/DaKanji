import 'package:flutter/cupertino.dart';



class DrawerListener with ChangeNotifier{


  bool _playForward;
  bool _playReverse;

  DrawerListener(){
    _playForward = false;
    _playReverse = false;
  }

  set playForward(bool forwardFrom){
    _playForward = forwardFrom;
    notifyListeners();
    _playForward = false;
  }

  bool get playForward{
    return _playForward;
  }
  
  set playReverse(bool reverse){
    _playReverse = reverse;
    notifyListeners();
    _playReverse = false;
  }

  bool get playReverse{
    return _playReverse;
  }

}