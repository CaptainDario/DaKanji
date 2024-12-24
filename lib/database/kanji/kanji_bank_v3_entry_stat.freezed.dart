// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_bank_v3_entry_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KanjiBankV3EntryStat _$KanjiBankV3EntryStatFromJson(Map<String, dynamic> json) {
  return _KanjiBankV3EntryStat.fromJson(json);
}

/// @nodoc
mixin _$KanjiBankV3EntryStat {
  /// The name of this stat
  String get name => throw _privateConstructorUsedError;

  /// The value of this stat
  String get value => throw _privateConstructorUsedError;

  /// Serializes this KanjiBankV3EntryStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KanjiBankV3EntryStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanjiBankV3EntryStatCopyWith<KanjiBankV3EntryStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanjiBankV3EntryStatCopyWith<$Res> {
  factory $KanjiBankV3EntryStatCopyWith(KanjiBankV3EntryStat value,
          $Res Function(KanjiBankV3EntryStat) then) =
      _$KanjiBankV3EntryStatCopyWithImpl<$Res, KanjiBankV3EntryStat>;
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class _$KanjiBankV3EntryStatCopyWithImpl<$Res,
        $Val extends KanjiBankV3EntryStat>
    implements $KanjiBankV3EntryStatCopyWith<$Res> {
  _$KanjiBankV3EntryStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KanjiBankV3EntryStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KanjiBankV3EntryStatImplCopyWith<$Res>
    implements $KanjiBankV3EntryStatCopyWith<$Res> {
  factory _$$KanjiBankV3EntryStatImplCopyWith(_$KanjiBankV3EntryStatImpl value,
          $Res Function(_$KanjiBankV3EntryStatImpl) then) =
      __$$KanjiBankV3EntryStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class __$$KanjiBankV3EntryStatImplCopyWithImpl<$Res>
    extends _$KanjiBankV3EntryStatCopyWithImpl<$Res, _$KanjiBankV3EntryStatImpl>
    implements _$$KanjiBankV3EntryStatImplCopyWith<$Res> {
  __$$KanjiBankV3EntryStatImplCopyWithImpl(_$KanjiBankV3EntryStatImpl _value,
      $Res Function(_$KanjiBankV3EntryStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of KanjiBankV3EntryStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$KanjiBankV3EntryStatImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KanjiBankV3EntryStatImpl implements _KanjiBankV3EntryStat {
  const _$KanjiBankV3EntryStatImpl({required this.name, required this.value});

  factory _$KanjiBankV3EntryStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanjiBankV3EntryStatImplFromJson(json);

  /// The name of this stat
  @override
  final String name;

  /// The value of this stat
  @override
  final String value;

  @override
  String toString() {
    return 'KanjiBankV3EntryStat(name: $name, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanjiBankV3EntryStatImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  /// Create a copy of KanjiBankV3EntryStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanjiBankV3EntryStatImplCopyWith<_$KanjiBankV3EntryStatImpl>
      get copyWith =>
          __$$KanjiBankV3EntryStatImplCopyWithImpl<_$KanjiBankV3EntryStatImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanjiBankV3EntryStatImplToJson(
      this,
    );
  }
}

abstract class _KanjiBankV3EntryStat implements KanjiBankV3EntryStat {
  const factory _KanjiBankV3EntryStat(
      {required final String name,
      required final String value}) = _$KanjiBankV3EntryStatImpl;

  factory _KanjiBankV3EntryStat.fromJson(Map<String, dynamic> json) =
      _$KanjiBankV3EntryStatImpl.fromJson;

  /// The name of this stat
  @override
  String get name;

  /// The value of this stat
  @override
  String get value;

  /// Create a copy of KanjiBankV3EntryStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanjiBankV3EntryStatImplCopyWith<_$KanjiBankV3EntryStatImpl>
      get copyWith => throw _privateConstructorUsedError;
}
