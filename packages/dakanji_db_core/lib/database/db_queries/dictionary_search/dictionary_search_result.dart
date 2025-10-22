import 'dart:convert';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';

/// Utility class representing the overall results from a dictionary search.
/// It groups results based on whether they matched the search term directly,
/// matched the hiragana form of the term (romaji converted to hiragana), or
/// matched pre-processed variants of the term (e.g., 食べます→食べる).
class DictionarySearchResult {
  /// Matches from the original search query.
  final SearchMatchGroup queryMatches;
  /// Matches from the hiragana-converted search queries.
  final List<SearchMatchGroup> normalizedQueryMatchGroups;
  /// Matches from pre-processed variants of the search term.
  /// For example, de-conjugated forms.
  final List<SearchMatchGroup> queryVariantMatches;

  DictionarySearchResult({
    required this.queryMatches,
    required this.normalizedQueryMatchGroups,
    required this.queryVariantMatches,
  }){

    // This set will store the unique IDs of dictionary entries that have
    // already been included in a higher-priority result list.
    final Set<String> seenEntryIds = {};

    // 1. Sort by matched query (Level 1)
    processMatchGroup(queryMatches, seenEntryIds);

    // 2. Normalized (Hiragana) search term matches
    for (final normalizedQueryMatch in normalizedQueryMatchGroups)
      processMatchGroup(normalizedQueryMatch, seenEntryIds);

    // 3. Preprocessed terms matche
    for (final variantGroup in queryVariantMatches)
      processMatchGroup(variantGroup, seenEntryIds);

    // remove all empty variant groups
    normalizedQueryMatchGroups.removeWhere((group) => group.isEmpty);
    queryVariantMatches.removeWhere((group) => group.isEmpty);
  }

  void processMatchGroup(SearchMatchGroup group, Set<String> seenEntryIds) {
      filterList(group.exactMatches, seenEntryIds);
      filterList(group.prefixMatches, seenEntryIds);
      filterList(group.tokenMatches, seenEntryIds);
      filterList(group.fuzzyMatches, seenEntryIds);
      filterList(group.wildcardMatches, seenEntryIds);
    }

  // Helper function to filter a list in-place.
  // It removes any matches whose entry ID is already in the `seenEntryIds` set.
  // For new entries, it adds their ID to the set.
  void filterList(List<DictionaryMatch> matches, Set<String> seenEntryIds) {
    matches.removeWhere((match) {
      // Create a unique identifier for the dictionary entry.
      // Using term + reading is a robust way to do this if no
      // single database ID (like `sequence` or `id`) is available
      // on the TermBankV3Entry.
      final String entryId = match.entry.hashCode.toString();

      if (seenEntryIds.contains(entryId)) {
        // This entry was already found in a more important list.
        // Remove it from this (less important) list.
        return true;
      } else {
        // This is the first time we've seen this entry.
        // Add it to the set and keep it in this list.
        seenEntryIds.add(entryId);
        return false;
      }
    });
  }

