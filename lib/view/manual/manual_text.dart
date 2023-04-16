import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:simple_html_css/simple_html_css.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/helper/color_conversion.dart';
import 'package:da_kanji_mobile/helper/part_of_speech.dart';



/// The manual for the TextScreen
class ManualTextScreen extends StatelessWidget {
  ManualTextScreen({super.key});

  final String manualTextScreenText = "";

  @override
  Widget build(BuildContext context) {
    return HTML.toRichText(
      context, 
      manualTextScreenText,
      defaultTextStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color
      )
    );
  }
}