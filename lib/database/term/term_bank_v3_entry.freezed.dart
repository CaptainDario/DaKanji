// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermBankV3Entry _$TermBankV3EntryFromJson(Map<String, dynamic> json) {
  return _TermBankV3Entry.fromJson(json);
}

/// @nodoc
mixin _$TermBankV3Entry {
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
  List<TagBankV3Entry> get tags => throw _privateConstructorUsedError;

  /// Serializes this TermBankV3Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermBankV3EntryCopyWith<TermBankV3Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermBankV3EntryCopyWith<$Res> {
  factory $TermBankV3EntryCopyWith(
          TermBankV3Entry value, $Res Function(TermBankV3Entry) then) =
      _$TermBankV3EntryCopyWithImpl<$Res, TermBankV3Entry>;
  @useResult
  $Res call(
      {String term,
      String reading,
      List<String> definitionTags,
      List<String> ruleIdentifiers,
      int popularity,
      List<String>? definitions,
      int sequenceNumber,
      List<TagBankV3Entry> tags});
}

/// @nodoc
class _$TermBankV3EntryCopyWithImpl<$Res, $Val extends TermBankV3Entry>
    implements $TermBankV3EntryCopyWith<$Res> {
  _$TermBankV3EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermBankV3Entry
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
              as List<TagBankV3Entry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermBankV3EntryImplCopyWith<$Res>
    implements $TermBankV3EntryCopyWith<$Res> {
  factory _$$TermBankV3EntryImplCopyWith(_$TermBankV3EntryImpl value,
          $Res Function(_$TermBankV3EntryImpl) then) =
      __$$TermBankV3EntryImplCopyWithImpl<$Res>;
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
      List<TagBankV3Entry> tags});
}

/// @nodoc
class __$$TermBankV3EntryImplCopyWithImpl<$Res>
    extends _$TermBankV3EntryCopyWithImpl<$Res, _$TermBankV3EntryImpl>
    implements _$$TermBankV3EntryImplCopyWith<$Res> {
  __$$TermBankV3EntryImplCopyWithImpl(
      _$TermBankV3EntryImpl _value, $Res Function(_$TermBankV3EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TermBankV3Entry
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
    return _then(_$TermBankV3EntryImpl(
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
              as List<TagBankV3Entry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermBankV3EntryImpl implements _TermBankV3Entry {
  const _$TermBankV3EntryImpl(
      {required this.term,
      required this.reading,
      required this.definitionTags,
      required this.ruleIdentifiers,
      required this.popularity,
      required this.definitions,
      required this.sequenceNumber,
      required this.tags});

  factory _$TermBankV3EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermBankV3EntryImplFromJson(json);

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
  final List<TagBankV3Entry> tags;

  @override
  String toString() {
    return 'TermBankV3Entry(term: $term, reading: $reading, definitionTags: $definitionTags, ruleIdentifiers: $ruleIdentifiers, popularity: $popularity, definitions: $definitions, sequenceNumber: $sequenceNumber, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermBankV3EntryImpl &&
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

  /// Create a copy of TermBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermBankV3EntryImplCopyWith<_$TermBankV3EntryImpl> get copyWith =>
      __$$TermBankV3EntryImplCopyWithImpl<_$TermBankV3EntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermBankV3EntryImplToJson(
      this,
    );
  }
}

abstract class _TermBankV3Entry implements TermBankV3Entry {
  const factory _TermBankV3Entry(
      {required final String term,
      required final String reading,
      required final List<String> definitionTags,
      required final List<String> ruleIdentifiers,
      required final int popularity,
      required final List<String>? definitions,
      required final int sequenceNumber,
      required final List<TagBankV3Entry> tags}) = _$TermBankV3EntryImpl;

  factory _TermBankV3Entry.fromJson(Map<String, dynamic> json) =
      _$TermBankV3EntryImpl.fromJson;

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
  List<TagBankV3Entry> get tags;

  /// Create a copy of TermBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermBankV3EntryImplCopyWith<_$TermBankV3EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
