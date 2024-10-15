// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_alt_search_flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/deconjugate.dart';
import 'package:da_kanji_mobile/entities/dictionary/dict_search_result.dart';
import 'package:da_kanji_mobile/entities/dictionary/dictionary_search.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/navigation_arguments.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/search_history/search_history_sql.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/filter_popup_body.dart';
import 'package:da_kanji_mobile/widgets/dictionary/radical_popup_body.dart';
import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';
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
  /// should queries be converted to kana if possible
  final bool convertToKana;
  /// should queries be deconjugated
  final bool allowDeconjugation;
  /// The current build context
  final BuildContext context;

  const DictionarySearchWidget(
    {
      this.initialSearch = "",
      required this.expandedHeight,
      this.isExpanded = false,
      this.canCollapse = true,
      this.includeDrawButton = true,
      required this.convertToKana,
      this.allowDeconjugation = true,
      required this.context,
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
  /// Timer to wait during resize event until popup will be opened again
  Timer? reopenPopupTimer;
  /// is the radical popup open
  bool radicalPopupOpen = false;
  /// is the filter popup open
  bool filterPopupOpen = false;
  /// should the radical popup be openend when `reopenPopupTimer` finishes
  bool reshowRadicalPopup = false;
  /// should the filter popup be openend when `reopenPopupTimer` finishes
  bool reshowFilterPopup = false;
  /// The flusbar that shows that a word has been deconjugated
  Flushbar? deconjugationFlushbar;

  
  @override
  void initState() {
    super.initState();

    searchBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    searchBarAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: searchBarAnimationController,
      curve: Curves.easeIn
    ));

    init();
    
  }

  @override
  void didUpdateWidget(covariant DictionarySearchWidget oldWidget) {

    init();

    if(radicalPopupOpen || filterPopupOpen){

      reshowRadicalPopup = radicalPopupOpen;
      reshowFilterPopup  = filterPopupOpen;

      Navigator.of(context).pop();
      reopenPopupTimer?.cancel();
      reopenPopupTimer = Timer(const Duration(seconds: 1), () {
        
        if(reshowRadicalPopup) showRadicalPopup();
        if(reshowFilterPopup) showFilterPopup();

        reshowFilterPopup = false; reshowRadicalPopup = false;
      });
    }

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
        await updateSearchResults(initialSearch,
          widget.convertToKana, widget.allowDeconjugation);
      }
      if(mounted) {
        setState(() {});
      }
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
      child: PopScope(
        canPop: context.read<DictSearch>().selectedResult == null &&
                !searchBarExpanded,
        onPopInvokedWithResult: (didPop, result) {
          if(searchBarExpanded) {
            collapseSearchBar();
          }
          else if (context.read<DictSearch>().selectedResult != null){
            context.read<DictSearch>().selectedResult = null;
            searchInputController.text = "";
            context.read<DictSearch>().currentSearch = "";
            context.read<DictSearch>().searchResults = [];
          }
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.white,
            ),
            child: Column(
              children: [
                // the search bar
                Container(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(
                        color: searchBarExpanded
                          ? Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey.shade800
                            : Colors.grey.shade300 
                          : Colors.transparent,
                        style: BorderStyle.solid
                      )
                    )
                  ),
                  child: Row(
                    key: searchTextInputKey,
                    children: [
                      // magnifying glass / arrow back icon button
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
                                      
                            if(!searchBarExpanded) {
                              openSearchBar();
                            }
                            else{
                              collapseSearchBar();
                            }
                          },
                        ),
                      ),
                      // text input
                      Expanded(
                        child: TextField(
                          focusNode: searchTextFieldFocusNode,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                          controller: searchInputController,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16
                          ),
                          onTap: () {
                            searchTextFieldFocusNode.requestFocus();
                            setState(() {
                              searchBarExpanded = true;
                              searchBarAnimationController.forward();
                            });
                          },
                          onChanged: (text) async {

                            text = text.trim();
                            
                            await updateSearchResults(text,
                              widget.allowDeconjugation,
                              widget.convertToKana,);
                            
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
                          onLongPress: onClipboardButtonPressed,
                          child: SizedBox(
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
                                widget.context, 
                                "/${Screens.drawing.name}",
                                (route) => true,
                                arguments: NavigationArguments(
                                  false,
                                  drawSearchPrefix: searchInputController.text.isNotEmpty
                                    ? searchInputController.text.substring(
                                      0,
                                      searchInputController.selection.baseOffset == -1
                                        ? searchInputController.text.length
                                        : searchInputController.selection.baseOffset
                                    )
                                    : "",
                                  drawSearchPostfix: searchInputController.text.isNotEmpty
                                    ? searchInputController.text.substring(
                                      searchInputController.selection.baseOffset == -1
                                        ? searchInputController.text.length
                                        : searchInputController.selection.baseOffset
                                    )
                                    : ""
                                )
                              );
                            },
                            child: const SizedBox(
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
                          onTap: showFilterPopup,
                          child: const SizedBox(
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
                          onTap: showRadicalPopup,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Transform.translate(
                                offset: const Offset(0, -2),
                                child: const Text(
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
                      const SizedBox(width: 4,)
                    ],
                  ),
                ),
                if(searchBarInputHeight != 0)
                  AnimatedBuilder(
                    animation: searchBarAnimation,
                    builder: (context, child) {
                      return SizedBox(
                        height: (widget.expandedHeight - searchBarInputHeight)
                          * searchBarAnimation.value,
                        child: child,
                      );
                    },
                    child: Stack(
                      children: [
                        widget.context.read<DictSearch>().currentSearch != ""
                          // search results if the user entered text
                          ? SearchResultList(
                            searchResults: widget.context.watch<DictSearch>().searchResults,
                            onSearchResultPressed: onSearchResultPressed,
                            showWordFrequency: GetIt.I<Settings>().dictionary.showWordFruequency,
                            init: (controller) {},
                          )
                          // otherwise the search history
                          : StreamBuilder<List<SearchHistorySQLData>>(
                            stream: GetIt.I<SearchHistorySQLDatabase>().watchAllSearchHistoryIDs(),
                            builder: (context, snapshot) {
              
                              if(snapshot.data == null) return const SizedBox();
              
                              List<JMdict> searchHistory = [];
                              List<int> sqlIDs = [];
                              if(snapshot.hasData){
                                final ids = snapshot.data!.map((e) => e.dictEntryID).toList();
                                searchHistory = GetIt.I<Isars>().dictionary.jmdict
                                  .getAllSync(ids)
                                  .nonNulls.toList();
              
                                sqlIDs = snapshot.data!.map((e) => e.id).toList();
                              }
              
                              return SearchResultList(
                                searchResults: searchHistory,
                                showWordFrequency: GetIt.I<Settings>().dictionary.showWordFruequency,
                                alwaysAnimateIn: false,
                                init: (controller) {},
                                onSearchResultPressed: onSearchResultPressed,
                                onDismissed: (direction, entry, idx) => 
                                  GetIt.I<SearchHistorySQLDatabase>().deleteEntry(
                                    sqlIDs[idx]
                                  ),
                              );
                            }
                          ),
                      ],
                    )
                  )
              ],
            )
          ),
        ),
      ),
    );
  }

  /// Opens the search bar
  void openSearchBar(){
    
    searchBarExpanded = true;
    searchBarAnimationController.forward();

    setState(() {});

  }

  /// Collapses the search bar
  void collapseSearchBar(){
    
    searchBarAnimationController.reverse().then((value) {
      setState(() {
        searchBarExpanded = false;
      });
    });

    setState(() {});

  }

  /// Deletes an entry from the search history when the user swipes (deletes)
  /// it
  Future onDismissedHistoryEntry(DismissDirection direction, JMdict entry, int idx) async {

    GetIt.I<SearchHistorySQLDatabase>().deleteEntry(entry.id);

  }

  /// opens the filter popup and applies the selected filters if necessary
  Future showFilterPopup() async {

    filterPopupOpen = true;

    await AwesomeDialog(
      context: widget.context,
      dialogType: DialogType.noHeader,
      bodyHeaderDistance: 0,
      alignment: Alignment.bottomCenter,
      onDismissCallback: (dismissType) async {
        await updateSearchResults(
          searchInputController.text,
          widget.allowDeconjugation,
           widget.convertToKana,
        );
        filterPopupOpen = false;
      },
      body: FilterPopupBody(
        height: widget.expandedHeight - searchBarInputHeight*1.1,
        searchController: searchInputController,
      )
    ).show();
  }

  /// opens the radical popup and applies the selected filters if necessary
  Future showRadicalPopup() async {

    radicalPopupOpen = true;
    
    await AwesomeDialog(
      context: widget.context,
      isDense: true,
      dialogType: DialogType.noHeader,
      bodyHeaderDistance: 0,
      alignment: Alignment.bottomCenter,
      onDismissCallback: (dismissType) async {
        await updateSearchResults(
          searchInputController.text,
          widget.allowDeconjugation,
          widget.convertToKana,
        );
        radicalPopupOpen = false;
      },
      body: RadicalPopupBody(
        height: widget.expandedHeight - searchBarInputHeight*1.1,
        kradIsar: GetIt.I<Isars>().krad.krads,
        radkIsar: GetIt.I<Isars>().radk.radks,
        searchController: searchInputController,
      )
    ).show();
  }

  /// callback that is executed when the user presses on a search result
  void onSearchResultPressed(JMdict entry) async {
    // update search variables
    context.read<DictSearch>().selectedResult = entry;

    // store new search in search history
    GetIt.I<SearchHistorySQLDatabase>().addEntry(entry);

    // collapse the search bar
    if(widget.canCollapse){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        
        searchBarAnimationController.reverse(from: 1.0).then((value) {
          setState(() {
            searchBarExpanded = false;
          });
        });
      }); 
    }

    // close the keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// callback when the copy/paste from clipboard button is pressed
  void onClipboardButtonPressed() async {
    if(searchInputController.text != ""){
      searchInputController.text = "";
      widget.context.read<DictSearch>().currentSearch = "";
      widget.context.read<DictSearch>().searchResults = [];
      searchTextFieldFocusNode.requestFocus();
    }
    else{
      String data = (await Clipboard.getData('text/plain'))?.text ?? "";
      data = data.replaceAll("\n", " ");
      searchInputController.text = data;
      await updateSearchResults(data, widget.convertToKana, widget.allowDeconjugation);
    }
    searchBarExpanded = true;
    searchBarAnimationController.forward();
    setState(() { });
  }

  /// Searches in the dictionary and updates all search results and variables
  /// setState() needs to be called to update the ui.
  Future<void> updateSearchResults(
    String text, bool convertToHiragana, bool allowDeconjugation) async {

    // hide all flushbars from previous searches
    deconjugationFlushbar?.dismiss();

    // only search in dictionary if the query is not empty (remove filters to check this)
    if(text.split(" ").where((e) => !e.startsWith("#")).join() == ""){
      widget.context.read<DictSearch>().currentSearch = "";
      widget.context.read<DictSearch>().searchResults = [];
      return;
    }

    KanaKit k = GetIt.I<KanaKit>();
    String deconjugated = "";
    // try to deconjugate the input if
    // 1. allowed
    // 2. convertable to hiragana (or is already japanese)
    // 3. does not have spaces
    if(allowDeconjugation &&!text.contains(" ") && 
      (k.isJapanese(text) || k.isJapanese(k.toKana(text))))
    {
      deconjugated = deconjugate(k.isJapanese(text) ? text : k.toHiragana(k.toKana(text)));
    }

    // if romaji conversion setting is enabled, convert query to hiragana
    String? queryKana; KanaKit kKitRomaji = const KanaKit();
    if(convertToHiragana) {
      String t = kKitRomaji.toHiragana(kKitRomaji.toKana(text));
      // assure that the outcome is japanese
      if(kKitRomaji.isJapanese(t)) queryKana = t;
    }

    // if the search query was changed show a snackbar and give the option to
    // use the original search
    if(deconjugated != "" && deconjugated != text){

      deconjugationFlushbar = DictionaryAltSearchFlushbar(
          text,
          text != queryKana ? queryKana : null,
          queryKana != deconjugated ? queryKana : null,
          onAltSearchTapped
        )
        .build(context)..show(context).then((value) {
          deconjugationFlushbar = null;
          return value;
        }
      );
    }
    else{
      deconjugated = text;
    }

    // update search variables and search
    widget.context.read<DictSearch>().currentSearch = text;
    widget.context.read<DictSearch>().searchResults =
      await GetIt.I<DictionarySearch>().search(
        text,
        queryKana != text ? queryKana : null,
        deconjugated != text ? deconjugated : null) ?? [];
  }

  /// when the user taps on an alternative search term from the flushbar
  void onAltSearchTapped(String text) async {

    searchInputController.text = text;
    await updateSearchResults(text, false, false);
    deconjugationFlushbar?.dismiss();

  }
}

