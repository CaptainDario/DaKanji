import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';



/// class to bundle data for manipulating / navigating the search results
class DictSearchResultController {
  
  /// All [FocusNode]s of the search results
  List<FocusNode> searchResultsFocusses;
  /// Index of the current focus, index based on `searchResultsFocusses`
  int _currentFocusIndex = -1;
  /// Index of the current focus, index based on `searchResultsFocusses`
  int get currentFocusIndex {
    return _currentFocusIndex;
  }
  /// Index of the current focus, index based on `searchResultsFocusses`
  set currentFocusIndex (int newIndex) {
    if(newIndex > searchResultsFocusses.length || newIndex < 0)
      return;

    _currentFocusIndex = newIndex;
  }
  /// [ItemScrollController] to scroll to a search result
  ItemScrollController resultListItemScrollController;
  /// [ItemPositionsListener] for the items that are currently visible in the
  /// search results
  ItemPositionsListener resultListItemPositionsListener;
  /// The index of all currently visible items
  List<int> currentlyVisible = [];


  DictSearchResultController(
    this.searchResultsFocusses,
    this.resultListItemScrollController,
    this.resultListItemPositionsListener
  ){
    resultListItemPositionsListener.itemPositions.addListener(() {
      currentlyVisible = resultListItemPositionsListener.itemPositions.value
        .map((e) => e.index)
        .toList()..sort();
    });
  }

  /// Resets `currentFocusIndex` to -1 to indicate that no element of the
  /// search results is focused
  void resetCurrentFocusIndex(){
    _currentFocusIndex = -1;
  }

  /// foucsses the search result at `index`
  void setFocus(int index) async {

    assert (0 <= index && index < searchResultsFocusses.length);

    currentFocusIndex = index;
    
    // only (scroll and) focus if this is not the last element
    if(currentFocusIndex < this.searchResultsFocusses.length-1){
      FocusManager.instance.primaryFocus?.unfocus();

      // if this element is not in the view scroll to it
      if(!currentlyVisible.sublist(0, currentlyVisible.length-1).contains(currentFocusIndex)){
        await resultListItemScrollController.scrollTo(
          duration: const Duration(milliseconds: 70),
          index: currentFocusIndex+1,
          alignment: currentFocusIndex < this.searchResultsFocusses.length-2 ? 1.0 : 0.8
        );
      }
      // set the focus to this element
      searchResultsFocusses[currentFocusIndex].requestFocus();
    }
  }

  /// Move the focus to the previous search result
  void previousFocus() async {
    // only (scroll and) focus if this is not the first element
    if(0 < currentFocusIndex){
      FocusManager.instance.primaryFocus?.unfocus();

      // if this element is not in the view scroll to it
      if(!currentlyVisible.sublist(1, currentlyVisible.length).contains(currentFocusIndex)){
        await resultListItemScrollController.scrollTo(
          duration: const Duration(milliseconds: 70),
          index: currentFocusIndex-1,
          alignment: 0
        );
      }
      if(currentFocusIndex != 0)
        searchResultsFocusses[--currentFocusIndex].requestFocus();
    }
  }

  /// Move the focus to the next search result
  void nextFocus() async {
    
    // only (scroll and) focus if this is not the last element
    if(currentFocusIndex < this.searchResultsFocusses.length-1){
      FocusManager.instance.primaryFocus?.unfocus();

      // if this element is not in the view scroll to it
      if(!currentlyVisible.sublist(0, currentlyVisible.length-2).contains(currentFocusIndex)){
        await resultListItemScrollController.scrollTo(
          duration: const Duration(milliseconds: 70),
          index: currentFocusIndex+2,
          alignment: currentFocusIndex < this.searchResultsFocusses.length-2 ? 1.0 : 0.8
        );
      }
      // set the focus to this element
      searchResultsFocusses[++currentFocusIndex].requestFocus();
    }
  }

}