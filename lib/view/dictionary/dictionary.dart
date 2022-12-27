import 'dart:math';
import 'package:da_kanji_mobile/view/dictionary/dictionary_search_widget.dart';
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
import 'package:da_kanji_mobile/view/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/user_data.dart';



class Dictionary extends StatefulWidget {

  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;
  /// should the action button for drawing a character be included
  final bool includeActionButton;
  /// Is the search expanded when instantiating this widget
  final bool isExpanded; 

  const Dictionary(
    this.includeTutorial,
    {
      this.initialSearch = "",
      this.includeActionButton = true,
      this.isExpanded = false,
      Key? key
    }
  ) : super(key: key);

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> with TickerProviderStateMixin {

  /// How many tabs should be shown side by side in the window 
  int tabsSideBySide = -1;
  /// Function that is executed when the tab was changed
  late void Function() changeTab;
  /// Current search in the dictionary
  DictSearch search = DictSearch();
  /// A list containing all kanjiVGs that match the selected dict entry
  List<isar_kanji.KanjiSVG> kanjiVGs = [];
  /// A List of kanjidic2 entries thath should be shown
  List<Kanjidic2> kanjidic2Entries = [];
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
            context.read<DictSearch>().currentSearch = widget.initialSearch;

            initialSearch = widget.initialSearch;
          }
  
          // calculate how many tabs should be placed side by side
          tabsSideBySide = min(4, (constraints.maxWidth / 600).floor() + 1);
  
          // if a search result was selected
          // search the kanjis from the selected word in KanjiVG
          if(context.watch<DictSearch>().selectedResult != null){
            findMatchingKanjiEntries(
              removeAllButKanji(context.watch<DictSearch>().selectedResult!.kanjis)
            );
          }
    
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
                                initialSearch: context.watch<DictSearch>().currentSearch,
                                expandedHeight: constraints.maxHeight - 25,
                                isExpanded: true,
                                canCollapse: false,
                              ),
                            ),
                          ),
                        // word 
                        if(tabsSideBySide > 1)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: DictionaryWordTab(
                                context.watch<DictSearch>().selectedResult
                              ),
                            ),
                          ),
                        // kanji
                        if(tabsSideBySide > 3)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DictionaryKanjiTab(
                                kanjiVGs,
                                kanjidic2Entries
                              ),
                            ),
                          ),
                        // examples
                        if(tabsSideBySide >= 4)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DictionaryExampleTab(),
                            )
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
                                        if(tabsSideBySide < 2) const Tab(text: "Word"),
                                        if(tabsSideBySide < 4) const Tab(text: "Kanji"),
                                        if(tabsSideBySide < 4) const Tab(text: "Example"),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TabBarView(
                                        children: [
                                          if(tabsSideBySide < 2)
                                            context.read<DictSearch>().selectedResult != null
                                            ?  DictionaryWordTab(
                                                context.watch<DictSearch>().selectedResult
                                              )
                                            : SizedBox(),
                                          if(tabsSideBySide < 4) 
                                            DictionaryKanjiTab(
                                              kanjiVGs,
                                              kanjidic2Entries
                                            ),
                                          if(tabsSideBySide < 4) 
                                            const DictionaryExampleTab(),
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
                      initialSearch: context.watch<DictSearch>().currentSearch,
                      expandedHeight: constraints.maxHeight - 24,
                      isExpanded: widget.isExpanded,
                    ),
                  ),
                ),
            ],
          );
        })
      ),
    );
  }

  /// Searches in KanjiVG and KanjiDic the matching entries to all Kanji in the
  /// selected search result
  void findMatchingKanjiEntries(List<String> kanjis){

    // TODO change to where search to prevent UI jank
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
      GetIt.I<Isar>().kanjidic2s.filter()
        .characterEqualTo(kanjiVGs[index].character)
      .findAllSync()
    ).expand((element) => element).toList();
  }
}

