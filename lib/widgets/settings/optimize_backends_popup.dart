import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/init.dart';
import 'package:da_kanji_mobile/globals.dart';


/// Popup that asks the user if he wants to optimize the backends for the
/// tflite models and tells that it will take some time.
AwesomeDialog optimizeBackendsPopup(BuildContext context){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    dismissOnTouchOutside: true,
    btnCancelColor: g_Dakanji_red,
    btnCancelText: LocaleKeys.SettingsScreen_advanced_settings_optimize_cancel.tr(),
    btnCancelOnPress: (){
      
    },
    btnOkColor: g_Dakanji_green,
    btnOkText: LocaleKeys.SettingsScreen_advanced_settings_optimize_ok.tr(),
    btnOkOnPress: () async {
      // show intermediate dialog while optimizing
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.noHeader,
        dismissOnTouchOutside: false,
        body: Column(
          children: [
            const SpinKitSpinningLines(
              color: g_Dakanji_green,
              lineWidth: 3,
              size: 30.0,
              itemCount: 10,
            ),
            const SizedBox(height: 20,),
            Text(
              LocaleKeys.SettingsScreen_advanced_settings_optimizing.tr()
            ),
            const SizedBox(height: 20,)
          ]
        ),
      ).show();
      
      // wait a bit so the dialog can be shown
      await Future.delayed(const Duration(seconds: 2));

      await optimizeTFLiteBackendsForModels();
      
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    },
    body: Column(
      children: [
        Text(
          LocaleKeys.SettingsScreen_advanced_settings_optimze_warning.tr(),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}