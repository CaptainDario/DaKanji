
import 'dart:convert';

import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/database/dakanji_db.dart';
import '/database/tag/tag_bank_v3_entry.dart';

part 'term_bank_v3_entry.freezed.dart';
part 'term_bank_v3_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one term of the database
class TermBankV3Entry with _$TermBankV3Entry {

  @override
  /// The id of this entry in the term bank v3 table
  final int id;
  /// The index (dictionary) in which this entry is defined
  @override
  final IndexEntry indexEntry;
  /// The term of a dictionary entry, for example: 食べる
  @override
  final String term;
  /// The term of a dictionary entry, for example: たべる
  @override
  final String reading;
  /// All definitions of this entry
  @override
  final List<String> definitions;
  /// All structured content definitions of this entry
  @override
  final List<String> structuredContentDefinitions;
  /// Tags assigned to each definition of this entry (inorder of `definitions`)
  @override
  final List<TagBankV3Entry> definitionTags;
  /// Identifiers how this entry can be conjugated
  @override
  final List<String> ruleIdentifiers;
  /// The popularity of this entry
  @override
  final int popularity;
  /// Number that can be shared across entries to group them
  /// Tags assigned to each definition of this entry
  @override
  final int sequenceNumber;
  /// All tags associated with this entry
  @override
  final List<TagBankV3Entry> tags;

    
  TermBankV3Entry({
    required this.id,
    required this.indexEntry,
    required this.term,
    required this.reading,
    required this.definitions,
    required this.structuredContentDefinitions,
    required this.definitionTags,
    required this.ruleIdentifiers,
    required this.popularity,
    required this.sequenceNumber,
    required this.tags,
  }) {
    ruleIdentifiers.sort();
    // sort tags first by sortingOrder then by name to ensure consistent order
    tags.sort((a, b) => a.comparedTo(b));
    definitionTags.sort((a, b) => a.comparedTo(b));
  }
    
  factory TermBankV3Entry.fromTermBankV3EntryViewData(TermBankV3EntryViewData r) {
    return TermBankV3Entry._fromDataSource(r);
  }

  // 2. Factory constructor for DictionarySearchFts5DriftResult
  factory TermBankV3Entry.fromDictionarySearchDetails(DictionarySearchDriftFindTermBankDetailsResult r) {
    return TermBankV3Entry._fromDataSource(r);
  }

  factory TermBankV3Entry._fromDataSource(dynamic r) {

    return TermBankV3Entry(
      id: r.termBankV3Id,
      indexEntry: IndexEntry.fromJson(jsonDecode(r.indexEntry)),
      term: r.term!,
      reading: r.reading!,
      definitions: List<String>.from(jsonDecode(r.definitions)),
      structuredContentDefinitions: List<String>.from(jsonDecode(r.structuredContentDefinitions ?? "[]")),
      definitionTags: List.from(jsonDecode(r.definitionTags))
          .where((tagJson) => tagJson != null && tagJson['name'] != null)
          .map((e) => TagBankV3Entry.fromJson(e))
          .toList(),
      ruleIdentifiers: List<String>.from(jsonDecode(r.ruleIdentifiers)),
      popularity: r.popularity,
      sequenceNumber: r.sequenceNumber,
      tags: List.from(jsonDecode(r.tags))
          .where((tagJson) => tagJson != null && tagJson['name'] != null)
          .map((e) => TagBankV3Entry.fromJson(e))
          .toList(),
    );
  }

  factory TermBankV3Entry.fromJson(Map<String, Object?> json) 
    => _$TermBankV3EntryFromJson(json);

  Map<String, Object?> toJson() => _$TermBankV3EntryToJson(this);
}
