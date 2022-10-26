import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:xml/xml.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/view/dictionary/kanji_vg_widget.dart';
import 'package:da_kanji_mobile/view/dictionary/kanji_group_widget.dart';
import 'package:da_kanji_mobile/provider/settings.dart';




/// Card to show a kanji and all important attribtues of it. This includes
/// a tree to show the different groups.
class DictionaryScreenKanjiCard extends StatefulWidget {
  const DictionaryScreenKanjiCard(
    this.kanjiVG,
    this.kanjidic2entry,
    this.targetLanguages,
    {
      this.alternatives,
      Key? key
    }
  ) : super(key: key);

  /// The kanji that should be shown in this card as a svg string
  final KanjiSVG kanjiVG;
  /// List of all kanjidict entries 
  final Kanjidic2Entry kanjidic2entry;
  /// String denoting the target language
  final List<String> targetLanguages;
  /// Alternative versions of this kanji
  final List<DictionaryScreenKanjiCard>? alternatives;

  @override
  State<DictionaryScreenKanjiCard> createState() => _DictionaryScreenKanjiCardState();
}

class _DictionaryScreenKanjiCardState extends State<DictionaryScreenKanjiCard> {

  /// List containing all on readings of this kanji
  final List<String> onReadings = [];
  /// List containing all kun readings of this kanji
  final List<String> kunReadings = [];
  /// List containing all readings in the target language
  final Map<String, List<String>> meanings = {};
  /// The stroke count information extracted from the KanjiVG data
  int strokeCount = -1;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.kanjidic2entry.readings.length; i++) {
      // init on reading list
      if(widget.kanjidic2entry.readings[i].r_type.contains("ja_on")) {
        onReadings.add(widget.kanjidic2entry.readings[i].value);
      }

      // init kun reading list
      if(widget.kanjidic2entry.readings[i].r_type.contains("ja_kun")) {
        kunReadings.add(widget.kanjidic2entry.readings[i].value);
      }
    }

    for (var i = 0; i < widget.kanjidic2entry.meanings.length; i++) {
      // init meaning list with all meanings that match `targetLanguage`
      if(widget.targetLanguages.any(
        (l) => l.contains(widget.kanjidic2entry.meanings[i].language)
      )) {
        if(!meanings.containsKey(widget.kanjidic2entry.meanings[i].language))
          meanings[widget.kanjidic2entry.meanings[i].language] = [];
        meanings[widget.kanjidic2entry.meanings[i].language]!.add(
          widget.kanjidic2entry.meanings[i].meaning
        );
      }
    }

    // get stroke count from kanjiVG
    final document = XmlDocument.parse(widget.kanjiVG.svg);
    strokeCount = document.root.findAllElements('text').map(
        (e) => int.parse(e.children.first.text)
      ).toList().reduce(max);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Kanji preview
                    KanjiVGWidget(
                      widget.kanjiVG.svg,
                      constrains.maxWidth * 0.5,
                      constrains.maxWidth * 0.5,
                      colorize: true,
                    ),
                    
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Strokes: $strokeCount, "
                            "Grade: ${widget.kanjidic2entry.grade}, " 
                            "JLPT: N${widget.kanjidic2entry.jlpt}, "
                            "Heisig: NONE, "
                            "SKIP: NONE"),
                          const Text(
                            "On:"
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Flexible(
                                child: SelectableText(
                                  onReadings.join(", ")
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Kun:"
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Flexible(
                                child: SelectableText(
                                  kunReadings.join(", ")
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                ...meanings.entries.map((e) => 
                  Row(
                    children: [
                      SizedBox(
                        height: 10,
                        width: 10,
                        child: SvgPicture.asset(
                          GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[e.key]!
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        e.value.toString().replaceAll("[", "").replaceAll("]", "")
                      )
                    ],
                  ),
                ).toList(),
                const SizedBox(height: 16,),
                ExpansionTile(
                  title: const Text("Kanji groups"),
                  children:
                  [
                    KanjiGroupWidget(
                      widget.kanjiVG.svg,
                      constrains.maxWidth - 16,
                      constrains.maxWidth - 16
                    ),
                  ]
                ),
                if(this.widget.alternatives != null && this.widget.alternatives != [])
                  ExpansionTile(
                    title: const Text("Alternate forms"),
                    children: this.widget.alternatives!
                  ),
              ],
            ),
          );
        }
      )
    );
  }
}