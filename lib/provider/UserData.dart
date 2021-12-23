import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import 'Changelog.dart';

class UserData{

  /// How often was the app opened by the user.
  int _appOpenedTimes;

  /// Did the user already chose to not the the rate dialogue again
  bool doNotShowRateAgain;

  /// The version of the app which was used last time
  String _versionUsed;

  /// if the rate dialogue was already shown in this app life cycle
  bool rateDialogueWasShown;



  get appOpenedTimes{
    return _appOpenedTimes;
  }

  get versionUsed{
    return _versionUsed;
  }

  UserData(){
    _appOpenedTimes = 0;
    doNotShowRateAgain = false;
    rateDialogueWasShown = false;

    init();
  }

  /// initializes the user data.
  /// 
  /// Loads the user data from disk and increments the app opened count.
  /// If the app was loaded for x % 10 == 0 times show a rating dialogue.
  void init () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _appOpenedTimes = (prefs.getInt('appOpenedTimes') ?? _appOpenedTimes) + 1;
    doNotShowRateAgain = prefs.getBool('doNotShowRateAgain') ?? false;
    _versionUsed = prefs.getString('versionUsed') ?? VERSION;

    print("The app was opened for the ${_appOpenedTimes.toString()} time");

    // a different version than last time is being used
    //VERSION = "0.0.0";
    print("used: $versionUsed now: $VERSION");
    if(versionUsed != VERSION && appOpenedTimes > 1){
      // show the changelog
      GetIt.I<Changelog>().showChangelog = true;
      _versionUsed = VERSION;

      // this version has new features for drawing screen => show tutorial
      if(DRAWING_SCREEN_NEW_FEATURES.contains(VERSION)){
        SHOW_SHOWCASE_DRAWING = true;
      }
    }

    save();
  }

  /// Saves the user data to disk.
  void save () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('appOpenedTimes', _appOpenedTimes);
    prefs.setBool('doNotShowRateAgain', doNotShowRateAgain);
    prefs.setString('versionUsed', versionUsed);
  }

}