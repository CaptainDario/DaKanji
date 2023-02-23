import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import "package:database_builder/database_builder.dart";

import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/helper/iso/iso_table.dart';



/// A card that shows an example sentence
class ExampleSentenceCard extends StatefulWidget {
  const ExampleSentenceCard(
    this.sentences,
    {Key? key}
  ) : super(key: key);

  /// the example sentence
  final ExampleSentence sentences;

  @override
  State<ExampleSentenceCard> createState() => _ExampleSentenceCardState();
}

class _ExampleSentenceCardState extends State<ExampleSentenceCard> {

  /// A list containing all translations of `widget.sentences` in languages
  /// that the user has selected in settings
  List<Translation> translations = [];


  @override
  void initState() {
    initTranslations();
    super.initState();
  }

  void initTranslations(){
    List<String> selectedLangs = 
      GetIt.I<Settings>().dictionary.selectedTranslationLanguages;
    translations = widget.sentences.translations
      // filter translations that are not of any selected language
      .where((e) =>
        selectedLangs.contains(isoToiso639_1[e.language]?.name)
      ).toList()
      // sort to match order set in settings
      ..sort((a, b) => 
        selectedLangs.indexOf(isoToiso639_1[a.language!]!.name)
        - selectedLangs.indexOf(isoToiso639_1[b.language!]!.name)
      );
  }

  @override
  void didUpdateWidget(covariant ExampleSentenceCard oldWidget) {
    initTranslations();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    if(translations.isEmpty){
      return Container();
    }

    return SizedBox(
      //height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                widget.sentences.sentence
              ),
              SizedBox(height: 10,),
              ...translations.map((e) => 
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: SvgPicture.asset(
                        GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[
                          isoToiso639_1[e.language]!.name
                        ]!
                      ),
                    ),
                    SizedBox(width: 10,),
                    SelectableText(e.sentence!)
                  ],
                ),
                
              ).toList()
            ]
          ),
        )
      )
    );
  }
}