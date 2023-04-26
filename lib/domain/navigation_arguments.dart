


/// Class to store arguments for navigating with named routs
class NavigationArguments{

  // GENERAL
  /// was the route opened by the navigation drawer
  final bool navigatedByDrawer;

  // DRAWING SCREEN
  /// prefix that should be prepended to every search query
  final String drawSearchPrefix;
  /// postfix that should be appended to every search query
  final String drawSearchPostfix;

  // DICT SCREEN
  /// query that should be searched when navigating the dictionary screen
  final String initialDictSearch;
  /// id of the entry that should be shown when navigating to the dictionary
  /// screen
  final int? initialEntryId;

  // TEXT SCREEN
  final String? initialText;


  NavigationArguments(
    this.navigatedByDrawer,
    {
      this.drawSearchPrefix = "",
      this.drawSearchPostfix = "",

      this.initialDictSearch = "",
      this.initialEntryId,

      this.initialText
    }
  );

}