import 'package:flutter/material.dart';



/*
// 
// 
*/
Widget OnBoardingPage(BuildContext context, int nr, Color bgColor) {

  double indicatorSize = 5;
  int nrPages = 3;

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
          top: MediaQuery.of(context).size.height - indicatorSize - (nrPages*indicatorSize),
          left: (MediaQuery.of(context).size.width - (indicatorSize*indicatorSize)) / 2,
          child: Row(
            children: () {
              List<Widget> widgets = [];

              for (int i = 0; i < nrPages; i++) {
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