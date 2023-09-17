// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/kana_trainer/kana_trainer.dart';

class KanaTrainerScreen extends StatefulWidget {

  /// If the screen was navigated by the drawer
  final bool navigatedByDrawer;

  const KanaTrainerScreen(
    this.navigatedByDrawer,
    {
      super.key
    }
  );

  @override
  State<KanaTrainerScreen> createState() => _KanaTrainerScreenState();
}

class _KanaTrainerScreenState extends State<KanaTrainerScreen> {
  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kana_trainer,
      drawerClosed: !widget.navigatedByDrawer,
      child: KanaTrainer()
    );
  }
}
