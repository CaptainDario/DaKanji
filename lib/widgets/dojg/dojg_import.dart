// Flutter imports:
import 'package:da_kanji_mobile/application/manual/manual.dart';
import 'package:da_kanji_mobile/domain/manual/manual_types.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:da_kanji_mobile/application/dojg/dojg.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

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
                Text(LocaleKeys.DojgScreen_dojg_import.tr()),
                const SizedBox(width: 4.0),
                const Icon(Icons.download),
              ],
            ),
            GestureDetector(
              onTap: () => pushManual(context, ManualTypes.dojg),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.DojgScreen_refer_to_manual.tr(),
                      textScaleFactor: 0.9,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 4,),
                    const Icon(
                      Icons.file_open,
                      size: 20,
                      color: Colors.grey,
                    )
                  ]
                ),
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
        desc: LocaleKeys.DojgScreen_dojg_import_success.tr()
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
        body: Align(
          child: Text(
            LocaleKeys.DojgScreen_dojg_import_fail.tr()
          ),
        ),
      ).show();
    }

    importing = false;
  }
}

