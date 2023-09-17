// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

/// Info popup that informs the user that a significant part of the dictionary
/// is only available in english
AwesomeDialog DisableEnglishDictPopup(BuildContext context){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: (){

    },
    body: Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          LocaleKeys.SettingsScreen_dict_disable_english_info.tr()
        ),
      )
    )
  );
}
