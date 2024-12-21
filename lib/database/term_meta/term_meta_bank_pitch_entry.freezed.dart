// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_pitch_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermMetaBankV3PitchEntry _$TermMetaBankV3PitchEntryFromJson(
    Map<String, dynamic> json) {
  return _TermMetaBankV3PitchEntry.fromJson(json);
}

/// @nodoc
mixin _$TermMetaBankV3PitchEntry {
  /// the position of this pitch entry
  int get position => throw _privateConstructorUsedError;

  /// all tags of this pitch entry
  List<String>? get tags => throw _privateConstructorUsedError;

  /// nasal data of this pitch entry
  int? get nasal => throw _privateConstructorUsedError;

  /// devoice data of this pitch entry
  int? get devoice => throw _privateConstructorUsedError;

  /// Serializes this TermMetaBankV3PitchEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermMetaBankV3PitchEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermMetaBankV3PitchEntryCopyWith<TermMetaBankV3PitchEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermMetaBankV3PitchEntryCopyWith<$Res> {
  factory $TermMetaBankV3PitchEntryCopyWith(TermMetaBankV3PitchEntry value,
          $Res Function(TermMetaBankV3PitchEntry) then) =
      _$TermMetaBankV3PitchEntryCopyWithImpl<$Res, TermMetaBankV3PitchEntry>;
  @useResult
  $Res call({int position, List<String>? tags, int? nasal, int? devoice});
}

/// @nodoc
class _$TermMetaBankV3PitchEntryCopyWithImpl<$Res,
        $Val extends TermMetaBankV3PitchEntry>
    implements $TermMetaBankV3PitchEntryCopyWith<$Res> {
  _$TermMetaBankV3PitchEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermMetaBankV3PitchEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? tags = freezed,
    Object? nasal = freezed,
    Object? devoice = freezed,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nasal: freezed == nasal
          ? _value.nasal
          : nasal // ignore: cast_nullable_to_non_nullable
              as int?,
      devoice: freezed == devoice
          ? _value.devoice
          : devoice // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermMetaBankV3PitchEntryImplCopyWith<$Res>
    implements $TermMetaBankV3PitchEntryCopyWith<$Res> {
  factory _$$TermMetaBankV3PitchEntryImplCopyWith(
          _$TermMetaBankV3PitchEntryImpl value,
          $Res Function(_$TermMetaBankV3PitchEntryImpl) then) =
      __$$TermMetaBankV3PitchEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int position, List<String>? tags, int? nasal, int? devoice});
}

/// @nodoc
class __$$TermMetaBankV3PitchEntryImplCopyWithImpl<$Res>
    extends _$TermMetaBankV3PitchEntryCopyWithImpl<$Res,
        _$TermMetaBankV3PitchEntryImpl>
    implements _$$TermMetaBankV3PitchEntryImplCopyWith<$Res> {
  __$$TermMetaBankV3PitchEntryImplCopyWithImpl(
      _$TermMetaBankV3PitchEntryImpl _value,
      $Res Function(_$TermMetaBankV3PitchEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TermMetaBankV3PitchEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? tags = freezed,
    Object? nasal = freezed,
    Object? devoice = freezed,
  }) {
    return _then(_$TermMetaBankV3PitchEntryImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nasal: freezed == nasal
          ? _value.nasal
          : nasal // ignore: cast_nullable_to_non_nullable
              as int?,
      devoice: freezed == devoice
          ? _value.devoice
          : devoice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermMetaBankV3PitchEntryImpl implements _TermMetaBankV3PitchEntry {
  const _$TermMetaBankV3PitchEntryImpl(
      {required this.position, this.tags, this.nasal, this.devoice});

  factory _$TermMetaBankV3PitchEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermMetaBankV3PitchEntryImplFromJson(json);

  /// the position of this pitch entry
  @override
  final int position;

  /// all tags of this pitch entry
  @override
  final List<String>? tags;

  /// nasal data of this pitch entry
  @override
  final int? nasal;

  /// devoice data of this pitch entry
  @override
  final int? devoice;

  @override
  String toString() {
    return 'TermMetaBankV3PitchEntry(position: $position, tags: $tags, nasal: $nasal, devoice: $devoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermMetaBankV3PitchEntryImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.nasal, nasal) || other.nasal == nasal) &&
            (identical(other.devoice, devoice) || other.devoice == devoice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, position,
      const DeepCollectionEquality().hash(tags), nasal, devoice);

  /// Create a copy of TermMetaBankV3PitchEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermMetaBankV3PitchEntryImplCopyWith<_$TermMetaBankV3PitchEntryImpl>
      get copyWith => __$$TermMetaBankV3PitchEntryImplCopyWithImpl<
          _$TermMetaBankV3PitchEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermMetaBankV3PitchEntryImplToJson(
      this,
    );
  }
}

abstract class _TermMetaBankV3PitchEntry implements TermMetaBankV3PitchEntry {
  const factory _TermMetaBankV3PitchEntry(
      {required final int position,
      final List<String>? tags,
      final int? nasal,
      final int? devoice}) = _$TermMetaBankV3PitchEntryImpl;

  factory _TermMetaBankV3PitchEntry.fromJson(Map<String, dynamic> json) =
      _$TermMetaBankV3PitchEntryImpl.fromJson;

  /// the position of this pitch entry
  @override
  int get position;

  /// all tags of this pitch entry
  @override
  List<String>? get tags;

  /// nasal data of this pitch entry
  @override
  int? get nasal;

  /// devoice data of this pitch entry
  @override
  int? get devoice;

  /// Create a copy of TermMetaBankV3PitchEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermMetaBankV3PitchEntryImplCopyWith<_$TermMetaBankV3PitchEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
