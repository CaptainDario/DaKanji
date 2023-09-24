// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

/// Simple popup that shows a spinning animation
AwesomeDialog loadingPopup(BuildContext context){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    body: const SizedBox(
      height: 100,
      width: 100,
      child: const DaKanjiLoadingIndicator()
    ),
    dismissOnBackKeyPress: false,
    dismissOnTouchOutside: false,
  );
}
