


/// Class to store arguments for navigating with named routs
class NavigationArguments{

  /// was the route opened by the navigation drawer
  final bool navigatedByDrawer;

  // DRAWING
  /// prefix that should be prepended to every search query
  final String drawSearchPrefix;
  /// postfix that should be appended to every search query
  final String drawSearchPostfix;

  //DICT
  /// query that should be searched when navigating the dictionary screen
  final String dictSearch;
  

  NavigationArguments(
    this.navigatedByDrawer,
    {
      this.drawSearchPrefix = "",
      this.drawSearchPostfix = "",
      this.dictSearch = ""
    }
  );

}