// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stat_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatEntry {

 String get statName; String? get displayName; double get value; String? get displayValue;
/// Create a copy of StatEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatEntryCopyWith<StatEntry> get copyWith => _$StatEntryCopyWithImpl<StatEntry>(this as StatEntry, _$identity);

  /// Serializes this StatEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatEntry&&(identical(other.statName, statName) || other.statName == statName)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statName,displayName,value,displayValue);

@override
String toString() {
  return 'StatEntry(statName: $statName, displayName: $displayName, value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class $StatEntryCopyWith<$Res>  {
  factory $StatEntryCopyWith(StatEntry value, $Res Function(StatEntry) _then) = _$StatEntryCopyWithImpl;
@useResult
$Res call({
 String statName, String? displayName, double value, String? displayValue
});




}
/// @nodoc
class _$StatEntryCopyWithImpl<$Res>
    implements $StatEntryCopyWith<$Res> {
  _$StatEntryCopyWithImpl(this._self, this._then);

  final StatEntry _self;
  final $Res Function(StatEntry) _then;

/// Create a copy of StatEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statName = null,Object? displayName = freezed,Object? value = null,Object? displayValue = freezed,}) {
  return _then(_self.copyWith(
statName: null == statName ? _self.statName : statName // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatEntry].
extension StatEntryPatterns on StatEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatEntry value)  $default,){
final _that = this;
switch (_that) {
case _StatEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatEntry value)?  $default,){
final _that = this;
switch (_that) {
case _StatEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String statName,  String? displayName,  double value,  String? displayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatEntry() when $default != null:
return $default(_that.statName,_that.displayName,_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String statName,  String? displayName,  double value,  String? displayValue)  $default,) {final _that = this;
switch (_that) {
case _StatEntry():
return $default(_that.statName,_that.displayName,_that.value,_that.displayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String statName,  String? displayName,  double value,  String? displayValue)?  $default,) {final _that = this;
switch (_that) {
case _StatEntry() when $default != null:
return $default(_that.statName,_that.displayName,_that.value,_that.displayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatEntry implements StatEntry {
  const _StatEntry({required this.statName, this.displayName, required this.value, this.displayValue});
  factory _StatEntry.fromJson(Map<String, dynamic> json) => _$StatEntryFromJson(json);

@override final  String statName;
@override final  String? displayName;
@override final  double value;
@override final  String? displayValue;

/// Create a copy of StatEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatEntryCopyWith<_StatEntry> get copyWith => __$StatEntryCopyWithImpl<_StatEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatEntry&&(identical(other.statName, statName) || other.statName == statName)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.value, value) || other.value == value)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statName,displayName,value,displayValue);

@override
String toString() {
  return 'StatEntry(statName: $statName, displayName: $displayName, value: $value, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class _$StatEntryCopyWith<$Res> implements $StatEntryCopyWith<$Res> {
  factory _$StatEntryCopyWith(_StatEntry value, $Res Function(_StatEntry) _then) = __$StatEntryCopyWithImpl;
@override @useResult
$Res call({
 String statName, String? displayName, double value, String? displayValue
});




}
/// @nodoc
class __$StatEntryCopyWithImpl<$Res>
    implements _$StatEntryCopyWith<$Res> {
  __$StatEntryCopyWithImpl(this._self, this._then);

  final _StatEntry _self;
  final $Res Function(_StatEntry) _then;

/// Create a copy of StatEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statName = null,Object? displayName = freezed,Object? value = null,Object? displayValue = freezed,}) {
  return _then(_StatEntry(
statName: null == statName ? _self.statName : statName // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
