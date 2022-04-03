import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';



void showCustomURLPopup(BuildContext context){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.NO_HEADER,
    headerAnimationLoop: false,
    body: Column(
      children: [
        Text(
          LocaleKeys.SettingsScreen_custom_url_format.tr(),
          //textScaleFactor: 2,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                LocaleKeys.SettingsScreen_custom_url_explanation.tr(
                  namedArgs: {'kanjiPlaceholder' : 
                    GetIt.I<Settings>().kanjiPlaceholder}
                )
              ),
            ]
          )
        ),
      ],
    ),
  )..show();
}