// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:da_db/util/da_db_search_manager.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/active_filters_row.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/draw_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/example_dictionary_search_popup_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/filter_suggestion_tile.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/paste_clear_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/radical_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/search_syntax_controller.dart';
import 'package:da_kanji_mobile/globals.dart';
import '../search_results/dictionary_search_result_widget.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/dictionary/model/dictionary_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:language_processing/language_processing.dart';
import 'package:da_kanji_mobile/features/dictionary/controller/isars.dart';
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/word_tab/radical_popup_body.dart';
import 'package:da_kanji_mobile/core/widgets/multi_focus.dart';

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

  const DictionarySearchWidget(
    {
      this.initialSearch = "",
      required this.expandedHeight,
      this.isExpanded = false,
      this.canCollapse = true,
      this.includeDrawButton = true,
      super.key
    }
  );

  @override
  State<DictionarySearchWidget> createState() => DictionarySearchWidgetState();
}

class DictionarySearchWidgetState extends State<DictionarySearchWidget>
  with TickerProviderStateMixin{


  /// the TextEditingController of the search field
  /// 
  /// Also handles syntax highliting
  DictionarySearchController searchInputController = DictionarySearchController();
  /// Used to check if `widget.initialQuery` changed
  String initialSearch = "";
  /// Is the search bar initially expanded
  bool initiallyExpanded = false;
  /// The height of the input searchfield
  double searchBarInputHeight = 0;
  /// The FoucsNode of the search input field
  FocusNode searchTextFieldFocusNode = FocusNode();
  /// Timer to wait during resize event until popup will be opened again
  Timer? reopenPopupTimer;
  /// is the radical popup open
  bool radicalPopupOpen = false;
  /// should the radical popup be openend when `reopenPopupTimer` finishes
  bool reshowRadicalPopup = false;

  
  @override
  void initState() {
    super.initState();

    initiallyExpanded = widget.isExpanded;

    init();
    
  }

  @override
  void didUpdateWidget(covariant DictionarySearchWidget oldWidget) {

    init();

    if(radicalPopupOpen){

      reshowRadicalPopup = radicalPopupOpen;

      Navigator.of(context).pop();
      reopenPopupTimer?.cancel();
      reopenPopupTimer = Timer(const Duration(seconds: 1), () {
        
        if(reshowRadicalPopup) showRadicalPopup();

        reshowRadicalPopup = false;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  /// init this widget on init or rebuild
  void init(){

    if(initiallyExpanded){
      initiallyExpanded = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // check if there is an initial query or if it was update
      if(widget.initialSearch != initialSearch){
        searchInputController.text = widget.initialSearch;
        initialSearch = widget.initialSearch;
        updateSearchResults(initialSearch);
      }
      if(mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


@override
Widget build(BuildContext context) {
  return MultiFocus(
    focusNodes: [
      GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputStep,
      GetIt.I<Tutorials>().dictionaryScreenTutorial.searchInputWildcardsStep,
    ],
    child: SearchAnchor(
      searchController: searchInputController,
      dividerColor: context.watch<DictionarySearchState>().activeFilters.isNotEmpty
        ? Colors.transparent
        : Colors.grey,
        
      // 1. RENAME to barContext so we don't shadow the main context
      builder: (BuildContext barContext, SearchController controller) {
        return SearchBar(
          controller: controller,
          elevation: const WidgetStatePropertyAll(0), 
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.white,
          ),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.grey.shade800
                : Colors.grey.shade300
            )
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12.0)
          ),
          // Uses parent context safely
          leading: context.watch<DictionarySearchState>().activeFilters.isEmpty 
            ? const Icon(Icons.search) 
            : Badge(
                label: Text('${context.watch<DictionarySearchState>().activeFilters.length}'),
                child: const Icon(Icons.search),
              ),
          onTap: () {
            controller.openView();
          },
          onChanged: (text) async {
            text = text.trim();
            if (text.isNotEmpty && !controller.isOpen) {
              controller.openView();
            }
            updateSearchResults(text);
          },
          trailing: [
            PasteClearButton(
              controller: controller,
              onPressed: onClipboardButtonPressed,
            ),
            if(widget.includeDrawButton)
              DrawButton(controller: controller),
            RadicalButton(
              onPressed: showRadicalPopup,
            ),
            ExampleDictionarySearchPopupButton(
              exampleTerms: g_AppConfig.dictionaryDevToolTerms,
              onSelected: (p0) {
                controller.text = p0;
                controller.selection = TextSelection.collapsed(offset: controller.text.length);
                updateSearchResults(p0);
              },
            )
          ],
        );
      },

      // --- 2. THE VIEW BUILDER ---
      viewBuilder: (Iterable<Widget> suggestions) {
        return ChangeNotifierProvider<DictionarySearchState>.value(
          // Use parent context here to pass the state into the new route
          value: context.read<DictionarySearchState>(),
          builder: (innerContext, _) {
            final state = innerContext.watch<DictionarySearchState>();
            
            return Column(
              children: [
                if (state.activeFilters.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ActiveFiltersRow(
                        activeFilters: state.activeFilters.toList(),
                        onDeleted: (filter) {
                          state.activeFilters.remove(filter);
                          updateSearchResults(searchInputController.text.trim());
                        },
                      ),
                    ),
                  ),
                
                if (state.activeFilters.isNotEmpty) const Divider(height: 1),

                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: suggestions.toList(),
                  ),
                ),
              ],
            );
          },
        );
      },

      // --- 3. THE SUGGESTIONS BUILDER ---
      // 2. RENAME to suggestionContext so we don't shadow the main context
      suggestionsBuilder: (BuildContext suggestionContext, SearchController controller) async {
        final String input = controller.text.trim();
        
        // Because we renamed the parameter above, 'context' now correctly 
        // refers to the parent widget's context where the provider lives!
        final searchState = context.read<DictionarySearchState>();

        // CASE 1: EMPTY QUERY (History)
        if (input.isEmpty) {
          return _buildHistorySuggestions();
        }

        final segments = input.split(' ');
        final currentWord = segments.last.toLowerCase();

        // CASE 2: TAG SUGGESTIONS
        final tagSuggestions = _buildTagSuggestions(currentWord, controller, searchState.activeFilters);
        if (tagSuggestions != null) return tagSuggestions;

        // CASE 3: POS SUGGESTIONS
        final posSuggestions = _buildPosSuggestions(currentWord, controller, searchState.activeFilters);
        if (posSuggestions != null) return posSuggestions;

        // CASE 4: SEARCH RESULTS
        return _buildSearchResults(input);
      },
    ),
  );
}
/// Builds the placeholder list for search history when the query is empty
  Iterable<Widget> _buildHistorySuggestions() {
    return [
      ListView(
        padding: EdgeInsets.zero,
        children: const [
          ListTile(
            leading: Icon(Icons.history),
            title: Text("History placeholder"),
          ),
        ],
      ),
    ];
  }

  /// Checks for and builds tag-based suggestions (e.g., #n5, #common)
  Iterable<Widget>? _buildTagSuggestions(String currentWord, SearchController controller, Set<String> activeFilters) {
    final tagSuggestions = _getFilterSuggestions(
      currentWord: currentWord,
      prefix: '#',
      data: {'n5': 'JLPT N5', 'common': 'Common Word', 'verb': 'Verb class'},
      icon: Icons.tag,
      controller: controller,
      activeFilters: activeFilters,
    );

    if (tagSuggestions != null && tagSuggestions.isNotEmpty) {
      return [
        ListView(
          padding: EdgeInsets.zero,
          children: tagSuggestions.toList(),
        ),
      ];
    }
    return null;
  }

  /// Checks for and builds Part-of-Speech suggestions (e.g., $noun, $adj)
  Iterable<Widget>? _buildPosSuggestions(String currentWord, SearchController controller, Set<String> activeFilters) {
    final posSuggestions = _getFilterSuggestions(
      currentWord: currentWord,
      prefix: r'$',
      data: {'noun': 'Noun', 'adj': 'Adjective', 'adv': 'Adverb'},
      icon: Icons.category,
      controller: controller,
      activeFilters: activeFilters,
    );

    if (posSuggestions != null && posSuggestions.isNotEmpty) {
      return [
        ListView(
          padding: EdgeInsets.zero,
          children: posSuggestions.toList(),
        ),
      ];
    }
    return null;
  }

  /// Triggers a dictionary search and builds the UI for the results/loading states
  Iterable<Widget> _buildSearchResults(String input) {
    updateSearchResults(input);
    
    return [
      Consumer<DictionarySearchState>(
        builder: (context, state, child) {
          
          bool hasNoOldResults = state.results.isEmpty; 
          
          // 1. Loading with no previous results
          if (state.isSearching && hasNoOldResults) {
            return state.showLoading 
                ? const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 2.0),
                  )
                : const SizedBox.shrink();
          }

          // 2. We have results to show, or are done searching
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.isSearching && state.showLoading) 
                const LinearProgressIndicator(minHeight: 2.0), 

              Expanded(
                child: IgnorePointer(
                  ignoring: state.isSearching, 
                  child: AnimatedOpacity(
                    opacity: state.isSearching ? 0.4 : 1.0, 
                    duration: const Duration(milliseconds: 200), 
                    child: DictionarySearchResultWidget(
                      key: ValueKey('results_$input'),
                      result: state.results, 
                      onTap: onSearchResultPressed,
                      wrapWithScrollView: true, 
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ];
  }

  Iterable<Widget>? _getFilterSuggestions({
    required String currentWord,
    required String prefix,
    required Map<String, String> data,
    required IconData icon,
    required SearchController controller,
    required Set<String> activeFilters,
  }) {
    if (!currentWord.startsWith(prefix)) return null;

    final searchTerm = currentWord.substring(prefix.length);
    final matches = data.keys
      .where((key) => key.startsWith(searchTerm) && 
        !activeFilters.contains('$prefix$key')
      );

    return matches.map((key) => FilterSuggestionTile(
      filterKey: key,
      prefix: prefix,
      description: data[key]!,
      icon: icon,
      controller: controller,
      onSelected: () {
        context.read<DictionarySearchState>().activeFilters.add('$prefix$key');
        updateSearchResults(controller.text.trim());
      },
    ));
  }

  /// Deletes an entry from the search history when the user swipes (deletes)
  /// it
  Future onDismissedHistoryEntry(DismissDirection direction, JMdict entry, int idx) async {

    GetIt.I<UserDataDB>().searchHistoryDao.deleteEntry(entry.id);

  }

  /// opens the radical popup and applies the selected filters if necessary
  Future showRadicalPopup() async {

    radicalPopupOpen = true;
    
    await AwesomeDialog(
      context: context,
      isDense: true,
      dialogType: DialogType.noHeader,
      bodyHeaderDistance: 0,
      alignment: Alignment.bottomCenter,
      onDismissCallback: (dismissType) async {
        updateSearchResults(searchInputController.text);
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
  void onSearchResultPressed(DictionaryMatch match) async {
    // update search variables
    context.read<DictionarySearchState>().selectedResult = match;

    // TODO store new search in search history
    //GetIt.I<UserDataDB>().searchHistoryDao.addEntry(entry);

    // collapse the search bar
    if(widget.canCollapse) searchInputController.closeView(null);

    // close the keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// callback when the copy/paste from clipboard button is pressed
  void onClipboardButtonPressed() async {
    if(searchInputController.text != ""){
      searchInputController.text = "";
      context.read<DictionarySearchState>().currentSearch = "";
      searchTextFieldFocusNode.requestFocus();

      if(!searchInputController.isOpen) searchInputController.openView();
      
    }
    else{
      String data = (await Clipboard.getData('text/plain'))?.text ?? "";
      data = data.replaceAll("\n", " ");
      searchInputController.text = data;
      updateSearchResults(data);

      if(searchInputController.isOpen) searchInputController.closeView(null);
    }

    
  }

  /// Searches in the dictionary and updates the DictionarySearchState
  void updateSearchResults(String query) async {
    final searchState = context.read<DictionarySearchState>();
    
    // 1. Instantly update state to "Pending"
    searchState.isSearching = true; 
    searchState.showLoading = false; 
    searchState.startLoadingTimer(); 
      
    GetIt.I<DaDbSearchManager>().search(
      DictionarySearchParams(
        searchInput: query, options: ProcessorOptions()
      ),
      onResult: (p0) {
        if (!mounted) return; 

        // Search is done, Reset flags and update results
        searchState.cancelLoadingTimer();
        searchState.isSearching = false;
        searchState.showLoading = false; 
        
        searchState.results = p0 ?? DictionarySearchResult.empty();
      }
    );
  }


}
