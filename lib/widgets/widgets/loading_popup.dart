// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

/// Simple popup that shows a spinning animation
AwesomeDialog loadingPopup(BuildContext context,
  {
    bool skippable = false,
    Widget? waitingInfo
  }){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    body: Column(
      children: [
        const SizedBox(
          height: 100,
          width: 100,
          child: DaKanjiLoadingIndicator()
        ),
        
        if(waitingInfo != null)
          ...[
            const SizedBox(height: 16,),
            waitingInfo,
            const SizedBox(height: 48,),
          ]
      ],
    ),
    dismissOnBackKeyPress: skippable,
    dismissOnTouchOutside: skippable,
  );
}
