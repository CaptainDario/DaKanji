import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



/// [AwesomeDialog] that shows a loading indicator while the dojg deck is
/// being imported
AwesomeDialog dojgImportLoadingDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    dismissOnTouchOutside: false,
    body: Column(
      children: [
        const DaKanjiLoadingIndicator(),
        const SizedBox(height: 8,),
        Text(
          LocaleKeys.DojgScreen_dojg_importing.tr()
        ),
        const SizedBox(height: 16,)
      ],
    ),
  );
}

/// [AwesomeDialog] that informs the user that the import of the DoJG deck
/// has failed
AwesomeDialog dojgImportFailedDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () {},
    dismissOnTouchOutside: false,
    body: Align(
      child: Text(
        LocaleKeys.DojgScreen_dojg_import_fail.tr()
      ),
    ),
  );
}

/// [AwesomeDialog] that informs the user that the import of the DoJG deck
/// has failed
AwesomeDialog dojgImportSucceededDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    btnOkColor: g_Dakanji_green,
    btnOkOnPress: () {},
    dismissOnTouchOutside: false,
    desc: LocaleKeys.DojgScreen_dojg_import_success.tr()
  );
}