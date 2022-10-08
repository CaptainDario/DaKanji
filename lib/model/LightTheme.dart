import 'package:flutter/material.dart';

import '../helper/ColorConversion.dart';



final ThemeData lightTheme = ThemeData(
  
  brightness: Brightness.light,

  primarySwatch: createMaterialColor(const Color.fromARGB(255, 26, 93, 71)),

  highlightColor: const Color.fromARGB(255, 194, 32, 44),

);