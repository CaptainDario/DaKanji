import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:da_kanji_mobile/helper/iso_table.dart';
import 'package:da_kanji_mobile/view/dictionary/radical_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:get_it/get_it.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as _jmdict;
import 'package:database_builder/objectbox.g.dart';

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

    //var query = GetIt.I<Box<_jmdict.Entry>>().query(
      // search the query as is
    //  Entry_.readings.contains(queryText)
      // search the input if it 
    //  .or(Entry_.kanjis.contains(queryText))
      // search the query converted to hiragana
    //  .or(Entry_.readings.contains(hiraText))
      // search the query converted to katakana
    //  .or(Entry_.readings.contains(kataText))
    //).build();
    //List<_jmdict.Entry> searchResults = query.find();
    //query.close();

    List<_jmdict.Entry> query = GetIt.I<Box<_jmdict.Entry>>().getMany(
      List.generate(500000, (index) => index+1)
    ).whereType<_jmdict.Entry>().toList();
    
    List<_jmdict.Entry> searchResults = query.where((_jmdict.Entry element) => 
      element.readings.any((String value) => value.contains(queryText)) ||
      element.kanjis.any((String value) => value.contains(queryText)) ||
      element.readings.any((String value) => value.contains(hiraText)) ||
      element.readings.any((String value) => value.contains(kataText))
    ).toList();

    // SORT
    // first sort by frequency
    //searchResults.sort((a, b) => a.)

    

    return sortJmdictList(searchResults, queryText);
  }

  List<_jmdict.Entry> sortJmdictList(List<_jmdict.Entry> entries, String queryText){

    // list with three sub lists
    // 0 - full matchs
    // 1 - matchs starting at the word beginning
    // 2 - other matches
    List<List<_jmdict.Entry>> matches = [[], [], []];
    String queryTextHira = GetIt.I<KanaKit>().toHiragana(queryText);

    for (_jmdict.Entry entry in entries) {

      // kanji
      Tuple3 result = rankMatchs(entry.kanjis, queryText);
      if(result.item1 != -1) matches[result.item1].add(entry);

      // kana
      result = rankMatchs(entry.readings, queryTextHira);
      if(result.item1 != -1) matches[result.item1].add(entry);

      // translation
      var k = entry.meanings.where(
        (e) => ["en"].contains(isoToiso639_1[e.language]!.name)
      ).toList();
      k = k;
      //result = rankMatchs(
      //  entry.meanings.map((e) => e.meanings).toList(), 
      //  queryTextHira
      //);
      //if(result.item1 != -1) matches[result.item1].add(entry);
      //print(" ");
    }
    return matches.expand((element) => element).toList();
  }

  ///
  ///
  /// Returns a Tuple with the structure:
  ///   1 - if it was a full (0), start(1) or other(2) match
  ///   2 - t
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
        lenDiff = k[matchIndex].length - queryText.length;
        result = 2;
      }
    }

    return Tuple3(result, lenDiff, matchIndex);
  }
}