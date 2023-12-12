// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/color_conversion.dart';
import 'package:da_kanji_mobile/globals.dart';

final ThemeData lightTheme = ThemeData(
  
  brightness: Brightness.light,
  colorSchemeSeed: Colors.white,

  //primarySwatch: createMaterialColor(g_Dakanji_green),

  appBarTheme: const AppBarTheme(
    color: g_Dakanji_green,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    foregroundColor: Colors.white
  ),

  highlightColor: g_Dakanji_red,

  typography: Typography.material2018()
);
