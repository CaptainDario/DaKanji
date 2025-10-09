// Package imports:
import 'dart:convert';

import '/database/dakanji_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '/database/tag/tag_bank_v3_entry.dart';

part 'term_bank_v3_entry.freezed.dart';
part 'term_bank_v3_entry.g.dart';



@Freezed()
@JsonSerializable()
/// Class representing one term of the database
class TermBankV3Entry with _$TermBankV3Entry {

  ///
  @override
  final int indexId;
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
    required this.indexId,
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
    
  factory TermBankV3Entry.fromTermBankV3EntryViewData(TermBankV3EntryViewData r) {
    return TermBankV3Entry._fromDataSource(r);
  }

  // 2. Factory constructor for DictionarySearchFts5DriftResult
  factory TermBankV3Entry.fromDictionarySearchDrift(DictionarySearchDriftResult r) {
    return TermBankV3Entry._fromDataSource(r);
  }

  factory TermBankV3Entry._fromDataSource(dynamic r) {

    return TermBankV3Entry(
      indexId: r.indexId,
      term: r.term!,
      reading: r.reading!,
      definitionTags: List<String>.from(jsonDecode(r.definitionTags)),
      ruleIdentifiers: List<String>.from(jsonDecode(r.ruleIdentifiers)),
      popularity: r.popularity,
      definitions: List<String>.from(jsonDecode(r.definitions)),
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
