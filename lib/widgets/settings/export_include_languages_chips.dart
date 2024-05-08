// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_filter_chips.dart';

/// A set of language chips that define which languages to include when exporting
/// to anki, pdf, etc.. Only the languages that are active in the dictionary
/// are selectable
class ExportLanguagesIncludeChips extends StatefulWidget {

  /// The text to show above this setting
  final String text;
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
      required this.text,
      required this.selectedTranslationLanguages,
      required this.includedLanguages,
      required this.settings,
      required this.setIncludeLanguagesItem,
      super.key,
    }
  );

  @override
  State<ExportLanguagesIncludeChips> createState() => _ExportLanguagesIncludeChipsState();
}

class _ExportLanguagesIncludeChipsState extends State<ExportLanguagesIncludeChips> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveFilterChips(
      description: widget.text,
      chipWidget: (int index) {
        String lang = widget.selectedTranslationLanguages[index];
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
              height: 10,
              child: SvgPicture.asset(
                widget.settings.dictionary.translationLanguagesToSvgPath[lang]!
              )
            ),
            const SizedBox(width: 8,),
            Text(lang,),
          ],
        );
      },
      selected: (index) {
        return widget.includedLanguages[index];
      },
      numChips: widget.selectedTranslationLanguages.length,
      onFilterChipTap: (selected, index) async {
        // do not allow disabling all lanugages
        if(widget.includedLanguages.where((e) => e).length == 1 &&
          widget.includedLanguages[index] == true){
          return;
        }
    
        widget.setIncludeLanguagesItem(selected, index);
        await widget.settings.save();

        setState(() {});
      },
    );
  }
}
