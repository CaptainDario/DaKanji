import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';



/// The manual for the DictionaryScreen
class ManualDictionary extends StatelessWidget {
  
  /// heading 1 text style
  TextStyle heading_1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  /// heading 2 text style
  TextStyle heading_2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  ManualDictionary(
    {
      super.key
    }
  );


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.ManualScreen_dict_kanji_title.tr(), style: heading_1,),

          SizedBox(height: 10),
          
          Text(LocaleKeys.ManualScreen_dict_kanji_search_kanji_group_title.tr(), style: heading_2,),
          SizedBox(height: 5),
          Text(LocaleKeys.ManualScreen_dict_kanji_search_kanji_group_text.tr()),

          SizedBox(height: 15),

          Text(LocaleKeys.ManualScreen_dict_examples_title.tr(), style: heading_1,),

          SizedBox(height: 10),
          
          Text(LocaleKeys.ManualScreen_dict_text_examples_analyze_title.tr(), style: heading_2,),
          SizedBox(height: 5),
          Text(LocaleKeys.ManualScreen_dict_text_examples_analyze_text.tr())
        ]
      ),
    );
  }
}