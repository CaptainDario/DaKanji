import 'package:collection/collection.dart';
import 'package:da_db/data/grouping_rules.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_search_result.freezed.dart';

@freezed
class ExampleSearchResult with _$ExampleSearchResult {

  @override
  final List<ExampleEntry> sourceEntries;
  @override
  final List<ExampleEntry> targetEntries;

  ExampleSearchResult({
    required this.sourceEntries,
    required this.targetEntries,
  });

  /// Generates the JSON payload required to query missing sibling entries.
  /// 
  /// Sentences with an explicitly `null` groupId are treated as standalone entries 
  /// and are excluded from group expansion lookups. 
  static List<Map<String, int>> buildLookupPayload(
    List<({int id, int? groupId, int indexId})> baseMatches,
    Set<SequenceGroupingRule> groupingRules,
  ) {
    if (groupingRules.isEmpty) return [];

    final pairs = <Map<String, int>>[];
    final seen = <String>{};

    for (final match in baseMatches) {
      // Standalone sentences (null) have no siblings to look up.
      if (match.groupId == null) continue;

      final rule = groupingRules.firstWhereOrNull(
        (r) => r.sourceDictId == match.indexId,
      );

      if (rule == null) continue;

      for (final targetId in rule.targetDictIds) {
        final key = '${match.groupId}_$targetId';

        if (seen.add(key)) {
          pairs.add({"g": match.groupId!, "i": targetId});
        }
      }
    }

    return pairs;
  }

  /// Factory method to assemble raw database results into grouped objects.
  /// 
  /// Groups entries based on `groupId` and `indexId`. Entries with a `null` 
  /// `groupId` bypass grouping logic and are yielded as standalone results.
  static List<ExampleSearchResult> fromRawData({
    required List<({int id, int? groupId, int indexId})> baseMatches,
    required List<({int id, int? groupId, int indexId})> missingEntries,
    required List<ExampleEntry> hydratedEntries,
    required Set<SequenceGroupingRule> groupingRules,
  }) {
    if (baseMatches.isEmpty) return [];

    // 1. Map hydrated rows by ID for O(1) access
    final hydratedMap = {
      for (final entry in hydratedEntries) entry.id: entry
    };

    // 2. Map missing entries by their groupId for fast lookup
    final missingGroupMap = <int, List<({int id, int? groupId, int indexId})>>{};
    for (final entry in missingEntries) {
      if (entry.groupId != null) {
        missingGroupMap.putIfAbsent(entry.groupId!, () => []).add(entry);
      }
    }

    final results = <ExampleSearchResult>[];
    
    // Track unique group+dictionary combinations to bundle them together
    final processedGroups = <String>{};

    // 3. Assemble the groups preserving the original Phase 1 order (e.g., BM25)
    for (final match in baseMatches) {
      
      // ISOLATION: Explicitly null groupIds are standalone sentences.
      // Do not attempt to bundle them with other entries.
      if (match.groupId == null) {
        final hydratedEntry = hydratedMap[match.id];
        if (hydratedEntry != null) {
          results.add(ExampleSearchResult(
            sourceEntries: [hydratedEntry],
            targetEntries: [], // Standalone entries have no linked targets
          ));
        }
        continue; // Skip the grouping logic below
      }

      // --- Standard Grouping Logic for valid Group IDs ---
      final groupKey = '${match.groupId}_${match.indexId}';

      // Skip if we already bundled this group
      if (!processedGroups.add(groupKey)) continue;

      // Find all base matches that share this groupId and dictionary
      final matchingBaseEntries = baseMatches
          .where((m) => m.groupId == match.groupId && m.indexId == match.indexId)
          .map((m) => hydratedMap[m.id])
          .nonNulls
          .toList();

      if (matchingBaseEntries.isEmpty) continue; // Safeguard

      final rule = groupingRules.firstWhereOrNull(
        (r) => r.sourceDictId == match.indexId
      );

      final targetEntries = <ExampleEntry>[];

      // If a rule applies, attach the missing sibling entries we found
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