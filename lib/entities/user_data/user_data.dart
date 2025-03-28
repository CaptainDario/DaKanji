// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/releases/version.dart';
import 'package:da_kanji_mobile/entities/tf_lite/inference_backend.dart';
import 'package:da_kanji_mobile/globals.dart';

part 'user_data.g.dart';



/// Class that stores preferences and information about the user
/// 
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class UserData{

  /// How often was the app opened by the user.
  @JsonKey(defaultValue: 0)
  int appOpenedTimes = 0;

  /// The seconds the app was used today
  @JsonKey(defaultValue: 0)
  int todayUsageSeconds = 0;
  /// Has today already been counted as daily / monthly active
  @JsonKey(defaultValue: false)
  bool dailyActiveUserTracked = false;
  /// How many days this app was used this month
  @JsonKey(defaultValue: 0)
  int monthsUsageDays = 0;
  /// Has today been counted towards the monthly goal
  @JsonKey(defaultValue: false)
  bool dailyForMonthlyTracked = false;
  /// Has this month been counted as monthly active
  @JsonKey(defaultValue: false)
  bool monthlyActiveUserTracked = false;
  /// Last day used
  @JsonKey()
  DateTime lastDayUsed = DateTime.now().toUtc();

  /// Did the user already chose to not see the rate dialogue again
  @JsonKey(defaultValue: false)
  bool doNotShowRateAgain = false;

  /// The version of the app which was used last time
  @JsonKey(defaultValue: null)
  Version? versionUsed;

  /// Does the user use a new version for the first time
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool newVersionUsed = false;

  /// Does the user use am older version than before
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool olderVersionUsed = false;

  /// Should new dictionary be downloaded / copied from the assets folder
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool getNewDict = false;

  /// Should new examples be downloaded / copied from the assets folder
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool getNewExamples = false;

  /// Should new examples be downloaded / copied from the assets folder
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool getNewRadicals = false;

  @JsonKey(defaultValue: null)
  DateTime? userRefusedUpdate;

  /// should the tutorial of the draw screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialDrawing = true;

  /// should the tutorial of the dictionary screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialDictionary = true;

  /// should the tutorial of the text screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialText = true;

  /// should the tutorial of the dictionary screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialDojg = true;

  /// should the tutorial of the immersion screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialImmersion = true;

  /// should the tutorial of the ocr screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialOcr = true;

  /// should the tutorial of the webbrowser screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialWebbrowser = true;

  /// should the tutorial of the youtube screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialYoutube = true;

  /// should the tutorial of the clipboard screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialClipboard = true;

  /// should the tutorial of the kanji table screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialKanjiTable = true;

  /// should the tutorial of the kanji table screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialKanjiMap = true;

  /// should the tutorial of the kana table screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialKanaTable = true;

  /// should the tutorial of the kana table screen be shown
  @JsonKey(defaultValue: true)
  bool showTutorialWordLists = true;

  /// should the App's onboarding be shown
  @JsonKey(defaultValue: true)
  bool showOnboarding = true;

  /// should the rate popup be shown
  @JsonKey(defaultValue: false)
  bool showRateDialog = false;

  /// should the onboarding be shown
  @JsonKey(defaultValue: false)
  bool showChangelog = false;

  /// Has anki been setup successfully
  @JsonKey(defaultValue: false)
  bool ankiSetup = false;

  /// Has the dictionary of japanese grammar anki deck (w/o media) been imported
  @JsonKey(defaultValue: false)
  bool dojgImported = false;

  /// Has the dictionary of japanese grammar anki deck (w/ media) been imported
  @JsonKey(defaultValue: false)
  bool dojgWithMediaImported = false;

  /// The inference backend that should be used for drawing
  @JsonKey(defaultValue: null)
  InferenceBackend? drawingBackend;



  UserData();

  /// initializes the user data.
  /// 
  /// Loads the user data from disk and increments the app opened count.
  /// If the app was loaded for x % 10 == 0 times show a rating dialogue.
  /// If a new version was installed show the changelog
  /// If the changelog was updated or this is the first time opening the app,
  /// show the onboarding screen
  Future<void> init () async {

    appOpenedTimes++;

    debugPrint("The app was opened for the ${appOpenedTimes.toString()} time");

    // a different version than last time is being used (test with version = 0.0.0)
    debugPrint("used: $versionUsed now: $g_Version");
    versionUsed ??= Version(0, 0, 0);
    if(versionUsed! < g_Version && appOpenedTimes > 1){
      newVersionUsed = true;debugPrint("New version installed");
      // show the changelog
      showChangelog = true;
      
      // any version newer than `versionUsed` has new drawing tutorial steps
      if(g_DrawingScreenNewFeatures.any((v) => v > versionUsed!)){
        showTutorialDrawing = true;
      }
      // any version newer than `versionUsed` has new onboarding pages
      if(g_OnboardingNewPages.any((v) => v > versionUsed!)){
        showOnboarding = true;
      }
      // any version newer than `versionUsed` has a newer dictionary
      if(g_NewDictionary.any((v) => v > versionUsed!)){
        getNewDict = true;
      }
      // any version newer than `versionUsed` has newer examples
      if(g_NewExamples.any((v) => v > versionUsed!)){
        getNewExamples = true;
      }
      // any version newer than `versionUsed` has newer radicals data
      if(g_NewRadicals.any((v) => v > versionUsed!)){
        getNewRadicals = true;
      }
      // any version newer than `versionUsed` needs a anki reset
      if(g_ResetAnki.any((v) => v > versionUsed!)){
        ankiSetup = false;
      }
    }
    if(versionUsed! > g_Version){

    }
    versionUsed = g_Version;

    // this is the first start of the app
    if (appOpenedTimes == 1){
      showChangelog = false;
      versionUsed = g_Version;
    }

    // should a rate popup be shown
    if (!doNotShowRateAgain && appOpenedTimes % g_AskRateAfterEach == 0){
     debugPrint("show rate dialogue");
      showRateDialog = true;
    }

    // DEBUGGING: onboarding, changelog, rate popup
    //showOnboarding = true;
    //showChangelog  = true;
    //showRatePopup  = true;

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

    UserData uD;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tmp = prefs.getString('userData') ?? "";
      if(tmp != "") {
        uD = UserData.fromJson(json.decode(tmp));
      }
      else {
        uD = UserData();
      }
    }
    catch (e) {
      Sentry.captureException(e);
      uD = UserData();
    }

    resetUsageIfNewDay();

    return uD;
  }

  /// Resets monthly/daily usage if applicable
  void resetUsageIfNewDay(){

    DateTime now = DateTime.now().toUtc();

    // It is not the same month as last time used
    if(!(now.year == lastDayUsed.year && now.month == lastDayUsed.month)){
      monthsUsageDays = 0;
      monthlyActiveUserTracked = false;
    }
    // It is not the same day as last time used
    if(!(now.year == lastDayUsed.year &&
      now.month == lastDayUsed.month &&
      now.day == lastDayUsed.day)){
      todayUsageSeconds = 0;
      dailyActiveUserTracked = false;
      dailyForMonthlyTracked = false;
    }

    lastDayUsed = now;

  }

  /// Instantiates a new instance from a json map
  factory UserData.fromJson(Map<String, dynamic> json) 
    => _$UserDataFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}
