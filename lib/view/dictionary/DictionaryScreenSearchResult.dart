import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenExampleTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenWordTab.dart';
import 'package:da_kanji_mobile/provider/DictSearchResult.dart';



class DictionaryScreenSearchResult extends StatefulWidget {
  DictionaryScreenSearchResult(
    {
      required this.noTabs,
      Key? key
    }
  ) : super(key: key);

  /// how many tabs should be shown in this widget.
  /// the order of tabs is word-tab, kanji-tab, example-tab
  final int noTabs;

  @override
  State<DictionaryScreenSearchResult> createState() => _DictionaryScreenSearchResultState();
}

class _DictionaryScreenSearchResultState extends State<DictionaryScreenSearchResult> {

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.noTabs,
      child: Column(
        children: [
          TabBar(
            tabs: [
              if(widget.noTabs > 2) Tab(text: "Word"),
              if(widget.noTabs > 1) Tab(text: "Kanji"),
              if(widget.noTabs > 0) Tab(text: "Example"),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return TabBarView(
                  children: [
                    if(widget.noTabs > 2)
                      DictionaryScreenWordTab(
                        context.watch<DictSearch>().selectedResult
                      ),
                    if(widget.noTabs > 1) 
                      DictionaryScreenKanjiTab(
                        ["鬱"],
                        ["鬱"]
                        //[GetIt.I<Box>().get("鬱").SVG]
                      ),
                    if(widget.noTabs > 0) 
                      DictionaryScreenExampleTab()
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}