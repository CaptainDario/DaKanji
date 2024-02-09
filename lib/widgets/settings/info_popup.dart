// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';



/// Shows a info dialog using the given `explanationText`
void infoPopup(BuildContext context, String explanationTitle, String explanationText){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    headerAnimationLoop: false,
    body: Column(
      children: [
        Text(
          explanationTitle,
          //textScaleFactor: 2,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(explanationText),
            ]
          )
        ),
      ],
    ),
  ).show();
}
