import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/ControllableLottieAnimation.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/provider/Changelog.dart';
import 'package:da_kanji_mobile/provider/UserData.dart';
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


  @override
  void initState() { 
    super.initState();


    // after the page was build 
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      
      if(SHOW_ONBOARDING){
        Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (route) => false);
      }
      // show a rating dialogue WITHOUT "do not show again"-option
      else if((!GetIt.I<UserData>().doNotShowRateAgain && 
        !GetIt.I<UserData>().rateDialogueWasShown && 
        appOpenedTimes < 31 && appOpenedTimes % 10 == 0))
          showRatePopup(context, false);
        
        // show a rating dialogue WITH "do not show again"-option
        else if((!GetIt.I<UserData>().doNotShowRateAgain && 
          !GetIt.I<UserData>().rateDialogueWasShown && 
          appOpenedTimes > MIN_TIMES_OPENED_ASK_NOT_SHOW_RATE && appOpenedTimes % 10 == 0))
          showRatePopup(context, true);
      

      // if a newer version was installed open the what's new pop up 
      else if(GetIt.I<Changelog>().showChangelog || true){

        GetIt.I<Changelog>().showChangelog = false;

        // show the confetti animations when the widget was build 
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          confettiAnimation_1.state.play();
          Future.delayed(Duration(milliseconds: 750), () =>
            confettiAnimation_2.state.play());
        });

        Container(
          color: Colors.amber
        );
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
      body: 
        Container(
          color: Colors.black.withAlpha(155),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 4/5,
              width:  MediaQuery.of(context).size.width * 4/5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(15, 15), // changes position of shadow
                  ),
                ],
              ),
              child: WhatsNewDialogue(context,
                confettiAnimation_1, confettiAnimation_2),
            ),
          ),
        ),
    );
  }
}
