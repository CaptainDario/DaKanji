import 'package:dakanji_db_ui/model/dakanji_db_localization.dart';



DakanjiDbLocalization dakanjiDbLocalization = DakanjiDbLocalization(

  /// --- SEARCH UI ---
  noResultsFound: noResultsFound,

  // --- SETTINGS ---
  // --- Dictionary Management ---
  dictionariesHeader: dictionariesHeader,

  defaultDictionary: defaultDictionary,
  userDictionary: userDictionary,

  importDictionary: importDictionary,
  updateDictionary: updateDictionary,
  deleteDictionary: deleteDictionary,
  
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
  groupingExplanation: groupingExplanation,

  configureGroupingTitle: configureGroupingTitle,
  groupby: groupby,
  source: source,
  targets: targets,
  select: select,
  delteRule: delteRule,
  addRule: addRule,

  targetDictSelectDialogTitle: targetDictSelectDialogTitle,
  targetDictSelectDialogNoIndexes: targetDictSelectDialogNoIndexes,
  targetDictSelectDialogUsedInOtherRule: targetDictSelectDialogUsedInOtherRule,
  targetDictSelectDialogCancel: targetDictSelectDialogCancel,
  targetDictSelectDialogOK: targetDictSelectDialogOK,

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

String importDictionary = "Import Dictionary";
String updateDictionary = "Update";
String deleteDictionary = "Delete";

/// --- Display ---
String displayHeader = "Display";

String showSeparatorsTitle = "Show Separators";
String showSeparatorsSubtitle = "Show or hide headers such as 'Exact Matches', 'Prefix Matches', etc.";

String showTagsTitle = "Show Tags";
String showTagsSubtitle = "Shows tags such as 'common' in search results";

String showMetaEntriesTitle = "Show Meta Entries";
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

String groupingExplanation = """
# How Grouping Works in DaKanji

DaKanji can group entries from your different dictionaries to make your search results more organized.
To simplify things, one dictionary entry consists of three main things

* Term (The written word): 漢字
* Reading (how to read the word in kana): かんじ
* Definitions (what this entry means): Japanese characters

There are four main strategies for this.

## Quick Comparison

| Strategy | Logic | Result |
| :--- | :--- | :--- |
| **No Grouping** | Show everything | Very long list, maximum detail. |
| **Term + Reading** | Match Term AND Reading | Balanced, keeps different words separate. |
| **Term** | Match Term only | Short list, groups all sounds together. |
| **Related Term** | Match the "Core Concept" | Smartest grouping, merges spelling variations, but requires a dictionary to support it. |

---

## 1. No Grouping
This means that every entry from every dictionary is shown separately, even if they are the same.

## 2. Term + Reading Grouping
DaKanji groups entries together only if they have **both** the same Term and the same Reading.

### Example
1. If you look up "生", DaKanji may find 生 [せい] and 生 [しょう].
Since their readings are different, they will be shown as separate entries.
2. If you look up "生", DaKanji may find 生 [せい] with a definition of "living" and 生 [せい] with a definition of "existence", these two entries will be shown together as both the Term and Reading are identical.

## 3. Term Grouping
This refers to grouping based solely on the Term, if two entries have the same Term they will be shown together.

### Example
1. If you look up "生", DaKanji may find 生 [せい] and 生 [しょう].
Since their terms are the same, they will be shown as one entry.
2. If you look up "生", DaKanji may find 生 [せい] with a definition of "living" and 生 [せい] with a definition of "existence", these two entries will be also shown together as the Terms are identical.

## 4. Related Term Grouping
It relies on unique identification numbers provided by dictionaries like JMdict (DaKanji's default dictionary) to group entries that are conceptually the same, even if their Terms or Readings differ.
This is useful for example if one word can be written using multiple Terms.
For this to work, DaKanji needs to know which dictionary defines the Sequence (Source) and which dictionaries use the same Sequence (Targets) which needs to be selected in the UI.

### Example
Searching for "taberu" may find "食べる辣油" and "食べるラー油". Even though their Terms are different, JMDict uses the same ID for them, so they will be shown together.
""";

String configureGroupingTitle = "Configure Grouping of Search Results";
String groupby = "Group by";
String source = "Source";
String targets = "Targets";
String select = "Select";
String delteRule = "Delete Rule";
String addRule = "Add Rule";

String targetDictSelectDialogTitle = "Select Target Dictionaries";
String targetDictSelectDialogNoIndexes = "No dictionaries found";
String targetDictSelectDialogUsedInOtherRule = "Used in another rule";
String targetDictSelectDialogCancel = "Cancel";
String targetDictSelectDialogOK = "OK";

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