// Flutter imports:
import 'package:da_kanji_mobile/widgets/settings/ocr_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/reading_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/video_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/webbrowser_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/youtube_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/settings/anki_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/clipboard_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/dictionary_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/dojg_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/drawing_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/kana_table_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/kanji_table_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/misc_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/text_settings.dart';
import 'package:da_kanji_mobile/widgets/settings/word_lists_settings.dart';

/// The "settings"-screen.
/// 
/// Here all settings of the app can be managed.
class SettingsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  const SettingsScreen(
    this.openedByDrawer,
    {
      super.key
    }
  );

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {

  /// The scroll controller for the list of settings
  late ScrollController scrollController;



  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.settings,
        drawerClosed: !widget.openedByDrawer,
        // ListView of all available settings
        child: ChangeNotifierProvider.value(
          value: GetIt.I<Settings>(),
          child: Consumer<Settings>(
            builder: (context, settings, child) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      
                      DrawingSettings(settings),
                      DictionarySettings(settings),

                      if(kDebugMode)
                        ReadingSettings(settings),
                      if(kDebugMode)
                        VideoSettings(settings),
                      if(kDebugMode)
                        WebbrowserSettings(settings),
                      if(kDebugMode)
                        YoutubeSettings(settings),
                      if(kDebugMode)
                        OcrSettings(settings),

                      TextSettings(settings),
                      DoJGSettings(settings),
                      KanjiTableSettings(settings),
                      KanaTableSettings(settings),
                      WordListSettings(settings),     
                      AnkiSettings(settings),
                      ClipboardSettings(settings),
                      MiscSettings(settings),
                      
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      )
    );
  }
}


