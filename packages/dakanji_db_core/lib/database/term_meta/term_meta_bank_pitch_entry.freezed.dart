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

 int get position; set position(int value); List<TagBankV3Entry> get tags; set tags(List<TagBankV3Entry> value); int? get nasal; set nasal(int? value); int? get devoice; set devoice(int? value);
/// Create a copy of TermMetaBankV3PitchEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermMetaBankV3PitchEntryCopyWith<TermMetaBankV3PitchEntry> get copyWith => _$TermMetaBankV3PitchEntryCopyWithImpl<TermMetaBankV3PitchEntry>(this as TermMetaBankV3PitchEntry, _$identity);



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
 int position, List<TagBankV3Entry> tags, int? nasal, int? devoice
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
  return _then(TermMetaBankV3PitchEntry(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,nasal: freezed == nasal ? _self.nasal : nasal // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
