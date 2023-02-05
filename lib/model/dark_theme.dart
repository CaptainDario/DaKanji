import 'package:flutter/material.dart';

import '../helper/color_conversion.dart';
import 'dakanji_colors.dart';



final ThemeData darkTheme = ThemeData(
  
  brightness: Brightness.dark,

  primarySwatch: createMaterialColor(dakanji_green),

  highlightColor: dakanji_red,

  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 0, 197, 207),
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 83, 83, 83),
    )
  ),
);
