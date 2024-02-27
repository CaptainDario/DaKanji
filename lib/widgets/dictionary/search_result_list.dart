// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dictionary/search_result_list_controller.dart';
import 'search_result_card.dart';

/// List that shows the search results of [DictSearch]
class SearchResultList extends StatefulWidget {

  /// The search results that should be shown in the list
  final List searchResults;
  /// should the searchResults be shown in reverse
  final bool reversed;
  /// If true the word frequency will be displayed
  final bool showWordFrequency;
  /// Should the entries of this list always be animated in ie.: with every
  /// change or only once when it is forst instantiated
  final bool alwaysAnimateIn;
  /// Function that is called after the search results have been initialized
  /// Provides a [SearchResultListController] as parameter that can be used
  /// to manipulate this list
  final void Function(SearchResultListController controller)? init;
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
      this.alwaysAnimateIn = true,
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

  /// Key to either only slide in search results once, or multiple times
  Key slideInAnimationKey = Key(DateTime.now().toIso8601String());
  /// List of focus nodes that each corresponds to on search result entry 
  List searchResultsFocusses = [];
  /// Controller that can be used to hadle this instance
  late SearchResultListController controller;


  @override
  void initState() {

    controller = SearchResultListController(
      runSlideInAnimation: () {
      },
    );

    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchResultList oldWidget) {
    init();
    if((oldWidget.searchResults != widget.searchResults && widget.alwaysAnimateIn) ||
      oldWidget.key != widget.key){
      slideInAnimationKey = Key(DateTime.now().toIso8601String());
    }
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    searchResultsFocusses =
      List.generate(widget.searchResults.length, (index) => FocusNode());
    widget.init?.call(controller);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      key: slideInAnimationKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            itemCount: widget.searchResults.length,
            itemBuilder: ((context, index) {
              // determine index based on 
              int i = widget.reversed ? widget.searchResults.length-index-1 : index;
          
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  curve: Curves.decelerate,
                  horizontalOffset: constraints.maxWidth,
                  delay: const Duration(milliseconds: 100),
                  key: Key("${widget.searchResults[i].id}$i"),
                  child: Dismissible(
                    key: ValueKey(widget.searchResults[i]),
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
                      focusNode: searchResultsFocusses[i],
                      resultIndex: i,
                      showWordFrequency: widget.showWordFrequency,
                      onPressed: (selection) {
                        widget.onSearchResultPressed?.call(selection);
                      } 
                    ),
                  ),
                ),
              );
            })
          );
        }
      ),
    );
  }
}
