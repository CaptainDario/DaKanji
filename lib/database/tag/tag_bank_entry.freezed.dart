// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_bank_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TagBankEntry _$TagBankEntryFromJson(Map<String, dynamic> json) {
  return _TagBankEntry.fromJson(json);
}

/// @nodoc
mixin _$TagBankEntry {
  /// Tag name.
  String get name => throw _privateConstructorUsedError;

  /// Categories for the tag.
  String get categories => throw _privateConstructorUsedError;

  /// Sorting order for the tag.
  int get sortingOrder => throw _privateConstructorUsedError;

  /// Notes for the tag.
  String get notes => throw _privateConstructorUsedError;

  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  int get score => throw _privateConstructorUsedError;

  /// Serializes this TagBankEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagBankEntryCopyWith<TagBankEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagBankEntryCopyWith<$Res> {
  factory $TagBankEntryCopyWith(
          TagBankEntry value, $Res Function(TagBankEntry) then) =
      _$TagBankEntryCopyWithImpl<$Res, TagBankEntry>;
  @useResult
  $Res call(
      {String name,
      String categories,
      int sortingOrder,
      String notes,
      int score});
}

/// @nodoc
class _$TagBankEntryCopyWithImpl<$Res, $Val extends TagBankEntry>
    implements $TagBankEntryCopyWith<$Res> {
  _$TagBankEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? categories = null,
    Object? sortingOrder = null,
    Object? notes = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as String,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagBankEntryImplCopyWith<$Res>
    implements $TagBankEntryCopyWith<$Res> {
  factory _$$TagBankEntryImplCopyWith(
          _$TagBankEntryImpl value, $Res Function(_$TagBankEntryImpl) then) =
      __$$TagBankEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String categories,
      int sortingOrder,
      String notes,
      int score});
}

/// @nodoc
class __$$TagBankEntryImplCopyWithImpl<$Res>
    extends _$TagBankEntryCopyWithImpl<$Res, _$TagBankEntryImpl>
    implements _$$TagBankEntryImplCopyWith<$Res> {
  __$$TagBankEntryImplCopyWithImpl(
      _$TagBankEntryImpl _value, $Res Function(_$TagBankEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? categories = null,
    Object? sortingOrder = null,
    Object? notes = null,
    Object? score = null,
  }) {
    return _then(_$TagBankEntryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as String,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagBankEntryImpl implements _TagBankEntry {
  const _$TagBankEntryImpl(
      {required this.name,
      required this.categories,
      required this.sortingOrder,
      required this.notes,
      required this.score});

  factory _$TagBankEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagBankEntryImplFromJson(json);

  /// Tag name.
  @override
  final String name;

  /// Categories for the tag.
  @override
  final String categories;

  /// Sorting order for the tag.
  @override
  final int sortingOrder;

  /// Notes for the tag.
  @override
  final String notes;

  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  @override
  final int score;

  @override
  String toString() {
    return 'TagBankEntry(name: $name, categories: $categories, sortingOrder: $sortingOrder, notes: $notes, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagBankEntryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categories, categories) ||
                other.categories == categories) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, categories, sortingOrder, notes, score);

  /// Create a copy of TagBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagBankEntryImplCopyWith<_$TagBankEntryImpl> get copyWith =>
      __$$TagBankEntryImplCopyWithImpl<_$TagBankEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagBankEntryImplToJson(
      this,
    );
  }
}

abstract class _TagBankEntry implements TagBankEntry {
  const factory _TagBankEntry(
      {required final String name,
      required final String categories,
      required final int sortingOrder,
      required final String notes,
      required final int score}) = _$TagBankEntryImpl;

  factory _TagBankEntry.fromJson(Map<String, dynamic> json) =
      _$TagBankEntryImpl.fromJson;

  /// Tag name.
  @override
  String get name;

  /// Categories for the tag.
  @override
  String get categories;

  /// Sorting order for the tag.
  @override
  int get sortingOrder;

  /// Notes for the tag.
  @override
  String get notes;

  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  @override
  int get score;

  /// Create a copy of TagBankEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagBankEntryImplCopyWith<_$TagBankEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
