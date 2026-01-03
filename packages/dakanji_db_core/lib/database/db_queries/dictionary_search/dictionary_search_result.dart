import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_match_type.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';

class DictionarySearchResult {
  final DictionaryMatchGroup queryMatches;
  final List<DictionaryMatchGroup> normalizedQueryMatchGroups;
  final List<DictionaryMatchGroup> queryVariantMatches;
  final List<DictionaryMatchGroup> fuzzyMatches;

  DictionarySearchResult.empty()
      : queryMatches = DictionaryMatchGroup.empty(),
        normalizedQueryMatchGroups = [],
        queryVariantMatches = [],
        fuzzyMatches = [];

  /// Factory constructor to create a result from raw database outputs.
  /// 
  /// [pruningPriority] defines the order in which duplicates are claimed. 
  /// Matches in the first category will exclude identical Term IDs from subsequent categories.
  /// Defaults to [exact, normalized, variant, fuzzy].
  factory DictionarySearchResult.fromSearchResults({
    required List<List<DictionarySearchDriftFindTermBankEntriesResult>> resultsRaw,
    required List<DictionarySearchDriftFindTermBankSequencesByPairsResult> sequenceMatches,
    required List<DictionarySearchDriftFindTermBankDetailsResult> allDetails,
    required bool isWildcardSearch,
    required List<DictionaryGroupingRule> groupingRules,
    List<DictionarySearchMatchType>? pruningPriority,
  }) {
    // 1. Global Deduplication State
    final seenTermBankIds = <int>{};

    // Helper to filter a list while updating the global set
    List<DictionarySearchDriftFindTermBankEntriesResult> filterDuplicates(
      List<DictionarySearchDriftFindTermBankEntriesResult> rawList
    ) {
      final filtered = <DictionarySearchDriftFindTermBankEntriesResult>[];
      for (final entry in rawList) {
        if (!seenTermBankIds.contains(entry.termBankId)) {
          seenTermBankIds.add(entry.termBankId);
          filtered.add(entry);
        }
      }
      return filtered;
    }

    // 2. Organize Raw Data by Type
    final rawMap = {
      DictionarySearchMatchType.exact: resultsRaw[0],
      DictionarySearchMatchType.normalized: resultsRaw[1],
      DictionarySearchMatchType.variant: resultsRaw[2],
      DictionarySearchMatchType.fuzzy: resultsRaw[3],
    };

    // 3. Determine Processing Order
    // Use user-provided order, or default to standard order.
    // We append any missing types to the end to ensure no data is lost.
    final order = pruningPriority != null ? List.of(pruningPriority) : [
      DictionarySearchMatchType.exact,
      DictionarySearchMatchType.normalized,
      DictionarySearchMatchType.variant,
      DictionarySearchMatchType.fuzzy,
    ];
    
    // Add missing types if the user passed a partial list
    for (final type in DictionarySearchMatchType.values) {
      if (!order.contains(type)) order.add(type);
    }

    // 4. Process Lists in Order
    final filteredMap = <DictionarySearchMatchType, List<DictionarySearchDriftFindTermBankEntriesResult>>{};
    
    for (final type in order) {
      filteredMap[type] = filterDuplicates(rawMap[type] ?? []);
    }

    // 5. Build Result Objects using the Filtered Lists
    return DictionarySearchResult.fromMatchGroups(
      queryMatches: DictionaryMatchGroup.fromDictionarySearch(
        (filteredMap[DictionarySearchMatchType.exact]!, sequenceMatches, allDetails), 
        isWildcardSearch,
        groupingRules: groupingRules,
      ).firstOrNull ?? DictionaryMatchGroup.empty(),
      
      normalizedQueryMatchGroups: DictionaryMatchGroup.fromDictionarySearch(
        (filteredMap[DictionarySearchMatchType.normalized]!, sequenceMatches, allDetails), 
        isWildcardSearch,
        groupingRules: groupingRules,
      ),
      
      queryVariantMatches: DictionaryMatchGroup.fromDictionarySearch(
        (filteredMap[DictionarySearchMatchType.variant]!, sequenceMatches, allDetails), 
        isWildcardSearch,
        groupingRules: groupingRules,
      ),
      
      fuzzyMatches: DictionaryMatchGroup.fromDictionarySearch(
        (filteredMap[DictionarySearchMatchType.fuzzy]!, sequenceMatches, allDetails), 
        isWildcardSearch,
        groupingRules: groupingRules,
      )
    );
  }

  // ... (rest of the class constructor and methods remain unchanged) ...
  DictionarySearchResult.fromMatchGroups({
    required this.queryMatches,
    required this.normalizedQueryMatchGroups,
    required this.queryVariantMatches,
    required this.fuzzyMatches,
  }) {
    // Legacy duplicate clean-up (can be kept for safety)
    final Set<String> seenEntryIds = {};
    _processMatchGroup(queryMatches, seenEntryIds);
    for (final g in normalizedQueryMatchGroups) _processMatchGroup(g, seenEntryIds);
    for (final g in queryVariantMatches) _processMatchGroup(g, seenEntryIds);
    for (final g in fuzzyMatches) _processMatchGroup(g, seenEntryIds);

    normalizedQueryMatchGroups.removeWhere((group) => group.isEmpty);
    queryVariantMatches.removeWhere((group) => group.isEmpty);
    fuzzyMatches.removeWhere((group) => group.isEmpty);
  }

  void _processMatchGroup(DictionaryMatchGroup group, Set<String> seenEntryIds) {
    _filterList(group.exactMatches, seenEntryIds);
    _filterList(group.prefixMatches, seenEntryIds);
    _filterList(group.tokenMatches, seenEntryIds);
    _filterList(group.wildcardMatches, seenEntryIds);
  }

  void _filterList(List<DictionaryMatch> matches, Set<String> seenEntryIds) {
    matches.removeWhere((match) {
      final String entryId = (match.entries.map((e) => e.id)
        .toList()..sort())
        .join(", ");

      if (seenEntryIds.contains(entryId)) {
        return true;
      } else {
        seenEntryIds.add(entryId);
        return false;
      }
    });
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    const sectionIndent = '  ';

    buffer.writeln('\n--- 📖 Dictionary Search Results ---');
    buffer.writeln('Search Term: ${queryMatches.searchTerm}');

    if (!queryMatches.isEmpty) {
      buffer.writeln('\n▼ Matches for Original Query');
      buffer.write(queryMatches.toFormattedString(indent: sectionIndent));
    }

    if (normalizedQueryMatchGroups.isNotEmpty) {
      buffer.writeln('\n▼ Matches for Normalized queries (${normalizedQueryMatchGroups.length})');
      for (var i = 0; i < normalizedQueryMatchGroups.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        buffer.write(normalizedQueryMatchGroups[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    if (queryVariantMatches.isNotEmpty) {
      buffer.writeln('\n▼ Matches for De-conjugated Variants (${queryVariantMatches.length})');
      for (var i = 0; i < queryVariantMatches.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        buffer.write(queryVariantMatches[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    if (fuzzyMatches.isNotEmpty) {
      buffer.writeln('\n▼ Matches for fuzzy search (${fuzzyMatches.length})');
      for (var i = 0; i < fuzzyMatches.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        buffer.write(fuzzyMatches[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    if (queryMatches.isEmpty &&
        normalizedQueryMatchGroups.isEmpty &&
        queryVariantMatches.isEmpty &&
        fuzzyMatches.isEmpty) {
      buffer.writeln("\n<No matches found anywhere>");
    }

    buffer.writeln('\n------------------------------------');
    return buffer.toString();
  }
}