// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/color_conversion.dart';
import 'package:da_kanji_mobile/globals.dart';

final ThemeData darkTheme = ThemeData(

  fontFamily: 'NotoSansJP',

  brightness: Brightness.dark,

  primarySwatch: createMaterialColor(g_Dakanji_green),

  highlightColor: g_Dakanji_red,

  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0
  ),

  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 0, 197, 207),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 83, 83, 83),
    )
  ),

  typography: Typography.material2018()
);
