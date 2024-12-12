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

KanjiMetaBankEntry _$KanjiMetaBankEntryFromJson(Map<String, dynamic> json) {
  return _KanjiMetaBankEntry.fromJson(json);
}

/// @nodoc
mixin _$KanjiMetaBankEntry {
  /// The term of this entry
  String get term => throw _privateConstructorUsedError;

  /// The category of this entry
  String get category => throw _privateConstructorUsedError;

  /// the numeric value of thsi entry
  int? get value => throw _privateConstructorUsedError;

  /// The display value of this entry
  String? get displayValue => throw _privateConstructorUsedError;

  /// Serializes this KanjiMetaBankEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KanjiMetaBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanjiMetaBankEntryCopyWith<KanjiMetaBankEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanjiMetaBankEntryCopyWith<$Res> {
  factory $KanjiMetaBankEntryCopyWith(
          KanjiMetaBankEntry value, $Res Function(KanjiMetaBankEntry) then) =
      _$KanjiMetaBankEntryCopyWithImpl<$Res, KanjiMetaBankEntry>;
  @useResult
  $Res call({String term, String category, int? value, String? displayValue});
}

/// @nodoc
class _$KanjiMetaBankEntryCopyWithImpl<$Res, $Val extends KanjiMetaBankEntry>
    implements $KanjiMetaBankEntryCopyWith<$Res> {
  _$KanjiMetaBankEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KanjiMetaBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? category = null,
    Object? value = freezed,
    Object? displayValue = freezed,
  }) {
    return _then(_value.copyWith(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
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
abstract class _$$KanjiMetaBankEntryImplCopyWith<$Res>
    implements $KanjiMetaBankEntryCopyWith<$Res> {
  factory _$$KanjiMetaBankEntryImplCopyWith(_$KanjiMetaBankEntryImpl value,
          $Res Function(_$KanjiMetaBankEntryImpl) then) =
      __$$KanjiMetaBankEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String term, String category, int? value, String? displayValue});
}

/// @nodoc
class __$$KanjiMetaBankEntryImplCopyWithImpl<$Res>
    extends _$KanjiMetaBankEntryCopyWithImpl<$Res, _$KanjiMetaBankEntryImpl>
    implements _$$KanjiMetaBankEntryImplCopyWith<$Res> {
  __$$KanjiMetaBankEntryImplCopyWithImpl(_$KanjiMetaBankEntryImpl _value,
      $Res Function(_$KanjiMetaBankEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of KanjiMetaBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? category = null,
    Object? value = freezed,
    Object? displayValue = freezed,
  }) {
    return _then(_$KanjiMetaBankEntryImpl(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
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
class _$KanjiMetaBankEntryImpl implements _KanjiMetaBankEntry {
  const _$KanjiMetaBankEntryImpl(
      {required this.term,
      required this.category,
      this.value,
      this.displayValue});

  factory _$KanjiMetaBankEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanjiMetaBankEntryImplFromJson(json);

  /// The term of this entry
  @override
  final String term;

  /// The category of this entry
  @override
  final String category;

  /// the numeric value of thsi entry
  @override
  final int? value;

  /// The display value of this entry
  @override
  final String? displayValue;

  @override
  String toString() {
    return 'KanjiMetaBankEntry(term: $term, category: $category, value: $value, displayValue: $displayValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanjiMetaBankEntryImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.displayValue, displayValue) ||
                other.displayValue == displayValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, term, category, value, displayValue);

  /// Create a copy of KanjiMetaBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanjiMetaBankEntryImplCopyWith<_$KanjiMetaBankEntryImpl> get copyWith =>
      __$$KanjiMetaBankEntryImplCopyWithImpl<_$KanjiMetaBankEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanjiMetaBankEntryImplToJson(
      this,
    );
  }
}

abstract class _KanjiMetaBankEntry implements KanjiMetaBankEntry {
  const factory _KanjiMetaBankEntry(
      {required final String term,
      required final String category,
      final int? value,
      final String? displayValue}) = _$KanjiMetaBankEntryImpl;

  factory _KanjiMetaBankEntry.fromJson(Map<String, dynamic> json) =
      _$KanjiMetaBankEntryImpl.fromJson;

  /// The term of this entry
  @override
  String get term;

  /// The category of this entry
  @override
  String get category;

  /// the numeric value of thsi entry
  @override
  int? get value;

  /// The display value of this entry
  @override
  String? get displayValue;

  /// Create a copy of KanjiMetaBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanjiMetaBankEntryImplCopyWith<_$KanjiMetaBankEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
