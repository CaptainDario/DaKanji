import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
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
  /// Matches from fuzzy search
  /// For example: りょこお -> りょこう 
  final List fuzzyMatches;

  DictionarySearchResult({
    required this.queryMatches,
    required this.normalizedQueryMatchGroups,
    required this.queryVariantMatches,
    required this.fuzzyMatches,
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

    for (final fuzzyMatch in fuzzyMatches)
      processMatchGroup(fuzzyMatch, seenEntryIds);

    // remove all empty variant groups
    normalizedQueryMatchGroups.removeWhere((group) => group.isEmpty);
    queryVariantMatches.removeWhere((group) => group.isEmpty);
    fuzzyMatches.removeWhere((group) => group.isEmpty);
  }

  void processMatchGroup(SearchMatchGroup group, Set<String> seenEntryIds) {
    filterList(group.exactMatches, seenEntryIds);
    filterList(group.prefixMatches, seenEntryIds);
    filterList(group.tokenMatches, seenEntryIds);
    filterList(group.wildcardMatches, seenEntryIds);
  }

  // Helper function to filter out all previously seen matches.
  void filterList(List<DictionaryMatch> matches, Set<String> seenEntryIds) {
    matches.removeWhere((match) {
      // Create a unique identifier for the dictionary entry.
      final String entryId = (match.entries.map((e) => e.id)
        .toList()..sort)
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

    // 4. Fuzzy Matches
    if (fuzzyMatches.isNotEmpty) {
      buffer.writeln('\n▼ Matches for fuzzy search (${fuzzyMatches.length})');
      for (var i = 0; i < fuzzyMatches.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        // Add extra indentation for the content of each variant.
        buffer.write(fuzzyMatches[i].toFormattedString(indent: '$sectionIndent  '));
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
  /// Matches that fit wildcard patterns.
  /// E.g., searching for 'で*しゃ' returns '電車 (densha)'.
  final List<DictionaryMatch> wildcardMatches;

  SearchMatchGroup({
    required this.searchTerm,
    this.variantReason,
    required this.exactMatches,
    required this.prefixMatches,
    required this.tokenMatches,
    required this.wildcardMatches,
  });

  SearchMatchGroup.empty()
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
  static List<SearchMatchGroup> fromDictionarySearch(
    (
      List<DictionarySearchDriftFindTermBankEntriesResult>,
      List<DictionarySearchDriftFindTermBankSequencesResult>,
      List<DictionarySearchDriftFindTermBankDetailsResult>
    ) resultTuple,
    bool isWildcardSearch, {
    bool groupSequences = false,
    bool groupByTermAndReading = false,
    String? variantReason,
  }) {
    final (searchResults, additionalSequences, resultInfos) = resultTuple;

    if (searchResults.isEmpty) return [];

    // Create a fast lookup map for the sequences and details 
    final detailMap = <int, DictionarySearchDriftFindTermBankDetailsResult>{};
    for (var detail in resultInfos) detailMap[detail.termBankV3Id] = detail;
    final sequenceMap = <int, List<DictionaryMatch>>{};
    for (var seq in additionalSequences){
      sequenceMap.putIfAbsent(seq.sequenceNumber, () => []).add(
        DictionaryMatch.fromDictionarySequenceWithDetails((seq, detailMap[seq.termBankId]!))
      );
    }
    
    // Create a list of combined records
    final combinedMatches = searchResults
        .map((searchInfo) {
          final detailInfo = detailMap[searchInfo.termBankId];
          return detailInfo != null ? (searchInfo, detailInfo) : null;
        })
        .whereType<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>()
        .toList();

    // Group by the original search term
    final groupedByTerm = groupBy(combinedMatches, (record) => record.$1.searchTerm);
    final finalGroups = <SearchMatchGroup>[];

    // Create one SearchMatchGroup for each term
    groupedByTerm.forEach((searchTerm, matchesForThisTerm) {
      List<DictionaryMatch> exactMatches = [], prefixMatches = [], tokenMatches = [], wildcardMatches = [];
      
      // Build the grouping map (based on the grouping strategy)
      Map<String, List<(DictionarySearchDriftFindTermBankEntriesResult, DictionarySearchDriftFindTermBankDetailsResult)>> groups;
      if (groupSequences) {
        groups = groupBy(matchesForThisTerm,
          (record) => '${record.$2.id}_${record.$2.sequenceNumber}');
      }
      else if (groupByTermAndReading) {
        groups = groupBy(
          matchesForThisTerm, (record) => '${record.$2.term}_${record.$2.reading}');
      }
      else {
        groups = {};
        for (final record in matchesForThisTerm) {
          groups[identityHashCode(record).toString()] = [record];
        }
      }
      
      // Iterate through the map and "add" matches
      for (final group in groups.values) {
        
        // Create ONE base match from the first item
        final baseRecord = group.first;
        final baseMatch = DictionaryMatch.fromDictionarySearchWithDetails(baseRecord);
        final baseMatchType = baseRecord.$1.matchType;

        // Add all OTHER matches to it
        for (int i = 1; i < group.length; i++) {
          final otherMatch = DictionaryMatch.fromDictionarySearchWithDetails(group[i]);
          baseMatch.addDictionaryMatch(otherMatch);
        }

        // add all group matcehs if grouping by sequence number
        for (final match in sequenceMap[baseRecord.$2.sequenceNumber] ?? []) {
          baseMatch.addDictionaryMatch(match);
        } 

        // Categorize the final, combined match
        if (isWildcardSearch) wildcardMatches.add(baseMatch);
        else if (baseMatchType == 1) exactMatches.add(baseMatch);
        else if (baseMatchType == 2) prefixMatches.add(baseMatch);
        else if (baseMatchType == 3) tokenMatches.add(baseMatch);
      }

      // Add the newly created group to the final list
      finalGroups.add(SearchMatchGroup(
        searchTerm: searchTerm,
        variantReason: variantReason,
        exactMatches: exactMatches,
        prefixMatches: prefixMatches,
        tokenMatches: tokenMatches,
        wildcardMatches: wildcardMatches,
      ));
    });

    return finalGroups;
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

/// Utility class representing a single search result from the dictionary search.
/// This can include multple dictionary entries if
/// 1. Join on term + reading is used
/// 2. The matched term has multiple entries (sequence numbers)
class DictionaryMatch {
  /// The tokens that was matched (e.g., 食べるラー油 -> 食べる).
  final List<String> matches;
  /// The popularity of this term.
  final List<int?> popularities;
  /// The full dictionary entry that was matched.
  final List<TermBankV3Entry> entries;
  /// Any associated metadata entries for this term.
  final List<List<TermMetaBankV3Entry>> metaEntriesForEachEntry;

  DictionaryMatch(
    {
      required this.matches,
      required this.popularities,
      required this.entries,
      this.metaEntriesForEachEntry = const [],
    }
  );

  factory DictionaryMatch.fromDictionarySequenceWithDetails(
    (
      DictionarySearchDriftFindTermBankSequencesResult,
      DictionarySearchDriftFindTermBankDetailsResult
    ) record,
  ) {
    final (searchInfo, entryInfo) = record;
    final entry = TermBankV3Entry.fromDictionarySearchDetails(entryInfo);

    return DictionaryMatch(
      matches: ["Sequence number"],
      popularities: [null],
      entries: [entry],
      metaEntriesForEachEntry: [
        (jsonDecode(entryInfo.termMetaEntries) as List)
          .map((me) => TermMetaBankV3Entry.fromJson(me)).toList()
      ],
    );
  }

  factory DictionaryMatch.fromDictionarySearchWithDetails(
    (
      DictionarySearchDriftFindTermBankEntriesResult,
      DictionarySearchDriftFindTermBankDetailsResult
    ) record,
  ) {
    final (searchInfo, entryInfo) = record;
    final entry = TermBankV3Entry.fromDictionarySearchDetails(entryInfo);

    return DictionaryMatch(
      matches: [searchInfo.matchedText ?? ""],
      popularities: [searchInfo.finalPopularity],
      entries: [entry],
      metaEntriesForEachEntry: [
        (jsonDecode(entryInfo.termMetaEntries) as List)
          .map((me) => TermMetaBankV3Entry.fromJson(me)).toList()
      ],
    );
  }

  /// Adds `other` to this match, combining them while putting `this` first.
  void addDictionaryMatch(DictionaryMatch other) {
    matches.addAll(other.matches);
    popularities.addAll(other.popularities);
    entries.addAll(other.entries);
    metaEntriesForEachEntry.addAll(other.metaEntriesForEachEntry);
  }

  @override
  String toString() => toFormattedString();

  String toFormattedString({String indent = ''}) {
    if (entries.isEmpty) return '';
    
    final buffer = StringBuffer();
    final entryIndent = '$indent  ';

    // Print a single group header for the entire DictionaryMatch
    buffer.writeln("$indent- Group:");

    // Loop through all the entries that have been combined into this match
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final match = matches[i];
      final popularity = popularities[i]?.toString() ?? "N/A";

      buffer.writeln('$entryIndent${entry.term} [${entry.reading}] (Matched: "$match", Popularity: $popularity)');
      for (var j = 0; j < entry.definitions.length; j++) {
        buffer.writeln('$entryIndent  ${j + 1}. ${entry.definitions[j]}');
      }
    }
    return buffer.toString().trimRight();
  }
}