// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_pitch_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TermMetaBankV3PitchEntry {

/// the position of this pitch entry
 int get position;/// all tags of this pitch entry
 List<String> get tags;/// nasal data of this pitch entry
 int? get nasal;/// devoice data of this pitch entry
 int? get devoice;
/// Create a copy of TermMetaBankV3PitchEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermMetaBankV3PitchEntryCopyWith<TermMetaBankV3PitchEntry> get copyWith => _$TermMetaBankV3PitchEntryCopyWithImpl<TermMetaBankV3PitchEntry>(this as TermMetaBankV3PitchEntry, _$identity);

  /// Serializes this TermMetaBankV3PitchEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermMetaBankV3PitchEntry&&(identical(other.position, position) || other.position == position)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.nasal, nasal) || other.nasal == nasal)&&(identical(other.devoice, devoice) || other.devoice == devoice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,const DeepCollectionEquality().hash(tags),nasal,devoice);

@override
String toString() {
  return 'TermMetaBankV3PitchEntry(position: $position, tags: $tags, nasal: $nasal, devoice: $devoice)';
}


}

/// @nodoc
abstract mixin class $TermMetaBankV3PitchEntryCopyWith<$Res>  {
  factory $TermMetaBankV3PitchEntryCopyWith(TermMetaBankV3PitchEntry value, $Res Function(TermMetaBankV3PitchEntry) _then) = _$TermMetaBankV3PitchEntryCopyWithImpl;
@useResult
$Res call({
 int position, List<String> tags, int? nasal, int? devoice
});




}
/// @nodoc
class _$TermMetaBankV3PitchEntryCopyWithImpl<$Res>
    implements $TermMetaBankV3PitchEntryCopyWith<$Res> {
  _$TermMetaBankV3PitchEntryCopyWithImpl(this._self, this._then);

  final TermMetaBankV3PitchEntry _self;
  final $Res Function(TermMetaBankV3PitchEntry) _then;

/// Create a copy of TermMetaBankV3PitchEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? tags = null,Object? nasal = freezed,Object? devoice = freezed,}) {
  return _then(_self.copyWith(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,nasal: freezed == nasal ? _self.nasal : nasal // ignore: cast_nullable_to_non_nullable
as int?,devoice: freezed == devoice ? _self.devoice : devoice // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TermMetaBankV3PitchEntry].
extension TermMetaBankV3PitchEntryPatterns on TermMetaBankV3PitchEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TermMetaBankV3PitchEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TermMetaBankV3PitchEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TermMetaBankV3PitchEntry value)  $default,){
final _that = this;
switch (_that) {
case _TermMetaBankV3PitchEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TermMetaBankV3PitchEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TermMetaBankV3PitchEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int position,  List<String> tags,  int? nasal,  int? devoice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TermMetaBankV3PitchEntry() when $default != null:
return $default(_that.position,_that.tags,_that.nasal,_that.devoice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int position,  List<String> tags,  int? nasal,  int? devoice)  $default,) {final _that = this;
switch (_that) {
case _TermMetaBankV3PitchEntry():
return $default(_that.position,_that.tags,_that.nasal,_that.devoice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int position,  List<String> tags,  int? nasal,  int? devoice)?  $default,) {final _that = this;
switch (_that) {
case _TermMetaBankV3PitchEntry() when $default != null:
return $default(_that.position,_that.tags,_that.nasal,_that.devoice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TermMetaBankV3PitchEntry implements TermMetaBankV3PitchEntry {
  const _TermMetaBankV3PitchEntry({required this.position, required this.tags, this.nasal, this.devoice});
  factory _TermMetaBankV3PitchEntry.fromJson(Map<String, dynamic> json) => _$TermMetaBankV3PitchEntryFromJson(json);

/// the position of this pitch entry
@override final  int position;
/// all tags of this pitch entry
@override final  List<String> tags;
/// nasal data of this pitch entry
@override final  int? nasal;
/// devoice data of this pitch entry
@override final  int? devoice;

/// Create a copy of TermMetaBankV3PitchEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermMetaBankV3PitchEntryCopyWith<_TermMetaBankV3PitchEntry> get copyWith => __$TermMetaBankV3PitchEntryCopyWithImpl<_TermMetaBankV3PitchEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermMetaBankV3PitchEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermMetaBankV3PitchEntry&&(identical(other.position, position) || other.position == position)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.nasal, nasal) || other.nasal == nasal)&&(identical(other.devoice, devoice) || other.devoice == devoice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,const DeepCollectionEquality().hash(tags),nasal,devoice);

@override
String toString() {
  return 'TermMetaBankV3PitchEntry(position: $position, tags: $tags, nasal: $nasal, devoice: $devoice)';
}


}

/// @nodoc
abstract mixin class _$TermMetaBankV3PitchEntryCopyWith<$Res> implements $TermMetaBankV3PitchEntryCopyWith<$Res> {
  factory _$TermMetaBankV3PitchEntryCopyWith(_TermMetaBankV3PitchEntry value, $Res Function(_TermMetaBankV3PitchEntry) _then) = __$TermMetaBankV3PitchEntryCopyWithImpl;
@override @useResult
$Res call({
 int position, List<String> tags, int? nasal, int? devoice
});




}
/// @nodoc
class __$TermMetaBankV3PitchEntryCopyWithImpl<$Res>
    implements _$TermMetaBankV3PitchEntryCopyWith<$Res> {
  __$TermMetaBankV3PitchEntryCopyWithImpl(this._self, this._then);

  final _TermMetaBankV3PitchEntry _self;
  final $Res Function(_TermMetaBankV3PitchEntry) _then;

/// Create a copy of TermMetaBankV3PitchEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? tags = null,Object? nasal = freezed,Object? devoice = freezed,}) {
  return _then(_TermMetaBankV3PitchEntry(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,nasal: freezed == nasal ? _self.nasal : nasal // ignore: cast_nullable_to_non_nullable
as int?,devoice: freezed == devoice ? _self.devoice : devoice // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
