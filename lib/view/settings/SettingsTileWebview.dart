import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';



class SettingsTileWebview extends StatelessWidget {
  const SettingsTileWebview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return CheckboxListTile(
          title: Text(LocaleKeys.SettingsScreen_use_default_browser_for_online_dictionaries.tr()),
          value: settings.useWebview,
          onChanged: (bool? newValue){
            settings.useWebview = newValue ?? false;
            settings.save();
          }
        );
      }
    );
  }
}