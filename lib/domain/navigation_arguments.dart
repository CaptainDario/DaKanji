


/// Class to store arguments for navigating with named routs
class NavigationArguments{

  // GENERAL
  /// was the route opened by the navigation drawer
  final bool navigatedByDrawer;

  // DRAWING SCREEN
  /// prefix that should be prepended to every search query
  String draw_SearchPrefix;
  /// postfix that should be appended to every search query
  String draw_SearchPostfix;

  // DICT SCREEN
  /// query that should be searched when navigating the dictionary screen
  String dict_InitialSearch;
  /// id of the entry that should be shown when navigating to the dictionary
  /// screen
  int? dict_InitialEntryId;

  // TEXT SCREEN
  /// The text that should be shown when opening the text screen
  String? text_InitialText;


  NavigationArguments(
    this.navigatedByDrawer,
    {
      this.draw_SearchPrefix = "",
      this.draw_SearchPostfix = "",

      this.dict_InitialSearch = "",
      this.dict_InitialEntryId,

      this.text_InitialText
    }
  );

}