  /// Override for a comprehensive and readable summary of all search results.
  @override
  String toString() {
    final buffer = StringBuffer();
    const sectionIndent = '  ';

    buffer.writeln('\n--- 📖 Dictionary Search Results ---');
    buffer.writeln('Search Term: ${queryMatches.searchTerm}');

    // 1. Original Query Matches
    if (!queryMatches.isEmpty) {
      buffer.writeln('\n▼ Matches for Original Query');
      buffer.write(queryMatches.toFormattedString(indent: sectionIndent));
    }

    // 2. Hiragana Query Matches
    if (normalizedQueryMatchGroups.isNotEmpty) {
      buffer.writeln('\n▼ Matches for Normalized queries (${normalizedQueryMatchGroups.length})');
      for (var i = 0; i < normalizedQueryMatchGroups.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        // Add extra indentation for the content of each variant.
        buffer.write(normalizedQueryMatchGroups[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    // 3. De-conjugated / Variant Matches
    if (queryVariantMatches.isNotEmpty) {
      buffer.writeln('\n▼ Matches for De-conjugated Variants (${queryVariantMatches.length})');
      for (var i = 0; i < queryVariantMatches.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        // Add extra indentation for the content of each variant.
        buffer.write(queryVariantMatches[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    // Check if any matches were found at all.
    if (queryMatches.isEmpty &&
        normalizedQueryMatchGroups.isEmpty &&
        queryVariantMatches.isEmpty) {
      buffer.writeln("\n<No matches found anywhere>");
    }

    buffer.writeln('\n------------------------------------');
    return buffer.toString();
  }
}

/// Utility class representing a grouped set of search results from the
/// dictionary search. It bundles [DictionaryMatch] objects into
/// categories based on the type of match.
class SearchMatchGroup {

  /// The search term that produced this match
  final String searchTerm;
  /// If this match was found via a variant (e.g., de-conjugation),
  /// this field describes the reason (e.g., 食べられます (polite -> potential))
  final String? variantReason;

  /// Matches that exactly match the search term.
  /// E.g., searching for 'でんしゃ' returns '電車 (densha)'.
  final List<DictionaryMatch> exactMatches;
  /// Matches that start with the search term.
  /// E.g., searching for 'でんしゃ' returns '電車賃 (denshachin)'.
  final List<DictionaryMatch> prefixMatches;
  /// Matches that contain the search term as a token.
  /// E.g., searching for 'でんしゃ' returns '満員電車 (man'in densha)'.
  final List<DictionaryMatch> tokenMatches;
  /// Matches that are similar to the search term (fuzzy).
  /// E.g., searching for 'りょこお' returns '旅行 (ryokou)'.
  final List<DictionaryMatch> fuzzyMatches;
  /// Matches that fit wildcard patterns.
  /// E.g., searching for 'で*しゃ' returns '電車 (densha)'.
  final List<DictionaryMatch> wildcardMatches;

  SearchMatchGroup({
    required this.searchTerm,
    this.variantReason,
    required this.exactMatches,
    required this.prefixMatches,
    required this.tokenMatches,
    required this.fuzzyMatches,
    required this.wildcardMatches,
  });

  SearchMatchGroup.empty()
      : searchTerm = '',
        variantReason = null,
        exactMatches = [],
        prefixMatches = [],
        tokenMatches = [],
        fuzzyMatches = [],
        wildcardMatches = [];

  bool get isEmpty =>
      exactMatches.isEmpty &&
      prefixMatches.isEmpty &&
      tokenMatches.isEmpty &&
      fuzzyMatches.isEmpty &&
      wildcardMatches.isEmpty;

  factory SearchMatchGroup.fromDictionaryMatchList(
      List<DictionarySearchDriftResult> matches,
      String searchTerm,
      bool isWildcardSearch,
      {
        String? variantReason
      }
    ) {

    if(matches.isEmpty) return SearchMatchGroup.empty();

    List<DictionaryMatch> exactMatches = [], prefixMatches = [],
                          tokenMatches = [], fuzzyMatches = [], 
                          wildcardMatches = [];
    
    for (int i = 0; i < matches.length; i++) {
      
      DictionarySearchDriftResult driftResult = matches[i];
      DictionaryMatch r = DictionaryMatch(
        match: driftResult.matchedText,
        spellfixSuggestion: driftResult.spellfixSuggestion,
        entry: TermBankV3Entry.fromDictionarySearchDrift(driftResult),
        metaEntries: (jsonDecode(driftResult.termMetaEntries) as List)
            .map((me) => TermMetaBankV3Entry.fromJson(me))
            .toList(),
        indexTableData: IndexTableEntry.fromDictionarySearchDrift(driftResult),
      );

      if(isWildcardSearch) {
        wildcardMatches.add(r);
        continue;
      }
      if (driftResult.matchTypePriority == 1) exactMatches.add(r);
      else if (driftResult.matchTypePriority == 2) prefixMatches.add(r);
      else if (driftResult.matchTypePriority == 3) tokenMatches.add(r);
      else if (driftResult.matchTypePriority == 4) fuzzyMatches.add(r);
    }

    return SearchMatchGroup(
      searchTerm: searchTerm,
      variantReason: variantReason,
      exactMatches: exactMatches,
      prefixMatches: prefixMatches,
      tokenMatches: tokenMatches,
      fuzzyMatches: fuzzyMatches,
      wildcardMatches: wildcardMatches
    );
  }

  @override
  String toString() => toFormattedString();

  String toFormattedString({String indent = ''}) {
    if (isEmpty) return '$indent<Empty Match Group>';
    
    final buffer = StringBuffer();
    final nextIndent = '$indent  ';

    void printSection(String title, List<DictionaryMatch> matches) {
      if (matches.isNotEmpty) {
        buffer.writeln('$indent▶ $title (${matches.length}):');
        for (final match in matches) {
          buffer.writeln(match.toFormattedString(indent: nextIndent));
        }
      }
    }

    printSection('Exact Matches', exactMatches);
    printSection('Prefix Matches', prefixMatches);
    printSection('Token Matches', tokenMatches);
    printSection('Fuzzy Matches', fuzzyMatches);
    printSection('Wildcard Matches', wildcardMatches);

    return buffer.toString();
  }
}

/// Utility class representing a single search result from the dictionary search.
class DictionaryMatch {
  /// The tokens that was matched (e.g., 食べるラー油 -> 食べる).
  final String match;
  /// If this match was found via spellfix, this field contains the suggestion
  /// that was used to find it.
  final String? spellfixSuggestion;
  /// The full dictionary entry that was matched.
  final TermBankV3Entry entry;
  /// Any associated metadata entries for this term.
  final List<TermMetaBankV3Entry> metaEntries;
  /// Index table data for this entry
  final IndexTableEntry indexTableData;

  DictionaryMatch(
    {
      required this.match,
      this.spellfixSuggestion,
      required this.entry,
      this.metaEntries = const [],
      required this.indexTableData,
    }
  );

  @override
  String toString() => toFormattedString();

  String toFormattedString({String indent = ''}) {
    final buffer = StringBuffer();
    buffer.writeln('$indent${entry.term} [${entry.reading}] (Matched: "$match")');
    for (var i = 0; i < entry.definitions.length; i++) {
      buffer.writeln('$indent  ${i + 1}. ${entry.definitions[i]}');
    }
    return buffer.toString().trimRight();
  }
}