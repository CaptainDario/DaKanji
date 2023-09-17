// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/// The manual for the DictionaryScreen
class ManualDictionary extends StatelessWidget {
  
  /// heading 1 text style
  final TextStyle heading_1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  /// heading 2 text style
  final TextStyle heading_2 = TextStyle(
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

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search results
            ExpansionTile(
              title: Text(LocaleKeys.ManualScreen_dict_search_results_title.tr(), style: heading_1,),
              children: [
                SizedBox(height: 15),

                Text(LocaleKeys.ManualScreen_dict_search_results_navigate_title.tr(), style: heading_2,),
                SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_dict_search_results_navigate_text.tr()),

                SizedBox(height: 15),
              ],
            ),
    
            // Search history
            ExpansionTile(
              title: Text(LocaleKeys.ManualScreen_dict_search_history_title.tr(), style: heading_1,),
              children: [
                SizedBox(height: 15),

                Text(LocaleKeys.ManualScreen_dict_search_history_delete_title.tr(), style: heading_2,),
                SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_dict_search_history_delete_text.tr()),
                
                SizedBox(height: 15),
              ],
            ),
    
            // Kanji
            ExpansionTile(
              title: Text(LocaleKeys.ManualScreen_dict_kanji_title.tr(), style: heading_1,),
              children: [
                SizedBox(height: 15),
            
                Text(LocaleKeys.ManualScreen_dict_kanji_search_kanji_group_title.tr(), style: heading_2,),
                SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_dict_kanji_search_kanji_group_text.tr()),
        
                SizedBox(height: 10),
                
                Text(LocaleKeys.ManualScreen_dict_kanji_copy_radicals_title.tr(), style: heading_2,),
                SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_dict_kanji_copy_radicals_text.tr()),
        
                SizedBox(height: 15),
              ],
            ),
    
            // Examples
            ExpansionTile(
              title: Text(LocaleKeys.ManualScreen_dict_examples_title.tr(), style: heading_1,),
              children: [
                SizedBox(height: 15),
            
                Text(LocaleKeys.ManualScreen_dict_text_examples_analyze_title.tr(), style: heading_2,),
                SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_dict_text_examples_analyze_text.tr()),
        
                SizedBox(height: 15,),
              ],
            ),
    
            // Radical popup
            ExpansionTile(
              title: Text(LocaleKeys.ManualScreen_dict_radicals_title.tr(), style: heading_1,),
              children: [
                SizedBox(height: 15),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.ManualScreen_dict_radicals_paste_title.tr(), style: heading_2,),
                    SizedBox(width: 8,),
                    Icon(Icons.paste, size: 18,),
                  ]
                ),
                SizedBox(height: 5),
                Text(LocaleKeys.ManualScreen_dict_radicals_paste_text.tr()),

                SizedBox(height: 15),
              ],
            )
          ]
        ),
      ),
    );
  }
}
