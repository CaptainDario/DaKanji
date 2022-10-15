import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';



class UserData{

  /// How often was the app opened by the user.
  late int _appOpenedTimes;

  /// Did the user already chose to not see the rate dialogue again
  late bool doNotShowRateAgain;

  /// The version of the app which was used last time
  late String _versionUsed;

  /// should the showcase of the draw screen be shown
  late bool showShowcaseDrawing;

  /// should the onboarding be shown
  late bool showOnboarding;

  /// should the rate popup be shown
  late bool showRatePopup;

  /// should the onboarding be shown
  late bool showChangelog;



  int get appOpenedTimes{
    return _appOpenedTimes;
  }

  //set versionUsed(String version) {
  //  _versionUsed = version;
  //}

  String get versionUsed{
    return _versionUsed;
  }

  UserData();

  /// initializes the user data.
  /// 
  /// Loads the user data from disk and increments the app opened count.
  /// If the app was loaded for x % 10 == 0 times show a rating dialogue.
  /// If a new version was installed show the changelog
  /// If the changelog was updated or this is the first time opening the app,
  /// show the onboarding screen
  Future<void> init () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _appOpenedTimes = (prefs.getInt('appOpenedTimes') ?? 0) + 1;
    doNotShowRateAgain = prefs.getBool('doNotShowRateAgain') ?? false;
    _versionUsed = prefs.getString('versionUsed') ?? g_Version;
    showShowcaseDrawing = prefs.getBool('showShowcaseDrawing') ?? false;
    showOnboarding = prefs.getBool('showOnboarding') ?? false;
    showRatePopup = prefs.getBool('showRatePopup') ?? false;
    showChangelog = prefs.getBool('showChangelog') ?? false;

    // TESTING
    if(g_IsTestingAppStartupOnboardingNewFeatures){
      _versionUsed = "1.0.0+15";
      g_Version = g_OnboardingNewPages[0] + "+1";
      _appOpenedTimes = 5;
    }
    if(g_IsTestingAppStartupDrawscreenNewFeatures){
      _versionUsed = "1.0.0+15";
      g_Version = g_DrawingScreenNewFeatures[0] + "+1";
      _appOpenedTimes = 5;
    }

    debugPrint("The app was opened for the ${_appOpenedTimes.toString()} time");

    // a different version than last time is being used (test with version = 0.0.0)
    debugPrint("used: $versionUsed now: $g_Version");
    if(versionUsed != g_Version && appOpenedTimes > 1){
      debugPrint("New version installed");
      // show the changelog
      showChangelog = true;
      _versionUsed = g_Version;

      String v = g_Version.replaceRange(g_Version.indexOf("+"), g_Version.length, "");
      // this version has new features for drawing screen => show tutorial
      if(g_DrawingScreenNewFeatures.contains(v)){
        showShowcaseDrawing = true;
      }

      // this version has new onboarding pages
      if(g_OnboardingNewPages.contains(v)){
        showOnboarding = true;
      }
    }

    // this is the first start of the app
    if (appOpenedTimes == 1){
      showShowcaseDrawing = true;
      showOnboarding = true;
    }

    // should a rate popup be shown
    if (!doNotShowRateAgain && appOpenedTimes % 10 == 0){
      debugPrint("show rate dialogue");
      showRatePopup = true;
    }

    // debugging onboarding, changelog, rate popup
    //showOnboarding = false;
    //showChangelog = true;
    //showRatePopup = true;

    save();
  }

  /// Saves the user data to disk.
  void save () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('appOpenedTimes', _appOpenedTimes);
    prefs.setBool('doNotShowRateAgain', doNotShowRateAgain);
    prefs.setString('versionUsed', versionUsed);
    prefs.setBool('showShowcaseDrawing', showShowcaseDrawing);
    prefs.setBool('showOnboarding', showOnboarding);
    prefs.setBool('showRatePopup', showRatePopup);
    prefs.setBool('showChangelog', showChangelog);
  }

}