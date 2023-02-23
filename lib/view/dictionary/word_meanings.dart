import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/view/dictionary/meanings_grid.dart';



class WordMeanings extends StatelessWidget {
  
  /// The entry of which the meanings should be shown
  final JMdict entry;
  /// The style to aply to the meanings
  final TextStyle meaningsStyle;

  const WordMeanings(
    {
      required this.entry,
      required this.meaningsStyle,
      super.key
    }
  );
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // create the children in the same order as in the settings
      children: GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((lang) {
        
        List<Widget> ret = [];

        // get the meaning of the selected language
        List<LanguageMeanings> meanings = entry.meanings.where(
          (element) => isoToiso639_1[element.language]!.name == lang
        ).toList();
        
        
        if(meanings.isNotEmpty){
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
                SizedBox(width: 10,),
                Text(
                  isoToLanguage[isoToiso639_1[lang]]!
                )
              ],
            ),
          );
          ret.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
              child: Column(
                children: [
                  MeaningsGrid(
                    meanings: meanings.first.meanings!,
                    style: meaningsStyle,
                    limit: 5,
                  ),
                ],
              ),
            )
          );

          ret.add(SizedBox(height: 20,));
              
        }

        return ret;
      }).expand((element) => element).toList(),
      
    );
  }
}