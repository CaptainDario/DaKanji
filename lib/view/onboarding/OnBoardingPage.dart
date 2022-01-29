import 'package:flutter/material.dart';



/*
// The widget which is used for one OnBoarding Page.
// 
// `context` should be the current `BuildContext`.
// `nr` is the number of this OnBoarding-page and totalNr the total number
// of OnBoarding-Pages. `bgColor` is the background color for this page.
*/
Widget OnBoardingPage(
  BuildContext context, int nr, int totalNr, Color bgColor, String headerText, String text) {

  // the size of the indicators showing on which page the user currently is
  double indicatorSize = 5;

  double sWidth  = MediaQuery.of(context).size.width;
  double sHeight = MediaQuery.of(context).size.height;

  double imageSize = sHeight * 0.5;
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
            SizedBox(height: sHeight * 0.05),
            Image.asset(
              'assets/artwork/onboarding_${nr}.png',
              width: imageSize,
              height: imageSize,
            ),
            Container(
              height: textSize / 2,
              width: imageSize,
              child: FittedBox(
                child: Text(
                  headerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]
        ),
        Positioned(
          top: sHeight * 0.925,
          left: (sWidth / 2) - (imageSize/2),
          width: imageSize,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: () {
                List<Widget> widgets = [];

                widgets.add(
                  OutlinedButton(
                    style: ButtonStyle(
                      shadowColor:  MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Color.fromARGB(150, 255, 255, 255)),
                      side: MaterialStateProperty.all(
                        BorderSide(color: Color.fromARGB(0, 255, 255, 255))
                      ),
                    ),
                    onPressed: (){}, 
                    child: Text("Skip")
                  )
                );
                widgets.add(SizedBox(width: indicatorSize*5,));

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
                
                widgets.add(SizedBox(width: indicatorSize*5,));
                widgets.add(
                  OutlinedButton(
                    style: ButtonStyle(
                      shadowColor:  MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(
                        BorderSide(color: Color.fromARGB(0, 255, 255, 255))
                      ),
                    ),
                    onPressed: (){}, 
                    child: Text("Next →")
                  )
                );

                return widgets;
              } ()
            ),
          )
        )
      ],
    )
  );

}