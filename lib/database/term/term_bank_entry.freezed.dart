// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_bank_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermBankEntry _$TermBankEntryFromJson(Map<String, dynamic> json) {
  return _TermBankEntry.fromJson(json);
}

/// @nodoc
mixin _$TermBankEntry {
  ///
  String get term => throw _privateConstructorUsedError;

  ///
  String get reading => throw _privateConstructorUsedError;

  ///
  List<String> get definitionTags => throw _privateConstructorUsedError;

  ///
  List<String> get ruleIdentifiers => throw _privateConstructorUsedError;

  ///
  int get popularity => throw _privateConstructorUsedError;

  ///
  List<String>? get definitions => throw _privateConstructorUsedError;

  ///
  int get sequenceNumber => throw _privateConstructorUsedError;

  ///
  List<TagBankEntry> get tags => throw _privateConstructorUsedError;

  /// Serializes this TermBankEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermBankEntryCopyWith<TermBankEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermBankEntryCopyWith<$Res> {
  factory $TermBankEntryCopyWith(
          TermBankEntry value, $Res Function(TermBankEntry) then) =
      _$TermBankEntryCopyWithImpl<$Res, TermBankEntry>;
  @useResult
  $Res call(
      {String term,
      String reading,
      List<String> definitionTags,
      List<String> ruleIdentifiers,
      int popularity,
      List<String>? definitions,
      int sequenceNumber,
      List<TagBankEntry> tags});
}

/// @nodoc
class _$TermBankEntryCopyWithImpl<$Res, $Val extends TermBankEntry>
    implements $TermBankEntryCopyWith<$Res> {
  _$TermBankEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? reading = null,
    Object? definitionTags = null,
    Object? ruleIdentifiers = null,
    Object? popularity = null,
    Object? definitions = freezed,
    Object? sequenceNumber = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      reading: null == reading
          ? _value.reading
          : reading // ignore: cast_nullable_to_non_nullable
              as String,
      definitionTags: null == definitionTags
          ? _value.definitionTags
          : definitionTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ruleIdentifiers: null == ruleIdentifiers
          ? _value.ruleIdentifiers
          : ruleIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as int,
      definitions: freezed == definitions
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sequenceNumber: null == sequenceNumber
          ? _value.sequenceNumber
          : sequenceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagBankEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermBankEntryImplCopyWith<$Res>
    implements $TermBankEntryCopyWith<$Res> {
  factory _$$TermBankEntryImplCopyWith(
          _$TermBankEntryImpl value, $Res Function(_$TermBankEntryImpl) then) =
      __$$TermBankEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String term,
      String reading,
      List<String> definitionTags,
      List<String> ruleIdentifiers,
      int popularity,
      List<String>? definitions,
      int sequenceNumber,
      List<TagBankEntry> tags});
}

/// @nodoc
class __$$TermBankEntryImplCopyWithImpl<$Res>
    extends _$TermBankEntryCopyWithImpl<$Res, _$TermBankEntryImpl>
    implements _$$TermBankEntryImplCopyWith<$Res> {
  __$$TermBankEntryImplCopyWithImpl(
      _$TermBankEntryImpl _value, $Res Function(_$TermBankEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TermBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? reading = null,
    Object? definitionTags = null,
    Object? ruleIdentifiers = null,
    Object? popularity = null,
    Object? definitions = freezed,
    Object? sequenceNumber = null,
    Object? tags = null,
  }) {
    return _then(_$TermBankEntryImpl(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      reading: null == reading
          ? _value.reading
          : reading // ignore: cast_nullable_to_non_nullable
              as String,
      definitionTags: null == definitionTags
          ? _value.definitionTags
          : definitionTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ruleIdentifiers: null == ruleIdentifiers
          ? _value.ruleIdentifiers
          : ruleIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as int,
      definitions: freezed == definitions
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sequenceNumber: null == sequenceNumber
          ? _value.sequenceNumber
          : sequenceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagBankEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermBankEntryImpl implements _TermBankEntry {
  const _$TermBankEntryImpl(
      {required this.term,
      required this.reading,
      required this.definitionTags,
      required this.ruleIdentifiers,
      required this.popularity,
      required this.definitions,
      required this.sequenceNumber,
      required this.tags});

  factory _$TermBankEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermBankEntryImplFromJson(json);

  ///
  @override
  final String term;

  ///
  @override
  final String reading;

  ///
  @override
  final List<String> definitionTags;

  ///
  @override
  final List<String> ruleIdentifiers;

  ///
  @override
  final int popularity;

  ///
  @override
  final List<String>? definitions;

  ///
  @override
  final int sequenceNumber;

  ///
  @override
  final List<TagBankEntry> tags;

  @override
  String toString() {
    return 'TermBankEntry(term: $term, reading: $reading, definitionTags: $definitionTags, ruleIdentifiers: $ruleIdentifiers, popularity: $popularity, definitions: $definitions, sequenceNumber: $sequenceNumber, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermBankEntryImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.reading, reading) || other.reading == reading) &&
            const DeepCollectionEquality()
                .equals(other.definitionTags, definitionTags) &&
            const DeepCollectionEquality()
                .equals(other.ruleIdentifiers, ruleIdentifiers) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            const DeepCollectionEquality()
                .equals(other.definitions, definitions) &&
            (identical(other.sequenceNumber, sequenceNumber) ||
                other.sequenceNumber == sequenceNumber) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      term,
      reading,
      const DeepCollectionEquality().hash(definitionTags),
      const DeepCollectionEquality().hash(ruleIdentifiers),
      popularity,
      const DeepCollectionEquality().hash(definitions),
      sequenceNumber,
      const DeepCollectionEquality().hash(tags));

  /// Create a copy of TermBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermBankEntryImplCopyWith<_$TermBankEntryImpl> get copyWith =>
      __$$TermBankEntryImplCopyWithImpl<_$TermBankEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermBankEntryImplToJson(
      this,
    );
  }
}

abstract class _TermBankEntry implements TermBankEntry {
  const factory _TermBankEntry(
      {required final String term,
      required final String reading,
      required final List<String> definitionTags,
      required final List<String> ruleIdentifiers,
      required final int popularity,
      required final List<String>? definitions,
      required final int sequenceNumber,
      required final List<TagBankEntry> tags}) = _$TermBankEntryImpl;

  factory _TermBankEntry.fromJson(Map<String, dynamic> json) =
      _$TermBankEntryImpl.fromJson;

  ///
  @override
  String get term;

  ///
  @override
  String get reading;

  ///
  @override
  List<String> get definitionTags;

  ///
  @override
  List<String> get ruleIdentifiers;

  ///
  @override
  int get popularity;

  ///
  @override
  List<String>? get definitions;

  ///
  @override
  int get sequenceNumber;

  ///
  @override
  List<TagBankEntry> get tags;

  /// Create a copy of TermBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermBankEntryImplCopyWith<_$TermBankEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
