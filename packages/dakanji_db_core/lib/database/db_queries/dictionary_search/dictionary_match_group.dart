
import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';



/// Utility class representing a grouped set of search results from the
/// dictionary search. It bundles [DictionaryMatch] objects into
/// categories based on the type of match.
class DictionaryMatchGroup {

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
  /// Matches that fit wildcard patterns.
  /// E.g., searching for 'で*しゃ' returns '電車 (densha)'.
  final List<DictionaryMatch> wildcardMatches;

  DictionaryMatchGroup({
    required this.searchTerm,
    this.variantReason,
    required this.exactMatches,
    required this.prefixMatches,
    required this.tokenMatches,
    required this.wildcardMatches,
  });

  DictionaryMatchGroup.empty()
      : searchTerm = '',
        variantReason = null,
        exactMatches = [],
        prefixMatches = [],
        tokenMatches = [],
        wildcardMatches = [];

  bool get isEmpty =>
      exactMatches.isEmpty &&
      prefixMatches.isEmpty &&
      tokenMatches.isEmpty &&
      wildcardMatches.isEmpty;

  /// Factory method to create [SearchMatchGroup] objects from raw
  /// database query results.
  /// Can group sequences or group on
  /// 1. same term + reading
  /// 2. same index + sequence number
  /// [variantReason] can be provided to indicate why this group
  /// was created (e.g., de-conjugation).
  static List<DictionaryMatchGroup> fromDictionarySearch(
    (
      List<DictionarySearchDriftFindTermBankEntriesResult>,
      List<DictionarySearchDriftFindTermBankSequencesByPairsResult>,
      List<DictionarySearchDriftFindTermBankDetailsResult>
    ) resultTuple,
    bool isWildcardSearch, {
    List<DictionaryGroupingRule> groupingRules = const [],
    String? variantReason,
  }) {
    final (searchResults, additionalSequences, resultInfos) = resultTuple;
    if (searchResults.isEmpty) return [];

    // 1. Create Lookup Maps
    final detailMap = <int, DictionarySearchDriftFindTermBankDetailsResult>{};
    for (var detail in resultInfos) detailMap[detail.termBankV3Id] = detail;

    final sequenceExpansionMap = _buildSequenceExpansionMap(additionalSequences, detailMap);

    // 2. Prepare Text Matches (Phase 1 results + Details)
    final combinedMatches = searchResults
        .map((searchInfo) => detailMap[searchInfo.termBankId] != null
            ? (searchInfo, detailMap[searchInfo.termBankId]!)
            : null)
        .whereType<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>()
        .toList();

    // 3. Group by Search Term
    final groupedByTerm = groupBy(combinedMatches, (record) => record.$1.searchTerm);
    final finalGroups = <DictionaryMatchGroup>[];

    groupedByTerm.forEach((searchTerm, matchesForThisTerm) {
      finalGroups.add(_createGroupForTerm(
        searchTerm: searchTerm,
        matches: matchesForThisTerm,
        sequenceExpansionMap: sequenceExpansionMap,
        groupingRules: groupingRules,
        isWildcardSearch: isWildcardSearch,
        variantReason: variantReason,
      ));
    });

    return finalGroups;
  }

  /// Builds a map of sequence number to list of dictionary matches from Phase 3 results.
  static Map<int, List<DictionaryMatch>> _buildSequenceExpansionMap(
    List<DictionarySearchDriftFindTermBankSequencesByPairsResult> sequences,
    Map<int, DictionarySearchDriftFindTermBankDetailsResult> detailMap,
  ) {
    final map = <int, List<DictionaryMatch>>{};
    for (var seq in sequences) {
      if (detailMap.containsKey(seq.termBankId)) {
        map.putIfAbsent(seq.sequenceNumber, () => []).add(
          DictionaryMatch.fromDictionarySequenceWithDetails((seq, detailMap[seq.termBankId]!))
        );
      }
    }
    return map;
  }

