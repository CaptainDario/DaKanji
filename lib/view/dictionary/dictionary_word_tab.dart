
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/helper/conjugation/conjos.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/helper/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/view/dictionary/conjugation_expansion_tile.dart';
import 'package:da_kanji_mobile/view/dictionary/word_meanings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:da_kanji_mobile/provider/isars.dart';



class DictionaryWordTab extends StatefulWidget {
  const DictionaryWordTab(
    this.entry,
    {Key? key}
  ) : super(key: key);

  /// the dict entry that should be shown 
  final JMdict? entry;


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
    
  );

  /// the menu elements of the more-popup-menu
  List<String> menuItems = [
    "Wikipedia (JP)", "Wikipedia (EN)", "DBPedia", "Wiktionary", "Massif", "Forvo"
  ];

  /// Gesture recognizers for the webview to be scrollable
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  /// either `widget.entry.kanji[0]` if not null, otherwise `widget.entry.readings[0]`
  String? readingOrKanji;
  /// The pos that should be used for conjugating this word
  List<Pos>? conjugationPos;


  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryWordTab oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  /// parses and initializes all data elements of this widget
  void initData(){
    if(widget.entry != null){
      readingOrKanji = widget.entry!.kanjis.isEmpty
        ? widget.entry!.readings[0]
        : widget.entry!.kanjis[0];

      // get the pos for conjugating this word
      conjugationPos = widget.entry!.partOfSpeech
        .map((e) => posDescriptionToPosEnum[e]!)
        .where((e) => posUsed.contains(e))
        .toList();
    }
  }

  @override
  Widget build(BuildContext context) {

    if(partOfSpeechStyle == null)
      partOfSpeechStyle = TextStyle(fontSize: 12, color: Theme.of(context).hintColor);

    return widget.entry == null
      ? Container()
      : Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
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
                                          // TODO: pitch accent - @ DaKanji v3.4
                                          /*
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                          )
                                          */
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
                          // field
                          if(widget.entry!.field.length > 0)
                            Text(
                              "Field: ${widget.entry!.field.join(", ")}",
                              style: partOfSpeechStyle,
                            ),
                          // dialects
                          if(widget.entry!.dialect.length > 0)
                            Text(
                              "Dialect: ${widget.entry!.dialect.join(", ")}",
                              style: partOfSpeechStyle
                            ),
                          // xref
                          if(widget.entry!.xref.length > 0)
                            Text.rich(
                              TextSpan(
                                text: "See also: ",
                                children: GetIt.I<Isars>().dictionary.jmdict
                                  .getAllSync(widget.entry!.xref)
                                .map((e) => TextSpan(
                                    text: (e!.kanjis.length > 0 ? e.kanjis.first : e.readings.first) + "、",
                                    mouseCursor: SystemMouseCursors.click,
                                    recognizer: TapGestureRecognizer()..onTap = 
                                      () => Navigator.pushNamedAndRemoveUntil(
                                        context, 
                                        "/dictionary",
                                        (route) => true,
                                        arguments: NavigationArguments(
                                          false,
                                          e.kanjis.length > 0
                                          ? e.kanjis.first
                                          : e.readings.first
                                        )
                                      ),
                                  )
                                ).toList()
                              ),
                              style: partOfSpeechStyle,
                            ),
                          // rinf
                          if(widget.entry!.re_inf.length > 0)
                            Text(
                              "Reading: ${widget.entry!.re_inf.join(", ")}",
                              style: partOfSpeechStyle,
                            ),
                          const SizedBox(
                            height: 30,
                          ),
                          // meanings
                          WordMeanings(
                            entry: widget.entry!, 
                            meaningsStyle: meaningsStyle
                          ),
                          if(g_webViewSupported) 
                            ExpansionTile(
                              title: Text(LocaleKeys.DictionaryScreen_word_images.tr()),
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: InAppWebView(
                                    gestureRecognizers: 
                                      Set()..add(
                                        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                                      ),
                                    initialUrlRequest: URLRequest(
                                      url: WebUri("$g_GoogleImgSearchUrl${readingOrKanji}")
                                    )
                                  )
                                )
                              ],
                            ),
                          if(conjugationPos != null && !conjugationPos!.isEmpty)
                            ConjugationExpansionTile(
                              word: readingOrKanji!,
                              pos: conjugationPos!,
                            ),
                            
                          //TODO - add proverbs @ DaKanji v3.4
                          if(!kReleaseMode)
                            ExpansionTile(
                              title: Text(LocaleKeys.DictionaryScreen_word_proverbs.tr()),
                              children: [
                                Text("This could be done by using kotowaza?")
                              ],
                            ),
                          //TODO - add synonyms @ DaKanji v3.4
                          if(!kReleaseMode)
                            ExpansionTile(
                              title: Text(LocaleKeys.DictionaryScreen_word_synonyms.tr()),
                              children: [
                                Text("This could be done by using wordnet jp?")
                              ],
                            ),
                          //TODO - add antonyms @ DaKanji v3.4
                          if(!kReleaseMode)
                            ExpansionTile(
                              title: Text(LocaleKeys.DictionaryScreen_word_antonyms.tr()),
                              children: [
                                Text("This could be done by using NANI??")
                              ],
                            ),
                        ],
                      ),
                      // more menu, to open this word in different web pages
                      Positioned(
                        right: 0,
                        top: 0,
                        child: PopupMenuButton(
                          splashRadius: 25,
                          icon: const Icon(Icons.more_vert),
                          onSelected: (String selection) {
                            // Wiki
                            if(selection == menuItems[0]) {
                              launchUrlString(Uri.encodeFull("$g_WikipediaJpUrl${readingOrKanji}"));
                            }
                            else if(selection == menuItems[1]) {
                              launchUrlString(Uri.encodeFull("$g_WikipediaEnUrl${readingOrKanji}"));
                            }
                            else if(selection == menuItems[2]) {
                              launchUrlString(Uri.encodeFull("$g_DbpediaUrl${readingOrKanji}"));
                            }
                            else if(selection == menuItems[3]) {
                              launchUrlString(Uri.encodeFull("$g_WiktionaryUrl${readingOrKanji}"));
                            }
                            else if(selection == menuItems[4]) {
                              launchUrlString(Uri.encodeFull("$g_Massif${readingOrKanji}"));
                            }
                            else if(selection == menuItems[5]) {
                              launchUrlString(Uri.encodeFull("$g_forvo${readingOrKanji}"));
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
                )
              ),
            ],
          ),
        ),
      );
  }
}
