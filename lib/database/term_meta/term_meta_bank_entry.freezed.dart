// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermMetaBankV3Entry _$TermMetaBankV3EntryFromJson(Map<String, dynamic> json) {
  return _TermMetaBankV3Entry.fromJson(json);
}

/// @nodoc
mixin _$TermMetaBankV3Entry {
  /// The term of this entry
  String get term => throw _privateConstructorUsedError;

  /// The type of this entry
  String get type => throw _privateConstructorUsedError;

  /// The reading of this entry
  String? get reading => throw _privateConstructorUsedError;

  /// Frequency of this entry
  TermMetaBankV3FrequencyEntry? get frequency =>
      throw _privateConstructorUsedError;

  /// Pitch data of this entry
  TermMetaBankV3PitchEntry? get pitch => throw _privateConstructorUsedError;

  /// Ipa transcription data of this entry
  TermMetaBankV3IpaEntry? get ipa => throw _privateConstructorUsedError;

  /// Serializes this TermMetaBankV3Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermMetaBankV3EntryCopyWith<TermMetaBankV3Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermMetaBankV3EntryCopyWith<$Res> {
  factory $TermMetaBankV3EntryCopyWith(
          TermMetaBankV3Entry value, $Res Function(TermMetaBankV3Entry) then) =
      _$TermMetaBankV3EntryCopyWithImpl<$Res, TermMetaBankV3Entry>;
  @useResult
  $Res call(
      {String term,
      String type,
      String? reading,
      TermMetaBankV3FrequencyEntry? frequency,
      TermMetaBankV3PitchEntry? pitch,
      TermMetaBankV3IpaEntry? ipa});

  $TermMetaBankV3FrequencyEntryCopyWith<$Res>? get frequency;
  $TermMetaBankV3PitchEntryCopyWith<$Res>? get pitch;
  $TermMetaBankV3IpaEntryCopyWith<$Res>? get ipa;
}

