import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreen.dart';
import 'package:da_kanji_mobile/view/onboarding/OnBoardingPage.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
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

class _OnBoardingScreenState extends State<OnBoardingScreen>
  with TickerProviderStateMixin {

  // total number of onboarding pages (excluding the final drawing screen)
  int totalPages = 2;
    
  // the size of the blob to indicate that the page can be turned by swiping
  double blobSize = 75.0;

  double buttonHeight = 50.0;

  LiquidController liquidController = LiquidController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation scaleAnimation;


  @override
  void initState() { 
    super.initState();

    // DO NOT loop the onboarding dragging animation when the startup process
    // is being tested
    if(!IS_TESTING_APP_STARTUP) _controller.repeat(reverse: true);
    
    scaleAnimation = new Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut
    ));

    _controller.addListener(() {
      liquidController.provider?.setIconSize(Size(scaleAnimation.value*15, 50));
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    List<Color> pageColors = [
      Theme.of(context).highlightColor,
      Theme.of(context).primaryColor,
      Colors.transparent
    ];

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return LiquidSwipe(
            positionSlideIcon: 0.85,           
            enableSideReveal: true,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableLoop: false,
            slideIconWidget: Container(
              width:  15, 
              height: 15,
            ),
            pages: [
              OnBoardingPage(
                1, totalPages,
                pageColors[0],
                LocaleKeys.OnBoarding_Onboarding_1_title.tr(),
                LocaleKeys.OnBoarding_Onboarding_1_text.tr(),
                liquidController
              ),
              OnBoardingPage(
                2, totalPages,
                pageColors[1],
                LocaleKeys.OnBoarding_Onboarding_2_title.tr(),
                LocaleKeys.OnBoarding_Onboarding_2_text.tr(),
                liquidController
              ),
              DrawScreen(false, false, false),
            ],
            onPageChangeCallback: (int activePageIndex) {
              // change the current route to the drawing screen
              if (activePageIndex == totalPages){
                GetIt.I<UserData>().showOnboarding = false;
                GetIt.I<UserData>().save();
                Future.delayed(Duration(milliseconds: 500), () =>
                  Navigator.pushNamedAndRemoveUntil(context, "/drawing", (route) => false)
                );
              }
            },
          );
        }
      ),
    );
  }

}

