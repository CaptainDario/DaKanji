import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/application/radicals/radicals.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/widgets/dictionary/linked_kanji_text.dart';
import 'package:da_kanji_mobile/widgets/dictionary/kanji_vg_widget.dart';
import 'package:da_kanji_mobile/widgets/dictionary/kanji_group_widget.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/application/dictionary/kanji_vg_util.dart';



/// Card to show a kanji and all important attribtues of it. This includes
/// a tree to show the different groups.
class DictionaryScreenKanjiCard extends StatefulWidget {

  /// List of all kanjidict entries 
  final Kanjidic2 kanjidic2entry;
  /// String denoting the target language
  final List<String> targetLanguages;

  const DictionaryScreenKanjiCard(
    this.kanjidic2entry,
    this.targetLanguages,
    {
      Key? key
    }
  ) : super(key: key);


  @override
  State<DictionaryScreenKanjiCard> createState() => _DictionaryScreenKanjiCardState();
}

class _DictionaryScreenKanjiCardState extends State<DictionaryScreenKanjiCard> {

  /// The kanji that should be shown in this card as a svg string
  List<KanjiSVG> kanjiVGs = [];
  /// A list of radicals use in this kanji
  List<String> radicals = [];
  /// List containing all on readings of this kanji
  List<String> onReadings = [];
  /// List containing all kun readings of this kanji
  List<String> kunReadings = [];
  /// List containing all readings in the target language
  Map<String, List<String>> meanings = {};
  /// the menu elements of the more-popup-menu
  List<String> menuItems = ["Kanji Map", "Japanese Graph"];
  /// The textstyle used for the headers
  TextStyle headerStyle = const TextStyle(color: Colors.grey);
  /// Kanji groups Regex, extracts all tags that are kanji part tags
  RegExp kanjiGroupsRe = RegExp('<g id="kvg:(?!Stroke(Numbers|Paths)).*?>');

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didUpdateWidget(covariant DictionaryScreenKanjiCard oldWidget) {
    
    initData();
    super.didUpdateWidget(oldWidget);
  }

