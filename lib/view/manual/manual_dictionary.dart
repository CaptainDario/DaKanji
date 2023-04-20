import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';



/// The manual for the DictionaryScreen
class ManualDictionary extends StatelessWidget {
  ManualDictionary({super.key});

  final String manualTextScreenText = 
    LocaleKeys.ManualScreen_dict_text_examples_analyze.tr() + "\n" +
    LocaleKeys.ManualScreen_dict_text_kanji_elements.tr();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MarkdownBody(
        data: manualTextScreenText,
      ),
    );
  }
}