// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:da_kanji_mobile/application/screenshots/dictionary_word_card.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:media_kit/media_kit.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/application/assets/assets.dart';
import 'package:da_kanji_mobile/entities/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/anki/anki_dialog.dart';
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


  /// the menu elements of the more-popup-menu
  List<String> menuItems = [
    "Wikipedia (JP)", "Wikipedia (EN)", "Wiktionary", "Massif", "Forvo",
    LocaleKeys.DictionaryScreen_word_tab_menu_share.tr(),
    LocaleKeys.DictionaryScreen_word_tab_menu_share_as_image.tr(),
    LocaleKeys.DictionaryScreen_word_tab_menu_add_to_list.tr(),
    LocaleKeys.DictionaryScreen_word_tab_menu_send_to_anki.tr(),
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
  /// Is currently the google image search expanded
  bool googleImagesIsExpanded = false;
  /// Is the conjugation table currently expanded
  bool conjugationsIsExpanded = false;
  /// ScreenshotController to take images of the word card
  final ScreenshotController cardScreenShotController = ScreenshotController();



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
    audioFilesDir = g_DakanjiPathManager.audiosDirectory;
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

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Screenshot(
                    controller: cardScreenShotController,
                    child: DictionaryWordCard(
                      widget.entry,
                      onConjugationTableExpansionChanged: (state) {
                        conjugationsIsExpanded = state;
                      },
                      onGooglSearchExpansionChanged: (state) {
                        googleImagesIsExpanded = state;
                      },
                    ),
                  ),
                  // audio play button
                  if(widget.entry!.audio != null)
                    Positioned(
                      top: 8,
                      right: 48,
                      child: IconButton(
                        splashRadius: 25,
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () async {
                          if(!audioFilesDir.existsSync()) {
                            downloadAudio(context);
                          }
                        
                          player.open(Media('file:///${audioFilesDir.path}/${widget.entry!.audio}.mp3'));
                          player.play();
                        },
                      )
                    ),
                  // more menu, to open this word in different web pages
                  Positioned(
                    right: 8,
                    top: 8,
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
                        // send dakanji link
                        else if(selection == menuItems[5]){
                          await Share.share("${GetIt.I<Settings>().misc.sharingScheme}dictionary?id=${widget.entry!.id}");
                        }
                        // send dakanji link and image
                        else if(selection == menuItems[6]){
                          await sendWordCard();
                        }
                        // add to word list
                        else if(selection == menuItems[7]) {
                          await addToWordListDialog(context, widget).show();
                        }
                        else if(selection == menuItems[8]){
                          await ankiDialog(context, widget.entry!).show();
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
            ),
          ],
        ),
      ),
    );
  }

  /// Takes a screenshot of the current word card and opens the share dialog with it
  Future<void> sendWordCard () async {

    File f = await screenshotDictionaryWordCard(
      widget.entry!,
      "${readingOrKanji}_${conjugationsIsExpanded ? "_conj" : ""}.png",
      conjugationsIsExpanded);

    Share.shareXFiles(
      [XFile(f.path)],
      text: "${GetIt.I<Settings>().misc.sharingScheme}dictionary?id=${widget.entry!.id}"
    );
    
  }


}
