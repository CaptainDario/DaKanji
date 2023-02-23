import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/controllable_lottie_animation.dart';
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/view/home/rate_popup.dart';
import 'package:da_kanji_mobile/view/home/whats_new_dialog.dart';



/// The "home"-screen
/// 
/// If this is the first app start or a new feature was added shows the
/// onBoarding
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version. 
/// Otherwise navigates to the "draw"-screen.
class HomeScreen extends StatefulWidget {

  const HomeScreen(
    {
      Key? key
    }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // shortcut for accessing how often the app was opened
  final appOpenedTimes = GetIt.I<UserData>().appOpenedTimes;

  ControllableLottieAnimation confettiAnimation_1 = 
    ControllableLottieAnimation("assets/animations/confetti.json");
  ControllableLottieAnimation confettiAnimation_2 = 
    ControllableLottieAnimation("assets/animations/confetti.json");
    ControllableLottieAnimation confettiAnimation_3 = 
    ControllableLottieAnimation("assets/animations/confetti.json");


  @override
  void initState() { 
    super.initState();

    // after the page was build 
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      // if the app is being tested for different startup situations
      if(g_IsTestingAppStartup) {
        print("RUNNING IN 'APP STARTUP TESTING'-mode");
      }

      // if the DrawScreen is being tested switch there immediately
      if(g_IsTestingDrawscreen){
        print("RUNNING IN 'DRAWSCREEN TESTING'-mode");
        Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false);
      }

      // if a newer version was installed open the what's new pop up 
      else if(GetIt.I<UserData>().showChangelog){

        // show the confetti animations when the widget was build 
        WidgetsBinding.instance.addPostFrameCallback((_) {
          confettiAnimation_1.state.play();
          Future.delayed(const Duration(milliseconds: 750), () =>
            confettiAnimation_2.state.play());
          Future.delayed(const Duration(milliseconds: 1250), () =>
            confettiAnimation_3.state.play());
          GetIt.I<UserData>().showChangelog = false;
        });
      }
      else if(GetIt.I<UserData>().showOnboarding){
        Navigator.pushNamedAndRemoveUntil(
          context, "/onboarding", (route) => false
          );
      }
      else if(GetIt.I<UserData>().showRatePopup){
        // show a rating dialogue WITHOUT "do not show again"-option
        if(appOpenedTimes < g_MinTimesOpenedToAsknotShowRate) {
          showRatePopup(context, false);
        } else {
          showRatePopup(context, true);
        }

        GetIt.I<UserData>().showRatePopup = false;
        GetIt.I<UserData>().save();
      }
        
      // otherwise open the default screen
      else{
        Navigator.pushNamedAndRemoveUntil(
          context, 
          "/${GetIt.I<Settings>().misc.startupScreens[GetIt.I<Settings>().misc.selectedStartupScreen].name}", 
          (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Visibility(
          maintainSize: true, 
          maintainAnimation: true,
          maintainState: true,
          visible: GetIt.I<UserData>().showChangelog, 
          child: WhatsNewDialogue(
            confettiAnimation_1, confettiAnimation_2, confettiAnimation_3
          )
        )
      )
    );
  }
}
