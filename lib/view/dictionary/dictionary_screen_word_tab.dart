import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as _jmdict;

import 'package:da_kanji_mobile/globals.dart';



class DictionaryScreenWordTab extends StatefulWidget {
  const DictionaryScreenWordTab(
    this.entry,
    {Key? key}
  ) : super(key: key);

  /// the dict entry that should be shown 
  final _jmdict.Entry? entry;


  @override
  State<DictionaryScreenWordTab> createState() => _DictionaryScreenWordTabState();
}

class _DictionaryScreenWordTabState extends State<DictionaryScreenWordTab> {

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

  late final List<String> conjugationTitles;

  late final List<String> conjugationExplanationsPositive;

  late final List<String> conjugationExplanationsNegative;
  

  @override
  void initState() {

    conjugationTitles = [
      "Present, (Future)",
      "Past",
      "て-form, Continuative",
      "Progressive",
      "Volitional",
      "Imperative",
      "Request",
      "Provisional",
      "Conditional",
      "Potential",
      "Passive, Respectful",
      "Causative",
      "Causative passive"
    ];

    conjugationExplanationsPositive = [
      "[does]",
      "[did]",
      "",
      "[doing], to be [doing]",
      "let's [do]!, I/we will [do], I/we intend to [do]",
      "[do] !",
      "please [do]",
      "if X [does], if X [is ~]",
      "if X were to [do], when X [does]",
      "be able to [do], can [do]",
      "is [done] (by ...), will be [done] (by ...)",
      "makes/will make (someone) [do]\nlets/will let (someone) [do]",
      "is made/will be made to [do] (by someone)"
    ];

    conjugationExplanationsNegative = [
      "will [do]",
      "didn't [do]",
      "",
      "not [doing]",
      "I will not [do], I do not intend to [do]",
      "don't [do] !",
      "please don't [do]",
      "if X doesn't [do], if X [is not ~]",
      "if X weren't to [do], when X doesn't [do]",
      "not be able to [do], can't [do]",
      "isn't [done] (by ...), will not be [done] (by ...)",
      "doesn't / won't make / let (someone) [do]",
      "isn't made / won't be made to [do] (by someone)"
    ];

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
                            children: [
                              Row(
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
                            ],
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
                          // create the children in the same order as in the settings
                          children: GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((lang) {
                            
                            // 
                            List<LanguageMeanings> meanings = widget.entry!.meanings.where(
                              (element) => element.language == lang
                            ).toList();
                            
                            if(meanings.isNotEmpty){
                              LanguageMeanings meaning = meanings.first;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20,),
                                  SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: SvgPicture.asset(
                                      GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[lang]!
                                    ),
                                  ),
                                  ...List.generate(
                                    meaning.meanings.length,
                                    (int j) => Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${(j+1).toString()}. ",
                                          style: meaningsStyle
                                        ),
                                        Expanded(
                                          child: SelectableText(
                                            meaning.meanings[j],
                                            style: meaningsStyle
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                                ]
                              );
                            }
                            else{
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10, width: double.infinity,),
                                  SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: SvgPicture.asset(
                                      GetIt.I<Settings>().dictionary.translationLanguagesToSvgPath[lang]!
                                    ),
                                  ),
                                ],
                              );
                            }
                          }).toList()
                          
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (Platform.isAndroid || Platform.isIOS) 
                          ExpansionTile(
                            title: const Text("Images"),
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: WebView(
                                  gestureRecognizers: gestureRecognizers,
                                  initialUrl: "$g_GoogleImgSearchUrl${widget.entry!.kanjis[0]} ${widget.entry!.readings[0]}",
                                  
                                ),
                              )
                            ],
                          ),
                        if (widget.entry!.partOfSpeech.any((element) => element.contains("verb")))
                          ExpansionTile(
                            childrenPadding: EdgeInsets.all(16),
                            title: const Text("Conjugation"),
                            children: List.generate(conjugationTitles.length, (i) =>
                              [
                                // Grammar "name"
                                SelectableText(
                                  conjugationTitles[i],
                                  style: TextStyle(fontSize: 20),
                                ),
                                // Grammar "explanation"
                                if(conjugationExplanationsNegative[i] != "")
                                  SelectableText(
                                    conjugationExplanationsNegative[i],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    // positive conjugations
                                    Expanded(
                                      child: Center(
                                        child: SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              // normal form
                                              TextSpan(
                                                text: widget.entry!.kanjis[0],
                                                style: TextStyle(
                                                  fontSize: 20
                                                ),
                                              ),
                                              // polite form
                                              TextSpan(
                                                text: "、 " + widget.entry!.kanjis[0],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey
                                                ),
                                              ),
                                            ]
                                          )
                                        )
                                      )
                                    ),
                                    // negative conjugations
                                    Expanded(
                                      child: Center(
                                        child: SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              // normal form
                                              TextSpan(
                                                text: widget.entry!.kanjis[0],
                                                style: TextStyle(
                                                  fontSize: 20
                                                ),
                                              ),
                                              // polite form
                                              TextSpan(
                                                text: "、 " + widget.entry!.kanjis[0],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey
                                                ),
                                              ),
                                            ]
                                          )
                                        )
                                      )
                                    ),
                                  ],
                                ),
                              ]
                            ).expand((i) => i).toList()
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
                          launchUrlString("$g_WikipediaEnUrl${widget.entry!.meanings[0].meanings[0]}");
                        }
                        if(selection == menuItems[2]) {
                          launchUrlString("$g_DbpediaUrl${widget.entry!.meanings[0].meanings[0]}");
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
