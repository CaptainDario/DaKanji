import 'package:da_kanji_mobile/globals.dart';
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

  // how often was the app opened
  final appOpenedTimes = GetIt.I<UserData>().appOpenedTimes;


  @override
  void initState() { 
    super.initState();


    // after the page was build 
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      
      if(appOpenedTimes > 1){
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
      else if(GetIt.I<Changelog>().showChangelog){

        GetIt.I<Changelog>().showChangelog = false;

        // what's new dialogue
        WhatsNewDialogue(context);
      }
      // otherwise open the default screen
      else{
        Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
