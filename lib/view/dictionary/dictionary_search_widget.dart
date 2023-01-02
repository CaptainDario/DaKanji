import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/helper/japanese_text_processing.dart';
import 'package:da_kanji_mobile/model/DictionaryScreen/dictionary_search_util.dart';
import 'package:da_kanji_mobile/model/DictionaryScreen/dictionary_search.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_list.dart';
import 'package:da_kanji_mobile/provider/dict_search_result.dart';



/// The search widget for the dictionary.
/// 
/// Shows a searchbar when minimized, but can open to show search results.
class DictionarySearchWidget extends StatefulWidget {

  /// The query that should be initially searched
  final String initialSearch;
  /// The height the widget should take when expanded
  final double expandedHeight;
  /// Is the search expanded when instantiating this widget
  final bool isExpanded; 
  /// Can the search results be collapsed
  final bool canCollapse;

  const DictionarySearchWidget(
    {
      this.initialSearch = "",
      required this.expandedHeight,
      this.isExpanded = false,
      this.canCollapse = true,
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

    if(widget.isExpanded)
      expanded = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox r = searchTextInputKey.currentContext!.findRenderObject()! as RenderBox;
      searchBarInputHeight = r.size.height;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // check if there is an initial query or if it was update
    if(widget.initialSearch != initialSearch){
      searchInputController.text = widget.initialSearch;
      initialSearch = widget.initialSearch;
      updateSearchResults(initialSearch, true);
    }

    return Focus(
      focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputStep,
      child: Card(
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
                        icon: Icon(expanded && widget.canCollapse
                          ? Icons.arrow_back
                          : Icons.search),
                        onPressed: () {
                          if(!widget.canCollapse) return;
    
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
                        await updateSearchResults(text, true);
                        setState(() {});
                      },
                    ),
                  ),
                  // Copy / clear button
                  Focus(
                    focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputClearStep,
                    child: IconButton(
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
                          await updateSearchResults(data, true);
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
                  ),
                  // drawing screen button
                  Focus(
                    focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputDrawStep,
                    child: IconButton(
                      splashRadius: 20,
                      icon: Icon(Icons.brush),
                      onPressed: () {
                        setState(() {
                          expanded = true;
                        });
                        
                      },
                    ),
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
                onSearchResultPressed: (entry) async {
                  List<String> kanjis =
                    removeAllButKanji(context.read<DictSearch>().selectedResult!.kanjis);
                  context.read<DictSearch>().kanjiVGs = findMatchingKanjiSVG(kanjis);
                  context.read<DictSearch>().kanjiDic2s = findMatchingKanjiDic2(kanjis);
    
                  // collapse the search bar
                  if(widget.canCollapse)
                    setState(() {
                      expanded = false;
                    });
                },
              ),
            )
          ],
        )
      ),
    );
  }

  /// Searches in the dictionary and updates all search results and variables
  /// setState() needs to be called to update the ui.
  Future<void> updateSearchResults(String text, bool allowDeconjugation) async {
    // only search in dictionary if the query changed and is not empty
    if(lastInput == text || text == "") {
      return;
    }
    KanaKit k = GetIt.I<KanaKit>();
    String deconjugated = "";
    // try to deconjugate the input if allowed
    // convertable to hiragana (or is already japanese)
    // does not have spaces
    if(allowDeconjugation &&
      (k.isJapanese(text) || k.isJapanese(k.toHiragana(text))) &&
      !text.contains(" ")
      )
    {
      deconjugated = deconjugate(k.isJapanese(text) ? text : k.toHiragana(text));
      if(deconjugated != "" && k.isJapanese(deconjugated) && k.isRomaji(text))
        deconjugated = k.toRomaji(deconjugated);
    }

    // if the search query was changed show a snackbar and give the option to
    // use the original search
    if(deconjugated != "" && deconjugated != text){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Searched: $deconjugated"),
              InkWell(
                onTap: () async {
                  await updateSearchResults(text, false);
                  setState(() {});
                },
                child: Text(
                  "Search $text instead",
                  style: TextStyle(
                    color: Theme.of(context).highlightColor
                  ),                
                ),
              )
            ],
          )
        )
      );
    }
    else{
      deconjugated = text;
    }

    // update search variables and search
    context.read<DictSearch>().currentSearch = deconjugated;
    context.read<DictSearch>().searchResults =
      await GetIt.I<DictionarySearch>().query(deconjugated);
    lastInput = deconjugated;
  }
}
