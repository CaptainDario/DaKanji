// Package imports:
import 'dart:convert';

import '/database/dakanji_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '/database/tag/tag_bank_v3_entry.dart';

part 'term_bank_v3_entry.freezed.dart';
part 'term_bank_v3_entry.g.dart';

extension _CommonTermData on Object {
  // Use a type that covers the fields you need, like `dynamic` 
  // or `Object` with casting, if the classes don't share a base type 
  // you can reference here. `dynamic` is often sufficient for *similar*
  // data coming from different sources.
  String get _term => (this as dynamic).term ?? "";
  String get _reading => (this as dynamic).reading ?? "";
  String get _definitionTags => (this as dynamic).definitionTags;
  String get _ruleIdentifiers => (this as dynamic).ruleIdentifiers;
  int get _popularity => (this as dynamic).popularity;
  String get _definitions => (this as dynamic).definitions;
  int get _sequenceNumber => (this as dynamic).sequenceNumber;
  String get _tags => (this as dynamic).tags;
}

@Freezed()
@JsonSerializable()
/// Class representing one term of the database
class TermBankV3Entry with _$TermBankV3Entry {

  /// The term of a dictionary entry, for example: 食べる
  @override
  final String term;
  /// The term of a dictionary entry, for example: たべる
  @override
  final String reading;
  ///
  @override
  final List<String> definitionTags;
  ///
  @override
  final List<String> ruleIdentifiers;
  /// The popularity of this entry
  @override
  final int popularity;
  /// 
  @override
  final List<String> definitions;
  /// 
  @override
  final int sequenceNumber;
  ///
  @override
  final List<TagBankV3Entry> tags;

    
  TermBankV3Entry({
    required this.term,
    required this.reading,
    required this.definitionTags,
    required this.ruleIdentifiers,
    required this.popularity,
    required this.definitions,
    required this.sequenceNumber,
    required this.tags,
  }) {
    definitionTags.sort();
    ruleIdentifiers.sort();
    definitions;
    tags.sort((a, b) => a.name.compareTo(b.name),);
  }
    
  factory TermBankV3Entry.fromTermBankV3SearchViewData(TermBankV3SearchViewData r) {
    return _mapCommonFields(r);
  }

  // 2. Factory constructor for DictionarySearchFts5DriftResult
  factory TermBankV3Entry.fromSearchTermDriftResult(DictionarySearchFts5DriftResult r) {
    return _mapCommonFields(r);
  }

  static TermBankV3Entry _mapCommonFields(Object r) {
    return TermBankV3Entry(
      term: r._term,
      reading: r._reading,
      definitionTags: List<String>.from(jsonDecode(r._definitionTags)),
      ruleIdentifiers: List<String>.from(jsonDecode(r._ruleIdentifiers)),
      popularity: r._popularity,
      definitions: List<String>.from(jsonDecode(r._definitions)),
      sequenceNumber: r._sequenceNumber,
      tags: List.from(jsonDecode(r._tags))
          .where((tagJson) => tagJson != null && tagJson['name'] != null)
          .map((e) => TagBankV3Entry.fromJson(e))
          .toList(),
    );
  }

  factory TermBankV3Entry.fromJson(Map<String, Object?> json) 
    => _$TermBankV3EntryFromJson(json);

  Map<String, Object?> toJson() => _$TermBankV3EntryToJson(this);
}
