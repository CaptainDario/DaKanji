import 'package:flutter/material.dart';

import 'package:simple_html_css/simple_html_css.dart';



/// The manual for the DictionaryScreen
class ManualDictionary extends StatelessWidget {
  ManualDictionary({super.key});

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