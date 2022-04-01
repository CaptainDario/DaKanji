import 'package:flutter/material.dart';

import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/view/drawer/DaKanjiDrawer.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileHeader.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileInvertPress.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileWebview.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileAdvancedSettings.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileCustomURL.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileLanguage.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileReshowTutorial.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileTheme.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileDoubleTap.dart';
import 'package:da_kanji_mobile/view/settings/SettingsTileDictionaryOptions.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// The "settings"-screen.
/// 
/// Here all settings of the app can be managed.
class SettingsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  SettingsScreen(this.openedByDrawer);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.settings,
        animationAtStart: !widget.openedByDrawer,
        // ListView of all available settings
        child: ChangeNotifierProvider.value(
          value: GetIt.I<Settings>(),
          child: Consumer<Settings>(
            builder: (context, settings, child){
              return ListView(
                primary: false,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // Drawing header
                  SettingsTileHeader(LocaleKeys.SettingsScreen_drawing_title.tr()),
                  SettingsTileDictionaryOptions(),
                  SettingsTileCustomURL(),
                  
                  // invert if short press or long press opens dict / copies to clip
                  SettingsTileInvertPress(),
                  // should a double tap on a prediction button empty the canvas
                  SettingsTileDoubleTap(),
                  if(Platform.isAndroid || Platform.isIOS)
                    SettingsTileWebview(),

                  Divider(),
                  // miscellaneous header
                  SettingsTileHeader(LocaleKeys.SettingsScreen_miscellaneous_title.tr()),
                  SettingsTileTheme(),
                  SettingsTileLanguage(),
                  SettingsTileReshowTutorial(),

                  SettingsTileAdvancedSettings(),
                ],
              );
            },
          ),
        )
      )
    );
  }
}


