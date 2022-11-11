import 'dart:math';

import 'package:da_kanji_mobile/view/dictionary/meanings_grid.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;
import 'package:da_kanji_mobile/provider/settings/settings.dart';



class WordMeanings extends StatelessWidget {
  
  /// The entry of which the meanings should be shown
  final isar_jm.Entry entry;
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
        List<isar_jm.LanguageMeanings> meanings = entry.meanings.where(
          (element) => isoToiso639_1[element.language]!.name == lang
        ).toList();
        
        ret.add(
          SizedBox(
            height: 10,
            width: 10,
            child: SvgPicture.asset(
              GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[lang]!
            ),
          ),
        );
        if(meanings.isNotEmpty){

          ret.add(
            Column(
              children: [
                MeaningsGrid(
                  meanings: meanings.first.meanings!,
                  style: meaningsStyle,
                  limit: 10,
                ),
                if(meanings.first.meanings!.length > 10)
                  ExpansionTile(
                    title: Text("More..."),
                    children: [
                      MeaningsGrid(
                        meanings: meanings.first.meanings!,
                        style: meaningsStyle,
                        countOffset: 10,
                      )
                    ],
                  )
              ],
            )
          );

          ret.add(SizedBox(height: 10,));
              
        }

        return ret;
      }).expand((element) => element).toList(),
      
    );
  }
}