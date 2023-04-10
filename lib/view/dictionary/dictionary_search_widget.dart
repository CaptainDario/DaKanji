import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';
import 'package:database_builder/database_builder.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/search_history.dart';
import 'package:da_kanji_mobile/helper/japanese_text_processing.dart';
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
  /// should the button to navigate to the drawing screen be included
  final bool includeDrawButton;
  /// should queries be deconjugated
  final bool allowDeconjugation;

  const DictionarySearchWidget(
    {
      this.initialSearch = "",
      required this.expandedHeight,
      this.isExpanded = false,
      this.canCollapse = true,
      this.includeDrawButton = true,
      this.allowDeconjugation = true,
      super.key
    }
  );

  @override
  State<DictionarySearchWidget> createState() => DictionarySearchWidgetState();
}

class DictionarySearchWidgetState extends State<DictionarySearchWidget>
  with SingleTickerProviderStateMixin{

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
  /// The FoucsNode of the search input field
  FocusNode searchTextFieldFocusNode = FocusNode();
  /// A list containing the ids of all searches the user made
  /// matches the search history Isar collection
  List<int> searchHistoryIds = [];
  /// A list containing all searches the user made
  late List<JMdict?> searchHistory;
  /// AnimationController for closing and opening the search bar
  late AnimationController searchBarAnimationController;
  /// Animation for closing and opening the search bar
  late Animation<double> searchBarAnimation;

  
  
  @override
  void initState() {
    super.initState();

    searchBarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    searchBarAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: searchBarAnimationController,
      curve: Curves.easeIn
    ));

    updateSearchHistoryIds();
    init();
    
  }

  @override
  void didUpdateWidget(covariant DictionarySearchWidget oldWidget) {
    
    updateSearchHistoryIds();
    init();

    super.didUpdateWidget(oldWidget);
  }

  /// init this widget on init or rebuild
  void init(){
    if(widget.isExpanded){
      expanded = true;
      searchBarAnimationController.value = 1.0;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      RenderBox r = searchTextInputKey.currentContext!.findRenderObject()! as RenderBox;
      searchBarInputHeight = r.size.height;

      // check if there is an initial query or if it was update
      if(widget.initialSearch != initialSearch){
        searchInputController.text = widget.initialSearch;
        initialSearch = widget.initialSearch;
        await updateSearchResults(initialSearch, widget.allowDeconjugation);
      }
      if(mounted)
        setState(() {});
    });
  }

  @override
  void dispose() {
    searchBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                  // magnifying glass icon button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                    child: IconButton(
                      splashRadius: 20,
                      icon: Icon(expanded && widget.canCollapse
                        ? Icons.arrow_back
                        : Icons.search),
                      onPressed: () {
                        if(!widget.canCollapse) return;

                        //close onscreen keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        setState(() {
                          expanded = !expanded;

                          if(expanded)
                            searchBarAnimationController.forward();
                          else
                            searchBarAnimationController.reverse();
                        });
                      },
                    ),
                  ),
                  // text input
                  Expanded(
                    child: TextField(
                      focusNode: searchTextFieldFocusNode,
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
                          searchBarAnimationController.forward();
                        });
                      },
                      onChanged: (text) async {
                        await updateSearchResults(text, widget.allowDeconjugation);
                        setState(() {});
                      },
                    ),
                  ),
                  // Copy / clear button
                  Focus(
                    focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputClearStep,
                    child: IconButton(
                      splashRadius: 20,
                      onPressed: onClipboardButtonPressed,
                      icon: Icon(
                        searchInputController.text == ""
                          ? Icons.paste
                          : Icons.clear,
                        size: 20,
                      ),
                    ),
                  ),
                  // drawing screen button
                  if(widget.includeDrawButton)
                    Focus(
                      focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputDrawStep,
                      child: IconButton(
                        splashRadius: 20,
                        icon: Icon(Icons.brush),
                        onPressed: () {
                          setState(() {
                            expanded = true;
                          });
                          GetIt.I<Settings>().drawing.selectedDictionary =
                            GetIt.I<Settings>().drawing.inbuiltDictId;
                          Navigator.pushNamedAndRemoveUntil(
                            context, 
                            "/drawing",
                            (route) => true,
                            arguments: NavigationArguments(
                              false, drawSearchPrefix: searchInputController.text
                            )
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
            if(searchBarInputHeight != 0)
              AnimatedBuilder(
                animation: searchBarAnimation,
                builder: (context, child) {
                  return Container(
                    //duration: Duration(milliseconds: 400),
                    //curve: Curves.easeInOut,
                    height: (widget.expandedHeight - searchBarInputHeight)
                        * searchBarAnimation.value,
                    child: child 
                  );
                },
                child: context.read<DictSearch>().currentSearch != ""
                  // search results if the user entered text
                  ? SearchResultList(
                    searchResults: context.watch<DictSearch>().searchResults,
                    onSearchResultPressed: onSearchResultPressed,
                    showWordFrequency: GetIt.I<Settings>().dictionary.showWordFruequency,
                  )
                  // otherwise the search history
                  : SearchResultList(
                    searchResults: searchHistory,
                    onSearchResultPressed: onSearchResultPressed,
                    //reversed: true,
                    showWordFrequency: GetIt.I<Settings>().dictionary.showWordFruequency,
                    onDismissed: (direction, entry, idx) async {
                      int id = searchHistoryIds.removeAt(
                        (idx).toInt()
                      );
                      
                      await GetIt.I<Isars>().searchHistory.writeTxn(() async {
                        final success = await GetIt.I<Isars>().searchHistory.searchHistorys
                          .delete(id);
                        debugPrint('Deleted search history entry: $success');
                      });
                      setState(() {
                        updateSearchHistoryIds();
                      });
                    }
                  )
              )
          ],
        )
      ),
    );
  }

  /// updates the search history
  void updateSearchHistoryIds(){
    searchHistoryIds = GetIt.I<Isars>().searchHistory.searchHistorys.where()
      .sortByDateSearchedDesc()
      .idProperty()
      .findAllSync();
    List<int> ids = GetIt.I<Isars>().searchHistory.searchHistorys.where()
      .sortByDateSearchedDesc()
      .dictEntryIdProperty()
      .findAllSync();
    searchHistory = GetIt.I<Isars>().dictionary.jmdict
      .getAllSync(ids)
      .toList();
  }

  /// callback that is executed when the user presses on a search result
  void onSearchResultPressed(JMdict entry) async {
    // update search variables
    context.read<DictSearch>().selectedResult = entry;

    // store new search in search history
    var isar = GetIt.I<Isars>().searchHistory;
    await isar.writeTxn(() async {
      await isar.searchHistorys.put(SearchHistory()
        ..dateSearched = DateTime.now()
        ..dictEntryId  = entry.id
        ..schema       = DatabaseType.JMDict
      );
    });
    searchHistory.add(entry);

    // collapse the search bar
    if(widget.canCollapse){
      setState(() {
        expanded = false;
        searchBarAnimationController.reverse();
      });
    }

    // close the keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// callback when the copy/paste from clipboard button is pressed
  void onClipboardButtonPressed() async {
    if(searchInputController.text != ""){
      searchInputController.text = "";
      context.read<DictSearch>().currentSearch = "";
      context.read<DictSearch>().searchResults = [];
      searchTextFieldFocusNode.requestFocus();
    }
    else{
      String data = (await Clipboard.getData('text/plain'))?.text ?? "";
      data = data.replaceAll("\n", " ");
      searchInputController.text = data;
      await updateSearchResults(data, widget.allowDeconjugation);
    }
    expanded = true;
    searchBarAnimationController.forward();
    setState(() { });
  }

  /// Searches in the dictionary and updates all search results and variables
  /// setState() needs to be called to update the ui.
  Future<void> updateSearchResults(String text, bool allowDeconjugation) async {
    // only search in dictionary if the query is not empty
    if(text == ""){
      context.read<DictSearch>().currentSearch = "";
      context.read<DictSearch>().searchResults = [];
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
              Expanded(
                child: Text(
                  "Searched: $deconjugated",
                  overflow: TextOverflow.ellipsis
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await updateSearchResults(text, false);
                    setState(() {});
                  },
                  child: Text(
                    "Search for: $text",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).highlightColor
                    ),                
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
      await GetIt.I<DictionarySearch>().query(deconjugated) ?? [];
  }
}