  static DictionaryMatchGroup _createGroupForTerm({
    required String searchTerm,
    required List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> matches,
    required Map<int, List<DictionaryMatch>> sequenceExpansionMap,
    required List<DictionaryGroupingRule> groupingRules,
    required bool isWildcardSearch,
    String? variantReason,
  }) {
    final state = _GroupingState();

    // 1. Process all matches to build groups
    _processMatches(
      matches, 
      state, 
      groupingRules, 
      sequenceExpansionMap, 
      isWildcardSearch
    );

    // 2. Attach sequence expansions to formed groups
    _appendPendingExpansions(state);

    // 3. Validate and dissolve invalid sequence groups
    _dissolveInvalidGroups(state.exactMatches, state);
    _dissolveInvalidGroups(state.prefixMatches, state);
    _dissolveInvalidGroups(state.tokenMatches, state);
    _dissolveInvalidGroups(state.wildcardMatches, state);

    return DictionaryMatchGroup(
      searchTerm: searchTerm,
      variantReason: variantReason,
      exactMatches: state.exactMatches,
      prefixMatches: state.prefixMatches,
      tokenMatches: state.tokenMatches,
      wildcardMatches: state.wildcardMatches,
    );
  }

  /// Iterates through sorted matches and assigns them to groups or anchors.
  static void _processMatches(
    List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> matches,
    _GroupingState state,
    List<DictionaryGroupingRule> rules,
    Map<int, List<DictionaryMatch>> expansionMap,
    bool isWildcardSearch,
  ) {
    for (final matchRecord in matches) {
      final dictId = matchRecord.$1.indexId;
      final rule = rules.firstWhereOrNull((r) => r.dictionaryIds.contains(dictId));

      final context = _analyzeMatchContext(matchRecord, rule);

      final shouldMerge = _shouldMergeMatch(context, state);

      if (shouldMerge) {
        _mergeIntoGroup(matchRecord, context, state);
      } else {
        _createNewAnchor(matchRecord, context, state, isWildcardSearch);
      }

      _queueExpansionsIfApplicable(matchRecord, context, state, expansionMap);
    }
  }

  /// Analyzing the match to determine its role (Source/Target) and group key.
  static _MatchContext _analyzeMatchContext(
    (DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult) record,
    DictionaryGroupingRule? rule,
  ) {
    String? key;
    bool isSequence = false;
    bool isSource = false;
    bool isTarget = false;

    if (rule != null) {
      final dictId = record.$1.indexId;
      
      if (rule is SequenceGroupingRule) {
        isSequence = true;
        isSource = (dictId == rule.sourceDictId);
        isTarget = rule.targetDictIds.contains(dictId);
        
        if (isSource || isTarget) {
          key = '${rule.hashCode}_seq_${record.$1.sequenceNumber}';
        }
      } else if (rule is TermGroupingRule) {
        key = '${rule.hashCode}_term_${record.$2.term}';
      } else if (rule is TermAndReadingGroupingRule) {
        key = '${rule.hashCode}_tr_${record.$2.term}_${record.$2.reading}';
      }
    }
    return _MatchContext(key, isSequence, isSource, isTarget);
  }

  /// Determines if the current match should join an existing group.
  /// Enforces Source exclusivity rules.
  static bool _shouldMergeMatch(_MatchContext context, _GroupingState state) {
    if (context.groupKey == null || !state.activeGroups.containsKey(context.groupKey)) {
      return false;
    }

    if (context.isSequence) {
      if (context.isTarget) {
        // Target dictionaries can always join an existing group.
        return true;
      } else if (context.isSource) {
        // Source dictionaries can join ONLY if the group is currently "Optimistic"
        // (started by a Target) and hasn't been claimed by another Source yet.
        final hasSourceClaimed = state.validSequenceGroups.contains(context.groupKey);
        return !hasSourceClaimed;
      }
      return false; 
    }

    // Non-sequence rules (Term/Reading) always merge if key matches.
    return true;
  }

  static void _mergeIntoGroup(
    (DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult) record,
    _MatchContext context,
    _GroupingState state,
  ) {
    final groupMatch = state.activeGroups[context.groupKey]!;
    groupMatch.addDictionaryMatch(DictionaryMatch.fromDictionarySearchWithDetails(record));

    // If a Source entry joins an Optimistic group, validate it.
    if (context.isSequence && context.isSource) {
      state.validSequenceGroups.add(context.groupKey!);
    }
  }

