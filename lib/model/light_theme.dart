import 'package:flutter/material.dart';

import '../helper/color_conversion.dart';
import 'dakanji_colors.dart';



final ThemeData lightTheme = ThemeData(
  
  brightness: Brightness.light,

  primarySwatch: createMaterialColor(dakanji_green),

  highlightColor: dakanji_red,

);