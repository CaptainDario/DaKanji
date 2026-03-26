import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:da_db/util/da_db_search_manager.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/core/widgets/multi_focus.dart';
import 'package:da_kanji_mobile/features/dictionary/controller/isars.dart';
import 'package:da_kanji_mobile/features/dictionary/model/dictionary_search_state.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/search_results/dictionary_search_result_widget.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/active_filters_row.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/dictionary_search_controller.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/draw_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/example_dictionary_search_popup_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/filter_suggestion_tile.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/paste_clear_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/radical_button.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/word_tab/radical_popup_body.dart';
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:language_processing/language_processing.dart';
import 'package:provider/provider.dart';

/// An expandable search interface for the dictionary with support for 
/// handwriting, radical selection, and syntax-based filters (#tags, $pos).
class DictionarySearchWidget extends StatefulWidget {
  final String initialSearch;
  final double expandedHeight;
  final bool isExpanded;
  final bool canCollapse;
  final bool includeDrawButton;

  const DictionarySearchWidget({
    super.key,
    required this.expandedHeight,
    this.initialSearch = "",
    this.isExpanded = false,
    this.canCollapse = true,
    this.includeDrawButton = true,
  });

  @override
  State<DictionarySearchWidget> createState() => DictionarySearchWidgetState();
}

