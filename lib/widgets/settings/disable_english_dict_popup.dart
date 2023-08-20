import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// Info popup that informs the user that a significant part of the dictionary
/// is only available in english
AwesomeDialog disableEnglishDictPopup(BuildContext context){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: (){

    },
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          LocaleKeys.SettingsScreen_dict_disable_english_info.tr()
        ),
      )
    )
  );
}