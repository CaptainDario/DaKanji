import 'package:database_builder/objectbox.g.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:objectbox/objectbox.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_hive/dataClasses_objectbox.dart';
import 'package:da_kanji_mobile/view/dictionary/SearchResultCard.dart';
import 'package:da_kanji_mobile/model/Dict/DictIsolate.dart';
import 'package:get_it/get_it.dart';



class DictionaryScreenSearchTab extends StatefulWidget {
  DictionaryScreenSearchTab(
    this.height,
    this.width,
    {Key? key}
  ) : super(key: key);

  final double height;
  final double width;

  @override
  State<DictionaryScreenSearchTab> createState() => _DictionaryScreenSearchTabState();
}

class _DictionaryScreenSearchTabState extends State<DictionaryScreenSearchTab> {

  /// data object of the search results
  List searchResults = [];

  String lastInput = "";
  
  DictIsolate dictIsolate = DictIsolate();

  TextEditingController searchInputController = TextEditingController();

  @override
  void initState() {

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
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchInputController,
                          onChanged: (text) async {
                            updateSearchResults(text);
                          },
                        ),
                      ),
                      SizedBox(
                        height: widget.height * 0.1,
                        width: widget.height * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              searchInputController.clear();
                              searchResults = [];
                            });
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
                itemCount: searchResults.length,
                itemBuilder: ((context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: SearchResultCard(
                          searchResults[index].readings,
                          searchResults[index].kanjis,
                          searchResults[index].meanings[0].meanings,
                          searchResults[index].partOfSpeech
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
            onPressed: () {},
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

  Future<void> updateSearchResults(String query) async {

    // only search in dictionary if the input text changed
    if(!(lastInput != query))
      return;

    searchResults = GetIt.I<Box<Jm_enam_and_dict_Entry>>().query(
      Jm_enam_and_dict_Entry_.readings.contains(query)
    ).build().find();

    setState(() {
      lastInput = query;
    });
  }
}