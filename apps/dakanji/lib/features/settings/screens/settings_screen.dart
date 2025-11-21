// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/features/settings/widgets/anki_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/clipboard_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/dictionary_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/dojg_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/drawing_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/kana_table_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/kanji_table_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/misc_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/ocr_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/text_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/immersion_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/webbrowser_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/word_lists_settings.dart';
import 'package:da_kanji_mobile/features/settings/widgets/youtube_settings.dart';

// Package imports:


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
        child: SingleChildScrollView(
          controller: scrollController,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                
                DrawingSettings(),
                DictionarySettings(),

                if(kDebugMode)
                  ImmersionSettings(),
                if(kDebugMode)
                  WebbrowserSettings(),
                if(kDebugMode)
                  YoutubeSettings(),
                if(kDebugMode)
                  OcrSettings(),

                TextSettings(),
                DoJGSettings(),
                KanjiTableSettings(),
                KanaTableSettings(),
                WordListSettings(),     
                AnkiSettings(),
                ClipboardSettings(),
                MiscSettings(),
                
              ],
            ),
          ),
        )
            
      )
    );
  }
}