  /// parses and initializes all data elements of this widget
  void initData(){

    // find alternatives
    kanjiVGs = (findMatchingKanjiSVG([widget.kanjidic2entry.character])
      ..sort((a, b) => a.kanjiVGId.length.compareTo(b.kanjiVGId.length)));

    radicals = getRadicalsOf(widget.kanjidic2entry.character, GetIt.I<Isars>().krad.krads);

    // get on / kun / meanings
    onReadings = []; kunReadings = []; meanings = {};

    for (var i = 0; i < widget.kanjidic2entry.readings.length; i++) {
      // init on reading list
      if(widget.kanjidic2entry.readings[i].rType!.contains("ja_on")) {
        onReadings.add(widget.kanjidic2entry.readings[i].value!);
      }

      // init kun reading list
      if(widget.kanjidic2entry.readings[i].rType!.contains("ja_kun")) {
        kunReadings.add(widget.kanjidic2entry.readings[i].value!);
      }
    }

    for (var i = 0; i < widget.kanjidic2entry.meanings.length; i++) {
      // init meaning list with all meanings that match `targetLanguage`
      if(widget.targetLanguages.any(
        (l) => l.contains(widget.kanjidic2entry.meanings[i].language!)
      )) {
        if(!meanings.containsKey(widget.kanjidic2entry.meanings[i].language)) {
          meanings[widget.kanjidic2entry.meanings[i].language!] = [];
        }

        meanings[widget.kanjidic2entry.meanings[i].language]!.add(
          widget.kanjidic2entry.meanings[i].meaning!
        );
      }
    }
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
                              ClipboardData(text: widget.kanjidic2entry.character)
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  LocaleKeys.DictionaryScreen_kanji_copied.tr() +
                                  widget.kanjidic2entry.character,
                                )
                              )
                            );
                          },
                          child: SizedBox(
                            width: constrains.maxWidth * 0.5,
                            height: constrains.maxWidth * 0.5,
                            child: kanjiVGs.isNotEmpty
                              ? KanjiVGWidget(
                                kanjiVGs.first.svg,
                                constrains.maxWidth * 0.5,
                                constrains.maxWidth * 0.5,
                                colorize: true,
                              )
                              : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: Colors.grey.withOpacity(0.5))
                                ),
                                child: FittedBox(
                                  child: Text(
                                    widget.kanjidic2entry.character,
                                  ),
                                ),
                              ),
                          ),
                        ),
                        
                        const SizedBox(width: 8,),
                        
                        Expanded(
                          child: LayoutGrid(
                            columnSizes: [auto, 1.fr],
                            columnGap: 0.1,
                            rowSizes: List.generate(11, (index) => auto),
                            children: [
                              if(kanjiVGs.isNotEmpty)
                                ...[
                                  Text("${LocaleKeys.DictionaryScreen_kanji_radicals.tr()}: ", style: headerStyle,),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        for (String radical in radicals)
                                          ...[
                                            WidgetSpan(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Clipboard.setData(ClipboardData(text: radical));
                                                  ScaffoldMessenger.of(context).clearSnackBars();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "${LocaleKeys.DictionaryScreen_kanji_copied.tr()} $radical"
                                                      )
                                                    )
                                                  );
                                                },
                                                onDoubleTap: () async {
                                                  var data = (await Clipboard.getData("text/plain"));
                                                  String text = data == null ? "" : data.text!;
                                                  Clipboard.setData(ClipboardData(text: text+radical));
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context).clearSnackBars();
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "${LocaleKeys.DictionaryScreen_kanji_apended.tr()} $text$radical"
                                                      )
                                                    )
                                                  );
                                                },
                                                child: Text(radical),
                                              )
                                            ),
                                            if(radical != radicals.last)
                                              const TextSpan(
                                                text: ","
                                              )
                                          ]
                                      ]
                                    )
                                  )
                                ],

                              const SizedBox(height: 20,).withGridPlacement(columnSpan: 2),

                              Text("${LocaleKeys.DictionaryScreen_kanji_strokes.tr()}: ", style: headerStyle), Text("${widget.kanjidic2entry.strokeCount}"),

                              if(widget.kanjidic2entry.frequency != -1)
                                ...[
                                  Text("${LocaleKeys.DictionaryScreen_kanji_frequency.tr()}: ", style: headerStyle),
                                  Text("${widget.kanjidic2entry.frequency}"),
                                ],

                              if(widget.kanjidic2entry.grade != -1)
                                ...[
                                  Text("${LocaleKeys.DictionaryScreen_kanji_grade.tr()}: ", style: headerStyle), 
                                  Text("${widget.kanjidic2entry.grade}"),
                                ],

                              if(widget.kanjidic2entry.jlptNew != -1)
                                ...[
                                  Text("${LocaleKeys.DictionaryScreen_kanji_jlpt.tr()}: ", style: headerStyle),
                                  Text("N${widget.kanjidic2entry.jlptNew}"),
                                ],
                              if(widget.kanjidic2entry.kanken != -1)
                                ...[
                                  Text("漢検: ", style: headerStyle),
                                  Text("${widget.kanjidic2entry.kanken}"),
                                ],
                              if(widget.kanjidic2entry.wanikani != -1)
                                ...[
                                  Text("Wanikani: ", style: headerStyle),
                                  Text(widget.kanjidic2entry.wanikani.toString()),
                                ],
                              if(widget.kanjidic2entry.klc != -1)
                                ...[
                                  Text("KLC: ", style: headerStyle),
                                  Text(widget.kanjidic2entry.klc.toString()),
                                ],
                              if(widget.kanjidic2entry.rtkNew != -1)
                                ...[
                                  Text("RTK: ", style: headerStyle),
                                  Text(widget.kanjidic2entry.rtkNew.toString()),
                                ],
                              
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16,),

                    // On / Kun readings
                    LayoutGrid(
                      columnSizes: [auto, 1.fr],
                      rowSizes: List.generate(10, (index) => auto),
                      children: [
                        Text("${LocaleKeys.DictionaryScreen_kanji_on_reading.tr()}: ", style: headerStyle),
                        SelectableText(onReadings.join(",  ")),
                        Text("${LocaleKeys.DictionaryScreen_kanji_kun_reading.tr()}: ", style: headerStyle),
                        SelectableText(kunReadings.join(",  ")),

                        if(widget.kanjidic2entry.antonyms != null)
                          ...[
                            Text("${LocaleKeys.DictionaryScreen_word_antonyms.tr()}: ", style: headerStyle),
                            LinkedKanjiText(widget.kanjidic2entry.antonyms!)
                          ],
                        if(widget.kanjidic2entry.synonyms != null)
                          ...[
                            Text("${LocaleKeys.DictionaryScreen_word_synonyms.tr()}: ", style: headerStyle),
                            LinkedKanjiText(widget.kanjidic2entry.synonyms!)
                          ],
                        if(widget.kanjidic2entry.lookalikes != null)
                          ...[
                            Text("${LocaleKeys.DictionaryScreen_kanji_lookalikes.tr()}: ", style: headerStyle),
                            LinkedKanjiText(widget.kanjidic2entry.lookalikes!)
                          ],
                      ],
                    ),

                    const SizedBox(height: 16,),

                    // meanings / translations
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
                          const SizedBox(width: 10,),
                          Flexible(
                            child: Text(
                              e.value.toString().replaceAll("[", "").replaceAll("]", "")
                            ),
                          )
                        ],
                      ),
                    ).toList(),
                    const SizedBox(height: 16,),

                    // Kanji groups
                    if(kanjiVGs.isNotEmpty && (kanjiGroupsRe.allMatches(kanjiVGs.first.svg)).length > 1)
                      ExpansionTile(
                        title: Text(LocaleKeys.DictionaryScreen_kanji_groups.tr()),
                        children:
                        [
                          KanjiGroupWidget(
                            kanjiVGs.first.svg,
                            constrains.maxWidth - 16,
                            constrains.maxWidth - 16
                          ),
                        ]
                      ),
                    if(kanjiVGs.length > 1)
                      ExpansionTile(
                        title: Text(LocaleKeys.DictionaryScreen_kanji_alternatives.tr()),
                        children: [
                          Wrap(
                            children: kanjiVGs.sublist(1).map((alternative) => 
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: KanjiVGWidget(
                                  alternative.svg,
                                  constrains.maxWidth * 0.4,
                                  constrains.maxWidth * 0.4,
                                  colorize: true,
                                ),
                              ),
                            ).toList()
                          ),
                        ]
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
                      String url = "";
                      // japanese Graph
                      if(selection == menuItems[0]) {
                        url = Uri.encodeFull("$g_theKanjiMapUrl${widget.kanjidic2entry.character}");
                      }
                      // Kanji Map
                      else if(selection == menuItems[1]) {
                        url = Uri.encodeFull("$g_japaneseGraphUrl${widget.kanjidic2entry.character}");
                      }
                      launchUrlString(
                        url,
                        mode: g_webViewSupported ? LaunchMode.inAppWebView : LaunchMode.platformDefault,
                      );
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