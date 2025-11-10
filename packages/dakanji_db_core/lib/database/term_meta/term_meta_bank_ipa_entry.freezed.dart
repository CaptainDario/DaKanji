// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_ipa_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TermMetaBankV3IpaEntry {

 String get ipa; set ipa(String value); List<TagBankV3Entry> get tags; set tags(List<TagBankV3Entry> value);
/// Create a copy of TermMetaBankV3IpaEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermMetaBankV3IpaEntryCopyWith<TermMetaBankV3IpaEntry> get copyWith => _$TermMetaBankV3IpaEntryCopyWithImpl<TermMetaBankV3IpaEntry>(this as TermMetaBankV3IpaEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermMetaBankV3IpaEntry&&(identical(other.ipa, ipa) || other.ipa == ipa)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ipa,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TermMetaBankV3IpaEntry(ipa: $ipa, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TermMetaBankV3IpaEntryCopyWith<$Res>  {
  factory $TermMetaBankV3IpaEntryCopyWith(TermMetaBankV3IpaEntry value, $Res Function(TermMetaBankV3IpaEntry) _then) = _$TermMetaBankV3IpaEntryCopyWithImpl;
@useResult
$Res call({
 String ipa, List<TagBankV3Entry> tags
});




}
/// @nodoc
class _$TermMetaBankV3IpaEntryCopyWithImpl<$Res>
    implements $TermMetaBankV3IpaEntryCopyWith<$Res> {
  _$TermMetaBankV3IpaEntryCopyWithImpl(this._self, this._then);

  final TermMetaBankV3IpaEntry _self;
  final $Res Function(TermMetaBankV3IpaEntry) _then;

/// Create a copy of TermMetaBankV3IpaEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ipa = null,Object? tags = null,}) {
  return _then(TermMetaBankV3IpaEntry(
ipa: null == ipa ? _self.ipa : ipa // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,
  ));
}

}


/// Adds pattern-matching-related methods to [TermMetaBankV3IpaEntry].
extension TermMetaBankV3IpaEntryPatterns on TermMetaBankV3IpaEntry {
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
