import 'package:flutter/material.dart';

import '../helper/ColorConversion.dart';



final ThemeData darkTheme = ThemeData(
  
  brightness: Brightness.dark,

  primarySwatch: createMaterialColor(Color.fromARGB(255, 26, 93, 71)),

  highlightColor: Color.fromARGB(255, 194, 32, 44),

  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromARGB(255, 0, 197, 207),
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 83, 83, 83),
    )
  ),
);
