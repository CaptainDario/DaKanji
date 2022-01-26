import 'package:da_kanji_mobile/view/onboarding/OnBoardingPage.dart';
import 'package:flutter/material.dart';

import 'package:liquid_swipe/liquid_swipe.dart';



/// The "home"-screen
/// 
/// If this is the first app start or a new feature was added shows the
/// onBoarding
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version. 
/// Otherwise navigates to the "draw"-screen.
class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int nrPages = 3;

  @override
  void initState() { 
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LiquidSwipe(
          enableLoop: false,
          pages: [
            OnBoardingPage(context, 1, nrPages, Colors.amber),
            OnBoardingPage(context, 2, nrPages, Colors.red),
            OnBoardingPage(context, 3, nrPages, Colors.green)
          ] 
        ),
      ],
    );
  }
}

