import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:da_kanji_mobile/view/home/init.dart';
import 'package:da_kanji_mobile/globals.dart';



AwesomeDialog optimizeBackendsPopup(BuildContext context){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    dismissOnTouchOutside: true,
    btnCancelColor: g_Dakanji_red,
    btnCancelOnPress: (){
      Navigator.of(context).pop();
    },
    btnOkColor: g_Dakanji_green,
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
            SizedBox(height: 20,),
            Text(
              "Optimizing backends...\nPlease do not close the app",
            ),
            SizedBox(height: 20,)
          ]
        ),
      )..show();
      
      await optimizeTFLiteBackendsForModels();
      
      Navigator.of(context).pop();
    },
    body: Column(
      children: [
        Text(
          "This will optimize the Neural Network backends for your device. This can take a while depending on your device, but can improve the performance of dramatically.",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}