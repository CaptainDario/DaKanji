// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/app/restart.dart';
import 'package:da_kanji_mobile/application/manual/manual.dart';
import 'package:da_kanji_mobile/entities/manual/manual_types.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/repositories/dojg/dojg.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_import_dialog.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: GestureDetector(
              onTap: importDojgPressed,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                  child: Text(
                    LocaleKeys.DojgScreen_dojg_import.tr(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          // info text
          GestureDetector(
            onTap: () => pushManual(context, ManualTypes.dojg),
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                child: Text(
                  LocaleKeys.DojgScreen_refer_to_manual.tr(),
                  textScaler: const TextScaler.linear(0.9),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Callback that is triggered when a user pressed on the import dojg button
  void importDojgPressed() async {
    if (importing) return;

    importing = true;

    // let user pick a file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any);
    
    // ignore: use_build_context_synchronously
    dojgImportLoadingDialog(context).show();

    if(result != null){
      if(await importDoJGDeck()){
        GetIt.I<UserData>().dojgImported = (checkDojgImported());
        GetIt.I<UserData>().dojgWithMediaImported = (checkDojgWithMediaImported());
        await GetIt.I<UserData>().save();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(context);
        // ignore: use_build_context_synchronously
        await dojgImportSucceededDialog(context).show();

        // ignore: use_build_context_synchronously
        restartApp(context);
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(context);
    // ignore: use_build_context_synchronously
    await dojgImportFailedDialog(context).show();

    importing = false;
  }
}

