// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_bank_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KanjiBankEntry _$KanjiBankEntryFromJson(Map<String, dynamic> json) {
  return _KanjiBankEntry.fromJson(json);
}

/// @nodoc
mixin _$KanjiBankEntry {
  /// The kanji character of this entry
  String get kanji => throw _privateConstructorUsedError;

  /// The onyomi readings of this entry
  List<String>? get onyomis => throw _privateConstructorUsedError;

  /// The kunyomi readings of this entry
  List<String>? get kunyomis => throw _privateConstructorUsedError;

  /// The tags of this entry
  List<String>? get tags => throw _privateConstructorUsedError;

  /// The meanings of this entry
  List<String>? get meanings => throw _privateConstructorUsedError;

  /// The stats of this entry
  Map<String, String>? get stats => throw _privateConstructorUsedError;

  /// Serializes this KanjiBankEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KanjiBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanjiBankEntryCopyWith<KanjiBankEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanjiBankEntryCopyWith<$Res> {
  factory $KanjiBankEntryCopyWith(
          KanjiBankEntry value, $Res Function(KanjiBankEntry) then) =
      _$KanjiBankEntryCopyWithImpl<$Res, KanjiBankEntry>;
  @useResult
  $Res call(
      {String kanji,
      List<String>? onyomis,
      List<String>? kunyomis,
      List<String>? tags,
      List<String>? meanings,
      Map<String, String>? stats});
}

/// @nodoc
class _$KanjiBankEntryCopyWithImpl<$Res, $Val extends KanjiBankEntry>
    implements $KanjiBankEntryCopyWith<$Res> {
  _$KanjiBankEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KanjiBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kanji = null,
    Object? onyomis = freezed,
    Object? kunyomis = freezed,
    Object? tags = freezed,
    Object? meanings = freezed,
    Object? stats = freezed,
  }) {
    return _then(_value.copyWith(
      kanji: null == kanji
          ? _value.kanji
          : kanji // ignore: cast_nullable_to_non_nullable
              as String,
      onyomis: freezed == onyomis
          ? _value.onyomis
          : onyomis // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      kunyomis: freezed == kunyomis
          ? _value.kunyomis
          : kunyomis // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      meanings: freezed == meanings
          ? _value.meanings
          : meanings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KanjiBankEntryImplCopyWith<$Res>
    implements $KanjiBankEntryCopyWith<$Res> {
  factory _$$KanjiBankEntryImplCopyWith(_$KanjiBankEntryImpl value,
          $Res Function(_$KanjiBankEntryImpl) then) =
      __$$KanjiBankEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String kanji,
      List<String>? onyomis,
      List<String>? kunyomis,
      List<String>? tags,
      List<String>? meanings,
      Map<String, String>? stats});
}

/// @nodoc
class __$$KanjiBankEntryImplCopyWithImpl<$Res>
    extends _$KanjiBankEntryCopyWithImpl<$Res, _$KanjiBankEntryImpl>
    implements _$$KanjiBankEntryImplCopyWith<$Res> {
  __$$KanjiBankEntryImplCopyWithImpl(
      _$KanjiBankEntryImpl _value, $Res Function(_$KanjiBankEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of KanjiBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kanji = null,
    Object? onyomis = freezed,
    Object? kunyomis = freezed,
    Object? tags = freezed,
    Object? meanings = freezed,
    Object? stats = freezed,
  }) {
    return _then(_$KanjiBankEntryImpl(
      kanji: null == kanji
          ? _value.kanji
          : kanji // ignore: cast_nullable_to_non_nullable
              as String,
      onyomis: freezed == onyomis
          ? _value.onyomis
          : onyomis // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      kunyomis: freezed == kunyomis
          ? _value.kunyomis
          : kunyomis // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      meanings: freezed == meanings
          ? _value.meanings
          : meanings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KanjiBankEntryImpl implements _KanjiBankEntry {
  const _$KanjiBankEntryImpl(
      {required this.kanji,
      required this.onyomis,
      required this.kunyomis,
      required this.tags,
      required this.meanings,
      required this.stats});

  factory _$KanjiBankEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanjiBankEntryImplFromJson(json);

  /// The kanji character of this entry
  @override
  final String kanji;

  /// The onyomi readings of this entry
  @override
  final List<String>? onyomis;

  /// The kunyomi readings of this entry
  @override
  final List<String>? kunyomis;

  /// The tags of this entry
  @override
  final List<String>? tags;

  /// The meanings of this entry
  @override
  final List<String>? meanings;

  /// The stats of this entry
  @override
  final Map<String, String>? stats;

  @override
  String toString() {
    return 'KanjiBankEntry(kanji: $kanji, onyomis: $onyomis, kunyomis: $kunyomis, tags: $tags, meanings: $meanings, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanjiBankEntryImpl &&
            (identical(other.kanji, kanji) || other.kanji == kanji) &&
            const DeepCollectionEquality().equals(other.onyomis, onyomis) &&
            const DeepCollectionEquality().equals(other.kunyomis, kunyomis) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.meanings, meanings) &&
            const DeepCollectionEquality().equals(other.stats, stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      kanji,
      const DeepCollectionEquality().hash(onyomis),
      const DeepCollectionEquality().hash(kunyomis),
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(meanings),
      const DeepCollectionEquality().hash(stats));

  /// Create a copy of KanjiBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanjiBankEntryImplCopyWith<_$KanjiBankEntryImpl> get copyWith =>
      __$$KanjiBankEntryImplCopyWithImpl<_$KanjiBankEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanjiBankEntryImplToJson(
      this,
    );
  }
}

abstract class _KanjiBankEntry implements KanjiBankEntry {
  const factory _KanjiBankEntry(
      {required final String kanji,
      required final List<String>? onyomis,
      required final List<String>? kunyomis,
      required final List<String>? tags,
      required final List<String>? meanings,
      required final Map<String, String>? stats}) = _$KanjiBankEntryImpl;

  factory _KanjiBankEntry.fromJson(Map<String, dynamic> json) =
      _$KanjiBankEntryImpl.fromJson;

  /// The kanji character of this entry
  @override
  String get kanji;

  /// The onyomi readings of this entry
  @override
  List<String>? get onyomis;

  /// The kunyomi readings of this entry
  @override
  List<String>? get kunyomis;

  /// The tags of this entry
  @override
  List<String>? get tags;

  /// The meanings of this entry
  @override
  List<String>? get meanings;

  /// The stats of this entry
  @override
  Map<String, String>? get stats;

  /// Create a copy of KanjiBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanjiBankEntryImplCopyWith<_$KanjiBankEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
