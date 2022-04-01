import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';



class SettingsTileDoubleTap extends StatelessWidget {
  const SettingsTileDoubleTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return CheckboxListTile(
          title: Text(LocaleKeys.SettingsScreen_empty_canvas_after_double_tap.tr()),
          value: settings.emptyCanvasAfterDoubleTap, 
          onChanged: (bool? newValue){
            settings.emptyCanvasAfterDoubleTap = newValue ?? false;
            settings.save();
          }
        );
      }
    );
  }
}