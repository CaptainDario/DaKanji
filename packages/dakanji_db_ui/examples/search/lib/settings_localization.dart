import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';



DakanjiDbLocalization dakanjiDbSettingsLocalization = DakanjiDbLocalization(

  /// --- SEARCH UI ---
  noResultsFound: noResultsFound,

  // --- SETTINGS ---
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

  useKatakanaForFuriganaTitle: useKatakanaForFuriganaTitle,

  // --- Sort Order ---
  sortOrderTitle: sortOrderTitle,

  sortByTitle: sortByTitle,
  sortByText: sortByText,
  sortByDirectMatch: sortByDirectMatch,
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

  // --- Misc ---
  miscTitle: miscTitle,

  typoCorrectionMaxResultsTitle: typoCorrectionMaxResultsTitle,
  typoCorrectionMaxResultsSubtitle: typoCorrectionMaxResultsSubtitle,
  typoCorrecctionMaxCostTitle: typoCorrecctionMaxCostTitle,
  typoCorrectionMaxCostSubtitle: typoCorrectionMaxCostSubtitle,

  exportDictionariesTitle: exportDictionariesTitle,
  importDictionariesTitle: importDictionariesTitle,
);


/// --- SEARCH UI ---
String noResultsFound = "No results found";

/// --- SETTINGS ---
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

String useKatakanaForFuriganaTitle = "Use Katakana for Furigana";

/// --- Sort Order ---

String sortOrderTitle = "Sort Order";

String sortByTitle = "Sort by";
String sortByText = """### Customize Search Result Priority (first priority)
*Drag items to change their importance. Unchecked items will be ignored.*

* **Direct:** Matches your text exactly as typed.
* **Flexible:** Ignores differences like capitalization or Hiragana/Katakana (e.g. Ａ = A, da = だ = ダ).
* **Smart Grammar:** Finds the dictionary form of a word (e.g., finds *食べる* if you type *食べます*).
* **Typo Correction:** Finds results even if your search has small spelling mistakes (e.g: "りょこ" finds "りょこう (旅行)").
""";

String sortByDirectMatch = "Direct";
String sortByFlexibleMatch = "Flexible";
String sortBySmartGrammarMatch = "Smart Grammar";
String sortByTypoCorrectionMatch = "Typo Correction";


String thenByTitle = "Then by";

String thenByText = """### Customize Search Result Priority (second priority)
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

// --- Misc ---
String miscTitle = "Misc";

String typoCorrectionMaxResultsTitle = "Typo Correction Max Results";
String typoCorrectionMaxResultsSubtitle = "Sets the maximum number of results returned when using Typo Correction in search.";
String typoCorrecctionMaxCostTitle = "Typo Correction Max Cost";
String typoCorrectionMaxCostSubtitle = "Sets the maximum cost (unlikely typos have a higher cost to fix) when using Typo Correction in search.";

String maxSearchResultsTitle = "Max Search Results";
String maxSearchResultsSubtitle = "Sets the maximum number of results returned (applied to each search method).";

String exportDictionariesTitle = "Export Dictionaries";
String importDictionariesTitle = "Import Dictionaries";