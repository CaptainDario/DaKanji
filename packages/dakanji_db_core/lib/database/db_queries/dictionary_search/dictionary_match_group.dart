
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
      List<DictionarySearchDriftFindTermBankSequencesResult>,
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
    List<DictionarySearchDriftFindTermBankSequencesResult> sequences,
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

  /// Processes all matches for a single term, partitioning them by rule and aggregating results.
  static DictionaryMatchGroup _createGroupForTerm({
    required String searchTerm,
    required List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> matches,
    required Map<int, List<DictionaryMatch>> sequenceExpansionMap,
    required List<DictionaryGroupingRule> groupingRules,
    required bool isWildcardSearch,
    String? variantReason,
  }) {
    final exactMatches = <DictionaryMatch>[];
    final prefixMatches = <DictionaryMatch>[];
    final tokenMatches = <DictionaryMatch>[];
    final wildcardMatches = <DictionaryMatch>[];

    // Partition matches into buckets based on rules
    final (ruleBuckets, defaultBucket) = _partitionMatchesByRule(matches, groupingRules);

    // Process buckets
    ruleBuckets.forEach((rule, bucket) {
      _processBucket(
        bucket: bucket,
        rule: rule,
        sequenceExpansionMap: sequenceExpansionMap,
        isWildcardSearch: isWildcardSearch,
        exactMatches: exactMatches,
        prefixMatches: prefixMatches,
        tokenMatches: tokenMatches,
        wildcardMatches: wildcardMatches,
      );
    });

    // Process leftover items (Default/NoGrouping)
    _processBucket(
      bucket: defaultBucket,
      rule: null, // No rule implies raw/default behavior
      sequenceExpansionMap: sequenceExpansionMap,
      isWildcardSearch: isWildcardSearch,
      exactMatches: exactMatches,
      prefixMatches: prefixMatches,
      tokenMatches: tokenMatches,
      wildcardMatches: wildcardMatches,
    );

    return DictionaryMatchGroup(
      searchTerm: searchTerm,
      variantReason: variantReason,
      exactMatches: exactMatches,
      prefixMatches: prefixMatches,
      tokenMatches: tokenMatches,
      wildcardMatches: wildcardMatches,
    );
  }

  /// Splits matches into buckets keyed by the rule that claims their dictionary ID.
  static (Map<DictionaryGroupingRule, List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>>, List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>)
      _partitionMatchesByRule(
    List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> matches,
    List<DictionaryGroupingRule> rules,
  ) {
    final buckets = <DictionaryGroupingRule, List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>>{};
    final defaults = <(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>[];

    for (final record in matches) {
      final dictId = record.$1.indexId;
      final rule = rules.firstWhereOrNull((r) => r.dictionaryIds.contains(dictId));

      if (rule != null) {
        buckets.putIfAbsent(rule, () => []).add(record);
      } else {
        defaults.add(record);
      }
    }
    return (buckets, defaults);
  }

  /// Processes a single bucket of matches according to its rule strategy.
  static void _processBucket({
    required List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> bucket,
    required DictionaryGroupingRule? rule,
    required Map<int, List<DictionaryMatch>> sequenceExpansionMap,
    required bool isWildcardSearch,
    required List<DictionaryMatch> exactMatches,
    required List<DictionaryMatch> prefixMatches,
    required List<DictionaryMatch> tokenMatches,
    required List<DictionaryMatch> wildcardMatches,
  }) {
    if (bucket.isEmpty) return;

    // Determine grouping strategy based on rule type
    String Function((DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)) keyGenerator;
    bool checkSourceSequences = false;
    int? sourceDictId;

    if (rule is SequenceGroupingRule) {
      checkSourceSequences = true;
      sourceDictId = rule.primaryDictId;
      keyGenerator = (_) => ''; // Key handled by sequence logic
    } else if (rule is TermAndReadingGroupingRule) {
      keyGenerator = (m) => '${m.$2.term}_${m.$2.reading}';
    } else if (rule is TermGroupingRule) {
      keyGenerator = (m) => '${m.$2.term}';
    } else {
      keyGenerator = (m) => 'raw_${m.$1.termBankId}';
    }

    // Apply grouping
    final groups = _groupMatchesInBucket(bucket, keyGenerator, checkSourceSequences, sourceDictId);

    // Convert grouped matches to DictionaryMatch objects
    for (final key in groups.keys) {
      final groupList = groups[key]!;
      final baseMatch = _createBaseMatch(groupList);

      // Add Sequence Expansions if applicable
      if (checkSourceSequences && key.startsWith('seq_')) {
        final seqNumber = groupList.first.$1.sequenceNumber;
        final expansions = sequenceExpansionMap[seqNumber] ?? [];
        for (final exp in expansions) {
          baseMatch.addDictionaryMatch(exp);
        }
      }

      // Categorize
      final type = groupList.first.$1.matchType;
      if (isWildcardSearch) wildcardMatches.add(baseMatch);
      else if (type == 1) exactMatches.add(baseMatch);
      else if (type == 2) prefixMatches.add(baseMatch);
      else if (type == 3) tokenMatches.add(baseMatch);
    }
  }

  /// Groups matches within a bucket, identifying valid sequence groups if required.
  static Map<String, List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>> _groupMatchesInBucket(
    List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> bucket,
    String Function((DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)) keyGen,
    bool checkSourceSequences,
    int? sourceDictId,
  ) {
    final validSourceSequences = <int>{};
    if (checkSourceSequences && sourceDictId != null) {
      for (final m in bucket) {
        if (m.$1.indexId == sourceDictId) validSourceSequences.add(m.$1.sequenceNumber);
      }
    }

    return groupBy(bucket, (m) {
      if (checkSourceSequences) {
        final seq = m.$1.sequenceNumber;
        if (validSourceSequences.contains(seq)) return 'seq_$seq';
        return 'raw_${m.$1.termBankId}';
      }
      return keyGen(m);
    });
  }

  /// Creates a combined [DictionaryMatch] from a list of grouped records.
  static DictionaryMatch _createBaseMatch(
    List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)> groupList
  ) {
    final baseMatch = DictionaryMatch.fromDictionarySearchWithDetails(groupList.first);
    for (int i = 1; i < groupList.length; i++) {
      baseMatch.addDictionaryMatch(DictionaryMatch.fromDictionarySearchWithDetails(groupList[i]));
    }
    return baseMatch;
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
