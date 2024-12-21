// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_frequency_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermMetaBankV3FrequencyEntry _$TermMetaBankV3FrequencyEntryFromJson(
    Map<String, dynamic> json) {
  return _TermMetaBankV3FrequencyEntry.fromJson(json);
}

/// @nodoc
mixin _$TermMetaBankV3FrequencyEntry {
  /// the frequency of this entry as a numeric value
  int? get frequency => throw _privateConstructorUsedError;

  /// the frequency of this entry as a string for displaying
  String? get frequencyDisplayValue => throw _privateConstructorUsedError;

  /// Serializes this TermMetaBankV3FrequencyEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TermMetaBankV3FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TermMetaBankV3FrequencyEntryCopyWith<TermMetaBankV3FrequencyEntry>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermMetaBankV3FrequencyEntryCopyWith<$Res> {
  factory $TermMetaBankV3FrequencyEntryCopyWith(
          TermMetaBankV3FrequencyEntry value,
          $Res Function(TermMetaBankV3FrequencyEntry) then) =
      _$TermMetaBankV3FrequencyEntryCopyWithImpl<$Res,
          TermMetaBankV3FrequencyEntry>;
  @useResult
  $Res call({int? frequency, String? frequencyDisplayValue});
}

/// @nodoc
class _$TermMetaBankV3FrequencyEntryCopyWithImpl<$Res,
        $Val extends TermMetaBankV3FrequencyEntry>
    implements $TermMetaBankV3FrequencyEntryCopyWith<$Res> {
  _$TermMetaBankV3FrequencyEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TermMetaBankV3FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = freezed,
    Object? frequencyDisplayValue = freezed,
  }) {
    return _then(_value.copyWith(
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyDisplayValue: freezed == frequencyDisplayValue
          ? _value.frequencyDisplayValue
          : frequencyDisplayValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermMetaBankV3FrequencyEntryImplCopyWith<$Res>
    implements $TermMetaBankV3FrequencyEntryCopyWith<$Res> {
  factory _$$TermMetaBankV3FrequencyEntryImplCopyWith(
          _$TermMetaBankV3FrequencyEntryImpl value,
          $Res Function(_$TermMetaBankV3FrequencyEntryImpl) then) =
      __$$TermMetaBankV3FrequencyEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? frequency, String? frequencyDisplayValue});
}

/// @nodoc
class __$$TermMetaBankV3FrequencyEntryImplCopyWithImpl<$Res>
    extends _$TermMetaBankV3FrequencyEntryCopyWithImpl<$Res,
        _$TermMetaBankV3FrequencyEntryImpl>
    implements _$$TermMetaBankV3FrequencyEntryImplCopyWith<$Res> {
  __$$TermMetaBankV3FrequencyEntryImplCopyWithImpl(
      _$TermMetaBankV3FrequencyEntryImpl _value,
      $Res Function(_$TermMetaBankV3FrequencyEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TermMetaBankV3FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = freezed,
    Object? frequencyDisplayValue = freezed,
  }) {
    return _then(_$TermMetaBankV3FrequencyEntryImpl(
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyDisplayValue: freezed == frequencyDisplayValue
          ? _value.frequencyDisplayValue
          : frequencyDisplayValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermMetaBankV3FrequencyEntryImpl
    implements _TermMetaBankV3FrequencyEntry {
  const _$TermMetaBankV3FrequencyEntryImpl(
      {this.frequency, this.frequencyDisplayValue});

  factory _$TermMetaBankV3FrequencyEntryImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TermMetaBankV3FrequencyEntryImplFromJson(json);

  /// the frequency of this entry as a numeric value
  @override
  final int? frequency;

  /// the frequency of this entry as a string for displaying
  @override
  final String? frequencyDisplayValue;

  @override
  String toString() {
    return 'TermMetaBankV3FrequencyEntry(frequency: $frequency, frequencyDisplayValue: $frequencyDisplayValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermMetaBankV3FrequencyEntryImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.frequencyDisplayValue, frequencyDisplayValue) ||
                other.frequencyDisplayValue == frequencyDisplayValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, frequency, frequencyDisplayValue);

  /// Create a copy of TermMetaBankV3FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermMetaBankV3FrequencyEntryImplCopyWith<
          _$TermMetaBankV3FrequencyEntryImpl>
      get copyWith => __$$TermMetaBankV3FrequencyEntryImplCopyWithImpl<
          _$TermMetaBankV3FrequencyEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermMetaBankV3FrequencyEntryImplToJson(
      this,
    );
  }
}

abstract class _TermMetaBankV3FrequencyEntry
    implements TermMetaBankV3FrequencyEntry {
  const factory _TermMetaBankV3FrequencyEntry(
          {final int? frequency, final String? frequencyDisplayValue}) =
      _$TermMetaBankV3FrequencyEntryImpl;

  factory _TermMetaBankV3FrequencyEntry.fromJson(Map<String, dynamic> json) =
      _$TermMetaBankV3FrequencyEntryImpl.fromJson;

  /// the frequency of this entry as a numeric value
  @override
  int? get frequency;

  /// the frequency of this entry as a string for displaying
  @override
  String? get frequencyDisplayValue;

  /// Create a copy of TermMetaBankV3FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermMetaBankV3FrequencyEntryImplCopyWith<
          _$TermMetaBankV3FrequencyEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
