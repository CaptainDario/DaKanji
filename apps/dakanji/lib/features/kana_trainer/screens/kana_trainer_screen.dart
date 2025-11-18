// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/view/drawer.dart';
import 'package:da_kanji_mobile/features/kana_trainer/widgets/kana_trainer.dart';

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
      currentScreen: Screens.kanaTrainer,
      drawerClosed: !widget.navigatedByDrawer,
      child: const KanaTrainer()
    );
  }
}
