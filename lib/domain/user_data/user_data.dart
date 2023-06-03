import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/domain/releases/version.dart';
import 'package:da_kanji_mobile/data/tf_lite/inference_backend.dart';
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

  /// Did the user already chose to not see the rate dialogue again
  @JsonKey(defaultValue: false)
  bool doNotShowRateAgain = false;

  /// The version of the app which was used last time
  @JsonKey(defaultValue: null)
  Version? versionUsed;

  /// Does the user use a new version for the first time
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool newVersionUsed = false;

  /// Should new dictionary be downloaded / copied from the assets folder
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool getNewDict = false;

  /// Should new examples be downloaded / copied from the assets folder
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool getNewExamples = false;

  @JsonKey(defaultValue: null)
  DateTime? userRefusedUpdate;

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
  bool showRateDialog = false;

  /// should the onboarding be shown
  @JsonKey(defaultValue: false)
  bool showChangelog = false;

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

    print("The app was opened for the ${appOpenedTimes.toString()} time");

    // a different version than last time is being used (test with version = 0.0.0)
    print("used: $versionUsed now: $g_Version");
    if(versionUsed == null) 
      versionUsed = Version(0, 0, 0);
    if(versionUsed! < g_Version && appOpenedTimes > 1){
      newVersionUsed = true;print("New version installed");
      // show the changelog
      showChangelog = true;
      
      // any version newer than `versionUsed` has new drawing tutorial steps
      if(g_DrawingScreenNewFeatures.any((v) => v > versionUsed!)){
        showShowcaseDrawing = true;
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

      versionUsed = g_Version;
    }

    // this is the first start of the app
    if (appOpenedTimes == 1){
      showChangelog = false;
      versionUsed = g_Version;
    }

    // should a rate popup be shown
    if (!doNotShowRateAgain && appOpenedTimes % g_AskRateAfterEach == 0){
     print("show rate dialogue");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    try {
      String tmp = prefs.getString('userData') ?? "";
      if(tmp != "") {
        return UserData.fromJson(json.decode(tmp));
      }
      else {
        return UserData();
      }
    }
    on Exception {
      return UserData();
    }
  }

  /// Instantiates a new instance from a json map
  factory UserData.fromJson(Map<String, dynamic> json) 
    => _$UserDataFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}