import 'package:flutter/material.dart';

import '../helper/color_conversion.dart';



final ThemeData darkTheme = ThemeData(
  
  brightness: Brightness.dark,

  primarySwatch: createMaterialColor(const Color.fromARGB(255, 26, 93, 71)),

  highlightColor: const Color.fromARGB(255, 194, 32, 44),

  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 0, 197, 207),
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 83, 83, 83),
    )
  ),
);
