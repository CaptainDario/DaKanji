// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TagBankV3Entry _$TagBankV3EntryFromJson(Map<String, dynamic> json) {
  return _TagBankV3Entry.fromJson(json);
}

/// @nodoc
mixin _$TagBankV3Entry {
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

  /// Serializes this TagBankV3Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagBankV3EntryCopyWith<TagBankV3Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagBankV3EntryCopyWith<$Res> {
  factory $TagBankV3EntryCopyWith(
          TagBankV3Entry value, $Res Function(TagBankV3Entry) then) =
      _$TagBankV3EntryCopyWithImpl<$Res, TagBankV3Entry>;
  @useResult
  $Res call(
      {String name,
      String categories,
      int sortingOrder,
      String notes,
      int score});
}

/// @nodoc
class _$TagBankV3EntryCopyWithImpl<$Res, $Val extends TagBankV3Entry>
    implements $TagBankV3EntryCopyWith<$Res> {
  _$TagBankV3EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagBankV3Entry
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
abstract class _$$TagBankV3EntryImplCopyWith<$Res>
    implements $TagBankV3EntryCopyWith<$Res> {
  factory _$$TagBankV3EntryImplCopyWith(_$TagBankV3EntryImpl value,
          $Res Function(_$TagBankV3EntryImpl) then) =
      __$$TagBankV3EntryImplCopyWithImpl<$Res>;
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
class __$$TagBankV3EntryImplCopyWithImpl<$Res>
    extends _$TagBankV3EntryCopyWithImpl<$Res, _$TagBankV3EntryImpl>
    implements _$$TagBankV3EntryImplCopyWith<$Res> {
  __$$TagBankV3EntryImplCopyWithImpl(
      _$TagBankV3EntryImpl _value, $Res Function(_$TagBankV3EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TagBankV3Entry
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
    return _then(_$TagBankV3EntryImpl(
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
class _$TagBankV3EntryImpl implements _TagBankV3Entry {
  const _$TagBankV3EntryImpl(
      {required this.name,
      required this.categories,
      required this.sortingOrder,
      required this.notes,
      required this.score});

  factory _$TagBankV3EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagBankV3EntryImplFromJson(json);

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
    return 'TagBankV3Entry(name: $name, categories: $categories, sortingOrder: $sortingOrder, notes: $notes, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagBankV3EntryImpl &&
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

  /// Create a copy of TagBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagBankV3EntryImplCopyWith<_$TagBankV3EntryImpl> get copyWith =>
      __$$TagBankV3EntryImplCopyWithImpl<_$TagBankV3EntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagBankV3EntryImplToJson(
      this,
    );
  }
}

abstract class _TagBankV3Entry implements TagBankV3Entry {
  const factory _TagBankV3Entry(
      {required final String name,
      required final String categories,
      required final int sortingOrder,
      required final String notes,
      required final int score}) = _$TagBankV3EntryImpl;

  factory _TagBankV3Entry.fromJson(Map<String, dynamic> json) =
      _$TagBankV3EntryImpl.fromJson;

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

  /// Create a copy of TagBankV3Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagBankV3EntryImplCopyWith<_$TagBankV3EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
