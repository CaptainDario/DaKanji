// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/data/iso/iso_table.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/dictionary/meanings_grid.dart';

class WordMeanings extends StatefulWidget {
  
  /// The entry of which the meanings should be shown
  final JMdict entry;
  /// The style to aply to the meanings
  final TextStyle meaningsStyle;
  /// Whether to include the wikipedia definition
  final bool includeWikipediaDefinition;

  const WordMeanings(
    {
      required this.entry,
      required this.meaningsStyle,
      this.includeWikipediaDefinition = false,
      super.key
    }
  );

  @override
  State<WordMeanings> createState() => _WordMeaningsState();
}

class _WordMeaningsState extends State<WordMeanings> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // create the children in the same order as in the settings
      children: [
        ...GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((lang) {
        
          List<Widget> ret = [];

          // get the meaning of the selected language
          List<LanguageMeanings> meanings = widget.entry.meanings.where(
            (element) => isoToiso639_1[element.language]!.name == lang
          ).toList();
          
          
          // language flag
          if(meanings.isNotEmpty) {
            ret.add(
              Row(
                children: [
                  SizedBox(
                    height: 10,
                    width: 10,
                    child: SvgPicture.asset(
                      GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[lang]!
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    isoToLanguage[isoToiso639_1[lang]]!
                  )
                ],
              ),
            );
          }
          // add the meanings
          if(meanings.isNotEmpty) {
            ret.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                child: Column(
                  children: [
                    MeaningsGrid(
                      meanings: meanings.first,
                      style: widget.meaningsStyle,
                      limit: 5,
                    ),
                  ],
                ),
              )
            );
          }

          return ret;
        }).expand((element) => element).toList(),

      ]
    );
  }
}
