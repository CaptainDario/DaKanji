import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';


/// Inform the user that additional data is needed to use the app
AwesomeDialog downloadPopup({
  required BuildContext context,
  void Function()? btnOkOnPress
  })
{

  return AwesomeDialog(
    context: context,
    desc: "We need to download some files before you can get started. " +
        "This will only happen once. " +
        "Please make sure you have a stable internet connection " +
        "and do not close the app while the download is in progress.",
    headerAnimationLoop: false,
    customHeader: Image.asset("assets/images/dakanji/icon.png"),
    dismissOnTouchOutside: false,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: btnOkOnPress,
  );

}