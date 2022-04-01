import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:provider/provider.dart';



class SettingsTileInvertPress extends StatelessWidget {
  const SettingsTileInvertPress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return CheckboxListTile(
          title: Text(LocaleKeys.SettingsScreen_invert_short_long_press.tr()),
          value: settings.invertShortLongPress, 
          onChanged: (bool? newValue){
            settings.invertShortLongPress = newValue ?? false;
            settings.save();
          }
        );
      }
    );
  }
}