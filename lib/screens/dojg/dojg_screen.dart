// Flutter imports:
import 'package:da_kanji_mobile/widgets/dojg/dojg.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_import.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';

class DoJGScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// A search term that should be the initial search
  final String? initialSearch;
  /// Should the first result of the initial search be openend (if one exists)
  final bool openFirstResult;


  const DoJGScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      this.initialSearch,
      this.openFirstResult = false,
      super.key
    }
  );

  @override
  State<DoJGScreen> createState() => _DoJGScreenState();
}

class _DoJGScreenState extends State<DoJGScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.dojg,
      child: !GetIt.I<UserData>().dojgImported
        // show the import widget if the deck has not been imported
        ? const DojgImport()
        // if it has been imported show the actual dojg data
        : DoJG(widget.openedByDrawer, widget.includeTutorial)
    );
  }



}
