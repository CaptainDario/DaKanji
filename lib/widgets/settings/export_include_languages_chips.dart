import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';



/// A set of language chips that define which languages to include when exporting
/// to anki, pdf, etc.. Only the languages that are active in the dictionary
/// are selectable
class ExportLanguagesIncludeChips extends StatelessWidget {

  /// The languages that are currently selected in the dictionary settings
  final List<String> selectedTranslationLanguages;
  /// The langauges that should be included when exporting
  final List<bool> includedLanguages;
  /// The [Settings] object to save to 
  final Settings settings;
  /// Function to set `this.includeLanguages`
  final Function (bool value, int index) setIncludeLanguagesItem;


  const ExportLanguagesIncludeChips(
    {
      required this.selectedTranslationLanguages,
      required this.includedLanguages,
      required this.settings,
      required this.setIncludeLanguagesItem,
      super.key,
    }
  );


  @override
  Widget build(BuildContext context) {
    return ResponsiveFilterChips(
      description: LocaleKeys.SettingsScreen_anki_languages_to_include.tr(),
      chipWidget: (int index) {
        String lang = selectedTranslationLanguages[index];
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
              height: 10,
              child: SvgPicture.asset(
                settings.dictionary.translationLanguagesToSvgPath[lang]!
              )
            ),
            const SizedBox(width: 8,),
            Text(lang,),
          ],
        );
      },
      selected: (index) {
        return includedLanguages[index];
      },
      numChips: selectedTranslationLanguages.length,
      onFilterChipTap: (selected, index) async {
        // do not allow disabling all lanugages
        if(includedLanguages.where((e) => e).length == 1 &&
          includedLanguages[index] == true){
          return;
        }
    
        setIncludeLanguagesItem(selected, index);
        await settings.save();
      },
    );
  }
}