/// @nodoc
class _$TermMetaBankV3EntryCopyWithImpl<$Res, $Val extends TermMetaBankV3Entry>
    implements $TermMetaBankV3EntryCopyWith<$Res> {
  _$TermMetaBankV3EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? type = null,
    Object? reading = freezed,
    Object? frequency = freezed,
    Object? pitch = freezed,
    Object? ipa = freezed,
  }) {
    return _then(_value.copyWith(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      reading: freezed == reading
          ? _value.reading
          : reading // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as TermMetaBankV3FrequencyEntry?,
      pitch: freezed == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as TermMetaBankV3PitchEntry?,
      ipa: freezed == ipa
          ? _value.ipa
          : ipa // ignore: cast_nullable_to_non_nullable
              as TermMetaBankV3IpaEntry?,
    ) as $Val);
  }

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TermMetaBankV3FrequencyEntryCopyWith<$Res>? get frequency {
    if (_value.frequency == null) {
      return null;
    }

    return $TermMetaBankV3FrequencyEntryCopyWith<$Res>(_value.frequency!,
        (value) {
      return _then(_value.copyWith(frequency: value) as $Val);
    });
  }

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TermMetaBankV3PitchEntryCopyWith<$Res>? get pitch {
    if (_value.pitch == null) {
      return null;
    }

    return $TermMetaBankV3PitchEntryCopyWith<$Res>(_value.pitch!, (value) {
      return _then(_value.copyWith(pitch: value) as $Val);
    });
  }

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TermMetaBankV3IpaEntryCopyWith<$Res>? get ipa {
    if (_value.ipa == null) {
      return null;
    }

    return $TermMetaBankV3IpaEntryCopyWith<$Res>(_value.ipa!, (value) {
      return _then(_value.copyWith(ipa: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TermMetaBankV3EntryImplCopyWith<$Res>
    implements $TermMetaBankV3EntryCopyWith<$Res> {
  factory _$$TermMetaBankV3EntryImplCopyWith(_$TermMetaBankV3EntryImpl value,
          $Res Function(_$TermMetaBankV3EntryImpl) then) =
      __$$TermMetaBankV3EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String term,
      String type,
      String? reading,
      TermMetaBankV3FrequencyEntry? frequency,
      TermMetaBankV3PitchEntry? pitch,
      TermMetaBankV3IpaEntry? ipa});

  @override
  $TermMetaBankV3FrequencyEntryCopyWith<$Res>? get frequency;
  @override
  $TermMetaBankV3PitchEntryCopyWith<$Res>? get pitch;
  @override
  $TermMetaBankV3IpaEntryCopyWith<$Res>? get ipa;
}

/// @nodoc
class __$$TermMetaBankV3EntryImplCopyWithImpl<$Res>
    extends _$TermMetaBankV3EntryCopyWithImpl<$Res, _$TermMetaBankV3EntryImpl>
    implements _$$TermMetaBankV3EntryImplCopyWith<$Res> {
  __$$TermMetaBankV3EntryImplCopyWithImpl(_$TermMetaBankV3EntryImpl _value,
      $Res Function(_$TermMetaBankV3EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? type = null,
    Object? reading = freezed,
    Object? frequency = freezed,
    Object? pitch = freezed,
    Object? ipa = freezed,
  }) {
    return _then(_$TermMetaBankV3EntryImpl(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      reading: freezed == reading
          ? _value.reading
          : reading // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as TermMetaBankV3FrequencyEntry?,
      pitch: freezed == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as TermMetaBankV3PitchEntry?,
      ipa: freezed == ipa
          ? _value.ipa
          : ipa // ignore: cast_nullable_to_non_nullable
              as TermMetaBankV3IpaEntry?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermMetaBankV3EntryImpl implements _TermMetaBankV3Entry {
  const _$TermMetaBankV3EntryImpl(
      {required this.term,
      required this.type,
      this.reading,
      this.frequency,
      this.pitch,
      this.ipa});

  factory _$TermMetaBankV3EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermMetaBankV3EntryImplFromJson(json);

  /// The term of this entry
  @override
  final String term;

  /// The type of this entry
  @override
  final String type;

  /// The reading of this entry
  @override
  final String? reading;

  /// Frequency of this entry
  @override
  final TermMetaBankV3FrequencyEntry? frequency;

  /// Pitch data of this entry
  @override
  final TermMetaBankV3PitchEntry? pitch;

  /// Ipa transcription data of this entry
  @override
  final TermMetaBankV3IpaEntry? ipa;

  @override
  String toString() {
    return 'TermMetaBankV3Entry(term: $term, type: $type, reading: $reading, frequency: $frequency, pitch: $pitch, ipa: $ipa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermMetaBankV3EntryImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reading, reading) || other.reading == reading) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.ipa, ipa) || other.ipa == ipa));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, term, type, reading, frequency, pitch, ipa);

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermMetaBankV3EntryImplCopyWith<_$TermMetaBankV3EntryImpl> get copyWith =>
      __$$TermMetaBankV3EntryImplCopyWithImpl<_$TermMetaBankV3EntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermMetaBankV3EntryImplToJson(
      this,
    );
  }
}

abstract class _TermMetaBankV3Entry implements TermMetaBankV3Entry {
  const factory _TermMetaBankV3Entry(
      {required final String term,
      required final String type,
      final String? reading,
      final TermMetaBankV3FrequencyEntry? frequency,
      final TermMetaBankV3PitchEntry? pitch,
      final TermMetaBankV3IpaEntry? ipa}) = _$TermMetaBankV3EntryImpl;

  factory _TermMetaBankV3Entry.fromJson(Map<String, dynamic> json) =
      _$TermMetaBankV3EntryImpl.fromJson;

  /// The term of this entry
  @override
  String get term;

  /// The type of this entry
  @override
  String get type;

  /// The reading of this entry
  @override
  String? get reading;

  /// Frequency of this entry
  @override
  TermMetaBankV3FrequencyEntry? get frequency;

  /// Pitch data of this entry
  @override
  TermMetaBankV3PitchEntry? get pitch;

  /// Ipa transcription data of this entry
  @override
  TermMetaBankV3IpaEntry? get ipa;

  /// Create a copy of TermMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermMetaBankV3EntryImplCopyWith<_$TermMetaBankV3EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