  static void _createNewAnchor(
    (DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult) record,
    _MatchContext context,
    _GroupingState state,
    bool isWildcardSearch,
  ) {
    final newMatch = DictionaryMatch.fromDictionarySearchWithDetails(record);
    
    // Add to appropriate result list
    final type = record.$1.matchType;
    if (isWildcardSearch) state.wildcardMatches.add(newMatch);
    else if (type == 1) state.exactMatches.add(newMatch);
    else if (type == 2) state.prefixMatches.add(newMatch);
    else if (type == 3) state.tokenMatches.add(newMatch);

    // Register as active group if a key exists
    if (context.groupKey != null) {
      state.activeGroups[context.groupKey!] = newMatch;
      state.matchToGroupKey[newMatch] = context.groupKey!;

      // Mark valid immediately if started by Source.
      // Optimistic groups (started by Target) remain invalid until a Source joins.
      if (context.isSequence && context.isSource) {
        state.validSequenceGroups.add(context.groupKey!);
      }
    }
  }

  static void _queueExpansionsIfApplicable(
    (DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult) record,
    _MatchContext context,
    _GroupingState state,
    Map<int, List<DictionaryMatch>> expansionMap,
  ) {
    // Only Source entries trigger lazy expansion lookups.
    if (context.isSequence && context.isSource && context.groupKey != null) {
      final seq = record.$1.sequenceNumber;
      final expansions = expansionMap[seq] ?? [];
      state.pendingExpansions
          .putIfAbsent(context.groupKey!, () => [])
          .addAll(expansions);
    }
  }

  static void _appendPendingExpansions(_GroupingState state) {
    state.pendingExpansions.forEach((key, expansions) {
      final anchor = state.activeGroups[key];
      // Only append if the group exists (it will be dissolved later if invalid)
      if (anchor != null) {
        for (final exp in expansions) {
          anchor.addDictionaryMatch(exp);
        }
      }
    });
  }

  /// Checks groups against validation rules. If a Sequence Group was formed
  /// optimistically but never met its Source Dictionary, it is dissolved
  /// back into individual entries.
  static void _dissolveInvalidGroups(List<DictionaryMatch> targetList, _GroupingState state) {
    final dissolvedList = <DictionaryMatch>[];
    
    for (final match in targetList) {
      final key = state.matchToGroupKey[match];
      final isSequenceGroup = key != null && key.contains('_seq_');
      final isValid = key != null && state.validSequenceGroups.contains(key);

      if (isSequenceGroup && !isValid) {
        // Explode the group back into individual matches
        for (int i = 0; i < match.entries.length; i++) {
          dissolvedList.add(DictionaryMatch(
            entries: [match.entries[i]],
            matches: [match.matches[i]],
            popularities: [match.popularities[i]],
            metaEntriesForEachEntry: [match.metaEntriesForEachEntry[i]],
          ));
        }
      } else {
        dissolvedList.add(match);
      }
    }
    
    targetList.clear();
    targetList.addAll(dissolvedList);
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
    printSection('Wildcard Matches', wildcardMatches);

    return buffer.toString();
  }
}

/// Helper DTO to pass context between private methods
class _MatchContext {
  final String? groupKey;
  final bool isSequence;
  final bool isSource;
  final bool isTarget;

  _MatchContext(this.groupKey, this.isSequence, this.isSource, this.isTarget);
}

/// Holds the mutable state required during the grouping process.
class _GroupingState {
  final List<DictionaryMatch> exactMatches = [];
  final List<DictionaryMatch> prefixMatches = [];
  final List<DictionaryMatch> tokenMatches = [];
  final List<DictionaryMatch> wildcardMatches = [];

  /// Maps group keys to their current active DictionaryMatch object.
  final Map<String, DictionaryMatch> activeGroups = {};
  
  /// Queues sequence expansions to be added after the main loop.
  final Map<String, List<DictionaryMatch>> pendingExpansions = {};
  
  /// Tracks which sequence groups have been validated by a Source entry.
  final Set<String> validSequenceGroups = {};
  
  /// Maps a match object back to its group key for post-process validation.
  final Map<DictionaryMatch, String> matchToGroupKey = {};
}