import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:get_it/get_it.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as _jmdict;
import 'package:database_builder/objectbox.g.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/view/dictionary/radical_search_widget.dart';
import 'package:da_kanji_mobile/helper/iso_table.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_card.dart';
import 'package:da_kanji_mobile/provider/dict_search_result.dart';
import 'package:da_kanji_mobile/provider/settings.dart';




class DictionaryScreenSearchTab extends StatefulWidget {
  const DictionaryScreenSearchTab(
    this.height,
    this.width,
    this.initialQuery,
    {Key? key}
  ) : super(key: key);

  
  /// height of this widget
  final double height;
  /// width of this widget
  final double width;
  /// The query that should be initially searched
  final String initialQuery;

  @override
  State<DictionaryScreenSearchTab> createState() => _DictionaryScreenSearchTabState();
}

class _DictionaryScreenSearchTabState extends State<DictionaryScreenSearchTab> {

  /// the text that was last entered in the search field
  String lastInput = "";
  /// the TextEditingController of the search field
  TextEditingController searchInputController = TextEditingController();


  @override
  void initState() {
    if(widget.initialQuery != ""){
      searchInputController.text = widget.initialQuery;
      context.read<DictSearch>().currentSearch = widget.initialQuery;

      context.read<DictSearch>().searchResults = searchInDict(widget.initialQuery);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: widget.height*0.025,),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchInputController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter a search term',
                          ),
                          style: TextStyle(
                            fontSize: 20
                          ),
                          onChanged: (text) async {
                            // only search in dictionary if the query changed
                            if(lastInput == text) {
                              return;
                            }

                            setState(() {
                              context.read<DictSearch>().currentSearch = text;
                              context.read<DictSearch>().searchResults = searchInDict(text);
                              lastInput = text;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            dismissOnTouchOutside: true,
                            body: RadicalSearchWidget(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.85,
                            ),
                            btnOk: ElevatedButton(
                              onPressed: (){},
                              child: Text("Ok"),
                            )
                          ).show();
                        },
                        icon: Text(
                          "部",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                              ? Colors.white
                              : Colors.black
                          ),
                        ),
                        //icon: Icon(Icons.kayaking),
                      ),
                      IconButton(
                        onPressed: () async {
                          if(searchInputController.text != ""){
                            searchInputController.text = "";
                            context.read<DictSearch>().currentSearch = "";
                            context.read<DictSearch>().searchResults = [];
                          }
                          else{
                            String data = (await Clipboard.getData('text/plain'))?.text ?? "";
                            searchInputController.text = data;
                            context.read<DictSearch>().currentSearch = data;
                            context.read<DictSearch>().searchResults = searchInDict(data);
                          }
                          setState(() { });
                        },
                        icon: Icon(
                          searchInputController.text == ""
                            ? Icons.copy
                            : Icons.clear,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: widget.height*0.025,),
              Expanded(
                child: ListView.builder(
                  itemCount: context.watch<DictSearch>().searchResults.length,
                  itemBuilder: ((context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: SearchResultCard(
                            dictEntry: context.watch<DictSearch>().searchResults[index],
                            resultIndex: index,
                            onPressed: (selection) {
                              context.read<DictSearch>().selectedResult = 
                                context.read<DictSearch>().searchResults[index];
                            }
                          )
                        ),
                      ),
                    );
                  })
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: widget.height*0.02,
          right: widget.width*0.02,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24),
            ),
            onPressed: () {
              GetIt.I<Settings>().drawing.selectedDictionary = 
                GetIt.I<Settings>().drawing.inbuiltDictId;
              Navigator.pushNamed(context, "/drawing");
            },
            child: SizedBox(
              width: widget.width*0.08,
              height: widget.height*0.08,
              child: const Icon(
                Icons.brush
              ),
            ),
          )
        )
      ],
    );
  }

  /// Searches `queryText` in the database
  List<_jmdict.Entry> searchInDict(String queryText){

    String hiraText = GetIt.I<KanaKit>().toHiragana(queryText);
    String kataText = GetIt.I<KanaKit>().toKatakana(queryText);

    // TODO: replace this super slow query with a faster implementation 
    List<_jmdict.Entry> query = GetIt.I<Box<_jmdict.Entry>>().getMany(
      List.generate(100000, (index) => index+1)
    ).whereType<_jmdict.Entry>().toList();
    List<_jmdict.Entry> searchResults = query.where((_jmdict.Entry element) {
      //element.readings.any((String value) => value.contains(queryText)) ||
      //element.kanjis.any((String value) => value.contains(queryText)) ||
      //element.readings.any((String value) => value.contains(hiraText)) ||
      //element.readings.any((String value) => value.contains(kataText)) ||
      return element.meanings.where((meaning) => 
        GetIt.I<Settings>().dictionary.selectedTranslationLanguages.contains(
          isoToiso639_1[meaning.language]!.name
        )
      ).any((meaning) => 
        meaning.meanings.any((m) => m.contains(queryText))
      );
    }).toList();
    // -------------------------------------------------------------------------

    // SORT
    // first sort by frequency
    //searchResults.sort((a, b) => a.)

    return sortJmdictList(searchResults, queryText, GetIt.I<Settings>().dictionary.selectedTranslationLanguages);
  }

  /// Sorts a list of Jmdict entries given a query text. The order is determined
  /// by those sorting criteria:
  /// 
  /// 1. Full > Match at the beginning > Match somwhere in the word
  ///    Those three categories are sorted individually and merged in the end
  ///   2.  sort inside each category based on 
  List<_jmdict.Entry> sortJmdictList(
    List<_jmdict.Entry> entries, String queryText, List<String> languages){

    /// lists with three sub lists
    /// 0 - full matchs ; 1 - matchs starting at the word beginning ; 2 - other matches
    List<List<_jmdict.Entry>> matches = [[], [], []];
    List<List<int>> indices = [[], [], []];
    String queryTextHira = GetIt.I<KanaKit>().toHiragana(queryText);

    for (_jmdict.Entry entry in entries) {
      // KANJI
      Tuple3 result = rankMatchs(entry.kanjis, queryText);
      
      // KANA
      if(result.item1 == -1) result = rankMatchs(entry.readings, queryTextHira);
      
      // MEANING
      // filter all langauges that are not selected in the settings
      if(result.item1 == -1){
        List<String> k = entry.meanings.where((e) => 
          languages.contains(isoToiso639_1[e.language]!.name)
        ).map((e) => e.meanings)
        .expand((e) => e).toList();
        result = rankMatchs(k, queryText);
      }

      if(result.item1 != -1){
        matches[result.item1].add(entry);
        indices[result.item1].add(result.item3);
      }
    }

    matches[0] = sortEntriesByInts(matches[0], indices[0]);
    return matches.expand((element) => element).toList();
  }

  /// Sorts a list of string `` based on `queryText`. The sorting criteria are
  /// explained by `sortJmdictList`.
  ///
  /// Returns a Tuple with the structure:
  ///   1 - if it was a full (0), start(1) or other(2) match
  ///   2 - how many characters are in the match but not in `queryText`
  ///   3 - the index where the search matched
  Tuple3<int, int, int> rankMatchs(List<String> k, String queryText) {   

    int result = -1, lenDiff = -1;

    // check if the word written in kanji contains the query
    int matchIndex = k.indexWhere((element) => element.contains(queryText));
    if(matchIndex != -1){
      // check kanji for full match
      if(k[matchIndex] == queryText){
        result = 0;
      }
      // does the found dict entry start with the search term
      else if(k[matchIndex].startsWith(queryText)){
        result = 1;
      }
      // how many additional characters does this entry include
      else {
        result = 2;
      }
      lenDiff = k[matchIndex].length - queryText.length;
    }

    return Tuple3(result, lenDiff, matchIndex);
  }

  /// Sorts list `a` based on the values in `b` and returns it.
  /// Throws an exception if the list do not have the same length.
  /// 
  /// Note: the type of list b needs to support `<`, `==` and `>`
  List<_jmdict.Entry> sortEntriesByInts(List<_jmdict.Entry> a, List<int> b){

    assert (a.length == b.length);

    List<Tuple2<_jmdict.Entry, int>> combined = List.generate(b.length,
      (i) => Tuple2(a[i], b[i])
    );
    combined.sort(
      (_a, _b) => _a.item2 - _b.item2
    );

    return  combined.map((e) => e.item1).toList();
  }
}