import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// Inform the user that additional data is needed to use the app
AwesomeDialog downloadPopup({
  required BuildContext context,
  void Function()? btnOkOnPress
  })
{

  return AwesomeDialog(
    context: context,
    desc: LocaleKeys.HomeScreen_download_popup_permission.tr(),
    headerAnimationLoop: false,
    customHeader: Image.asset("assets/images/dakanji/icon.png"),
    dismissOnTouchOutside: false,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: btnOkOnPress,
  );

}