import 'dart:math';
import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_search_widget.dart';
import 'package:da_kanji_mobile/provider/dict_search_result.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_example_tab.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_kanji_tab.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';



class Dictionary extends StatefulWidget {

  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;
  /// should the button for opening the drawing screen be included
  final bool includeDrawButton;
  /// Is the search expanded when instantiating this widget
  final bool isExpanded; 
  /// The id of the entry that should be shown when the dict is opened
  final int? initialEntryId;
  /// Should the search term be deconjugated before searching
  final bool allowDeconjugation;

  const Dictionary(
    this.includeTutorial,
    {
      this.initialSearch = "",
      this.initialEntryId,
      this.includeDrawButton = true,
      this.isExpanded = false,
      this.allowDeconjugation=true,
      Key? key
    }
  ) : super(key: key);

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> with TickerProviderStateMixin {

  /// How many tabs should be shown side by side in the window 
  int tabsSideBySide = -1;
  /// Current search in the dictionary
  DictSearch search = DictSearch();


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
      search.currentSearch = widget.initialSearch;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<DictSearch>.value(
      value: search,
      child: LayoutBuilder(
        builder: ((context, constraints) {
          
          // calculate how many tabs should be placed side by side
          tabsSideBySide = min(4, (constraints.maxWidth / 600).floor() + 1);
    
          return Stack(
            children: [
              Column(
                children: [
                  // create an invisble widget with the same size as the searchbar
                  if(tabsSideBySide <= 2)
                    Visibility(
                      maintainSize: true,
                      visible: false,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: TextField(),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Row(
                      children: [
                        // search
                        if(tabsSideBySide > 2)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DictionarySearchWidget(
                                initialSearch: widget.initialSearch,
                                expandedHeight: constraints.maxHeight - 25,
                                isExpanded: true,
                                canCollapse: false,
                                includeDrawButton: widget.includeDrawButton,
                                allowDeconjugation: widget.allowDeconjugation
                              ),
                            ),
                          ),
                        // word 
                        if(tabsSideBySide > 1)
                          Expanded(
                            child: Focus(
                              focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.wordTabStep,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: DictionaryWordTab(
                                  context.watch<DictSearch>().selectedResult
                                ),
                              ),
                            ),
                          ),
                        // kanji
                        if(tabsSideBySide > 3)
                          Expanded(
                            child: Focus(
                              focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.kanjiTabStep,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DictionaryKanjiTab(
                                  context.read<DictSearch>().selectedResult
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
                          DefaultTabController(
                            length: 4 - (tabsSideBySide == 3 ? 2 : tabsSideBySide),
                            child: Expanded(
                              child: Column(
                                children: [
                                  // disable the TabBar if there is no result selected
                                  IgnorePointer(
                                    ignoring: context.read<DictSearch>().selectedResult == null,
                                    child: TabBar(
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
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TabBarView(
                                        children: [
                                          if(tabsSideBySide < 2)
                                            DictionaryWordTab(
                                              context.watch<DictSearch>().selectedResult
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
                ],
              ),
              // the actual search bar (rendered on top of the fake)
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
                      allowDeconjugation: widget.allowDeconjugation
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

