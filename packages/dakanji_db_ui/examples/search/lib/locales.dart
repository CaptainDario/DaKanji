import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_localization.dart';



DakanjiDbSettingsLocalization dakanjiDbSettingsLocalization = DakanjiDbSettingsLocalization(
  // --- Dictionary Management ---
  dictionariesHeader: dictionariesHeader,

  defaultDictionary: defaultDictionary,
  userDictionary: userDictionary,
  
  // --- Display ---
  displayHeader: displayHeader,

  showSeparatorsTitle: showSeparatorsTitle,
  showSeparatorsSubtitle: showSeparatorsSubtitle,

  showTagsTitle: showTagsTitle,
  showTagsSubtitle: showTagsSubtitle,

  showMetaEntriesTitle: showMetaEntriesTitle,
  showMetaEntriesSubtitle: showMetaEntriesSubtitle,

  useCompactDefinitionsTitle: useCompactDefinitionsTitle,
  useCompactDefinitionsSubtitle: useCompactDefinitionsSubtitle,

  // --- Sort Order ---
  sortOrderTitle: sortOrderTitle,

  sortByTitle: sortByTitle,
  sortByText: sortByText,
  sortByExactMatch: sortByExactMatch,
  sortByFlexibleMatch: sortByFlexibleMatch,
  sortBySmartGrammarMatch: sortBySmartGrammarMatch,
  sortByTypoCorrectionMatch: sortByTypoCorrectionMatch,

  thenByTitle: thenByTitle,
  thenByText: thenByText,
  thenByExactMatch: thenByExactMatch,
  thenByStartsWithMatch: thenByStartsWithMatch,
  thenBySubwordMatch: thenBySubwordMatch,
  thenByWildcardMatch: thenByWildcardMatch,

  // --- Grouping ---
  groupingTitle: groupingTitle,
);

/// --- Dictionary Management ---
String dictionariesHeader = "Dictionaries";

String defaultDictionary = "Default Dictionary";
String userDictionary = "User Dictionary";


/// --- Display ---
String displayHeader = "Display";

String showSeparatorsTitle = "Show Separators";
String showSeparatorsSubtitle = "Show or hide headers such as 'Exact Matches', 'Prefix Matches', etc.";

String showTagsTitle = "Show Tags";
String showTagsSubtitle = "Shows tags such as 'common' in search results";

String showMetaEntriesTitle = "Show Meta entries";
String showMetaEntriesSubtitle = "Shows Meta entries such as frequency in search results";

String useCompactDefinitionsTitle = "Use Compact Definitions";
String useCompactDefinitionsSubtitle = "Limits the height of definitions in search results";

/// --- Sort Order ---

String sortOrderTitle = "Sort Order";

String sortByTitle = "Sort by";
String sortByText = """### Customize Search Priority
*Drag items to change their importance. Unchecked items will be ignored.*

* **Exact Match:** Matches your text exactly as typed.
* **Flexible Match:** Ignores differences like capitalization or Hiragana/Katakana (e.g. ).
* **Smart Grammar:** Finds the dictionary form of a word (e.g., finds *食べる* if you type *食べます*).
* **Typo Correction:** Finds results even if your search has small spelling mistakes (e.g: "りょこ" finds "りょこう (旅行)").
""";

String sortByExactMatch = "Exact Match";
String sortByFlexibleMatch = "Flexible Match";
String sortBySmartGrammarMatch = "Smart Grammar Match";
String sortByTypoCorrectionMatch = "Typo Correction Match";


String thenByTitle = "Then by";

String thenByText = """### Customize Match Method
*Drag items to change their importance. Unchecked items will be ignored.*

* **Exact Match:** The result is exactly equal to your search term.
* **Starts With:** The result starts with your search term (e.g. "食べ" finds "**食べ**物").
* **Sub-word Match:** Finds entries where your search term appears as a sub-word (e.g. "食べる" finds "ボリボリ**食べる**").
* **Wildcard:** Advanced pattern matching (Case-sensitive & slower):
  * `*` matches any text.
  * `?` matches exactly one character (e.g. `?本` finds **日**本 or **三**本).
  * `[.]` matches one character from a list (e.g. `[日一]本` finds **日**本 or **一**本).
  * `[0-9]` matches a range of numbers or letters.
  * `[^.]` excludes characters in the list (e.g. `[^日]本` finds **三**本 but **not** 日本).
""";

String thenByExactMatch = "Exact Match";
String thenByStartsWithMatch = "Starts With";
String thenBySubwordMatch = "Sub-word Match";
String thenByWildcardMatch = "Wildcard Match";

// --- Grouping ---
String groupingTitle = "Grouping";