import 'package:flutter/material.dart';



/*
// The widget which is used for one OnBoarding Page.
// 
// `context` should be the current `BuildContext`.
// `nr` is the number of this OnBoarding-page and totalNr the total number
// of OnBoarding-Pages. `bgColor` is the background color for this page.
*/
Widget OnBoardingPage(BuildContext context, int nr, int totalNr, Color bgColor) {

  // the size of the indicators showing on which page the user currently is
  double indicatorSize = 5;

  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: bgColor,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/artwork/onboarding_${nr}.png'
        ),
        Positioned(
          top: MediaQuery.of(context).size.height - indicatorSize - (totalNr*indicatorSize),
          left: (MediaQuery.of(context).size.width - (indicatorSize*indicatorSize)) / 2,
          child: Row(
            children: () {
              List<Widget> widgets = [];

              for (int i = 0; i < totalNr; i++) {
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
                widgets.add(SizedBox(width: indicatorSize,));
              }

              return widgets;
            } ()
          )
        )
      ],
    )
  );

}