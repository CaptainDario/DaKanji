import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';
import 'package:database_builder/database_builder.dart';
import 'package:isar/isar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/filter_popup_body.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/search_history/search_history.dart';
import 'package:da_kanji_mobile/application/helper/japanese_text_processing.dart';
import 'package:da_kanji_mobile/domain/dictionary/dictionary_search.dart';
import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';
import 'package:da_kanji_mobile/domain/dictionary/dict_search_result.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/dictionary/radical_popup_body.dart';
import 'package:da_kanji_mobile/widgets/widgets/multi_focus.dart';



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
  with TickerProviderStateMixin{

  /// the TextEditingController of the search field
  TextEditingController searchInputController = TextEditingController();
  /// Used to check if `widget.initialQuery` changed
  String initialSearch = "";
  /// Is the search list expanded or not
  bool searchBarExpanded = false;
  /// Animation for closing and opening the search bar
  late Animation<double> searchBarAnimation;
  /// AnimationController for closing and opening the search bar
  late AnimationController searchBarAnimationController;
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
      searchBarExpanded = true;
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

    return MultiFocus(
      focusNodes: [
        GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputStep,
        GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputWildcardsStep,
      ],
      child: Card(
        child: Column(
          children: [
            // the search bar
            Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                    color: searchBarExpanded ? Colors.grey : Colors.transparent,
                    style: BorderStyle.solid
                  )
                )
              ),
              child: Row(
                key: searchTextInputKey,
                children: [
                  // magnifying glass icon button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                    child: IconButton(
                      splashRadius: 20,
                      icon: Icon(searchBarExpanded && widget.canCollapse
                        ? Icons.arrow_back
                        : Icons.search),
                      onPressed: () {
                        if(!widget.canCollapse) return;
                
                        //close onscreen keyboard
                        FocusManager.instance.primaryFocus?.unfocus();
                
                        setState(() {
                          searchBarExpanded = !searchBarExpanded;
                
                          if(searchBarExpanded)
                            searchBarAnimationController.forward();
                          else{
                            searchBarAnimationController.reverse();
                          }
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
                        fontSize: 16
                      ),
                      onTap: () {
                        setState(() {
                          searchBarExpanded = true;
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(1000000),
                      onTap: onClipboardButtonPressed,
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          searchInputController.text == ""
                            ? Icons.paste
                            : Icons.clear,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // drawing screen button
                  if(widget.includeDrawButton)
                    Focus(
                      focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputDrawStep,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000000),
                        onTap: () {
                          setState(() {
                            searchBarExpanded = true;
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
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(Icons.brush)
                        ),
                      ),
                    ),
                  // filter button 
                  Focus(
                    focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchFilterStep,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(1000000),
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          //alignment: Alignment.bottomCenter,
                          dialogType: DialogType.noHeader,
                          btnCancelColor: g_Dakanji_red,
                          btnCancelOnPress: () {},
                          btnCancelText: LocaleKeys.DictionaryScreen_search_filter_close.tr(),
                          onDismissCallback: (dismissType) {
                            setState(() {
                              updateSearchResults(
                                searchInputController.text,
                                widget.allowDeconjugation
                              );
                            },);
                          },
                          body: FilterPopupBody(
                            height: widget.expandedHeight,
                            searchController: searchInputController,
                          )
                        ).show();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.filter_alt_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // radical button 
                  Focus(
                    focusNode: GetIt.I<Tutorials>().dictionaryScreenTutorial.searchRadicalStep,
                    child: InkWell(
                    borderRadius: BorderRadius.circular(1000000),
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.noHeader,
                          btnCancelColor: g_Dakanji_red,
                          btnCancelText: LocaleKeys.DictionaryScreen_search_radical_close.tr(),
                          btnCancelOnPress: () {},
                          onDismissCallback: (dismissType) {
                            setState(() {
                              updateSearchResults(
                                searchInputController.text,
                                widget.allowDeconjugation
                              );
                            });
                          },
                          body: RadicalPopupBody(
                            height: widget.expandedHeight,
                            kradIsar: GetIt.I<Isars>().krad,
                            searchController: searchInputController,
                          )
                        ).show();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Transform.translate(
                            offset: Offset(0, -2),
                            child: Text(
                              "部",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(width: 4,)
                ],
              ),
            ),
            if(searchBarInputHeight != 0)
              AnimatedBuilder(
                animation: searchBarAnimation,
                builder: (context, child) {
                  return Container(
                    height: (widget.expandedHeight - searchBarInputHeight)
                      * searchBarAnimation.value,
                    child: child 
                  );
                },
                child: Stack(
                  children: [
                    context.read<DictSearch>().currentSearch != ""
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
                      ),
                  ],
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
        searchBarExpanded = false;
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
    searchBarExpanded = true;
    searchBarAnimationController.forward();
    setState(() { });
  }

  /// Searches in the dictionary and updates all search results and variables
  /// setState() needs to be called to update the ui.
  Future<void> updateSearchResults(String text, bool allowDeconjugation) async {
    // only search in dictionary if the query is not empty (remove filters to check this)
    if(text.split(" ").where((e) => !e.startsWith("#")).join() == ""){
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
                  "${LocaleKeys.DictionaryScreen_search_searched.tr()} $deconjugated",
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
                    "${LocaleKeys.DictionaryScreen_search_search_for.tr()}  $text",
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
