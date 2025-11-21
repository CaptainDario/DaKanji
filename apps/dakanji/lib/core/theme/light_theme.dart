// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

final ThemeData lightTheme = ThemeData(

  fontFamily: 'NotoSansJP',
  
  brightness: Brightness.light,
  colorSchemeSeed: g_Dakanji_green,
  //colorSchemeSeed: Colors.pink,

  //primarySwatch: createMaterialColor(g_Dakanji_green),

  appBarTheme: const AppBarTheme(
    color: g_Dakanji_green,
    //color: Colors.brown.shade600,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    foregroundColor: Colors.white
  ),

  highlightColor: g_Dakanji_red,

  typography: Typography.material2018()
);
