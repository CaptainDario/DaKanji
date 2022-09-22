import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:database_builder/objectbox.g.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_hive/dataClasses_objectbox.dart';

import 'package:da_kanji_mobile/view/dictionary/SearchResultCard.dart';
import 'package:da_kanji_mobile/provider/DictSearchResult.dart';



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

  /// the text that was last entered in the search field
  String lastInput = "";
  /// the TextEditingController of the search field
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
                            // only search in dictionary if the query changed
                            if(!(lastInput != text))
                              return;

                            context.read<DictSearch>().currentSearch = text;

                            context.read<DictSearch>().searchResults = 
                              GetIt.I<Box<Jm_enam_and_dict_Entry>>().query(
                                Jm_enam_and_dict_Entry_.readings.contains(text)
                              ).build().find();

                            setState(() {
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
                            setState(() {
                              searchInputController.clear();
                              context.read<DictSearch>().searchResults = [];
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
                itemCount: context.watch<DictSearch>().searchResults.length,
                itemBuilder: ((context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: SearchResultCard(
                          context.watch<DictSearch>().searchResults[index],
                          onPressed: (selection) {
                            setState(() {
                              context.read<DictSearch>().selectedResult = 
                                context.read<DictSearch>().searchResults[index];
                            });
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