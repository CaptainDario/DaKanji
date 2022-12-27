import 'package:da_kanji_mobile/view/dictionary/dictionary.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/provider/dict_search_result.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/user_data.dart';



class DictionaryScreen extends StatefulWidget {

  const DictionaryScreen(
    this.openedByDrawer,
    this.includeTutorial,
    this.initialSearch,
    {
      Key? key
    }
  ) : super(key: key);

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState
  extends State<DictionaryScreen>
  with TickerProviderStateMixin {

  /// TabController to manage the different tabs in the dictionary
  late TabController dictionaryTabController;
  /// How many tabs should be shown side by side in the window 
  int tabsSideBySide = -1;
  /// Number of tabs in the Dictionaries TabBar
  int noTabs = -1;
  /// Function that is executed when the tab was changed
  late void Function() changeTab;
  /// Current search in the dictionary
  DictSearch search = DictSearch();
  /// A list containing all kanjiVGs that match the selected dict entry
  List<KanjiSVG> kanjiVGs = [];
  /// A List of kanjidic2 entries thath should be shown
  List<Kanjidic2> kanjidic2Entries = [];

  @override
  void initState() {
    search.currentSearch = widget.initialSearch;
    super.initState();

    // init tutorial
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null && 
        GetIt.I<UserData>().showShowcaseDictionary && widget.includeTutorial) {

        onboarding.showWithSteps(
          GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes![0],
          GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes!
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      animationAtStart: !widget.openedByDrawer,
      child: Dictionary(
        false,
      )
    );
  }
}