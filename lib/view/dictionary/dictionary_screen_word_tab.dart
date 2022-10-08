import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as Jmdict;

import 'package:da_kanji_mobile/globals.dart';



class DictionaryScreenWordTab extends StatefulWidget {
  const DictionaryScreenWordTab(
    this.entry,
    {Key? key}
  ) : super(key: key);

  /// the dict entry that should be shown 
  final Jmdict.Entry? entry;


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
  TextStyle partOfSpeechStyle = const TextStyle(
    fontSize: 12,
    color: Colors.blueGrey
  );

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
  Widget build(BuildContext context) {

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
                        // word
                        SelectableText(
                          widget.entry!.kanjis.isNotEmpty ?
                            widget.entry!.kanjis[0] : "",
                          style: kanjiStyle
                        ),
                        // word reading
                        Row(
                          children: 
                          [
                            ...List.generate(
                              widget.entry!.readings.length,
                              (index_1) => SelectionArea(
                                child: Row(
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
                                          widget.entry!.readings[index_1][index_2],
                                          style: readingStyle
                                        ),
                                      ),
                                    ),
                                    SelectionContainer.disabled(
                                      child: Text(
                                        ", ",
                                        style: readingStyle,
                                      ),
                                    )
                                  ]
                                ),
                              )
                            )
                          ],
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
                        // meaning 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              widget.entry!.meanings[0].meanings.length,
                              (int index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${(index+1).toString()}. ",
                                    style: meaningsStyle
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      widget.entry!.meanings[0].meanings[index],
                                      style: meaningsStyle
                                    ),
                                  ),
                                ],
                              )
                            )
                          ],
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
                                  initialUrl: "$globalGoogleImgSearchUrl${widget.entry!.kanjis[0]} ${widget.entry!.readings[0]}",
                                  
                                ),
                              )
                            ],
                          ),
                        //},
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
                          launchUrlString("$globalWikipediaJpUrl${widget.entry!.kanjis[0]}");
                        }
                        if(selection == menuItems[1]) {
                          launchUrlString("$globalWikipediaEnUrl${widget.entry!.meanings[0].meanings[0]}");
                        }
                        if(selection == menuItems[2]) {
                          launchUrlString("$globalDbpediaUrl${widget.entry!.meanings[0].meanings[0]}");
                        }
                        if(selection == menuItems[3]) {
                          launchUrlString("$globalWiktionaryUrl${widget.entry!.kanjis[0]}");
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
