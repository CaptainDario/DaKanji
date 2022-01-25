import 'package:flutter/material.dart';



final ThemeData darkTheme = ThemeData(
  
  brightness: Brightness.dark,

  primarySwatch: MaterialColor(4280361249,{
    50: Color( 0xfff2f2f2 )
  , 100: Color( 0xffe6e6e6 )
  , 200: Color( 0xffcccccc )
  , 300: Color( 0xffb3b3b3 )
  , 400: Color( 0xff999999 )
  , 500: Color( 0xff808080 )
  , 600: Color( 0xff666666 )
  , 700: Color( 0xff4d4d4d )
  , 800: Color( 0xff333333 )
  , 900: Color( 0xff191919 )
  }),

  highlightColor: Colors.red
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}