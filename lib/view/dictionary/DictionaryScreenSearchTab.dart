import 'package:da_kanji_mobile/view/dictionary/SearchResultCard.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';



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

  /// Global key to add/remove elements from the search result list UI
  final GlobalKey<AnimatedListState> animatedListKey =
    GlobalKey<AnimatedListState>();
  /// data onject of the search results
  List searchResults = [];

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
                  child: TextField(
                    onChanged: (text) {
                      // remove old search results
                      for (var i = 0; i < searchResults.length; i++) {
                        animatedListKey.currentState!.removeItem(0, 
                          (context, animation) => Opacity(
                            opacity: animation.value,
                          ),
                        );
                      }

                      // lookup words in database
                      var box = Hive.box('jm_enam_and_dict');
                      searchResults = box.values.where((entry) => 
                        entry.readings.contains(text) ? true : false
                      ).toList();

                      // add new search results with staggered effect
                      Future ft = Future((){});
                      for (var i = 0; i < searchResults.length; i++) {
                        ft = ft.then((value) {
                          return Future.delayed(Duration(milliseconds: 50), (){
                            animatedListKey.currentState!.insertItem(i);
                          });
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: widget.height*0.025,),
            Container(
              height: widget.height * 0.85,
              width: widget.width,
              child: AnimatedList(
                key: animatedListKey,
                initialItemCount: 0,
                itemBuilder: ((context, index, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SearchResultCard(
                      searchResults[index].readings.join(", "),
                      searchResults[index].kanjis.join(", "),
                      () {
                        String s = searchResults[index].meanings[0].meanings.join(", ");
                        if(s.length > 50) s = s.substring(0, 50);
                        return s;
                      } (),
                    )
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
}