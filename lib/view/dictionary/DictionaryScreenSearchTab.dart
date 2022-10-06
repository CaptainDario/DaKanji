import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as Jmdict;
import 'package:database_builder/objectbox.g.dart';

import 'package:da_kanji_mobile/view/dictionary/SearchResultCard.dart';
import 'package:da_kanji_mobile/provider/DictSearchResult.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';



class DictionaryScreenSearchTab extends StatefulWidget {
  DictionaryScreenSearchTab(
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
  late final initialQuery;

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
        Column(
          children: [
            SizedBox(height: widget.height*0.025,),
            Container(
              height: widget.height * 0.1,
              width: widget.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchInputController,
                          onChanged: (text) async {
                            // only search in dictionary if the query changed
                            if(lastInput == text)
                              return;

                            context.read<DictSearch>().currentSearch = text;
                            
                            setState(() {
                              context.read<DictSearch>().searchResults = searchInDict(text);
                              lastInput = text;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: widget.height * 0.1,
                        width: widget.height * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            searchInputController.clear();
                            context.read<DictSearch>().searchResults = [];
                          },
                          child: Icon(
                            Icons.clear
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: widget.height*0.025,),
            Container(
              height: widget.height * 0.85,
              width: widget.width,
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
        Positioned(
          bottom: widget.height*0.02,
          right: widget.width*0.02,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(24),
            ),
            onPressed: () {
              GetIt.I<Settings>().selectedDictionary = 
                GetIt.I<Settings>().settingsDrawing.inbuiltDictId;
              Navigator.pushNamed(context, "/drawing");
            },
            child: SizedBox(
              width: widget.width*0.08,
              height: widget.height*0.08,
              child: Icon(
                Icons.brush
              ),
            ),
          )
        )
      ],
    );
  }

  /// Searches `queryText` in the database
  List<Jmdict.Entry> searchInDict(String queryText){

    String hiraText = GetIt.I<KanaKit>().toHiragana(queryText);
    String kataText = GetIt.I<KanaKit>().toKatakana(queryText);

    var query = GetIt.I<Box<Jmdict.Entry>>().query(
      // search the query as is
      Entry_.readings.contains(queryText)
      // search the input if it 
      .or(Entry_.kanjis.contains(queryText))
      // search the query converted to hiragana
      .or(Entry_.readings.contains(hiraText))
      // search the query converted to katakana
      .or(Entry_.readings.contains(kataText))
    ).build();
    
    List<Jmdict.Entry> searchResults = query.find();
    query.close();

    return searchResults;
  }
}