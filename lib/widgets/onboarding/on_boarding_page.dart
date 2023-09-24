// Dart imports:
import 'dart:core';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/*
// The widget which is used for one OnBoarding Page.
// 
// `context` should be the current `BuildContext`.
// `nr` is the number of this OnBoarding-page and totalNr the total number
// of OnBoarding-Pages. `bgColor` is the background color for this page.
*/
class OnBoardingPage extends StatelessWidget {

  /// the number of this onboarding
  final int nr;
  /// how many pages does the onboarding have in total
  final int totalPages;
  ///back ground color of this onboarding page
  final Color bgColor;
  /// the bigger header text of this onboarding page
  final String headerText;
  /// the smaller text for this onboarding page
  final String text;
  /// liquid controller to control the page turn effect
  final LiquidController liquidController;

  const OnBoardingPage(
    this.nr,
    this.totalPages, 
    this.bgColor,
    this.headerText,
    this.text,
    this.liquidController,
    {
      Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // the size of the indicators showing on which page the user currently is
    double indicatorSize = 5;

    // the amount of parallax
    double parallaxLow  = 25.0;
    double parallaxHigh = 50.0;

    double sWidth  = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;

    double imageSize = sHeight*0.5 < sWidth*0.95 ? sHeight*0.5 : sWidth*0.95;
    double textSize = sHeight * 0.3;



    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: bgColor,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: sHeight * 0.05,
                width: sWidth,
              ),
              Provider.value(
                value: liquidController.provider?.slidePercentHor,
                child: 
                SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Positioned(
                        height: imageSize,
                        width: imageSize,
                        left: () {
                          // assure that the current swipe process is not 0
                          if(liquidController.provider == null) return 0.0;

                          var ret = -liquidController.provider!.slidePercentHor * parallaxLow;

                          if (liquidController.currentPage > nr-1) {
                            return -ret - parallaxLow;
                          } else if (liquidController.currentPage == nr-1){
                            if(liquidController.provider!.slideDirection == SlideDirection.rightToLeft) {
                              return ret;
                            }
                            if(liquidController.provider!.slideDirection == SlideDirection.leftToRight) {
                              return -ret;
                            }
                          }
                          else if(liquidController.currentPage < nr-1) {
                            return ret + parallaxLow;
                          }
                        } (),
                        child: Image.asset(
                          'assets/images/onboarding/onboarding_${nr}_1.png',
                          isAntiAlias: true,
                        ),
                      ),
                      Positioned(
                        height: imageSize,
                        width: imageSize,
                        left: () {
                          // assure that the current swipe process is not 0
                          if(liquidController.provider == null) return 0.0;

                          var ret = -liquidController.provider!.slidePercentHor * parallaxHigh;

                          if (liquidController.currentPage > nr-1) {
                            return -ret - parallaxHigh;
                          } else if (liquidController.currentPage == nr-1){
                            if(liquidController.provider!.slideDirection == SlideDirection.rightToLeft) {
                              return ret;
                            }
                            if(liquidController.provider!.slideDirection == SlideDirection.leftToRight) {
                              return -ret;
                            }
                          }
                          else if(liquidController.currentPage < nr-1) {
                            return ret + parallaxHigh;
                          }
                        } (),
                        child: Image.asset(
                          'assets/images/onboarding/onboarding_${nr}_2.png',
                          isAntiAlias: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: textSize,
                width: imageSize,
                child: Column(
                  children: [
                    const SizedBox(height: 5,),
                    FittedBox(
                      child: Text(
                        headerText,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                )
              ),
            ]
          ),
          Positioned(
            bottom: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: () {
                List<Widget> widgets = [];

                widgets.add(OutlinedButton(
                  style: ButtonStyle(
                    shadowColor:  MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(const Color.fromARGB(150, 255, 255, 255)),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Color.fromARGB(0, 255, 255, 255))
                    ),
                  ),
                  onPressed: (){
                    liquidController.animateToPage(page: totalPages);
                  }, 
                  child:Text(LocaleKeys.General_skip.tr())
                ));

                widgets.add(const SizedBox(width: 50));

                for (int i = 0; i < totalPages; i++) {
                  widgets.add(
                    Container(
                      width: indicatorSize,
                      height: indicatorSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: nr-1 == i ? Colors.white : Colors.black,
                      ),
                    )
                  );
                  if(i+1 < totalPages) {
                    widgets.add(SizedBox(width: indicatorSize,));
                  }
                }
                
                widgets.add(const SizedBox(width: 50));
              
                widgets.add(OutlinedButton(
                  style: ButtonStyle(
                    shadowColor:  MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Color.fromARGB(0, 255, 255, 255))
                    ),
                  ),
                  onPressed: (){
                    liquidController.animateToPage(
                      page: liquidController.currentPage + 1
                    );
                  }, 
                  child: Text("${LocaleKeys.General_next.tr()} →")
                ));
                return widgets;
              } ()
            ),
          )
        ],
      )
    );
  }
}
