import 'package:da_kanji_mobile/view/home/OnBoardingPage.dart';
import 'package:flutter/material.dart';

import 'package:liquid_swipe/liquid_swipe.dart';



Widget OnBoarding (BuildContext context){

  return Stack(
    children: [
      LiquidSwipe(
        enableLoop: false,
        pages: [
          OnBoardingPage(context, 1, Colors.amber),
          OnBoardingPage(context, 2, Colors.red),
          OnBoardingPage(context, 3, Colors.green)
        ] 
      ),
    ],
  );

}