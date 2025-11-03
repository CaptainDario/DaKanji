// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TermBankV3Entry {

 int get termBankV3TableId; int get indexId; String get term; String get reading; List<String> get definitionTags; List<String> get ruleIdentifiers; int get popularity; List<String> get definitions; int get sequenceNumber; List<TagBankV3Entry> get tags;
/// Create a copy of TermBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermBankV3EntryCopyWith<TermBankV3Entry> get copyWith => _$TermBankV3EntryCopyWithImpl<TermBankV3Entry>(this as TermBankV3Entry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermBankV3Entry&&(identical(other.termBankV3TableId, termBankV3TableId) || other.termBankV3TableId == termBankV3TableId)&&(identical(other.indexId, indexId) || other.indexId == indexId)&&(identical(other.term, term) || other.term == term)&&(identical(other.reading, reading) || other.reading == reading)&&const DeepCollectionEquality().equals(other.definitionTags, definitionTags)&&const DeepCollectionEquality().equals(other.ruleIdentifiers, ruleIdentifiers)&&(identical(other.popularity, popularity) || other.popularity == popularity)&&const DeepCollectionEquality().equals(other.definitions, definitions)&&(identical(other.sequenceNumber, sequenceNumber) || other.sequenceNumber == sequenceNumber)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,termBankV3TableId,indexId,term,reading,const DeepCollectionEquality().hash(definitionTags),const DeepCollectionEquality().hash(ruleIdentifiers),popularity,const DeepCollectionEquality().hash(definitions),sequenceNumber,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TermBankV3Entry(termBankV3TableId: $termBankV3TableId, indexId: $indexId, term: $term, reading: $reading, definitionTags: $definitionTags, ruleIdentifiers: $ruleIdentifiers, popularity: $popularity, definitions: $definitions, sequenceNumber: $sequenceNumber, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TermBankV3EntryCopyWith<$Res>  {
  factory $TermBankV3EntryCopyWith(TermBankV3Entry value, $Res Function(TermBankV3Entry) _then) = _$TermBankV3EntryCopyWithImpl;
@useResult
$Res call({
 int termBankV3TableId, int indexId, String term, String reading, List<String> definitionTags, List<String> ruleIdentifiers, int popularity, List<String> definitions, int sequenceNumber, List<TagBankV3Entry> tags
});




}
/// @nodoc
class _$TermBankV3EntryCopyWithImpl<$Res>
    implements $TermBankV3EntryCopyWith<$Res> {
  _$TermBankV3EntryCopyWithImpl(this._self, this._then);

  final TermBankV3Entry _self;
  final $Res Function(TermBankV3Entry) _then;

/// Create a copy of TermBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? termBankV3TableId = null,Object? indexId = null,Object? term = null,Object? reading = null,Object? definitionTags = null,Object? ruleIdentifiers = null,Object? popularity = null,Object? definitions = null,Object? sequenceNumber = null,Object? tags = null,}) {
  return _then(TermBankV3Entry(
termBankV3TableId: null == termBankV3TableId ? _self.termBankV3TableId : termBankV3TableId // ignore: cast_nullable_to_non_nullable
as int,indexId: null == indexId ? _self.indexId : indexId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,reading: null == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as String,definitionTags: null == definitionTags ? _self.definitionTags : definitionTags // ignore: cast_nullable_to_non_nullable
as List<String>,ruleIdentifiers: null == ruleIdentifiers ? _self.ruleIdentifiers : ruleIdentifiers // ignore: cast_nullable_to_non_nullable
as List<String>,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,definitions: null == definitions ? _self.definitions : definitions // ignore: cast_nullable_to_non_nullable
as List<String>,sequenceNumber: null == sequenceNumber ? _self.sequenceNumber : sequenceNumber // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,
  ));
}

}


/// Adds pattern-matching-related methods to [TermBankV3Entry].
extension TermBankV3EntryPatterns on TermBankV3Entry {
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
