// Flutter imports:
import 'package:da_kanji_mobile/widgets/ocr/ocr_widget.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';

class OcrScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const OcrScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.ocr,
      child: const OcrWidget()
    );
  }

}
