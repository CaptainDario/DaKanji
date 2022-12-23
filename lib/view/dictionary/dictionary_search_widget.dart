import 'package:da_kanji_mobile/model/DictionaryScreen/dictionary_search.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';


import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/model/DictionaryScreen/search_isolate.dart';
import 'package:da_kanji_mobile/provider/dict_search_result.dart';



/// The search widget for the dictionary.
/// 
/// Shows a searchbar when minimized, but can open to show search results.
class DictionarySearchWidget extends StatefulWidget {

  /// The query that should be initially searched
  final String initialSearch;
  /// The height the widget should take when expanded
  final double expandedHeight;

  const DictionarySearchWidget(
    {
      this.initialSearch = "",
      required this.expandedHeight,
      super.key
    }
  );

  @override
  State<DictionarySearchWidget> createState() => DictionarySearchWidgetState();
}

class DictionarySearchWidgetState extends State<DictionarySearchWidget>
  with SingleTickerProviderStateMixin{

  /// the text that was last entered in the search field
  String lastInput = "";
  /// the TextEditingController of the search field
  TextEditingController searchInputController = TextEditingController();
  /// Used to check if `widget.initialQuery` changed
  String initialSearch = "";
  /// Is the search list expanded or not
  bool expanded = false;
  /// The global key of the search input field (used to measure size)
  GlobalKey searchTextInputKey = GlobalKey();
  /// The height of the input searchfield
  double searchBarInputHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox r = searchTextInputKey.currentContext!.findRenderObject()! as RenderBox;
      searchBarInputHeight = r.size.height;
    });
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

    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: expanded ? Colors.grey : Colors.transparent,
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              key: searchTextInputKey,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                  child: IconButton(
                    splashRadius: 20,
                    icon: Icon(expanded ? Icons.arrow_back : Icons.search),
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                  ),
                ),
                // text input
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                    controller: searchInputController,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    onTap: () {
                      setState(() {
                        expanded = true;
                      });
                    },
                    onChanged: (text) async {
                      // only search in dictionary if the query changed
                      if(lastInput == text) {
                        return;
                      }

                      context.read<DictSearch>().currentSearch = text;
                      context.read<DictSearch>().searchResults =
                        await GetIt.I<DictionarySearch>().query(text);
                      lastInput = text;

                      setState(() {});
                    },
                  ),
                ),
                // Copy / clear button
                IconButton(
                  splashRadius: 20,
                  onPressed: () async {
                    if(searchInputController.text != ""){
                      searchInputController.text = "";
                      context.read<DictSearch>().currentSearch = "";
                      context.read<DictSearch>().searchResults = [];
                    }
                    else{
                      String data = (await Clipboard.getData('text/plain'))?.text ?? "";
                      data = data.replaceAll("\n", " ");
                      searchInputController.text = data;
                      context.read<DictSearch>().currentSearch = data;
                      context.read<DictSearch>().searchResults =
                        await GetIt.I<DictionarySearch>().query(data);
                    }
                    expanded = true;
                    setState(() { });
                  },
                  icon: Icon(
                    searchInputController.text == ""
                      ? Icons.copy
                      : Icons.clear,
                    size: 20,
                  ),
                ),
                // drawing screen button
                IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.brush),
                  onPressed: () {
                    setState(() {
                      expanded = true;
                    });
                    
                  },
                )
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: expanded 
              ? widget.expandedHeight - searchBarInputHeight
              : 0,
            child: SearchResultList(
              onSearchResultPressed: (entry) {
                setState(() {
                  expanded = false;
                });
              },
            ),
          )
        ],
      )
    );
  }
}
