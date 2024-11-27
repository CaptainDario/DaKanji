// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_bank_entry_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KanjiBankEntryStat _$KanjiBankEntryStatFromJson(Map<String, dynamic> json) {
  return _KanjiBankEntryStat.fromJson(json);
}

/// @nodoc
mixin _$KanjiBankEntryStat {
  /// The name of this stat
  String get name => throw _privateConstructorUsedError;

  /// The value of this stat
  String get value => throw _privateConstructorUsedError;

  /// Serializes this KanjiBankEntryStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KanjiBankEntryStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KanjiBankEntryStatCopyWith<KanjiBankEntryStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanjiBankEntryStatCopyWith<$Res> {
  factory $KanjiBankEntryStatCopyWith(
          KanjiBankEntryStat value, $Res Function(KanjiBankEntryStat) then) =
      _$KanjiBankEntryStatCopyWithImpl<$Res, KanjiBankEntryStat>;
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class _$KanjiBankEntryStatCopyWithImpl<$Res, $Val extends KanjiBankEntryStat>
    implements $KanjiBankEntryStatCopyWith<$Res> {
  _$KanjiBankEntryStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KanjiBankEntryStat
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
abstract class _$$KanjiBankEntryStatImplCopyWith<$Res>
    implements $KanjiBankEntryStatCopyWith<$Res> {
  factory _$$KanjiBankEntryStatImplCopyWith(_$KanjiBankEntryStatImpl value,
          $Res Function(_$KanjiBankEntryStatImpl) then) =
      __$$KanjiBankEntryStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class __$$KanjiBankEntryStatImplCopyWithImpl<$Res>
    extends _$KanjiBankEntryStatCopyWithImpl<$Res, _$KanjiBankEntryStatImpl>
    implements _$$KanjiBankEntryStatImplCopyWith<$Res> {
  __$$KanjiBankEntryStatImplCopyWithImpl(_$KanjiBankEntryStatImpl _value,
      $Res Function(_$KanjiBankEntryStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of KanjiBankEntryStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$KanjiBankEntryStatImpl(
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
class _$KanjiBankEntryStatImpl implements _KanjiBankEntryStat {
  const _$KanjiBankEntryStatImpl({required this.name, required this.value});

  factory _$KanjiBankEntryStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanjiBankEntryStatImplFromJson(json);

  /// The name of this stat
  @override
  final String name;

  /// The value of this stat
  @override
  final String value;

  @override
  String toString() {
    return 'KanjiBankEntryStat(name: $name, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanjiBankEntryStatImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  /// Create a copy of KanjiBankEntryStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KanjiBankEntryStatImplCopyWith<_$KanjiBankEntryStatImpl> get copyWith =>
      __$$KanjiBankEntryStatImplCopyWithImpl<_$KanjiBankEntryStatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanjiBankEntryStatImplToJson(
      this,
    );
  }
}

abstract class _KanjiBankEntryStat implements KanjiBankEntryStat {
  const factory _KanjiBankEntryStat(
      {required final String name,
      required final String value}) = _$KanjiBankEntryStatImpl;

  factory _KanjiBankEntryStat.fromJson(Map<String, dynamic> json) =
      _$KanjiBankEntryStatImpl.fromJson;

  /// The name of this stat
  @override
  String get name;

  /// The value of this stat
  @override
  String get value;

  /// Create a copy of KanjiBankEntryStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KanjiBankEntryStatImplCopyWith<_$KanjiBankEntryStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
