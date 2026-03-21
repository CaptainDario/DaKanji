// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/active_filters_row.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/draw_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/example_dictionary_search_popup_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/filter_suggestion_tile.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/paste_clear_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/radical_button.dart';
import 'package:da_kanji_mobile/globals.dart';
import './search_results/dictionary_search_result_widget.dart';
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
import 'package:da_kanji_mobile/features/dictionary/widgets/radical_popup_body.dart';
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
  SearchController searchInputController = SearchController();
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
        await updateSearchResults(initialSearch);
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
      dividerColor: Colors.transparent,
      viewTrailing: [
        PasteClearButton(
          controller: searchInputController,
          onPressed: onClipboardButtonPressed,
        ),
        if(widget.includeDrawButton)
          DrawButton(controller: searchInputController),
        RadicalButton(
          onPressed: showRadicalPopup,
        ),
      ],

      builder: (BuildContext context, SearchController controller) {
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
          
          // --- THE BADGE IS NOW ON THE LEFT SEARCH ICON ---
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
            await updateSearchResults(text);
          },
          
          // Trailing area is clean again
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
      viewBuilder: (suggestions) {
        return ChangeNotifierProvider<DictionarySearchState>.value(
          value: context.watch<DictionarySearchState>(),
          child: Column(
            children: suggestions.toList(),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
          final String input = controller.text;
          
          // 1. We keep our top-level list to hold the static filters + the animated body
          List<Widget> topLevelWidgets = [];

          // --- PERSISTENT FILTERS (No animation, stays solid at the top) ---
          topLevelWidgets.add(
            StatefulBuilder(
              builder: (context, setInnerState) {
                if (context.read<DictionarySearchState>().activeFilters.isEmpty)
                  return const SizedBox.shrink();
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ActiveFiltersRow(
                          activeFilters: context.read<DictionarySearchState>().activeFilters.toList(),
                          onDeleted: (filter) {
                            setState(() => 
                              context.read<DictionarySearchState>().activeFilters.remove(filter)
                            );
                            setInnerState(() {});
                            updateSearchResults(controller.text.trim());
                          },
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                );
              }
            )
          );

          // 2. Determine what the dynamic content below the filters should be
          // CRITICAL: Every distinct view MUST have a unique ValueKey so the AnimatedSwitcher 
          // knows when to trigger the animation!
          Widget dynamicContent;

          if (input.trim().isEmpty) {
            dynamicContent = Column(
              key: const ValueKey('history'),
              mainAxisSize: MainAxisSize.min,
              children: const [ListTile(title: Text("History placeholder"))],
            );
          }
          else {
            final segments = input.split(' ');
            final currentWord = segments.last.toLowerCase();

            final tagSuggestions = _getFilterSuggestions(
              currentWord: currentWord,
              prefix: '#',
              dummyData: {'n5': 'JLPT N5', 'common': 'Common Word', 'verb': 'Verb class'},
              icon: Icons.tag,
              controller: controller,
              activeFilters: context.watch<DictionarySearchState>().activeFilters,
            );

            final posSuggestions = _getFilterSuggestions(
              currentWord: currentWord,
              prefix: r'$',
              dummyData: {'noun': 'Noun', 'adj': 'Adjective', 'adv': 'Adverb'},
              icon: Icons.category,
              controller: controller,
              activeFilters: context.watch<DictionarySearchState>().activeFilters,
            );

            if (tagSuggestions != null) {
              dynamicContent = Column(
                key: const ValueKey('tags'),
                mainAxisSize: MainAxisSize.min,
                children: tagSuggestions.toList(),
              );
            }
            else if (posSuggestions != null) {
              dynamicContent = Column(
                key: const ValueKey('pos'),
                mainAxisSize: MainAxisSize.min,
                children: posSuggestions.toList(),
              );
            }
            else {
              // Normal Search
              final results = await updateSearchResults(input.trim());
              if (results != null) {
                dynamicContent = DictionarySearchResultWidget(
                  key: ValueKey('results_${input}'), // Unique key for results
                  result: results,
                  onTap: onSearchResultPressed,
                );
              }
              else {
                dynamicContent = const SizedBox.shrink(key: ValueKey('empty'));
              }
            }
          }

          // --- 3. THE MAGIC: Wrap the dynamic content in an AnimatedSwitcher ---
          topLevelWidgets.add(
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Combining Fade and Size makes it look like a smooth dropdown expansion
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1.0, // Anchors the animation to the top
                    child: child,
                  ),
                );
              },
              child: dynamicContent,
            )
          );

          return topLevelWidgets;
        },
      ),
    );
  }




  Iterable<Widget>? _getFilterSuggestions({
    required String currentWord,
    required String prefix,
    required Map<String, String> dummyData,
    required IconData icon,
    required SearchController controller,
    required Set<String> activeFilters,
  }) {
    if (!currentWord.startsWith(prefix)) return null;

    final searchTerm = currentWord.substring(prefix.length);
    final matches = dummyData.keys
      .where((key) => key.startsWith(searchTerm) && 
        !activeFilters.contains('$prefix$key')
      );

    return matches.map((key) => FilterSuggestionTile(
      filterKey: key,
      prefix: prefix,
      description: dummyData[key]!,
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
        await updateSearchResults(searchInputController.text);
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
      await updateSearchResults(data);

      if(searchInputController.isOpen) searchInputController.closeView(null);
    }

    
  }

  /// Searches in the dictionary and updates the DictionarySearchState
  Future<DictionarySearchResult?> updateSearchResults(String query) async {
    
    late final DictionarySearchResult? results;

    context.read<DictionarySearchState>().results = results =
      await GetIt.I<DaDb>().dictionarySearchDao.dictionarySearch(
        DictionarySearchParams(
          searchInput: query, options: ProcessorOptions()
        )
      );

    return results;

  }


}

