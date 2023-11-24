// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/dictionary/dict_search_result_controller.dart';
import 'search_result_card.dart';

/// List that shows the search results of `DictSearch`
class SearchResultList extends StatefulWidget {

  /// The search results that should be shown in the list
  final List searchResults;
  /// should the searchResults be shown in reverse
  final bool reversed;
  /// If true the word frequency will be displayed
  final bool showWordFrequency;
  /// Function that is called after the search results have been initialized
  /// provides
  /// * [DictSearchResultController] for controlling the search results
  /// as argument 
  final void Function(DictSearchResultController controller)? init;
  /// Callback that is executed when the user pressed on a search result.
  /// Provides the selected entry as a parameter
  final void Function(JMdict selection)? onSearchResultPressed;
  /// Callback that is executed when the user dismisses a search result.
  /// Provides the DissmissDirection the dismissed item and
  /// the index in the list as a parameter
  final void Function(DismissDirection direction, JMdict entry, int idx)? onDismissed;

  const SearchResultList(
    {
      required this.searchResults,
      this.reversed = false,
      this.showWordFrequency = false,
      this.init,
      this.onSearchResultPressed,
      this.onDismissed,
      super.key
    }
  );

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {

  
  /// [DictSearchResultController] to focus between the different search results
  late DictSearchResultController dictSearchResultController;
  /// [ItemScrollController] controller to scroll to items if they are not visible
  ItemScrollController itemScrollController = ItemScrollController();
  /// [ItemPositionsListener] to check which search results are currently visible 
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();


  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchResultList oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){

    final searchResultsFocusses =
      List.generate(widget.searchResults.length, (index) => FocusNode());
    dictSearchResultController = DictSearchResultController(
      searchResultsFocusses,
      itemScrollController,
      itemPositionsListener
    );

    widget.init?.call(dictSearchResultController);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: widget.searchResults.length,
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemBuilder: ((context, index) {
        // determine index based on 
        int i = widget.reversed ? widget.searchResults.length-index-1 : index;
    
        return Dismissible(
          key: ValueKey(widget.searchResults[i].id),
          direction: widget.onDismissed != null
            ? DismissDirection.endToStart
            : DismissDirection.none,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(left: 20),
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete)
            ),
          ),
          onDismissed: (DismissDirection direction) {
            widget.onDismissed?.call(direction, widget.searchResults[i], i);
          },
          child: SearchResultCard(
            dictEntry: widget.searchResults[i],
            resultIndex: i,
            showWordFrequency: widget.showWordFrequency,
            focusNode: dictSearchResultController.searchResultsFocusses[i],
            onPressed: (selection) {
              widget.onSearchResultPressed?.call(selection);
            } 
          ),
        );
      })
    );
  }
}
