import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:da_kanji_mobile/view/home/init.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/view/home/rate_popup.dart' as ratePopup;
import 'package:da_kanji_mobile/view/home/whats_new_dialog.dart';
import 'package:da_kanji_mobile/dakanji_splash.dart';



/// The "home"-screen
/// 
/// If this is the first app start or a new feature was added shows the
/// onBoarding
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version.
/// If the app was opened enough times shows a popup asking the user to rate the
/// app.
/// If different version was installed that usese a different dictionary, etc.
/// asks the user to download the new data.
/// Otherwise navigates to the "dictionary"-screen.
class HomeScreen extends StatefulWidget {

  const HomeScreen(
    {
      Key? key
    }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    setupApp();
  }

  /// Setup the app by showing the changelog, onboarding, rate popup or 
  /// dwonloading the data necessary for this release
  Future<void> setupApp() async {
    if(testing()) return;

    await initDocumentsServices(context);

    if(GetIt.I<UserData>().showChangelog){
      await showChangelog();
    }
    if(GetIt.I<UserData>().showRatePopup){
      await showRatePopup();
    }
    if(GetIt.I<UserData>().showOnboarding){
      Navigator.pushNamedAndRemoveUntil(
        context, "/onboarding", (route) => false
      );
    }
    else {
      Navigator.pushNamedAndRemoveUntil(context, 
        "/${GetIt.I<Settings>().misc.startupScreens[GetIt.I<Settings>().misc.selectedStartupScreen].name}", 
        (route) => false
      );
    }
  }

  /// Runs the app in different testing modes
  bool testing(){

    bool isTesting = false;

    // if the app is being tested for different startup situations
    if(g_IsTestingAppStartup) {
      isTesting = true;
      print("RUNNING IN 'APP STARTUP TESTING'-mode");
    }
    // if the DrawScreen is being tested switch there immediately
    else if(g_IsTestingDrawscreen){
      isTesting = true;
      print("RUNNING IN 'DRAWSCREEN TESTING'-mode");
      Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false);
    }

    return isTesting;
  }

  /// Shows a popup with the changelog of the current version
  Future<void> showChangelog() async {
    // opem the changelog popup
    await AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      body: WhatsNewDialogue(),
    ).show();

    GetIt.I<UserData>().showChangelog = false;
    GetIt.I<UserData>().save();
  }

  /// Shows a rate popup which lets the user rate the app
  Future<void> showRatePopup() async {
    // show a rating dialogue WITHOUT "do not show again"-option
    if(GetIt.I<UserData>().appOpenedTimes < g_MinTimesOpenedToAsknotShowRate) {
      await ratePopup.showRatePopup(context, false);
    }
    else {
      await ratePopup.showRatePopup(context, true);
    }

    GetIt.I<UserData>().showRatePopup = false;
    GetIt.I<UserData>().save();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<String>(
        stream: g_initTextStream.stream,
        builder: (context, snapshot) {
          return DaKanjiSplash(
            text: snapshot.data ,
          );
        }
      ),
    );
  }
}
