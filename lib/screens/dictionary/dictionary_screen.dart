


// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';

class DictionaryScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;
  /// The id of the entry that should be shown when the dict is opened
  final int? initialEntryId;

  const DictionaryScreen(
    this.openedByDrawer,
    this.includeTutorial,
    this.initialSearch,
    {
      this.initialEntryId,
      super.key
    }
  );

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
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
  /// A list containing all kanjiVGs that match the selected dict entry
  List<KanjiSVG> kanjiVGs = [];
  /// A List of kanjidic2 entries thath should be shown
  List<Kanjidic2> kanjidic2Entries = [];

  @override
  void initState() {
    super.initState();

    // init tutorial
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if(widget.includeTutorial){
        final OnboardingState? onboarding = Onboarding.of(context);
        if (onboarding != null && 
          GetIt.I<UserData>().showTutorialDictionary && widget.includeTutorial) {

          onboarding.showWithSteps(
            GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes!
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      drawerClosed: !widget.openedByDrawer,
      child: Dictionary(
        widget.includeTutorial,
        initialSearch: widget.initialSearch,
        includeFallingWords: true,
        isExpanded: widget.initialSearch != "",
        initialEntryId: widget.initialEntryId,
        allowDeconjugation: GetIt.I<Settings>().dictionary.searchDeconjugate,
      )
    );
  }
}
