// Flutter imports:
import 'package:da_kanji_mobile/asset_sizes.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

/// Inform the user that additional data is needed to use the app
AwesomeDialog downloadPopup(
  {
    required BuildContext context,
    void Function()? btnOkOnPress,
    bool dismissable = false
  }
)
{

  return AwesomeDialog(
    context: context,
    desc: LocaleKeys.HomeScreen_download_popup_permission.tr()
      .replaceAll("{DOWNLOAD_SIZE}", c_DOWNLOAD_SIZE.toStringAsFixed(1)),
    headerAnimationLoop: false,
    customHeader: Image.asset("assets/images/dakanji/icon.png"),
    dismissOnTouchOutside: dismissable,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: btnOkOnPress,
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: dismissable ? () {} : null,
  );

}
