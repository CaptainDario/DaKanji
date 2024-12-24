// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KanjiBankV3Entry _$KanjiBankV3EntryFromJson(Map<String, dynamic> json) {
  return _KanjiBankV3Entry.fromJson(json);
}

/// @nodoc
mixin _$KanjiBankV3Entry {
  /// The kanji character of this entry
  String get kanji => throw _privateConstructorUsedError;

  /// The onyomi readings of this entry
  List<String>? get onyomis => throw _privateConstructorUsedError;

  /// The kunyomi readings of this entry
  List<String>? get kunyomis => throw _privateConstructorUsedError;

  /// The tags of this entry
  List<TagBankV3Entry>? get tags => throw _privateConstructorUsedError;

  /// The meanings of this entry
  List<String>? get meanings => throw _privateConstructorUsedError;

  /// The stats of this entry
  List<KanjiBankV3EntryStat>? get stats => throw _privateConstructorUsedError;

  /// Serializes this KanjiBankV3Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KanjiBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanjiBankV3EntryCopyWith<KanjiBankV3Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanjiBankV3EntryCopyWith<$Res> {
  factory $KanjiBankV3EntryCopyWith(
          KanjiBankV3Entry value, $Res Function(KanjiBankV3Entry) then) =
      _$KanjiBankV3EntryCopyWithImpl<$Res, KanjiBankV3Entry>;
  @useResult
  $Res call(
      {String kanji,
      List<String>? onyomis,
      List<String>? kunyomis,
      List<TagBankV3Entry>? tags,
      List<String>? meanings,
      List<KanjiBankV3EntryStat>? stats});
}

/// @nodoc
class _$KanjiBankV3EntryCopyWithImpl<$Res, $Val extends KanjiBankV3Entry>
    implements $KanjiBankV3EntryCopyWith<$Res> {
  _$KanjiBankV3EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KanjiBankV3Entry
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
              as List<TagBankV3Entry>?,
      meanings: freezed == meanings
          ? _value.meanings
          : meanings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<KanjiBankV3EntryStat>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KanjiBankV3EntryImplCopyWith<$Res>
    implements $KanjiBankV3EntryCopyWith<$Res> {
  factory _$$KanjiBankV3EntryImplCopyWith(_$KanjiBankV3EntryImpl value,
          $Res Function(_$KanjiBankV3EntryImpl) then) =
      __$$KanjiBankV3EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String kanji,
      List<String>? onyomis,
      List<String>? kunyomis,
      List<TagBankV3Entry>? tags,
      List<String>? meanings,
      List<KanjiBankV3EntryStat>? stats});
}

/// @nodoc
class __$$KanjiBankV3EntryImplCopyWithImpl<$Res>
    extends _$KanjiBankV3EntryCopyWithImpl<$Res, _$KanjiBankV3EntryImpl>
    implements _$$KanjiBankV3EntryImplCopyWith<$Res> {
  __$$KanjiBankV3EntryImplCopyWithImpl(_$KanjiBankV3EntryImpl _value,
      $Res Function(_$KanjiBankV3EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of KanjiBankV3Entry
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
    return _then(_$KanjiBankV3EntryImpl(
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
              as List<TagBankV3Entry>?,
      meanings: freezed == meanings
          ? _value.meanings
          : meanings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<KanjiBankV3EntryStat>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KanjiBankV3EntryImpl implements _KanjiBankV3Entry {
  const _$KanjiBankV3EntryImpl(
      {required this.kanji,
      required this.onyomis,
      required this.kunyomis,
      required this.tags,
      required this.meanings,
      required this.stats});

  factory _$KanjiBankV3EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanjiBankV3EntryImplFromJson(json);

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
  final List<TagBankV3Entry>? tags;

  /// The meanings of this entry
  @override
  final List<String>? meanings;

  /// The stats of this entry
  @override
  final List<KanjiBankV3EntryStat>? stats;

  @override
  String toString() {
    return 'KanjiBankV3Entry(kanji: $kanji, onyomis: $onyomis, kunyomis: $kunyomis, tags: $tags, meanings: $meanings, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanjiBankV3EntryImpl &&
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

  /// Create a copy of KanjiBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanjiBankV3EntryImplCopyWith<_$KanjiBankV3EntryImpl> get copyWith =>
      __$$KanjiBankV3EntryImplCopyWithImpl<_$KanjiBankV3EntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanjiBankV3EntryImplToJson(
      this,
    );
  }
}

abstract class _KanjiBankV3Entry implements KanjiBankV3Entry {
  const factory _KanjiBankV3Entry(
          {required final String kanji,
          required final List<String>? onyomis,
          required final List<String>? kunyomis,
          required final List<TagBankV3Entry>? tags,
          required final List<String>? meanings,
          required final List<KanjiBankV3EntryStat>? stats}) =
      _$KanjiBankV3EntryImpl;

  factory _KanjiBankV3Entry.fromJson(Map<String, dynamic> json) =
      _$KanjiBankV3EntryImpl.fromJson;

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
  List<TagBankV3Entry>? get tags;

  /// The meanings of this entry
  @override
  List<String>? get meanings;

  /// The stats of this entry
  @override
  List<KanjiBankV3EntryStat>? get stats;

  /// Create a copy of KanjiBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanjiBankV3EntryImplCopyWith<_$KanjiBankV3EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
