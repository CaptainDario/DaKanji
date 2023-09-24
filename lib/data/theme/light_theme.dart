// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/color_conversion.dart';
import 'package:da_kanji_mobile/globals.dart';

final ThemeData lightTheme = ThemeData(
  
  brightness: Brightness.light,

  primarySwatch: createMaterialColor(g_Dakanji_green),

  highlightColor: g_Dakanji_red,

);
