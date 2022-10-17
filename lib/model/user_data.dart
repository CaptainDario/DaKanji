import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

part 'user_data.g.dart';



/// Class that stores preferences and information about the user
/// 
/// To update the toJson code run `flutter pub run build_runner build`
@JsonSerializable()
class UserData{

  /// How often was the app opened by the user.
  @JsonKey(defaultValue: 0)
  int appOpenedTimes = 0;

  /// Did the user already chose to not see the rate dialogue again
  @JsonKey(defaultValue: false)
  bool doNotShowRateAgain = false;

  /// The version of the app which was used last time
  @JsonKey(defaultValue: "")
  String versionUsed = "";

  /// should the showcase of the draw screen be shown
  @JsonKey(defaultValue: true)
  bool showShowcaseDrawing = true;

  /// should the showcase of the dictionary screen be shown
  @JsonKey(defaultValue: true)
  bool showShowcaseDictionary = true;

  /// should the showcase of the text screen be shown
  @JsonKey(defaultValue: true)
  bool showShowcaseText = true;

  /// should the onboarding be shown
  @JsonKey(defaultValue: true)
  bool showOnboarding = true;

  /// should the rate popup be shown
  @JsonKey(defaultValue: false)
  bool showRatePopup = false;

  /// should the onboarding be shown
  @JsonKey(defaultValue: false)
  bool showChangelog = false;



  UserData();

  /// initializes the user data.
  /// 
  /// Loads the user data from disk and increments the app opened count.
  /// If the app was loaded for x % 10 == 0 times show a rating dialogue.
  /// If a new version was installed show the changelog
  /// If the changelog was updated or this is the first time opening the app,
  /// show the onboarding screen
  Future<void> init () async {

    // TESTING
    if(g_IsTestingAppStartupOnboardingNewFeatures){
      versionUsed = "1.0.0+15";
      g_Version = g_OnboardingNewPages[0] + "+1";
      appOpenedTimes = 5;
    }
    if(g_IsTestingAppStartupDrawscreenNewFeatures){
      versionUsed = "1.0.0+15";
      g_Version = g_DrawingScreenNewFeatures[0] + "+1";
      appOpenedTimes = 5;
    }

    debugPrint("The app was opened for the ${appOpenedTimes.toString()} time");

    // a different version than last time is being used (test with version = 0.0.0)
    debugPrint("used: $versionUsed now: $g_Version");
    if(versionUsed != g_Version && appOpenedTimes > 1){
      debugPrint("New version installed");
      // show the changelog
      showChangelog = true;
      versionUsed = g_Version;

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

    /// Saves all settings to the SharedPreferences.
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('userData', json.encode(toJson()));
  }

  /// Load all saved settings from SharedPreferences and returns a new `UserData`
  /// instance.
  Future<UserData> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // drawing screen
    String tmp = prefs.getString('userData') ?? "";
    if(tmp != "") {
      return UserData.fromJson(json.decode(tmp));
    }
    else {
      return UserData();
    }
  }

  /// Instantiates a new instance from a json map
  factory UserData.fromJson(Map<String, dynamic> json) 
    => _$UserDataFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}