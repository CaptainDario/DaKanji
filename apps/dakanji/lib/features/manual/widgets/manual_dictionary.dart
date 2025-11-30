// Flutter imports:
import 'package:da_kanji_mobile/features/manual/widgets/manual_section.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/locales_keys.dart';

/// The manual for the DictionaryScreen
class ManualDictionary extends StatelessWidget {
  
  /// heading 1 text style
  final TextStyle heading_1 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  /// heading 2 text style
  final TextStyle heading_2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  const ManualDictionary(
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
            // Search
            ManualSection(
              title: LocaleKeys.ManualScreen_dict_search_title.tr(),
              sectionHeaders: [
                (null, LocaleKeys.ManualScreen_dict_search_wildcard_search_title.tr()),
                (null, LocaleKeys.ManualScreen_dict_search_specifiying_searches_title.tr())
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_dict_search_wildcard_search_text.tr(), true),
                (LocaleKeys.ManualScreen_dict_search_specifiying_searches_text.tr(), true)
              ]
            ),
    
            // Search history
            ManualSection(
              title: LocaleKeys.ManualScreen_dict_search_history_title.tr(),
              sectionHeaders: [
                (null, LocaleKeys.ManualScreen_dict_search_history_delete_title.tr())
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_dict_search_history_delete_text.tr(), false)
              ]
            ),
    
            // Kanji
            ManualSection(
              title: LocaleKeys.ManualScreen_dict_kanji_title.tr(),
              sectionHeaders: [
                (null, LocaleKeys.ManualScreen_dict_kanji_search_kanji_group_title.tr()),
                (null, LocaleKeys.ManualScreen_dict_kanji_copy_radicals_title.tr()),
                (null, LocaleKeys.ManualScreen_dict_kanji_animation_title.tr())
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_dict_kanji_search_kanji_group_text.tr(), false),
                (LocaleKeys.ManualScreen_dict_kanji_copy_radicals_text.tr(), false),
                (LocaleKeys.ManualScreen_dict_kanji_animation_text.tr(), false)
              ]
            ),
    
            // Examples
            ManualSection(
              title: LocaleKeys.ManualScreen_dict_examples_title.tr(),
              sectionHeaders: [
                (null, LocaleKeys.ManualScreen_dict_text_examples_analyze_title.tr())
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_dict_text_examples_analyze_text.tr(), false)
              ]
            ),
    
            // Radical popup
            ManualSection(
              title: LocaleKeys.ManualScreen_dict_radicals_title.tr(),
              sectionHeaders: [
                (Icon(Icons.paste), LocaleKeys.ManualScreen_dict_radicals_paste_title.tr())
              ],
              sectionTexts: [
                (LocaleKeys.ManualScreen_dict_radicals_paste_text.tr(), false)
              ]
            ),
          ]
        ),
      ),
    );
  }
}
