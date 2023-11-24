// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import "package:database_builder/database_builder.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/screens/text/text_screen.dart';

/// A card that shows an example sentence
class ExampleSentenceCard extends StatefulWidget {

  /// the example sentence
  final ExampleSentence sentences;
  /// Spans that matched
  final List<Tuple2<int, int>> matchSpans;


  const ExampleSentenceCard(
    this.sentences,
    this.matchSpans,
    {Key? key}
  ) : super(key: key);

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
      ).toList();
      
      // sort to match order set in settings
      translations.sort((a, b) => 
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

    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: 
          (context) => TextScreen(
            false,
            false,
            useBackArrowAppBar: true,
            initialText: widget.sentences.sentence,
          )
        ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectionArea(
                child: Text.rich(
                    TextSpan(
                      children: [
                        if(widget.matchSpans.isNotEmpty)
                          ...[  
                            for (int i = 0; i < widget.matchSpans.length; i++)
                              ...[
                                // before the word of th
                                if(widget.matchSpans[i].item1 != 0)
                                  TextSpan(
                                    text: widget.sentences.sentence.substring(
                                      0,
                                      widget.matchSpans[i].item1,
                                    ),
                                  ),
                                // the dict entry in bold
                                TextSpan(
                                  text: widget.sentences.sentence.substring(
                                    widget.matchSpans[i].item1,
                                    widget.matchSpans[i].item2,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: g_japaneseFontFamily,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ],
                            // after the dict entry
                            if(widget.matchSpans.last.item2 != widget.sentences.sentence.length)
                              TextSpan(
                                text: widget.sentences.sentence.substring(
                                  widget.matchSpans.last.item2,
                                ),
                              )
                          ]
                        else
                          TextSpan(
                            text: widget.sentences.sentence
                          )
                      ]
                    )
                )
              ),
              const SizedBox(height: 10,),
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
                    const SizedBox(width: 10,),
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
