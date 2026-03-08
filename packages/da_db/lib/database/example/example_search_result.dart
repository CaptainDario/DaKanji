import 'package:collection/collection.dart';
import 'package:da_db/data/grouping_rules.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_search_result.freezed.dart';

@freezed
class ExampleSearchResult with _$ExampleSearchResult{

  @override
  final List<ExampleEntry> sourceEntries;
  @override
  final List<ExampleEntry> targetEntries;

  ExampleSearchResult({
    required this.sourceEntries,
    required this.targetEntries,
  });

  /// Factory method to assemble raw database results into grouped objects.
  static List<ExampleSearchResult> fromRawData({
    required List<({int id, int groupId, int indexId})> baseMatches,
    required List<({int id, int groupId, int indexId})> missingEntries,
    required List<ExampleEntry> hydratedEntries,
    required Set<SequenceGroupingRule> groupingRules,
  }) {
    // 1. Map hydrated rows by ID for O(1) access
    final hydratedMap = {
      for (final entry in hydratedEntries) entry.id: entry
    };

    // 2. Map missing entries by their groupId for fast lookup
    final missingGroupMap = <int, List<({int id, int groupId, int indexId})>>{};
    for (final entry in missingEntries) {
      missingGroupMap.putIfAbsent(entry.groupId, () => []).add(entry);
    }

    final results = <ExampleSearchResult>[];
    
    // Track unique group+dictionary combinations to bundle them together
    final processedGroups = <String>{};

    // 3. Assemble the groups preserving the original Phase 1 order (e.g., BM25)
    for (final match in baseMatches) {
      final groupKey = '${match.groupId}_${match.indexId}';

      // Skip if we already bundled this group
      if (processedGroups.contains(groupKey)) continue;
      processedGroups.add(groupKey);

      // Find all base matches that share this groupId and dictionary
      final matchingBaseEntries = baseMatches
          .where((m) => m.groupId == match.groupId && m.indexId == match.indexId)
          .map((m) => hydratedMap[m.id])
          .nonNulls.toList();

      if (matchingBaseEntries.isEmpty) continue; // Safeguard

      final rule = groupingRules.firstWhereOrNull(
        (r) => r.sourceDictId == match.indexId
      );

      final targetEntries = <ExampleEntry>[];

      // If a rule applies, attach the missing entries we found
      if (rule != null) {
        final groupMissingEntries = missingGroupMap[match.groupId] ?? [];
        
        for (final missingEntry in groupMissingEntries) {
          if (rule.targetDictIds.contains(missingEntry.indexId)) {
            final hydratedSibling = hydratedMap[missingEntry.id];
            if (hydratedSibling != null) {
              targetEntries.add(hydratedSibling);
            }
          }
        }
      } 
      
      // Add the bundled result containing MULTIPLE source entries
      results.add(ExampleSearchResult(
        sourceEntries: matchingBaseEntries,
        targetEntries: targetEntries,
      ));
    }

    return results;
  }
}