// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_ipa_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermMetaBankV3IpaEntry _$TermMetaBankV3IpaEntryFromJson(
    Map<String, dynamic> json) {
  return _TermMetaBankV3IpaEntry.fromJson(json);
}

/// @nodoc
mixin _$TermMetaBankV3IpaEntry {
  /// the ipa transcription of this entry
  String get ipa => throw _privateConstructorUsedError;

  /// all tags of this pitch entry
  List<String>? get tags => throw _privateConstructorUsedError;

  /// Serializes this TermMetaBankV3IpaEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermMetaBankV3IpaEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermMetaBankV3IpaEntryCopyWith<TermMetaBankV3IpaEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermMetaBankV3IpaEntryCopyWith<$Res> {
  factory $TermMetaBankV3IpaEntryCopyWith(TermMetaBankV3IpaEntry value,
          $Res Function(TermMetaBankV3IpaEntry) then) =
      _$TermMetaBankV3IpaEntryCopyWithImpl<$Res, TermMetaBankV3IpaEntry>;
  @useResult
  $Res call({String ipa, List<String>? tags});
}

/// @nodoc
class _$TermMetaBankV3IpaEntryCopyWithImpl<$Res,
        $Val extends TermMetaBankV3IpaEntry>
    implements $TermMetaBankV3IpaEntryCopyWith<$Res> {
  _$TermMetaBankV3IpaEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermMetaBankV3IpaEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ipa = null,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      ipa: null == ipa
          ? _value.ipa
          : ipa // ignore: cast_nullable_to_non_nullable
              as String,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermMetaBankV3IpaEntryImplCopyWith<$Res>
    implements $TermMetaBankV3IpaEntryCopyWith<$Res> {
  factory _$$TermMetaBankV3IpaEntryImplCopyWith(
          _$TermMetaBankV3IpaEntryImpl value,
          $Res Function(_$TermMetaBankV3IpaEntryImpl) then) =
      __$$TermMetaBankV3IpaEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ipa, List<String>? tags});
}

/// @nodoc
class __$$TermMetaBankV3IpaEntryImplCopyWithImpl<$Res>
    extends _$TermMetaBankV3IpaEntryCopyWithImpl<$Res,
        _$TermMetaBankV3IpaEntryImpl>
    implements _$$TermMetaBankV3IpaEntryImplCopyWith<$Res> {
  __$$TermMetaBankV3IpaEntryImplCopyWithImpl(
      _$TermMetaBankV3IpaEntryImpl _value,
      $Res Function(_$TermMetaBankV3IpaEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TermMetaBankV3IpaEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ipa = null,
    Object? tags = freezed,
  }) {
    return _then(_$TermMetaBankV3IpaEntryImpl(
      ipa: null == ipa
          ? _value.ipa
          : ipa // ignore: cast_nullable_to_non_nullable
              as String,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermMetaBankV3IpaEntryImpl implements _TermMetaBankV3IpaEntry {
  const _$TermMetaBankV3IpaEntryImpl({required this.ipa, this.tags});

  factory _$TermMetaBankV3IpaEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermMetaBankV3IpaEntryImplFromJson(json);

  /// the ipa transcription of this entry
  @override
  final String ipa;

  /// all tags of this pitch entry
  @override
  final List<String>? tags;

  @override
  String toString() {
    return 'TermMetaBankV3IpaEntry(ipa: $ipa, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermMetaBankV3IpaEntryImpl &&
            (identical(other.ipa, ipa) || other.ipa == ipa) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ipa, const DeepCollectionEquality().hash(tags));

  /// Create a copy of TermMetaBankV3IpaEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermMetaBankV3IpaEntryImplCopyWith<_$TermMetaBankV3IpaEntryImpl>
      get copyWith => __$$TermMetaBankV3IpaEntryImplCopyWithImpl<
          _$TermMetaBankV3IpaEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermMetaBankV3IpaEntryImplToJson(
      this,
    );
  }
}

abstract class _TermMetaBankV3IpaEntry implements TermMetaBankV3IpaEntry {
  const factory _TermMetaBankV3IpaEntry(
      {required final String ipa,
      final List<String>? tags}) = _$TermMetaBankV3IpaEntryImpl;

  factory _TermMetaBankV3IpaEntry.fromJson(Map<String, dynamic> json) =
      _$TermMetaBankV3IpaEntryImpl.fromJson;

  /// the ipa transcription of this entry
  @override
  String get ipa;

  /// all tags of this pitch entry
  @override
  List<String>? get tags;

  /// Create a copy of TermMetaBankV3IpaEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermMetaBankV3IpaEntryImplCopyWith<_$TermMetaBankV3IpaEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
