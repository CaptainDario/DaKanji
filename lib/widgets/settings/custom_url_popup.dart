import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/provider/settings/settings_drawing.dart';
import 'package:da_kanji_mobile/locales_keys.dart';




void showCustomURLPopup(BuildContext context){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    headerAnimationLoop: false,
    body: Column(
      children: [
        Text(
          LocaleKeys.SettingsScreen_draw_custom_url_format.tr(),
          //textScaleFactor: 2,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                LocaleKeys.SettingsScreen_custom_url_explanation.tr(
                  namedArgs: {'kanjiPlaceholder' : 
                    SettingsDrawing.kanjiPlaceholder}
                )
              ),
            ]
          )
        ),
      ],
    ),
  ).show();
}