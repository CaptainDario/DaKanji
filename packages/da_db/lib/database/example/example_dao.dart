import 'dart:convert';

import "package:collection/collection.dart";
import "package:da_db/data/grouping_rules.dart";
import "package:drift/drift.dart";
import 'package:language_processing/language_processing.dart';

import "/database/example/example_entry.dart";
import "/database/example/example_search_result.dart";
import "/database/example/example_tables.dart";
import "../da_db.dart";

part 'example_dao.g.dart';

// Type alias for our standardized base match record to keep signatures clean
typedef _BaseMatchRecord = ({int id, int groupId, int indexId});

@DriftAccessor(
  tables: [
    ExampleTable, 
    ExampleSentenceTable,
    ExampleAudioTable,
  ],
)
class ExampleDao extends DatabaseAccessor<DaDb> with _$ExampleDaoMixin {
  
  ExampleDao(super.db);

  /// Uses the raw FTS5 query syntax to search the exact surface forms of the examples
  /// (Using the better-trigram index). 
  /// Returns a list of [ExampleSearchResult] objects if successful, or null on invalid query.
  Future<List<ExampleSearchResult>?> searchExamples(
    String rawFts5Query,
    List<Iso639_3> languages,
    {
      Set<SequenceGroupingRule> groupingRules = const {},
      int limit = -1,
      int offset = 0,
    }
  ) async {
    if (rawFts5Query.trim().isEmpty) return [];

    final langCodes = languages.map((l) => l.name).toList();
    
    // Note: Drift auto-generates the class SearchExampleBaseMatchesResult
    try {
      final rawMatches = await db.searchExampleBaseMatches(
        rawFts5Query, langCodes, limit, offset
      ).get();

      if (rawMatches.isEmpty) return [];

      final baseMatches = rawMatches.map((m) => 
        (id: m.id, groupId: m.groupId, indexId: m.indexId)
      ).toList();

      return _processBaseMatches(baseMatches, groupingRules);
    } catch (e) {
      // Catch syntax errors from malformed FTS queries
      return null; 
    }
  }

  /// Searches the lemmatized (base form) FTS index using unicode61.
  /// Replaces both `searchExamplesByTermIds` and `searchExamplesByTermString`.
  Future<List<ExampleSearchResult>> searchExamplesByTokens(
    List<String> lemmas,
    List<Iso639_3> languages, {
    Set<SequenceGroupingRule> groupingRules = const {},
    bool requireAllTokens = false,
    int limit = 50,
    int offset = 0,
  }) async {
    if (lemmas.isEmpty) return [];

    final langCodes = languages.map((l) => l.name).toList();
    
    // Construct the FTS5 query string from the list of lemmas.
    final operator = requireAllTokens ? ' ' : ' OR ';
    final ftsTokenQuery = lemmas.map((l) => '"${l.replaceAll('"', '""')}"').join(operator);
    
    try {
      final rawMatches = await db.searchExampleBaseMatchesByTokens(
        ftsTokenQuery, langCodes, limit, offset
      ).get();
      
      if (rawMatches.isEmpty) return [];

      final baseMatches = rawMatches.map((m) => 
        (id: m.id, groupId: m.groupId, indexId: m.indexId)
      ).toList();

      return _processBaseMatches(baseMatches, groupingRules);
    } catch (e) {
      print('FTS Token Search Error: $e');
      return [];
    }
  }

  Future<List<ExampleSearchResult>> _processBaseMatches(
    List<_BaseMatchRecord> baseMatches,
    Set<SequenceGroupingRule> groupingRules,
  ) async {
    
    // Phase 2: Targeted Sibling Expansion
    final lookupPairs = _buildLookupPairs(baseMatches, groupingRules);
    final missingEntries = <_BaseMatchRecord>[];

    if (lookupPairs.isNotEmpty) {
      final pairsJson = jsonEncode(lookupPairs);
      final excludedIds = baseMatches.map((m) => m.id).toList();
      
      final rawMissing = await db.getMissingGroupEntries(pairsJson, excludedIds).get();
      
      missingEntries.addAll(rawMissing.map((m) => 
        (id: m.id, groupId: m.groupId, indexId: m.indexId)
      ));
    }

    // Phase 3: Rich Data Hydration
    final allIdsToFetch = [
      ...baseMatches.map((m) => m.id),
      ...missingEntries.map((m) => m.id)
    ];
    
    final viewRows = await db.getExamplesByIds(allIdsToFetch).get();
    final hydratedEntries = viewRows.map((row) => ExampleEntry.fromViewData(row)).toList();

    // Delegate Assembly
    return ExampleSearchResult.fromRawData(
      baseMatches: baseMatches,
      missingEntries: missingEntries,
      hydratedEntries: hydratedEntries,
      groupingRules: groupingRules,
    );
  }

  /// Helper method to extract the JSON payload needed for Phase 2
  List<Map<String, int>> _buildLookupPairs(
    List<_BaseMatchRecord> baseMatches, 
    Set<SequenceGroupingRule> groupingRules
  ) {
    final pairs = <Map<String, int>>[];
    final seen = <String>{}; 
    
    for (final match in baseMatches) {
      final rule = groupingRules.firstWhereOrNull((r) => r.sourceDictId == match.indexId);
      if (rule != null) {
        for (final targetId in rule.targetDictIds) {
          final key = '${match.groupId}_$targetId';
          
          // Only add the lookup pair if we haven't already requested it
          if (seen.add(key)) {
            pairs.add({"g": match.groupId, "i": targetId});
          }
        }
      }
    }
    return pairs;
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum id of the [ExampleTable]
  Future<int> maxExampleId() async {
    
    final query = await (selectOnly(exampleTable)
        ..addColumns([exampleTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleTable.id.max()) ?? 0;

  }

  /// Get the maximum id of the [exampleSentenceTable]
  Future<int> maxExampleSentenceId() async {
    
    final query = await (selectOnly(exampleSentenceTable)
        ..addColumns([exampleSentenceTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleSentenceTable.id.max()) ?? 0;

  }

  /// Get the maximum id of the [exampleAudioTable]
  Future<int> maxExampleAudioTableId() async {
    
    final query = await (selectOnly(exampleAudioTable)
        ..addColumns([exampleAudioTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(exampleAudioTable.id.max()) ?? 0;

  }

}
