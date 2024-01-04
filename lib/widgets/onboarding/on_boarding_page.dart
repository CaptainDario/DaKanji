// Dart imports:
import 'dart:core';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
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
  /// Svg picture info of the foreground onboarding image
  final ui.Image foregroundSvgPictureInfo;
  /// Svg picture info of the background onboarding image
  final ui.Image backgroundSvgPictureInfo;
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
    this.foregroundSvgPictureInfo,
    this.backgroundSvgPictureInfo,
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
  /// screen width
  double sWidth = 0;
  /// screen height
  double sHeight = 0;
  /// size of the total canvas where the onboarding images are shown
  double canvasSize = 0;
  /// the size of the actual svg image shown on the canvas
  double imgSize = 0;
  /// padding around the canvs (percent)
  double padding = 0;
  /// size of the text
  double textSize = 0;

  double imageTopPadding = 0;


  @override
  Widget build(BuildContext context) {

    // if size changed update sizes
    if(sWidth != MediaQuery.sizeOf(context).width ||
      sHeight != MediaQuery.sizeOf(context).height){
      sWidth  = MediaQuery.sizeOf(context).width;
      sHeight = MediaQuery.sizeOf(context).height;

      canvasSize = sWidth*0.95 > sHeight*0.75 ? sHeight*0.75 : sWidth*0.95;
      
      imgSize  = canvasSize * imgCanvasFraction;
      padding  = 1 - imgCanvasFraction;
      textSize = sHeight * 0.3;
      imageTopPadding = (sHeight*0.33)-imgSize/2;
    }

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
                      ? ui.lerpDouble(minImgSwipeSize, 1, 1-widget.swipeAnimation.value)!
                      : ui.lerpDouble(minImgSwipeSize, 1, widget.swipeAnimation.value)!),
                  height: imgSize,
                  left: calculateLeftOffset(imgSize, parallaxBackground) + imgSize*padding,
                  child: RepaintBoundary(
                    child: RawImage(
                      image: widget.foregroundSvgPictureInfo,
                    ),
                  ),
                ),
                Positioned(
                  height: imgSize *
                    (widget.liquidController.currentPage == widget.nr-1
                      ? ui.lerpDouble(minImgSwipeSize, 1, 1-widget.swipeAnimation.value)!
                      : ui.lerpDouble(minImgSwipeSize, 1, widget.swipeAnimation.value)!),
                  width: imgSize,
                  left: calculateLeftOffset(imgSize, parallaxForeground) + imgSize*padding,
                  child: RepaintBoundary(
                    child: RawImage(
                      image: widget.backgroundSvgPictureInfo,
                    ),
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
                    textScaler: const TextScaler.linear(1.5),
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            )
          ),
          // skip
          Positioned(
            bottom: 8,
            left: 24,
            child: SizedBox(
              height: 36,
              child: InkWell(
                onTap: (){
                  widget.liquidController.animateToPage(page: widget.totalPages);
                }, 
                child: Center(
                  child: Text(
                    LocaleKeys.General_skip.tr(),
                    style: const TextStyle(color: Colors.white),
                  )
                )
              ),
            ),
          ),
          Positioned(
            // padding + half button size - half indicatr
            bottom: 8 + 36/2 - indicatorSize/2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...[
                  for (int i = 0; i < widget.totalPages; i++)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0, 0, i+1 < widget.totalPages ? indicatorSize : 0, 0
                      ),
                      child: Container(
                        width: indicatorSize,
                        height: indicatorSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.nr-1 == i ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                ],
              ]
            ),
          ),
          //next
          Positioned(
            bottom: 8,
            right: 24,
            child: SizedBox(
              height: 36,
              child: GestureDetector(
                onTap: (){
                  widget.liquidController.animateToPage(
                    page: widget.liquidController.currentPage + 1
                  );
                },
                child: Center(
                  child: Text(
                    "${LocaleKeys.General_next.tr()} →",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
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
