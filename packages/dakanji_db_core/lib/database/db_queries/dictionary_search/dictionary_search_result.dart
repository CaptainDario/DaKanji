import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';

/// Utility class representing the overall results from a dictionary search.
/// It groups results based on whether they matched the search term directly,
/// matched the hiragana form of the term (romaji converted to hiragana), or
/// matched pre-processed variants of the search term (e.g., 食べます→食べる).
class DictionarySearchResult {
  /// Matches from the original search query.
  final DictionaryMatchGroup queryMatches;
  
  /// Matches from the hiragana-converted search queries.
  final List<DictionaryMatchGroup> normalizedQueryMatchGroups;
  
  /// Matches from pre-processed variants of the search term.
  /// For example, de-conjugated forms.
  final List<DictionaryMatchGroup> queryVariantMatches;
  
  /// Matches from fuzzy search.
  /// For example: りょこお -> りょこう 
  final List<DictionaryMatchGroup> fuzzyMatches;

  DictionarySearchResult.empty()
      : queryMatches = DictionaryMatchGroup.empty(),
        normalizedQueryMatchGroups = [],
        queryVariantMatches = [],
        fuzzyMatches = [];

  /// Factory constructor to create a result from raw database outputs.
  /// 
  /// [groupingRules] dictates how matches from different dictionaries are merged.
  factory DictionarySearchResult.fromSearchResults({
    required List<List<DictionarySearchDriftFindTermBankEntriesResult>> resultsRaw,
    required List<DictionarySearchDriftFindTermBankSequencesResult> sequenceMatches,
    required List<DictionarySearchDriftFindTermBankDetailsResult> allDetails,
    required bool isWildcardSearch,
    required List<DictionaryGroupingRule> groupingRules,
  }) {
    return DictionarySearchResult.fromMatchGroups(
      queryMatches: DictionaryMatchGroup.fromDictionarySearch(
        (resultsRaw[0], sequenceMatches, allDetails), isWildcardSearch,
        groupingRules: groupingRules,
      ).firstOrNull ?? DictionaryMatchGroup.empty(),
      normalizedQueryMatchGroups: DictionaryMatchGroup.fromDictionarySearch(
        (resultsRaw[1], sequenceMatches, allDetails), isWildcardSearch,
        groupingRules: groupingRules,
      ),
      queryVariantMatches: DictionaryMatchGroup.fromDictionarySearch(
        (resultsRaw[2], sequenceMatches, allDetails), isWildcardSearch,
        groupingRules: groupingRules,
      ),
      fuzzyMatches: DictionaryMatchGroup.fromDictionarySearch(
        (resultsRaw[3], sequenceMatches, allDetails), isWildcardSearch,
        groupingRules: groupingRules,
      )
    );
  }

  DictionarySearchResult.fromMatchGroups({
    required this.queryMatches,
    required this.normalizedQueryMatchGroups,
    required this.queryVariantMatches,
    required this.fuzzyMatches,
  }){
    // This set will store the unique IDs of dictionary entries that have
    // already been included in a higher-priority result list.
    final Set<String> seenEntryIds = {};

    // 1. Sort by matched query (Level 1)
    _processMatchGroup(queryMatches, seenEntryIds);

    // 2. Normalized (Hiragana) search term matches
    for (final normalizedQueryMatch in normalizedQueryMatchGroups) {
      _processMatchGroup(normalizedQueryMatch, seenEntryIds);
    }

    // 3. Preprocessed terms matches
    for (final variantGroup in queryVariantMatches) {
      _processMatchGroup(variantGroup, seenEntryIds);
    }

    // 4. Fuzzy matches
    for (final fuzzyMatch in fuzzyMatches) {
      _processMatchGroup(fuzzyMatch, seenEntryIds);
    }

    // remove all empty groups
    normalizedQueryMatchGroups.removeWhere((group) => group.isEmpty);
    queryVariantMatches.removeWhere((group) => group.isEmpty);
    fuzzyMatches.removeWhere((group) => group.isEmpty);
  }

  /// Filters duplicates from all lists within a [DictionaryMatchGroup].
  void _processMatchGroup(DictionaryMatchGroup group, Set<String> seenEntryIds) {
    _filterList(group.exactMatches, seenEntryIds);
    _filterList(group.prefixMatches, seenEntryIds);
    _filterList(group.tokenMatches, seenEntryIds);
    _filterList(group.wildcardMatches, seenEntryIds);
  }

  /// Helper function to filter out all previously seen matches from a list.
  void _filterList(List<DictionaryMatch> matches, Set<String> seenEntryIds) {
    matches.removeWhere((match) {
      // Create a unique identifier for the dictionary entry.
      final String entryId = (match.entries.map((e) => e.id)
        .toList()..sort())
        .join(", ");

      if (seenEntryIds.contains(entryId)) {
        // This entry was already found in a more important list, remove it
        return true;
      } else {
        // first time seeing this entry, keep it and mark as seen
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
        buffer.write(normalizedQueryMatchGroups[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    // 3. De-conjugated / Variant Matches
    if (queryVariantMatches.isNotEmpty) {
      buffer.writeln('\n▼ Matches for De-conjugated Variants (${queryVariantMatches.length})');
      for (var i = 0; i < queryVariantMatches.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        buffer.write(queryVariantMatches[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    // 4. Fuzzy Matches
    if (fuzzyMatches.isNotEmpty) {
      buffer.writeln('\n▼ Matches for fuzzy search (${fuzzyMatches.length})');
      for (var i = 0; i < fuzzyMatches.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        buffer.write(fuzzyMatches[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    if (queryMatches.isEmpty &&
        normalizedQueryMatchGroups.isEmpty &&
        queryVariantMatches.isEmpty) {
      buffer.writeln("\n<No matches found anywhere>");
    }

    buffer.writeln('\n------------------------------------');
    return buffer.toString();
  }
}