// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_entry_translation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExampleEntryTranslation _$ExampleEntryTranslationFromJson(
    Map<String, dynamic> json) {
  return _ExampleEntryTranslation.fromJson(json);
}

/// @nodoc
mixin _$ExampleEntryTranslation {
  /// The example's translation
  String get translation => throw _privateConstructorUsedError;

  /// Language code of the language of this translation
  String get languageCode => throw _privateConstructorUsedError;

  /// Serializes this ExampleEntryTranslation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExampleEntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExampleEntryTranslationCopyWith<ExampleEntryTranslation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleEntryTranslationCopyWith<$Res> {
  factory $ExampleEntryTranslationCopyWith(ExampleEntryTranslation value,
          $Res Function(ExampleEntryTranslation) then) =
      _$ExampleEntryTranslationCopyWithImpl<$Res, ExampleEntryTranslation>;
  @useResult
  $Res call({String translation, String languageCode});
}

/// @nodoc
class _$ExampleEntryTranslationCopyWithImpl<$Res,
        $Val extends ExampleEntryTranslation>
    implements $ExampleEntryTranslationCopyWith<$Res> {
  _$ExampleEntryTranslationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExampleEntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translation = null,
    Object? languageCode = null,
  }) {
    return _then(_value.copyWith(
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExampleEntryTranslationImplCopyWith<$Res>
    implements $ExampleEntryTranslationCopyWith<$Res> {
  factory _$$ExampleEntryTranslationImplCopyWith(
          _$ExampleEntryTranslationImpl value,
          $Res Function(_$ExampleEntryTranslationImpl) then) =
      __$$ExampleEntryTranslationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String translation, String languageCode});
}

/// @nodoc
class __$$ExampleEntryTranslationImplCopyWithImpl<$Res>
    extends _$ExampleEntryTranslationCopyWithImpl<$Res,
        _$ExampleEntryTranslationImpl>
    implements _$$ExampleEntryTranslationImplCopyWith<$Res> {
  __$$ExampleEntryTranslationImplCopyWithImpl(
      _$ExampleEntryTranslationImpl _value,
      $Res Function(_$ExampleEntryTranslationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExampleEntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translation = null,
    Object? languageCode = null,
  }) {
    return _then(_$ExampleEntryTranslationImpl(
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExampleEntryTranslationImpl implements _ExampleEntryTranslation {
  const _$ExampleEntryTranslationImpl(
      {required this.translation, required this.languageCode});

  factory _$ExampleEntryTranslationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExampleEntryTranslationImplFromJson(json);

  /// The example's translation
  @override
  final String translation;

  /// Language code of the language of this translation
  @override
  final String languageCode;

  @override
  String toString() {
    return 'ExampleEntryTranslation(translation: $translation, languageCode: $languageCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleEntryTranslationImpl &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, translation, languageCode);

  /// Create a copy of ExampleEntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleEntryTranslationImplCopyWith<_$ExampleEntryTranslationImpl>
      get copyWith => __$$ExampleEntryTranslationImplCopyWithImpl<
          _$ExampleEntryTranslationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExampleEntryTranslationImplToJson(
      this,
    );
  }
}

abstract class _ExampleEntryTranslation implements ExampleEntryTranslation {
  const factory _ExampleEntryTranslation(
      {required final String translation,
      required final String languageCode}) = _$ExampleEntryTranslationImpl;

  factory _ExampleEntryTranslation.fromJson(Map<String, dynamic> json) =
      _$ExampleEntryTranslationImpl.fromJson;

  /// The example's translation
  @override
  String get translation;

  /// Language code of the language of this translation
  @override
  String get languageCode;

  /// Create a copy of ExampleEntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExampleEntryTranslationImplCopyWith<_$ExampleEntryTranslationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
