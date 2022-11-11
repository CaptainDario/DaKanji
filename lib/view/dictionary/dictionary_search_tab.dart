import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;

import 'package:da_kanji_mobile/model/DictionaryScreen/dictionary_search.dart';
import 'package:da_kanji_mobile/model/DictionaryScreen/search_isolate.dart';
import 'package:da_kanji_mobile/view/dictionary/radical_search_widget.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_card.dart';
import 'package:da_kanji_mobile/provider/dict_search_result.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';




class DictionarySearchTab extends StatefulWidget {
  const DictionarySearchTab(
    this.height,
    this.width,
    {
      this.initialSearch = "",
      this.includeActionButton = true,
      this.onSearchResultPressed,
      Key? key
    }
  ) : super(key: key);

  
  /// height of this widget
  final double height;
  /// width of this widget
  final double width;
  /// The query that should be initially searched
  final String initialSearch;
  /// should the action button to open the drawing screen be included
  final bool includeActionButton;
  /// callback when on a search result was pressed
  final Function(isar_jm.Entry selection)? onSearchResultPressed;

  @override
  State<DictionarySearchTab> createState() => _DictionarySearchTabState();
}

class _DictionarySearchTabState extends State<DictionarySearchTab> {

  /// the text that was last entered in the search field
  String lastInput = "";
  /// the TextEditingController of the search field
  TextEditingController searchInputController = TextEditingController();
  /// Used to check if `widget.initialQuery` changed
  String initialSearch = "";
  ///
  final GlobalKey<AnimatedListState> _searchResultsListKey = GlobalKey<AnimatedListState>();

  final SearchIsolate searchIsolate = SearchIsolate(1, ["eng"]);

  @override
  void initState() {
    searchIsolate.init();
    super.initState();
  }

  @override
  void dispose() {
    //searchIsolate.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    // check if there is an initial query or if it was update
    if(widget.initialSearch != initialSearch){
      searchInputController.text = widget.initialSearch;
      initialSearch = widget.initialSearch;
    }

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

                            context.read<DictSearch>().currentSearch = text;
                            context.read<DictSearch>().searchResults =
                              await searchIsolate.query(text);
                            lastInput = text;

                            setState(() {});
                          },
                        ),
                      ),
                      // Radical search
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
                      // Copy / clear button
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
                            context.read<DictSearch>().searchResults =
                              await searchIsolate.query(data);
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
                child: 
                ListView.builder(
                  itemCount: context.watch<DictSearch>().searchResults.length,
                  itemBuilder: ((context, index) {
                    return SearchResultCard(
                      dictEntry: context.watch<DictSearch>().searchResults[index],
                      resultIndex: index,
                      onPressed: (selection) {
                        context.read<DictSearch>().selectedResult = selection;
                        if(widget.onSearchResultPressed != null)
                          widget.onSearchResultPressed!(selection);
                      } 
                    );
                  })
                ),
              ),
            ],
          ),
        ),
        if(widget.includeActionButton) 
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

  
}