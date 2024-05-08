// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';

// Project imports:
import 'package:da_kanji_mobile/application/manual/manual.dart';
import 'package:da_kanji_mobile/entities/manual/manual_types.dart';
import 'package:da_kanji_mobile/globals.dart';

// Project imports:




/// A dialog that that tells the user that anki is not setup and that he needs
/// to configure it.
/// opens the manual if desired
AwesomeDialog ankiNotSetupDialog(BuildContext context,) {

  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    title: "Anki not setup",
    desc: "Anki is not setup. To add cards to anki please set it up first",

    btnOkText: "Setup",
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () async {
      pushManual(context, ManualTypes.anki);
    },
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: () { },
  );

}
