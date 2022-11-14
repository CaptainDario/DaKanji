import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:xml/xml.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:database_builder/database_builder.dart';
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;

import 'package:da_kanji_mobile/view/dictionary/kanji_vg_widget.dart';
import 'package:da_kanji_mobile/view/dictionary/kanji_group_widget.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';




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
  final isar_kanji.KanjiSVG kanjiVG;
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
  /// the menu elements of the more-popup-menu
  List<String> menuItems = ["Kanji Map", "Japanese Graph"];
  /// The textstyle used for the headers
  TextStyle headerStyle = TextStyle(color: Colors.grey);

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.kanjidic2entry.readings.length; i++) {
      // init on reading list
      if(widget.kanjidic2entry.readings[i].r_type!.contains("ja_on")) {
        onReadings.add(widget.kanjidic2entry.readings[i].value!);
      }

      // init kun reading list
      if(widget.kanjidic2entry.readings[i].r_type!.contains("ja_kun")) {
        kunReadings.add(widget.kanjidic2entry.readings[i].value!);
      }
    }

    for (var i = 0; i < widget.kanjidic2entry.meanings.length; i++) {
      // init meaning list with all meanings that match `targetLanguage`
      if(widget.targetLanguages.any(
        (l) => l.contains(widget.kanjidic2entry.meanings[i].language!)
      )) {
        if(!meanings.containsKey(widget.kanjidic2entry.meanings[i].language))
          meanings[widget.kanjidic2entry.meanings[i].language!] = [];
        meanings[widget.kanjidic2entry.meanings[i].language]!.add(
          widget.kanjidic2entry.meanings[i].meaning!
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
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Kanji preview
                        GestureDetector(
                          // on tap copy to clipboard and show snakbar
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: widget.kanjidic2entry.literal)
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text("copied " + widget.kanjidic2entry.literal + " to clipboard"),
                              )
                            );
                          },
                          child: KanjiVGWidget(
                            widget.kanjiVG.svg,
                            constrains.maxWidth * 0.5,
                            constrains.maxWidth * 0.5,
                            colorize: true,
                          ),
                        ),
                        
                        const SizedBox(width: 8,),
                        Expanded(
                          child: LayoutGrid(
                            columnSizes: [auto, 1.fr, auto, 1.fr],
                            rowSizes: List.generate(7, (index) => auto),
                            children: [
                              Text("On: ", style: headerStyle),       SelectableText(onReadings.join(",  ")).withGridPlacement(columnSpan: 3),
                              Text("Kun: ", style: headerStyle),      SelectableText(kunReadings.join(",  ")).withGridPlacement(columnSpan: 3),
                              Text("Radicals: ", style: headerStyle), SelectableText("NONE").withGridPlacement(columnSpan: 3),
                              
                              SizedBox(height: 20,).withGridPlacement(columnSpan: 4),

                              Text("Strokes: ", style: headerStyle), Text("$strokeCount"),
                              Text("Grade: ", style: headerStyle),   Text("${widget.kanjidic2entry.grade}"),

                              Text("JLPT: ", style: headerStyle),    Text("N${widget.kanjidic2entry.jlpt}"),
                              Text("Heisig: ", style: headerStyle),  Text("NONE"),

                              Text("SKIP: ", style: headerStyle),    Text("NONE"),
                              Text("Freq.: ", style: headerStyle),   Text("${widget.kanjidic2entry.frequency}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // meanings / translations
                    const SizedBox(height: 16,),
                    ...meanings.entries.map((e) => 
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                            width: 10,
                            child: SvgPicture.asset(
                              GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[e.key]!
                            ),
                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            child: Text(
                              e.value.toString().replaceAll("[", "").replaceAll("]", "")
                            ),
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
                // more menu, to open this kanji in different web pages
                  Positioned(
                    right: 0,
                    top: 0,
                    child: PopupMenuButton(
                      splashRadius: 25,
                      icon: const Icon(Icons.more_vert),
                      onSelected: (String selection) {
                        // Kanji Graph
                        if(selection == menuItems[0]) {
                          launchUrlString("$g_theKanjiMapUrl${widget.kanjidic2entry.literal}");
                        }
                        // Kanji Map
                        if(selection == menuItems[1]) {
                          launchUrlString("$g_japaneseGraphUrl${widget.kanjidic2entry.literal}");
                        }
                      },
                      itemBuilder: (context) => List.generate(
                        menuItems.length,
                        (index) => 
                          PopupMenuItem(
                            value: menuItems[index],
                            child: Text(menuItems[index])
                          )
                      ),
                    )
                  ),
              ],
            ),
          );
        }
      )
    );
  }
}