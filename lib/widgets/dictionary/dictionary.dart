// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:da_kanji_mobile/application/dictionary/falling_word_stack_controller.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/dictionary/dict_search_result.dart';
import 'package:da_kanji_mobile/entities/dictionary/floating_word.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_example_tab.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_kanji_tab.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_search_widget.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/widgets/dictionary/floating_word_stack.dart';

class Dictionary extends StatefulWidget {

  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;
  /// The id of the entry that should be shown when the dict is opened
  final int? initialEntryId;
  /// Should the falling words be included or not
  final bool includeFallingWords;
  /// should the button for opening the drawing screen be included
  final bool includeDrawButton;
  /// Is the search expanded when instantiating this widget
  final bool isExpanded; 
  
  /// Should the search term be deconjugated before searching
  final bool allowDeconjugation;
  /// Should the search term be converted to kana
  final bool convertToKana;

  const Dictionary(
    this.includeTutorial,
    {
      this.initialSearch = "",
      this.initialEntryId,
      required this.includeFallingWords,
      this.includeDrawButton = true,
      this.isExpanded = false,
      this.allowDeconjugation=true,
      this.convertToKana=true,
      super.key
    }
  );

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> with TickerProviderStateMixin {

  /// How many tabs should be shown side by side in the window 
  int tabsSideBySide = -1;
  /// Current search in the dictionary
  DictSearch search = DictSearch();
  /// Tab controller for the dictionary tabs
  TabController? dictionaryTabController;
  /// Controller of the floating words
  FloatingWordStackController? floatingWordStackController;
  /// Has the initial search been set
  bool initialSearchSet = false;


  @override
  void initState() {
    
    // show the initial word if it was given
    if(widget.initialEntryId != null){
      search.selectedResult =
        GetIt.I<Isars>().dictionary.jmdict.getSync(widget.initialEntryId!);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Dictionary oldWidget) {
    setState(() {
      if(!initialSearchSet){
        search.currentSearch = widget.initialSearch;
        initialSearchSet = true;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<DictSearch>.value(
      value: search,
      child: LayoutBuilder(
        builder: ((context, constraints) {

          // reset the floating words when the search was emptied
          if(search.currentSearch == "" && search.selectedResult == null) {
            floatingWordStackController?.reset();
          }
          // hide the falling words when a search starts
          if(search.currentSearch != "" &&
            floatingWordStackController!.opacityAnimationController.isCompleted){
            floatingWordStackController?.opacityAnimationController.reverse(from: 1);
          }
          
          // calculate how many tabs should be placed side by side
          tabsSideBySide = min(4, (constraints.maxWidth / 600).floor() + 1);
          int tabs = 4 - (tabsSideBySide == 3 ? 2 : tabsSideBySide);

          if(dictionaryTabController == null || dictionaryTabController!.length != tabs){
            dictionaryTabController = TabController(length: tabs, vsync: this);
          }
    
          return Stack(
            children: [
              Column(
                children: [
                  // create an invisble widget with the same size as the searchbar
                  if(tabsSideBySide <= 2)
                    const Visibility(
                      maintainSize: true,
                      visible: false,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          child: TextField(),
                        ),
                      ),
                    ),
                  Expanded(
                    child: FloatingWordStack(
                      levels: GetIt.I<Settings>().dictionary.selectedFallingWordsLevels,
                      hide: search.selectedResult != null || !widget.includeFallingWords,
                      onTap: (FloatingWord entry) {
                        search.selectedResult =
                          GetIt.I<Isars>().dictionary.jmdict.getSync(entry.entry.id);
                      },
                      onInitialized: (controller) {
                        floatingWordStackController = controller;
                      },
                      child: Row(
                        children: [
                          // search bar spanning maxium 2 tabs (no function)
                          if(tabsSideBySide > 2)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DictionarySearchWidget(
                                  //key: Key(search.selectedResult.toString()),
                                  initialSearch: widget.initialSearch,
                                  expandedHeight: constraints.maxHeight - 24,
                                  isExpanded: true,
                                  canCollapse: false,
                                  includeDrawButton: widget.includeDrawButton,
                                  convertToKana: widget.convertToKana,
                                  allowDeconjugation: widget.allowDeconjugation,
                                  context: context,
                                ),
                              ),
                            ),
                          // word 
                          if(tabsSideBySide > 1)
                            Expanded(
                              child: Focus(
                                focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.wordTabStep,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: DictionaryWordTab(
                                    context.watch<DictSearch>().selectedResult,
                                  ),
                                ),
                              ),
                            ),
                          // kanji
                          if(tabsSideBySide > 3)
                            Expanded(
                              child: Focus(
                                focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.kanjiTabStep,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DictionaryKanjiTab(
                                      context.read<DictSearch>().selectedResult
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // examples
                          if(tabsSideBySide >= 4)
                            Expanded(
                              child: Focus(
                                focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.examplesTabStep,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DictionaryExampleTab(
                                    context.watch<DictSearch>().selectedResult
                                  ),
                                ),
                              ),
                            ),
                        
                          // tab bar
                          if(tabsSideBySide < 4)
                            /// provide the tab bar controller so that other widgets
                            /// can listen to its state (ex. Kanji animation)
                            ListenableProvider.value(
                              value: dictionaryTabController,
                              child: Expanded(
                                child: Column(
                                  children: [
                                    // disable the TabBar if there is no result selected
                                    IgnorePointer(
                                      ignoring: context.read<DictSearch>().selectedResult == null,
                                      child: TabBar(
                                        controller: dictionaryTabController,
                                        labelColor: Theme.of(context).highlightColor,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorColor: Theme.of(context).highlightColor,
                                        tabs: [
                                          if(tabsSideBySide < 2) 
                                            Focus(
                                              focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.wordTabStep,
                                              child: Tab(
                                                text: LocaleKeys.DictionaryScreen_word_tab.tr()
                                                ),
                                            ),
                                          if(tabsSideBySide < 4) 
                                            Focus(
                                              focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.kanjiTabStep,
                                              child: Tab(
                                                text: LocaleKeys.DictionaryScreen_kanji_tab.tr()
                                                ),
                                            ),
                                          if(tabsSideBySide < 4) 
                                            Focus(
                                              focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.examplesTabStep,
                                              child: Tab(
                                                text: LocaleKeys.DictionaryScreen_example_tab.tr()
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    // tab bar with the word, kanji, ... tabs
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TabBarView(
                                          controller: dictionaryTabController,
                                          children: [
                                            if(tabsSideBySide < 2)
                                              DictionaryWordTab(
                                                context.watch<DictSearch>().selectedResult,
                                              ),
                                            if(tabsSideBySide < 4) 
                                              DictionaryKanjiTab(
                                                context.watch<DictSearch>().selectedResult
                                              ),
                                            if(tabsSideBySide < 4)
                                              DictionaryExampleTab(
                                                context.watch<DictSearch>().selectedResult
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // the actual search bar (rendered on top of non functional)
              if(tabsSideBySide <= 2)
                Positioned(
                  width: constraints.maxWidth,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DictionarySearchWidget(
                      initialSearch: widget.initialSearch,
                      expandedHeight: constraints.maxHeight - 24,
                      isExpanded: widget.isExpanded,
                      includeDrawButton: widget.includeDrawButton,
                      convertToKana: widget.convertToKana,
                      allowDeconjugation: widget.allowDeconjugation,
                      context: context,
                    ),
                  ),
                ),
            
            ],
          );
        })
      ),
    );
  }
}