class DictionarySearchWidgetState extends State<DictionarySearchWidget>
    with TickerProviderStateMixin {
  final _searchInputController = DictionarySearchController();
  final _searchTextFieldFocusNode = FocusNode();
  
  String _currentInitialSearch = "";
  bool _initiallyExpanded = false;
  double _searchBarInputHeight = 0;
  
  Timer? _reopenPopupTimer;
  bool _radicalPopupOpen = false;
  bool _reshowRadicalPopup = false;

  @override
  void initState() {
    super.initState();
    _initiallyExpanded = widget.isExpanded;
    _syncWithWidgetState();
  }

  @override
  void didUpdateWidget(covariant DictionarySearchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncWithWidgetState();

    // If the radical popup is active during a widget rebuild (e.g. keyboard resize),
    // it is dismissed and scheduled for a reopen to prevent context errors.
    if (_radicalPopupOpen) {
      _reshowRadicalPopup = _radicalPopupOpen;
      Navigator.of(context).pop();
      _reopenPopupTimer?.cancel();
      _reopenPopupTimer = Timer(const Duration(seconds: 1), () {
        if (_reshowRadicalPopup && mounted) showRadicalPopup();
        _reshowRadicalPopup = false;
      });
    }
  }

  @override
  void dispose() {
    _reopenPopupTimer?.cancel();
    _searchInputController.dispose();
    _searchTextFieldFocusNode.dispose();
    super.dispose();
  }

  void _syncWithWidgetState() {
    if (_initiallyExpanded) _initiallyExpanded = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      if (widget.initialSearch != _currentInitialSearch) {
        _searchInputController.text = widget.initialSearch;
        _currentInitialSearch = widget.initialSearch;
        updateSearchResults(_currentInitialSearch);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final tutorial = GetIt.I<Tutorials>().dictionaryScreenTutorial;

    return MultiFocus(
      focusNodes: [tutorial.searchInputStep, tutorial.searchInputWildcardsStep],
      child: SearchAnchor(
        searchController: _searchInputController,
        dividerColor: context.watch<DictionarySearchState>().activeFilters.isNotEmpty
            ? Colors.transparent
            : Colors.grey,
        builder: _buildSearchBar,
        viewBuilder: _buildExpandedView,
        suggestionsBuilder: _buildSuggestions,
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, SearchController controller) {
    final state = context.watch<DictionarySearchState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SearchBar(
      controller: controller,
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(
        isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      ),
      side: WidgetStatePropertyAll(
        BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12.0)),
      leading: state.activeFilters.isEmpty
          ? const Icon(Icons.search)
          : Badge(
              label: Text('${state.activeFilters.length}'),
              child: const Icon(Icons.search),
            ),
      onTap: () => controller.openView(),
      onChanged: (text) {
        final query = text.trim();
        if (query.isNotEmpty && !controller.isOpen) controller.openView();
        updateSearchResults(query);
      },
      trailing: [
        PasteClearButton(controller: controller, onPressed: onClipboardButtonPressed),
        if (widget.includeDrawButton) DrawButton(controller: controller),
        RadicalButton(onPressed: showRadicalPopup),
        ExampleDictionarySearchPopupButton(
          exampleTerms: g_AppConfig.dictionaryDevToolTerms,
          onSelected: (term) {
            controller.text = term;
            controller.selection = TextSelection.collapsed(offset: term.length);
            updateSearchResults(term);
          },
        )
      ],
    );
  }

  Widget _buildExpandedView(Iterable<Widget> suggestions) {
    return ChangeNotifierProvider<DictionarySearchState>.value(
      value: context.read<DictionarySearchState>(),
      builder: (innerContext, _) {
        final state = innerContext.watch<DictionarySearchState>();
        return Column(
          children: [
            if (state.activeFilters.isNotEmpty) _buildActiveFiltersRow(state),
            if (state.activeFilters.isNotEmpty) const Divider(height: 1),
            Expanded(
              child: Stack(fit: StackFit.expand, children: suggestions.toList()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActiveFiltersRow(DictionarySearchState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ActiveFiltersRow(
          activeFilters: state.activeFilters.toList(),
          onDeleted: (filter) {
            state.activeFilters.remove(filter);
            updateSearchResults(_searchInputController.text.trim());
          },
        ),
      ),
    );
  }

  Future<Iterable<Widget>> _buildSuggestions(
    BuildContext context,
    SearchController controller,
  ) async {
    final input = controller.text.trim();
    final searchState = this.context.read<DictionarySearchState>();

    if (input.isEmpty) return _buildHistoryList();

    final lastSegment = input.split(' ').last.toLowerCase();

    // Check for syntax-specific suggestions
    final tagResults = _getFilterSuggestions(
      currentWord: lastSegment,
      prefix: '#',
      data: {'n5': 'JLPT N5', 'common': 'Common Word', 'verb': 'Verb class'},
      icon: Icons.tag,
      controller: controller,
      activeFilters: searchState.activeFilters,
    );
    if (tagResults != null) return [ListView(padding: EdgeInsets.zero, children: tagResults.toList())];

    final posResults = _getFilterSuggestions(
      currentWord: lastSegment,
      prefix: r'$',
      data: {'noun': 'Noun', 'adj': 'Adjective', 'adv': 'Adverb'},
      icon: Icons.category,
      controller: controller,
      activeFilters: searchState.activeFilters,
    );
    if (posResults != null) return [ListView(padding: EdgeInsets.zero, children: posResults.toList())];

    return _buildResultList(input);
  }

  Iterable<Widget> _buildHistoryList() {
    return [
      ListView(
        padding: EdgeInsets.zero,
        children: const [
          ListTile(leading: Icon(Icons.history), title: Text("History placeholder")),
        ],
      ),
    ];
  }

  Iterable<Widget> _buildResultList(String input) {
    updateSearchResults(input);
    return [
      Consumer<DictionarySearchState>(
        builder: (context, state, _) {
          final showSkeleton = state.isSearching && state.results.isEmpty;

          if (showSkeleton) {
            return state.showLoading
                ? const Align(alignment: Alignment.topCenter, child: LinearProgressIndicator(minHeight: 2.0))
                : const SizedBox.shrink();
          }

          return Column(
            children: [
              if (state.isSearching && state.showLoading) const LinearProgressIndicator(minHeight: 2.0),
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

    final term = currentWord.substring(prefix.length);
    final matches = data.keys.where((key) => key.startsWith(term) && !activeFilters.contains('$prefix$key'));

    if (matches.isEmpty) return null;

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

  void updateSearchResults(String query) {
    final searchState = context.read<DictionarySearchState>();

    searchState.isSearching = true;
    searchState.showLoading = false;
    searchState.startLoadingTimer();

    GetIt.I<DaDbSearchManager>().search(
      DictionarySearchParams(searchInput: query, options: ProcessorOptions()),
      onResult: (result) {
        if (!mounted) return;
        searchState.cancelLoadingTimer();
        searchState.isSearching = false;
        searchState.showLoading = false;
        searchState.results = result ?? DictionarySearchResult.empty();
      },
    );
  }

  Future<void> showRadicalPopup() async {
    _radicalPopupOpen = true;
    await AwesomeDialog(
      context: context,
      isDense: true,
      dialogType: DialogType.noHeader,
      alignment: Alignment.bottomCenter,
      onDismissCallback: (_) {
        updateSearchResults(_searchInputController.text);
        _radicalPopupOpen = false;
      },
      body: RadicalPopupBody(
        height: widget.expandedHeight - (_searchBarInputHeight * 1.1),
        kradIsar: GetIt.I<Isars>().krad.krads,
        radkIsar: GetIt.I<Isars>().radk.radks,
        searchController: _searchInputController,
      ),
    ).show();
  }

  void onSearchResultPressed(DictionaryMatch match) {
    context.read<DictionarySearchState>().selectedResult = match;
    if (widget.canCollapse) _searchInputController.closeView(null);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onClipboardButtonPressed() async {
    if (_searchInputController.text.isNotEmpty) {
      _searchInputController.text = "";
      context.read<DictionarySearchState>().currentSearch = "";
      _searchTextFieldFocusNode.requestFocus();
      if (!_searchInputController.isOpen) _searchInputController.openView();
    } else {
      final data = await Clipboard.getData('text/plain');
      final text = (data?.text ?? "").replaceAll("\n", " ");
      _searchInputController.text = text;
      updateSearchResults(text);
      if (_searchInputController.isOpen) _searchInputController.closeView(null);
    }
  }

  Future<void> onDismissedHistoryEntry(DismissDirection direction, JMdict entry, int idx) async {
    await GetIt.I<UserDataDB>().searchHistoryDao.deleteEntry(entry.id);
  }
}