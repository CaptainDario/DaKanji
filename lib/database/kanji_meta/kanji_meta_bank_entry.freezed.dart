// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_meta_bank_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KanjiMetaBankV3Entry _$KanjiMetaBankV3EntryFromJson(Map<String, dynamic> json) {
  return _KanjiMetaBankV3Entry.fromJson(json);
}

/// @nodoc
mixin _$KanjiMetaBankV3Entry {
  /// The kanji of this entry
  String get kanji => throw _privateConstructorUsedError;

  /// The type of this entry
  String get type => throw _privateConstructorUsedError;

  /// the numeric value of thsi entry
  int? get value => throw _privateConstructorUsedError;

  /// The display value of this entry
  String? get displayValue => throw _privateConstructorUsedError;

  /// Serializes this KanjiMetaBankV3Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KanjiMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanjiMetaBankV3EntryCopyWith<KanjiMetaBankV3Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanjiMetaBankV3EntryCopyWith<$Res> {
  factory $KanjiMetaBankV3EntryCopyWith(KanjiMetaBankV3Entry value,
          $Res Function(KanjiMetaBankV3Entry) then) =
      _$KanjiMetaBankV3EntryCopyWithImpl<$Res, KanjiMetaBankV3Entry>;
  @useResult
  $Res call({String kanji, String type, int? value, String? displayValue});
}

/// @nodoc
class _$KanjiMetaBankV3EntryCopyWithImpl<$Res,
        $Val extends KanjiMetaBankV3Entry>
    implements $KanjiMetaBankV3EntryCopyWith<$Res> {
  _$KanjiMetaBankV3EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KanjiMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kanji = null,
    Object? type = null,
    Object? value = freezed,
    Object? displayValue = freezed,
  }) {
    return _then(_value.copyWith(
      kanji: null == kanji
          ? _value.kanji
          : kanji // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      displayValue: freezed == displayValue
          ? _value.displayValue
          : displayValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KanjiMetaBankV3EntryImplCopyWith<$Res>
    implements $KanjiMetaBankV3EntryCopyWith<$Res> {
  factory _$$KanjiMetaBankV3EntryImplCopyWith(_$KanjiMetaBankV3EntryImpl value,
          $Res Function(_$KanjiMetaBankV3EntryImpl) then) =
      __$$KanjiMetaBankV3EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String kanji, String type, int? value, String? displayValue});
}

/// @nodoc
class __$$KanjiMetaBankV3EntryImplCopyWithImpl<$Res>
    extends _$KanjiMetaBankV3EntryCopyWithImpl<$Res, _$KanjiMetaBankV3EntryImpl>
    implements _$$KanjiMetaBankV3EntryImplCopyWith<$Res> {
  __$$KanjiMetaBankV3EntryImplCopyWithImpl(_$KanjiMetaBankV3EntryImpl _value,
      $Res Function(_$KanjiMetaBankV3EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of KanjiMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kanji = null,
    Object? type = null,
    Object? value = freezed,
    Object? displayValue = freezed,
  }) {
    return _then(_$KanjiMetaBankV3EntryImpl(
      kanji: null == kanji
          ? _value.kanji
          : kanji // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      displayValue: freezed == displayValue
          ? _value.displayValue
          : displayValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KanjiMetaBankV3EntryImpl implements _KanjiMetaBankV3Entry {
  const _$KanjiMetaBankV3EntryImpl(
      {required this.kanji, required this.type, this.value, this.displayValue});

  factory _$KanjiMetaBankV3EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanjiMetaBankV3EntryImplFromJson(json);

  /// The kanji of this entry
  @override
  final String kanji;

  /// The type of this entry
  @override
  final String type;

  /// the numeric value of thsi entry
  @override
  final int? value;

  /// The display value of this entry
  @override
  final String? displayValue;

  @override
  String toString() {
    return 'KanjiMetaBankV3Entry(kanji: $kanji, type: $type, value: $value, displayValue: $displayValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanjiMetaBankV3EntryImpl &&
            (identical(other.kanji, kanji) || other.kanji == kanji) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.displayValue, displayValue) ||
                other.displayValue == displayValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, kanji, type, value, displayValue);

  /// Create a copy of KanjiMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanjiMetaBankV3EntryImplCopyWith<_$KanjiMetaBankV3EntryImpl>
      get copyWith =>
          __$$KanjiMetaBankV3EntryImplCopyWithImpl<_$KanjiMetaBankV3EntryImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanjiMetaBankV3EntryImplToJson(
      this,
    );
  }
}

abstract class _KanjiMetaBankV3Entry implements KanjiMetaBankV3Entry {
  const factory _KanjiMetaBankV3Entry(
      {required final String kanji,
      required final String type,
      final int? value,
      final String? displayValue}) = _$KanjiMetaBankV3EntryImpl;

  factory _KanjiMetaBankV3Entry.fromJson(Map<String, dynamic> json) =
      _$KanjiMetaBankV3EntryImpl.fromJson;

  /// The kanji of this entry
  @override
  String get kanji;

  /// The type of this entry
  @override
  String get type;

  /// the numeric value of thsi entry
  @override
  int? get value;

  /// The display value of this entry
  @override
  String? get displayValue;

  /// Create a copy of KanjiMetaBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanjiMetaBankV3EntryImplCopyWith<_$KanjiMetaBankV3EntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
