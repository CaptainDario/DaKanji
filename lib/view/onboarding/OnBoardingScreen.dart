import 'package:da_kanji_mobile/view/drawing/MockDrawScreen.dart';
import 'package:da_kanji_mobile/view/onboarding/OnBoardingPage.dart';
import 'package:flutter/material.dart';

import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:blobs/blobs.dart';



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

  // total number of onboarding pages
  int totalPages = 2;
    
  // the size of the blob to indicate that the page can be turned by swiping
  double blobSize = 75.0;

  double buttonHeight = 50.0;

  LiquidController liquidController = LiquidController();


  @override
  void initState() { 
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    
    List<Color> pageColors = [
      Theme.of(context).highlightColor,
      Theme.of(context).primaryColor,
      Colors.transparent
    ];

    return Scaffold(
      body: LiquidSwipe(            
        slideIconWidget: Transform.translate(
          offset: Offset(blobSize*0.5, 0),
          child: Blob.animatedRandom(
            styles: BlobStyles(
              color: pageColors[liquidController.currentPage+1]
            ),
            size: blobSize,
            duration: Duration(milliseconds: 1000),
            loop: true,
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        liquidController: liquidController,
        fullTransitionValue: 880,
        enableLoop: false,
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
          MockDrawScreen(false)
          //Container(color: pageColors[2])
          //OnBoardingPage(context, 3, nrPages, Theme.of(context).buttonTheme.colorScheme!.primary)
        ],
        onPageChangeCallback: (int activePageIndex) {
        },
      ),
    );
  }

}

