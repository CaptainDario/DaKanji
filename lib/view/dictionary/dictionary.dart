import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';
import 'package:database_builder/database_builder.dart';
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;
import 'package:database_builder/src/kanjidic2_to_Isar/data_classes.dart' as isar_kanjidic;

import 'package:da_kanji_mobile/provider/dict_search_result.dart';
import 'package:da_kanji_mobile/helper/japanese_text_processing.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_example_tab.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_kanji_tab.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_search_tab.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/user_data.dart';



class Dictionary extends StatefulWidget {

  const Dictionary(
    this.includeTutorial,
    {
      this.initialSearch = "",
      this.includeActionButton = true,
      Key? key
    }
  ) : super(key: key);

  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;
  /// should the action button for drawing a character be included
  final bool includeActionButton;

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> with TickerProviderStateMixin {

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
  List<isar_kanji.KanjiSVG> kanjiVGs = [];
  /// A List of kanjidic2 entries thath should be shown
  List<Kanjidic2Entry> kanjidic2Entries = [];
  /// Used to check if `widget.initialQuery` changed
  String initialSearch = "";
  

  @override
  void initState() {
    
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
    
    return ChangeNotifierProvider<DictSearch>.value(
      value: search,
      child: LayoutBuilder(
        builder: ((context, constraints) {

          // check if there is an initial query or if it was update
          if(widget.initialSearch != initialSearch){
            //searchInputController.text = widget.initialSearch;

            context.read<DictSearch>().currentSearch = widget.initialSearch;
            //context.read<DictSearch>().searchResults = searchInDict(widget.initialSearch);

            initialSearch = widget.initialSearch;
          }
  
          // calculate how many tabs should be placed side by side
          tabsSideBySide = min(4, (constraints.maxWidth / 500).floor() + 1);
          int newNoTabs = 5 - tabsSideBySide;
  
          // if the window size was changed and a different number of tabs 
          // should be shown 
          if(newNoTabs != noTabs){
            print("tabsSideBySide $tabsSideBySide newNoTabs $newNoTabs");
            noTabs = newNoTabs;
            dictionaryTabController = TabController(length: noTabs, vsync: this);
  
            changeTab = () {
              // only change the tab if the tab bar includes the search tab
              if(noTabs != 4 || tabsSideBySide > 1) return;
              
              // if a search result was selected change the tab
              if(context.read<DictSearch>().selectedResult != null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {         
                  dictionaryTabController.animateTo(1);
                });
              }
            };
          }
  
          // if a search result was selected
          // search the kanjis from the selected word in KanjiVG
          if(context.watch<DictSearch>().selectedResult != null){
            findMatchingEntries(
              removeAllButKanji(context.watch<DictSearch>().selectedResult!.kanjis)
            );
          }
    
          return Row(
            children: [
              if(tabsSideBySide > 1)
                SizedBox(
                  width: constraints.maxWidth / (tabsSideBySide),
                  height: constraints.maxHeight,
                  child: DictionarySearchTab(
                    constraints.maxHeight,
                    constraints.maxWidth / (tabsSideBySide),
                    initialSearch: context.watch<DictSearch>().currentSearch,
                    includeActionButton: widget.includeActionButton,
                    onSearchResultPressed: (entry) {
                      // start a tab switching animation on the next frame
                      // only if the search is not separated
                      if(tabsSideBySide == 1)
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {         
                          
                            dictionaryTabController.animateTo(1);
                        });
                    },
                  ),
                ),
              if(tabsSideBySide > 2)
                SizedBox(
                  width: constraints.maxWidth / (tabsSideBySide),
                  height: constraints.maxHeight,
                  child: DictionaryWordTab(
                    context.watch<DictSearch>().selectedResult
                  ),
                ),
              if(tabsSideBySide > 3)
                SizedBox(
                  width: constraints.maxWidth / (tabsSideBySide),
                  height: constraints.maxHeight,
                  child: DictionaryKanjiTab(
                    kanjiVGs,
                    kanjidic2Entries
                  ),
                ),
              if(tabsSideBySide >= 4) 
                SizedBox(
                  width: constraints.maxWidth / (tabsSideBySide),
                  height: constraints.maxHeight,
                  child: const DictionaryExampleTab(),
                ),
              // 
              if(tabsSideBySide < 4)
                SizedBox(
                  width: constraints.maxWidth / (tabsSideBySide),
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      // disable the TabBar if there is no result selected
                      IgnorePointer(
                        ignoring: context.read<DictSearch>().selectedResult == null,
                        child: TabBar(
                          labelColor: Theme.of(context).highlightColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Theme.of(context).highlightColor,
                          controller: dictionaryTabController,
                          tabs: [
                            if(noTabs > 3) const Tab(text: "Search", ),
                            if(noTabs > 2) const Tab(text: "Word"),
                            if(noTabs > 1) const Tab(text: "Kanji"),
                            if(noTabs > 0) const Tab(text: "Example"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TabBarView(
                                controller: dictionaryTabController,
                                children: [
                                  if(noTabs > 3) 
                                    DictionarySearchTab(
                                      constraints.maxHeight,
                                      constraints.maxWidth,
                                      initialSearch: context.watch<DictSearch>().currentSearch,
                                      includeActionButton: widget.includeActionButton,
                                      onSearchResultPressed: (entry) {
                                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                          if(tabsSideBySide != 4)
                                            dictionaryTabController.animateTo(1);
                                        });
                                      },
                                    ),
                                  if(noTabs > 2)
                                    DictionaryWordTab(
                                      context.watch<DictSearch>().selectedResult
                                    ),
                                  if(noTabs > 1) 
                                    DictionaryKanjiTab(
                                      kanjiVGs,
                                      kanjidic2Entries
                                    ),
                                  if(noTabs > 0) 
                                    const DictionaryExampleTab(),
                                  
                                ],
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        })
      ),
    );
  }

  void findMatchingEntries(List<String> kanjis){
    
    kanjiVGs = GetIt.I<Isar>().kanjiSVGs.filter()
      .characterMatches(kanjis.join("|"))
      .findAllSync(); 
    
    kanjiVGs = List.generate(
      kanjis.length, (index) => 
        GetIt.I<Isar>().kanjiSVGs.filter()
          .characterEqualTo(kanjis[index])
        .findAllSync()
    ).expand((element) => element).toList();
    

    kanjidic2Entries = List.generate(kanjiVGs.length, (index) =>
      GetIt.I<Isar>().kanjidic2Entrys.filter()
        .literalEqualTo(kanjiVGs[index].character)
      .findAllSync()
    ).expand((element) => element).toList();
  }
}

