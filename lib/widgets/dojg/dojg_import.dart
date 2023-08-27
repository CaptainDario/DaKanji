import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/application/dojg/dojg.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:da_kanji_mobile/globals.dart';



class DojgImport extends StatefulWidget {
  const DojgImport({super.key});

  @override
  State<DojgImport> createState() => _DojgImportState();
}

class _DojgImportState extends State<DojgImport> {
  /// Is the dojg deck currently being imported
  bool importing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: importDojgPressed,
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.download),
                const SizedBox(width: 10.0),
                Text(LocaleKeys.DojgScreen_import_dojg.tr()),
              ],
            ),
            const SizedBox(height: 4,),
            Text(
              LocaleKeys.DojgScreen_refer_to_manual.tr(),
              textScaleFactor: 0.9,
              style: const TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Callback that is triggered when a user pressed on the import dojg button
  void importDojgPressed() async {
    if (importing) return;

    importing = true;

    if(await importDoJGDeck()){
      GetIt.I<UserData>().dojgImported = (checkDojgImported());
      GetIt.I<UserData>().dojgWithMediaImported = (checkDojgWithMediaImported());
      await GetIt.I<UserData>().save();

      // ignore: use_build_context_synchronously
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.noHeader,
        btnOkColor: g_Dakanji_green,
        btnOkOnPress: () {},
        dismissOnTouchOutside: false,
        desc: "DoJG has been imported successfully! Resetarting the app..."
      ).show();
      // ignore: use_build_context_synchronously
      restartApp(context);
    }
    else {
      // ignore: use_build_context_synchronously
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.noHeader,
        btnOkColor: g_Dakanji_green,
        btnOkOnPress: () {},
        dismissOnTouchOutside: false,
        desc: "The import failed, please assure that you are importing the correct data. "
          "Refer to the manual for more details."
      ).show();
    }

    importing = false;
  }
}

