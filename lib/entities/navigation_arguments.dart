


/// Class to store arguments for navigating with named routs
class NavigationArguments{

  // GENERAL
  /// was the route opened by the navigation drawer
  final bool navigatedByDrawer;

  // DRAWING SCREEN
  /// prefix that should be prepended to every search query
  String drawSearchPrefix;
  /// postfix that should be appended to every search query
  String drawSearchPostfix;

  // DICT SCREEN
  /// query that should be searched when navigating the dictionary screen
  String dictInitialSearch;
  /// id of the entry that should be shown when navigating to the dictionary
  /// screen
  int? dictInitialEntryId;

  // TEXT SCREEN
  /// The text that should be shown when opening the text screen
  String? textInitialText;

  // DOJG SCREEN
  /// The initial grammar that should be searched
  String? dojgInitialSearch;
  /// Should the first match from the initial results be opened
  bool dojgOpenFirstMatch;


  NavigationArguments(
    this.navigatedByDrawer,
    {
      this.drawSearchPrefix = "",
      this.drawSearchPostfix = "",

      this.dictInitialSearch = "",
      this.dictInitialEntryId,

      this.textInitialText,

      this.dojgInitialSearch,
      this.dojgOpenFirstMatch = false,
    }
  );

}