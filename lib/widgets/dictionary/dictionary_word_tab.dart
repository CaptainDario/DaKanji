// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:da_kanji_mobile/application/assets/assets.dart';
import 'package:da_kanji_mobile/data/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/anki/anki_dialog.dart';
import 'package:da_kanji_mobile/widgets/dictionary/conjugation_expansion_tile.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab_kanji.dart';
import 'package:da_kanji_mobile/widgets/dictionary/word_meanings.dart';
import 'package:da_kanji_mobile/widgets/downloads/download_popup.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';
import 'package:da_kanji_mobile/widgets/word_lists/add_to_word_list_dialog.dart';

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
    "Wikipedia (JP)", "Wikipedia (EN)", "Wiktionary", "Massif", "Forvo",
    "share",
    // TODO v word lists - reenable
    //LocaleKeys.DictionaryScreen_word_tab_menu_add_to_list.tr(),
    //LocaleKeys.DictionaryScreen_word_tab_menu_send_to_anki.tr(),
  ];

  /// Gesture recognizers for the webview to be scrollable
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  /// either `widget.entry.kanji[0]` if not null, otherwise `widget.entry.readings[0]`
  String? readingOrKanji;
  /// The pos that should be used for conjugating this word
  List<Pos>? conjugationPos;
  /// the directory in which the audio files are stored
  late Directory audioFilesDir;
  /// Playback of audio files
  final Player player = Player();


  @override
  void initState() {
    initData();
    initDataAsync();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryWordTab oldWidget) {
    initData();
    initDataAsync();
    super.didUpdateWidget(oldWidget);
  }

  /// parses and initializes all data elements of this widget
  void initData() {

    if(widget.entry != null){
      readingOrKanji = widget.entry!.kanjis.isEmpty
        ? widget.entry!.readings[0]
        : widget.entry!.kanjis[0];

      // get the pos for conjugating this word
      conjugationPos = widget.entry!.meanings.map((e) => e.partOfSpeech)
        .whereNotNull().expand((e) => e)
        .whereNotNull().expand((e) => e.attributes)
        .whereNotNull().map((e) => posDescriptionToPosEnum[e]!)
        .toSet().toList();
    }
  }

  void initDataAsync() async {
    audioFilesDir = Directory(p.join(g_documentsDirectory.path, "DaKanji", "audios"));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.entry == null) {
      return Container();
    }

    partOfSpeechStyle ??= TextStyle(fontSize: 12, color: Theme.of(context).hintColor);

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
                          height: 5,
                        ),

                        // JLPT
                        if(widget.entry!.jlptLevel != null && widget.entry!.jlptLevel!.isNotEmpty)
                          ...[
                            Text(
                              widget.entry!.jlptLevel!.join(", "),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                              ),
                            ),
                          
                            const SizedBox(
                              height: 5,
                            ),
                          ],

                        // meanings
                        WordMeanings(
                          entry: widget.entry!, 
                          meaningsStyle: meaningsStyle,
                        ),

                        if(g_webViewSupported)
                          ExpansionTile(
                            title: Text(LocaleKeys.DictionaryScreen_word_images.tr()),
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: WebViewWidget(
                                  controller: WebViewController()
                                    ..loadRequest(Uri.parse("$g_GoogleImgSearchUrl${readingOrKanji}")),
                                    gestureRecognizers: {
                                      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                                    },
                                )
                              )
                            ],
                          ),
                        if(conjugationPos != null && conjugationPos!.isNotEmpty)
                          ConjugationExpansionTile(
                            word: readingOrKanji!,
                            pos: conjugationPos!,
                          ),
                      ],
                    ),
                    if(widget.entry!.audio != null)
                      Positioned(
                        top: 0,
                        right: 40,
                        child: IconButton(
                          splashRadius: 25,
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () async {
                            if(!audioFilesDir.existsSync()) {
                              downloadAudio();
                            }

                            player.open(Media('file:///${audioFilesDir.path}/${widget.entry!.audio}.mp3'));
                            player.play();
                          },
                        )
                      ),
                    // more menu, to open this word in different web pages
                    Positioned(
                      right: 0,
                      top: 0,
                      child: PopupMenuButton(
                        splashRadius: 25,
                        icon: const Icon(Icons.more_vert),
                        onSelected: (String selection) async {
                          String url = "";
                          // Wiki
                          if(selection == menuItems[0]) {
                            url = Uri.encodeFull("$g_WikipediaJpUrl$readingOrKanji");
                          }
                          else if(selection == menuItems[1]) {
                            url = Uri.encodeFull("$g_WikipediaEnUrl${widget.entry!.meanings.firstWhere((e) => e.language == "eng").meanings[0].attributes[0]}");
                          }
                          else if(selection == menuItems[2]) {
                            url = Uri.encodeFull("$g_WiktionaryUrl$readingOrKanji");
                          }
                          else if(selection == menuItems[3]) {
                            url = Uri.encodeFull("$g_Massif$readingOrKanji");
                          }
                          else if(selection == menuItems[4]) {
                            url = Uri.encodeFull("$g_forvo$readingOrKanji");
                          }
                          // add to word list
                          else if(selection == menuItems[5]) {
                            await addToWordListDialog(context, widget).show();
                          }
                          else if(selection == menuItems[6]){
                            await ankiDialog(context).show();
                          }

                          if(url != "") {
                            launchUrlString(
                              url,
                              mode: g_webViewSupported ? LaunchMode.inAppWebView : LaunchMode.platformDefault,
                            );
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

  /// Download the audio files from the github release
  void downloadAudio(){

    downloadPopup(
      context: context,
      dismissable: true,
      btnOkOnPress: () async {
        downloadAssetFromGithubRelease(
          File(p.join(g_documentsDirectory.path, "DaKanji", "audios")),
          g_GithubApiDependenciesRelase,
        ).then((value) {
          Navigator.of(context).pop();
        });
        AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          dismissOnTouchOutside: false,
          customHeader: Image.asset("assets/images/dakanji/icon.png"),
          dialogType: DialogType.noHeader,
          body: StreamBuilder(
            stream: g_downloadFromGHStream.stream,
            builder: (context, snapshot) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const DaKanjiLoadingIndicator(),
                      const SizedBox(height: 8,),
                      Text(
                        snapshot.data ?? ""
                      ),
                    ],
                  ),
                ),
              );
            }
          )
        ).show();
      }
    ).show();

  }
}
