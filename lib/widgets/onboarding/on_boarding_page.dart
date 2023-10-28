// Dart imports:
import 'dart:core';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/*
// The widget which is used for one OnBoarding Page.
// 
// `context` should be the current `BuildContext`.
// `nr` is the number of this OnBoarding-page and totalNr the total number
// of OnBoarding-Pages. `bgColor` is the background color for this page.
*/
class OnBoardingPage extends StatefulWidget {

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
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {

    // the size of the indicators showing on which page the user currently is
    double indicatorSize = 5;

    // the amount of parallax
    double parallaxLow  = 25.0;
    double parallaxHigh = 50.0;

    double sWidth  = MediaQuery.sizeOf(context).width;
    double sHeight = MediaQuery.sizeOf(context).height;

    double canvasSize = sWidth*0.95 > sHeight*0.75 ? sHeight*0.75 : sWidth*0.95;
    double imgSize  = canvasSize * 0.75;
    double textSize = sHeight * 0.3;

    widget.liquidController.provider?.addListener(() {setState(() {});});

    return Container(
      height: sHeight,
      width: sWidth,
      color: widget.bgColor,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            width: canvasSize,
            height: canvasSize,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  width: imgSize,
                  height: imgSize,
                  left: () {
                    // assure that the current swipe process is not 0
                    if(widget.liquidController.provider == null) return 0.0;

                    var ret = -widget.liquidController.provider!.slidePercentHor * parallaxLow;

                    if (widget.liquidController.currentPage > widget.nr-1) {
                      ret = -ret - parallaxLow;
                    }
                    else if (widget.liquidController.currentPage == widget.nr-1){
                      if(widget.liquidController.provider!.slideDirection == SlideDirection.rightToLeft) {
                        ret = ret;
                      }
                      else if(widget.liquidController.provider!.slideDirection == SlideDirection.leftToRight) {
                        ret = -ret;
                      }
                    }
                    else if(widget.liquidController.currentPage < widget.nr-1) {
                      ret = ret + parallaxLow;
                    }

                    return ret;
                  } () + imgSize * 0.25,
                  child: SvgPicture.asset(
                    'assets/images/onboarding/onboarding_${widget.nr}_1.svg',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Positioned(
                  height: imgSize,
                  width: imgSize,
                  left: () {
                    // assure that the current swipe process is not 0
                    if(widget.liquidController.provider == null) return 0.0;

                    var ret = -widget.liquidController.provider!.slidePercentHor * parallaxHigh;

                    if (widget.liquidController.currentPage > widget.nr-1) {
                      ret = -ret - parallaxHigh;
                    } else if (widget.liquidController.currentPage == widget.nr-1){
                      if(widget.liquidController.provider!.slideDirection == SlideDirection.rightToLeft) {
                        ret = ret;
                      }
                      else if(widget.liquidController.provider!.slideDirection == SlideDirection.leftToRight) {
                        ret = -ret;
                      }
                    }
                    else if(widget.liquidController.currentPage < widget.nr-1) {
                      ret = ret + parallaxHigh;
                    }
                    return ret;
                  } () + imgSize*0.25,
                  child: SvgPicture.asset(
                    'assets/images/onboarding/onboarding_${widget.nr}_2.svg',
                    width: imgSize,
                    height: imgSize,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            height: textSize,
            width: imgSize,
            top: imgSize*1.25,
            child: Column(
              children: [
                const SizedBox(height: 5,),
                FittedBox(
                  child: Text(
                    widget.headerText,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            )
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
                    widget.liquidController.animateToPage(page: widget.totalPages);
                  }, 
                  child:Text(LocaleKeys.General_skip.tr())
                ));

                widgets.add(const SizedBox(width: 50));

                for (int i = 0; i < widget.totalPages; i++) {
                  widgets.add(
                    Container(
                      width: indicatorSize,
                      height: indicatorSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.nr-1 == i ? Colors.white : Colors.black,
                      ),
                    )
                  );
                  if(i+1 < widget.totalPages) {
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
                    widget.liquidController.animateToPage(
                      page: widget.liquidController.currentPage + 1
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
