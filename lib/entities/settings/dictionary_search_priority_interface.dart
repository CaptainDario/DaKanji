


/// Interface that guarantess that the implementing class can be used for a
/// search priority setting widget
abstract class DictionarySearchPriorityInterface {

  /// The search result sorting order priorities that are selected
  List<String> get selectedSearchResultSortPriorities;
  /// The search result sorting order priorities that are selected
  set selectedSearchResultSortPriorities(List<String> newValue){}


  /// The search result sorting order priorities
  List<String> get searchResultSortPriorities;
  /// The search result sorting order priorities
  set searchResultSortPriorities(List<String> newValue){}

}
