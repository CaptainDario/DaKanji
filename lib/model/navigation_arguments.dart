


/// Class to store arguments for navigating with named routs
class NavigationArguments{

  // GENERAL
  /// was the route opened by the navigation drawer
  final bool navigatedByDrawer;
  /// If set to true, the app will include a back-arrow instead of the hamburger
  /// menu (useful if a sceen should just be shown shortly and the user likely
  /// want to go back to the previous screen)
  final bool useBackArrowAppBar;

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
      this.useBackArrowAppBar = false,

      this.drawSearchPrefix = "",
      this.drawSearchPostfix = "",

      this.initialDictSearch = "",
      this.initialEntryId,

      this.initialText
    }
  );

}