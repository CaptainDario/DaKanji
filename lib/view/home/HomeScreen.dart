import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/ControllableLottieAnimation.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/view/home/RatePopup.dart';
import 'package:da_kanji_mobile/view/home/WhatsNewDialog.dart';



/// The "home"-screen
/// 
/// If this is the first app start or a new feature was added shows the
/// onBoarding
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version. 
/// Otherwise navigates to the "draw"-screen.
class HomeScreen extends StatefulWidget {

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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

      // if the app is being tested for different startup situations
      if(IS_TESTING_APP_STARTUP)
        print("RUNNING IN 'APP STARTUP TESTING'-mode");

      // if the DrawScreen is being tested switch there immediately
      if(IS_TESTING_DRAWSCREEN){
        print("RUNNING IN 'DRAWSCREEN TESTING'-mode");
        Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false);
      }

      // if a newer version was installed open the what's new pop up 
      else if(GetIt.I<UserData>().showChangelog){

        // show the confetti animations when the widget was build 
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          confettiAnimation_1.state.play();
          Future.delayed(Duration(milliseconds: 750), () =>
            confettiAnimation_2.state.play());
          Future.delayed(Duration(milliseconds: 1250), () =>
            confettiAnimation_3.state.play());
          GetIt.I<UserData>().showChangelog = false;
        });
      }
      // 
      else if(GetIt.I<UserData>().showOnboarding){
        Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (route) => false);
      }
      
      else if(GetIt.I<UserData>().showRatePopup){
        // show a rating dialogue WITHOUT "do not show again"-option
        if(appOpenedTimes < MIN_TIMES_OPENED_ASK_NOT_SHOW_RATE)
          showRatePopup(context, false);
        // show a rating dialogue WITH "do not show again"-option
        else
          showRatePopup(context, true);

        GetIt.I<UserData>().showRatePopup = false;
        GetIt.I<UserData>().save();
      }
        
      // otherwise open the default screen
      else{
        Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false);
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
          child: WhatsNewDialogue(context,
          confettiAnimation_1, confettiAnimation_2, confettiAnimation_3)
        )
      )
    );
  }
}
