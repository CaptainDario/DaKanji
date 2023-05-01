
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/data/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as WordListsUI;
import 'package:da_kanji_mobile/domain/word_lists/word_lists.dart';
import 'package:da_kanji_mobile/widgets/dictionary/conjugation_expansion_tile.dart';
import 'package:da_kanji_mobile/widgets/dictionary/word_meanings.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab_kanji.dart';



class DictionaryWordTab extends StatefulWidget {

  /// the dict entry that should be shown 
  final JMdict? entry;

  const DictionaryWordTab(
    this.entry,
    {
      Key? key
    }
  ) : super(key: key);


  @override
  State<DictionaryWordTab> createState() => _DictionaryWordTabState();
}

class _DictionaryWordTabState extends State<DictionaryWordTab> {

  /// the text style to use for all partOfSpeech elements
  TextStyle? partOfSpeechStyle;

  /// the text style to use for all meaning elements
  TextStyle meaningsStyle = const TextStyle(
    
  );

  /// the menu elements of the more-popup-menu
  List<String> menuItems = [
    "Wikipedia (JP)", "Wikipedia (EN)", "DBPedia", "Wiktionary", "Massif", "Forvo",
    "Add to List"
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
      conjugationPos = widget.entry!.meanings.map((e) => e.partOfSpeech)
        .whereNotNull().expand((e) => e)
        .whereNotNull().map((e) => e.split("⬜"))
        .flattened.map((e) => posDescriptionToPosEnum[e]!)
        .where((e) => posUsed.contains(e))
        .toSet().toList();
    }
  }

  @override
  Widget build(BuildContext context) {

    if(widget.entry == null)
      return Container();

    if(partOfSpeechStyle == null)
      partOfSpeechStyle = TextStyle(fontSize: 12, color: Theme.of(context).hintColor);

    return Align(
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
                        
                        DictionaryWordTabKanji(widget.entry!),

                        const SizedBox(
                          height: 10,
                        ),

                        // JLPT
                        if(widget.entry!.jlptLevel != null && widget.entry!.jlptLevel!.isNotEmpty)
                          Wrap(
                            children: [
                              for (var jlpt in widget.entry!.jlptLevel!.toSet())
                                Text(
                                  "$jlpt",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12
                                  ),
                                ),
                            ],
                          ),
                        
                        const SizedBox(
                          height: 30,
                        ),

                        // meanings
                        WordMeanings(
                          entry: widget.entry!, 
                          meaningsStyle: meaningsStyle,
                          includeWikipediaDefinition: widget.includeWikipediaDefinition,
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
                          // add to word list
                          else if(selection == menuItems[6]) {
                            AwesomeDialog(
                              context: context,
                              headerAnimationLoop: false,
                              useRootNavigator: false,
                              dialogType: DialogType.noHeader,
                              body: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: WordListsUI.WordLists(
                                  false,
                                  GetIt.I<WordLists>().root,
                                  showDefaults: false,
                                  onSelectionConfirmed: (selection) {
                                    
                                    selection.where(
                                      (sel) =>
                                        // assure this node is a word list
                                        wordListListypes.contains(sel.value.type) &&
                                        // assure that the word is not already in the list
                                        !sel.value.wordIds.contains(widget.entry!.id)
                                    ).forEach(
                                      (sel) => sel.value.wordIds.add(widget.entry!.id)
                                    );
                                    Navigator.of(context, rootNavigator: false).pop();
                                  },
                                ),
                              )
                            )..show();
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
