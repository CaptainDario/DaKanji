import 'package:da_kanji_mobile/helper/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/view/dictionary/conjugation_expansion_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;
import 'package:easy_web_view/easy_web_view.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';



class DictionaryWordTab extends StatefulWidget {
  const DictionaryWordTab(
    this.entry,
    {Key? key}
  ) : super(key: key);

  /// the dict entry that should be shown 
  final isar_jm.Entry? entry;


  @override
  State<DictionaryWordTab> createState() => _DictionaryWordTabState();
}

class _DictionaryWordTabState extends State<DictionaryWordTab> {

  /// the text style to use for all words
  TextStyle kanjiStyle = const TextStyle(
    fontSize: 30
  );

  /// the text style to use for all readings
  TextStyle readingStyle = const TextStyle(
    fontSize: 20
  );

  /// the text style to use for all partOfSpeech elements
  TextStyle? partOfSpeechStyle;

  /// the text style to use for all meaning elements
  TextStyle meaningsStyle = const TextStyle(
    fontSize: 20
  );

  /// the menu elements of the more-popup-menu
  List<String> menuItems = [
    "Wikipedia (JP)", "Wikipedia (EN)", "DBPedia", "Wiktionary"
  ];

  /// Gesture recognizers for the webview to be scrollable
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if(partOfSpeechStyle == null){
      partOfSpeechStyle = TextStyle(
        fontSize: 12,
        color: Theme.of(context).hintColor
      );
    }

    if(widget.entry == null){
      return Container();
    }
    else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // word written with kanji
                        SelectionArea(
                          child: Wrap(
                            children: [
                              ...List.generate(widget.entry!.kanjis.length, (i) =>
                                Text(
                                  widget.entry!.kanjis[i] +
                                  (widget.entry!.kanjis.length-1 != i ? "、" : ""),
                                  style: kanjiStyle
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Readings
                        SelectionArea(
                          child: Wrap(
                            children: List.generate( (widget.entry!.readings.length),
                              // Characters of word reading with  pitch accent
                              (index_1) => Row(
                                children:
                                [
                                  ...List.generate(
                                    widget.entry!.readings[index_1].length,
                                    (index_2) => Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        )
                                      ),
                                      child: Text (
                                        widget.entry!.readings[index_1][index_2] +
                                        (widget.entry!.readings[index_1].length-1 == index_2 ? "、" : ""),
                                        style: readingStyle
                                      ),
                                    ),
                                  ),
                                ]
                              )
                            ),
                          ),
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                        // part of speech
                        ...List.generate(widget.entry!.partOfSpeech.length, (index) =>
                          Text(
                            widget.entry!.partOfSpeech[index],
                            style: partOfSpeechStyle,
                          )
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // meanings
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // create the children in the same order as in the settings
                          children: GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((lang) {
                            
                            List<Widget> ret = [];

                            // get the meaning of the selected language
                            List<isar_jm.LanguageMeanings> meanings = widget.entry!.meanings.where(
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
                                LayoutGrid(
                                  gridFit: GridFit.loose,
                                  columnSizes: [auto, 0.425.fr, auto, 0.425.fr],
                                  rowSizes: List.generate(
                                    meanings.first.meanings!.length, 
                                    (index) => auto
                                  ),
                                  children: List.generate(
                                    meanings.first.meanings!.length,
                                    (int j) => [
                                      Text(
                                        "${(j+1).toString()}. ",
                                        style: meaningsStyle
                                      ),
                                      SelectableText(
                                        meanings.first.meanings![j],
                                        style: meaningsStyle
                                      )
                                    ],
                                  ).expand((e) => e).toList()
                                )
                              );

                              ret.add(SizedBox(height: 10,));
                                  
                            }

                            return ret;
                          }).expand((element) => element).toList(),
                          
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if(g_webViewSupported) 
                          ExpansionTile(
                            title: const Text("Images"),
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: EasyWebView(
                                    src: Uri.encodeFull("$g_GoogleImgSearchUrl${widget.entry!.kanjis[0]}")
                                  )
                              )
                            ],
                          ),
                        if (posDescriptionToPosEnum[widget.entry!.partOfSpeech[0]] != null &&
                          widget.entry!.partOfSpeech[0].contains(" verb"))
                          ConjugationExpansionTile(
                            word: widget.entry!.kanjis.isEmpty
                              ? widget.entry!.readings[0]
                              : widget.entry!.kanjis[0],
                            pos: posDescriptionToPosEnum[widget.entry!.partOfSpeech[0]]!,
                            conjugationTileType: ConjugationTileType.verb,
                          ),
                        if (posDescriptionToPosEnum[widget.entry!.partOfSpeech[0]] != null &&
                          widget.entry!.partOfSpeech[0].contains("adjective"))
                          ConjugationExpansionTile(
                            word: widget.entry!.kanjis.isEmpty
                              ? widget.entry!.readings[0]
                              : widget.entry!.kanjis[0],
                            pos: posDescriptionToPosEnum[widget.entry!.partOfSpeech[0]]!,
                            conjugationTileType: ConjugationTileType.adjective,
                          ),
                          
                        const ExpansionTile(
                          title: Text("Proverbs"),
                          children: [
                            Text("This could be done by using kotowaza?")
                          ],
                        ),
                        const ExpansionTile(
                          title: Text("Synonyms"),
                          children: [
                            Text("This could be done by using wordnet jp?")
                          ],
                        )
                      ],
                    ),
                  ),
                  // more menu, to open this word in different web pages
                  Positioned(
                    right: 0,
                    top: 0,
                    child: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (String selection) {
                        // Wiki
                        if(selection == menuItems[0]) {
                          launchUrlString("$g_WikipediaJpUrl${widget.entry!.kanjis[0]}");
                        }
                        if(selection == menuItems[1]) {
                          launchUrlString("$g_WikipediaEnUrl${widget.entry!.meanings[0]}");
                        }
                        if(selection == menuItems[2]) {
                          launchUrlString("$g_DbpediaUrl${widget.entry!.meanings[0]}");
                        }
                        if(selection == menuItems[3]) {
                          launchUrlString("$g_WiktionaryUrl${widget.entry!.kanjis[0]}");
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
              )
            ),
          ],
        ),
      );
    }
  }
}
