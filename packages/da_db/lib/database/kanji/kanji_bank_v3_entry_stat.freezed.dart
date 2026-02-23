// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_bank_v3_entry_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KanjiBankV3EntryStat {

/// The value of this stat
 String get value;/// The tag associated with this stat
 TagBankV3Entry get tag;
/// Create a copy of KanjiBankV3EntryStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanjiBankV3EntryStatCopyWith<KanjiBankV3EntryStat> get copyWith => _$KanjiBankV3EntryStatCopyWithImpl<KanjiBankV3EntryStat>(this as KanjiBankV3EntryStat, _$identity);

  /// Serializes this KanjiBankV3EntryStat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanjiBankV3EntryStat&&(identical(other.value, value) || other.value == value)&&(identical(other.tag, tag) || other.tag == tag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,tag);

@override
String toString() {
  return 'KanjiBankV3EntryStat(value: $value, tag: $tag)';
}


}

/// @nodoc
abstract mixin class $KanjiBankV3EntryStatCopyWith<$Res>  {
  factory $KanjiBankV3EntryStatCopyWith(KanjiBankV3EntryStat value, $Res Function(KanjiBankV3EntryStat) _then) = _$KanjiBankV3EntryStatCopyWithImpl;
@useResult
$Res call({
 String value, TagBankV3Entry tag
});


$TagBankV3EntryCopyWith<$Res> get tag;

}
/// @nodoc
class _$KanjiBankV3EntryStatCopyWithImpl<$Res>
    implements $KanjiBankV3EntryStatCopyWith<$Res> {
  _$KanjiBankV3EntryStatCopyWithImpl(this._self, this._then);

  final KanjiBankV3EntryStat _self;
  final $Res Function(KanjiBankV3EntryStat) _then;

/// Create a copy of KanjiBankV3EntryStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? tag = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as TagBankV3Entry,
  ));
}
/// Create a copy of KanjiBankV3EntryStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagBankV3EntryCopyWith<$Res> get tag {
  
  return $TagBankV3EntryCopyWith<$Res>(_self.tag, (value) {
    return _then(_self.copyWith(tag: value));
  });
}
}


/// Adds pattern-matching-related methods to [KanjiBankV3EntryStat].
extension KanjiBankV3EntryStatPatterns on KanjiBankV3EntryStat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanjiBankV3EntryStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanjiBankV3EntryStat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanjiBankV3EntryStat value)  $default,){
final _that = this;
switch (_that) {
case _KanjiBankV3EntryStat():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanjiBankV3EntryStat value)?  $default,){
final _that = this;
switch (_that) {
case _KanjiBankV3EntryStat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  TagBankV3Entry tag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanjiBankV3EntryStat() when $default != null:
return $default(_that.value,_that.tag);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  TagBankV3Entry tag)  $default,) {final _that = this;
switch (_that) {
case _KanjiBankV3EntryStat():
return $default(_that.value,_that.tag);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  TagBankV3Entry tag)?  $default,) {final _that = this;
switch (_that) {
case _KanjiBankV3EntryStat() when $default != null:
return $default(_that.value,_that.tag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KanjiBankV3EntryStat implements KanjiBankV3EntryStat {
  const _KanjiBankV3EntryStat({required this.value, required this.tag});
  factory _KanjiBankV3EntryStat.fromJson(Map<String, dynamic> json) => _$KanjiBankV3EntryStatFromJson(json);

/// The value of this stat
@override final  String value;
/// The tag associated with this stat
@override final  TagBankV3Entry tag;

/// Create a copy of KanjiBankV3EntryStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanjiBankV3EntryStatCopyWith<_KanjiBankV3EntryStat> get copyWith => __$KanjiBankV3EntryStatCopyWithImpl<_KanjiBankV3EntryStat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KanjiBankV3EntryStatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanjiBankV3EntryStat&&(identical(other.value, value) || other.value == value)&&(identical(other.tag, tag) || other.tag == tag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,tag);

@override
String toString() {
  return 'KanjiBankV3EntryStat(value: $value, tag: $tag)';
}


}

/// @nodoc
abstract mixin class _$KanjiBankV3EntryStatCopyWith<$Res> implements $KanjiBankV3EntryStatCopyWith<$Res> {
  factory _$KanjiBankV3EntryStatCopyWith(_KanjiBankV3EntryStat value, $Res Function(_KanjiBankV3EntryStat) _then) = __$KanjiBankV3EntryStatCopyWithImpl;
@override @useResult
$Res call({
 String value, TagBankV3Entry tag
});


@override $TagBankV3EntryCopyWith<$Res> get tag;

}
/// @nodoc
class __$KanjiBankV3EntryStatCopyWithImpl<$Res>
    implements _$KanjiBankV3EntryStatCopyWith<$Res> {
  __$KanjiBankV3EntryStatCopyWithImpl(this._self, this._then);

  final _KanjiBankV3EntryStat _self;
  final $Res Function(_KanjiBankV3EntryStat) _then;

/// Create a copy of KanjiBankV3EntryStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? tag = null,}) {
  return _then(_KanjiBankV3EntryStat(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as TagBankV3Entry,
  ));
}

/// Create a copy of KanjiBankV3EntryStat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagBankV3EntryCopyWith<$Res> get tag {
  
  return $TagBankV3EntryCopyWith<$Res>(_self.tag, (value) {
    return _then(_self.copyWith(tag: value));
  });
}
}

// dart format on
