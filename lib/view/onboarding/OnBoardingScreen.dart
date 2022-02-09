import 'package:da_kanji_mobile/view/drawing/DrawScreen.dart';
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
  )..repeat(reverse: true);
  late final Animation scaleAnimation;


  @override
  void initState() { 
    super.initState();
    
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
                context, 1, totalPages,
                pageColors[0],
                "You do not know a Kanji?",
                "Just draw it!",
                liquidController
              ),
              OnBoardingPage(
                context, 2, totalPages,
                pageColors[1],
                "Look up characters with", 
                "web and app dictionaries.",
                liquidController
              ),
              DrawScreen(false, false),
            ],
            onPageChangeCallback: (int activePageIndex) {
              // change the current route to the drawing screen
              if (activePageIndex == totalPages){
                Future.delayed(Duration(milliseconds: 1000), () => 
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

