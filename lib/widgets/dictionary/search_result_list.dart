// Flutter imports:
import 'package:da_kanji_mobile/widgets/helper/conditional_parent_widget.dart';
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
  final List<List<JMdict>> searchResults;
  /// A list that contains headers to display that should match `searchResults`
  /// in length.
  /// `null` can be used to exclude a header
  final List<String?> headers;
  /// should the searchResults be shown in reverse
  //final bool reversed;
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
      required this.headers,
      //this.reversed = false,
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
  Key? slideInAnimationKey;
  /// List of focus nodes that each corresponds to on search result entry 
  List searchResultsFocusses = [];
  /// total number of search results
  int noSearchResults = -1;
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
    noSearchResults = widget.searchResults.isEmpty
      ? 0
      : widget.searchResults
        .map((e) => e.length,)
        .reduce((l1, l2) => l1+l2);
      
    searchResultsFocusses =
      List.generate(noSearchResults, (index) => FocusNode());
    widget.init?.call(controller);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    if(widget.searchResults.isEmpty) return const SizedBox();

    return AnimationLimiter(
      key: slideInAnimationKey,
      child: LayoutBuilder(
        builder: (context, constraints) {

          return ListView.builder(
            itemCount: noSearchResults,
            itemBuilder: ((context, index) {
              // get the current element
              int resultCnt = 0; int resultListIdx = 0;
              late JMdict result; bool showHeader = false;
              for (var i  = 0; i < widget.searchResults.length; i++) {
                for (var j = 0; j < widget.searchResults[i].length; j++) {
                  if(resultCnt++ == index){
                    result = widget.searchResults[i][j];
                    resultListIdx = i;
                    showHeader = j==0;
                    break;
                  }
                }
              }
          
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  curve: Curves.decelerate,
                  horizontalOffset: constraints.maxWidth,
                  delay: const Duration(milliseconds: 100),
                  key: Key("${result.id}$index"),
                  child: Dismissible(
                    key: ValueKey(result),
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
                      widget.onDismissed?.call(direction, result, index);
                    },
                    child: ConditionalParentWidget(
                      condition: widget.headers[resultListIdx] != null && showHeader,
                      conditionalBuilder: (child) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(widget.headers[resultListIdx]!),
                              ),
                            ),
                            child
                          ],
                        );
                      },
                      child: SearchResultCard(
                        dictEntry: result,
                        focusNode: searchResultsFocusses[index],
                        resultIndex: index,
                        showWordFrequency: widget.showWordFrequency,
                        onPressed: (selection) {
                          widget.onSearchResultPressed?.call(selection);
                        } 
                      ),
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
