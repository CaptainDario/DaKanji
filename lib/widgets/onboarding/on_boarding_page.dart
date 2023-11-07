// Dart imports:
import 'dart:core';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:vector_graphics/vector_graphics.dart';

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
  /// Svg loader for the fßoreground onboarding image
  final AssetBytesLoader foregroundSvgLoader;
  /// Svg loader for the background onboarding image
  final AssetBytesLoader backgroundSvgLoader;
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
  /// Controller to animate the onboarding pictures
  final AnimationController swipeAnimation;

  const OnBoardingPage(
    this.nr,
    this.foregroundSvgLoader,
    this.backgroundSvgLoader,
    this.totalPages, 
    this.bgColor,
    this.headerText,
    this.text,
    this.liquidController,
    this.swipeAnimation,
    {
      Key? key
    }) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

    /// the size of the indicators showing on which page the user currently is
    double indicatorSize = 5;
    /// the amount of parallax for the background image
    double parallaxBackground  = 25.0;
    /// the amount of parallax for the foreground image
    double parallaxForeground = 100.0;
    /// the minimum size the image will take during swiping through the onboarding
    double minImgSwipeSize = 0.5;
    /// how much space the iamge should take of available space as a fraction
    /// of the canvas space also see `canvasSize`
    double imgCanvasFraction = 0.9;

  @override
  Widget build(BuildContext context) {

    double sWidth  = MediaQuery.sizeOf(context).width;
    double sHeight = MediaQuery.sizeOf(context).height;

    double canvasSize = sWidth*0.95 > sHeight*0.75 ? sHeight*0.75 : sWidth*0.95;
    
    double imgSize  = canvasSize * imgCanvasFraction;
    double padding  = 1 - imgCanvasFraction;
    double textSize = sHeight * 0.3;
    double imageTopPadding = (sHeight*0.33)-imgSize/2;


    return Container(
      height: sHeight,
      width: sWidth,
      color: widget.bgColor,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            width: canvasSize,
            height: canvasSize,
            top: imageTopPadding,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  width: imgSize *
                    (widget.liquidController.currentPage == widget.nr-1
                      ? lerpDouble(minImgSwipeSize, 1, 1-widget.swipeAnimation.value)!
                      : lerpDouble(minImgSwipeSize, 1, widget.swipeAnimation.value)!),
                  height: imgSize,
                  left: calculateLeftOffset(imgSize, parallaxBackground) + imgSize*padding,
                  child: RepaintBoundary(
                    child: SvgPicture(widget.foregroundSvgLoader),
                  ),
                ),
                
                Positioned(
                  height: imgSize *
                    (widget.liquidController.currentPage == widget.nr-1
                      ? lerpDouble(minImgSwipeSize, 1, 1-widget.swipeAnimation.value)!
                      : lerpDouble(minImgSwipeSize, 1, widget.swipeAnimation.value)!),
                  width: imgSize,
                  left: calculateLeftOffset(imgSize, parallaxForeground) + imgSize*padding,
                  child: RepaintBoundary(
                    child: SvgPicture(widget.backgroundSvgLoader),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            height: textSize,
            width: imgSize,
            top:  imgSize*(1+padding)+imageTopPadding,
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

  double calculateLeftOffset(double imgSize, double parallax){

    // assure that the current swipe process is not null
    if(widget.liquidController.provider == null) return 0.0;

    var ret = -widget.swipeAnimation.value * parallax;

    // this is the previous page
    if (widget.liquidController.currentPage > widget.nr-1) {
      ret = -ret - parallax;
      // adjust for smaller size
      ret -= imgSize * (1-widget.swipeAnimation.value);
    }
    // this is the current page
    else if (widget.liquidController.currentPage == widget.nr-1){
      if(widget.liquidController.provider!.slideDirection == SlideDirection.rightToLeft) {
        ret = ret;
        // adjust for smaller size
        ret -= imgSize * (widget.swipeAnimation.value);
      }
      else if(widget.liquidController.provider!.slideDirection == SlideDirection.leftToRight) {
        ret = -ret;
        // adjust for smaller size
        ret += imgSize * (widget.swipeAnimation.value);
      }
    }
    // this is the next page
    else if(widget.liquidController.currentPage < widget.nr-1) {
      ret = ret + parallax;
      // adjust for smaller size
      ret += imgSize * (1-widget.swipeAnimation.value);
    }

    return ret;
  }
}
