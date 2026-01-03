import 'dart:convert';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';

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
      DictionarySearchDriftFindTermBankSequencesByPairsResult,
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
    // keep track of duplicates
    final existingDefIds = entries.map((e) => e.id).toSet();

    for (int i = 0; i < other.entries.length; i++) {
      
      if (!existingDefIds.contains(other.entries[i].id)) {
        existingDefIds.add(other.entries[i].id); 
        
        entries.add(other.entries[i]);
        matches.add(other.matches[i]);
        popularities.add(other.popularities[i]);
        metaEntriesForEachEntry.add(other.metaEntriesForEachEntry[i]);
      }
    }
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

      buffer.writeln('$entryIndent${entry.term} [${entry.reading}] (Matched: "$match", Popularity: $popularity, Idx: ${entry.indexEntry.id})');
      for (var j = 0; j < entry.definitions.length; j++) {
        buffer.writeln('$entryIndent  ${j + 1}. ${entry.definitions[j]}');
      }
    }
    return buffer.toString().trimRight();
  }
}