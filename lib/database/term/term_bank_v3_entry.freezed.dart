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

/// 
 String get term;/// 
 String get reading;///
 List<String> get definitionTags;///
 List<String> get ruleIdentifiers;/// 
 int get popularity;/// 
 List<String>? get definitions;/// 
 int get sequenceNumber;///
 List<TagBankV3Entry> get tags;
/// Create a copy of TermBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermBankV3EntryCopyWith<TermBankV3Entry> get copyWith => _$TermBankV3EntryCopyWithImpl<TermBankV3Entry>(this as TermBankV3Entry, _$identity);

  /// Serializes this TermBankV3Entry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermBankV3Entry&&(identical(other.term, term) || other.term == term)&&(identical(other.reading, reading) || other.reading == reading)&&const DeepCollectionEquality().equals(other.definitionTags, definitionTags)&&const DeepCollectionEquality().equals(other.ruleIdentifiers, ruleIdentifiers)&&(identical(other.popularity, popularity) || other.popularity == popularity)&&const DeepCollectionEquality().equals(other.definitions, definitions)&&(identical(other.sequenceNumber, sequenceNumber) || other.sequenceNumber == sequenceNumber)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,term,reading,const DeepCollectionEquality().hash(definitionTags),const DeepCollectionEquality().hash(ruleIdentifiers),popularity,const DeepCollectionEquality().hash(definitions),sequenceNumber,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TermBankV3Entry(term: $term, reading: $reading, definitionTags: $definitionTags, ruleIdentifiers: $ruleIdentifiers, popularity: $popularity, definitions: $definitions, sequenceNumber: $sequenceNumber, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TermBankV3EntryCopyWith<$Res>  {
  factory $TermBankV3EntryCopyWith(TermBankV3Entry value, $Res Function(TermBankV3Entry) _then) = _$TermBankV3EntryCopyWithImpl;
@useResult
$Res call({
 String term, String reading, List<String> definitionTags, List<String> ruleIdentifiers, int popularity, List<String>? definitions, int sequenceNumber, List<TagBankV3Entry> tags
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
@pragma('vm:prefer-inline') @override $Res call({Object? term = null,Object? reading = null,Object? definitionTags = null,Object? ruleIdentifiers = null,Object? popularity = null,Object? definitions = freezed,Object? sequenceNumber = null,Object? tags = null,}) {
  return _then(_self.copyWith(
term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,reading: null == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as String,definitionTags: null == definitionTags ? _self.definitionTags : definitionTags // ignore: cast_nullable_to_non_nullable
as List<String>,ruleIdentifiers: null == ruleIdentifiers ? _self.ruleIdentifiers : ruleIdentifiers // ignore: cast_nullable_to_non_nullable
as List<String>,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,definitions: freezed == definitions ? _self.definitions : definitions // ignore: cast_nullable_to_non_nullable
as List<String>?,sequenceNumber: null == sequenceNumber ? _self.sequenceNumber : sequenceNumber // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TermBankV3Entry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TermBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TermBankV3Entry value)  $default,){
final _that = this;
switch (_that) {
case _TermBankV3Entry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TermBankV3Entry value)?  $default,){
final _that = this;
switch (_that) {
case _TermBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String term,  String reading,  List<String> definitionTags,  List<String> ruleIdentifiers,  int popularity,  List<String>? definitions,  int sequenceNumber,  List<TagBankV3Entry> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TermBankV3Entry() when $default != null:
return $default(_that.term,_that.reading,_that.definitionTags,_that.ruleIdentifiers,_that.popularity,_that.definitions,_that.sequenceNumber,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String term,  String reading,  List<String> definitionTags,  List<String> ruleIdentifiers,  int popularity,  List<String>? definitions,  int sequenceNumber,  List<TagBankV3Entry> tags)  $default,) {final _that = this;
switch (_that) {
case _TermBankV3Entry():
return $default(_that.term,_that.reading,_that.definitionTags,_that.ruleIdentifiers,_that.popularity,_that.definitions,_that.sequenceNumber,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String term,  String reading,  List<String> definitionTags,  List<String> ruleIdentifiers,  int popularity,  List<String>? definitions,  int sequenceNumber,  List<TagBankV3Entry> tags)?  $default,) {final _that = this;
switch (_that) {
case _TermBankV3Entry() when $default != null:
return $default(_that.term,_that.reading,_that.definitionTags,_that.ruleIdentifiers,_that.popularity,_that.definitions,_that.sequenceNumber,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TermBankV3Entry implements TermBankV3Entry {
  const _TermBankV3Entry({required this.term, required this.reading, required this.definitionTags, required this.ruleIdentifiers, required this.popularity, required this.definitions, required this.sequenceNumber, required this.tags});
  factory _TermBankV3Entry.fromJson(Map<String, dynamic> json) => _$TermBankV3EntryFromJson(json);

/// 
@override final  String term;
/// 
@override final  String reading;
///
@override final  List<String> definitionTags;
///
@override final  List<String> ruleIdentifiers;
/// 
@override final  int popularity;
/// 
@override final  List<String>? definitions;
/// 
@override final  int sequenceNumber;
///
@override final  List<TagBankV3Entry> tags;

/// Create a copy of TermBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermBankV3EntryCopyWith<_TermBankV3Entry> get copyWith => __$TermBankV3EntryCopyWithImpl<_TermBankV3Entry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermBankV3EntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermBankV3Entry&&(identical(other.term, term) || other.term == term)&&(identical(other.reading, reading) || other.reading == reading)&&const DeepCollectionEquality().equals(other.definitionTags, definitionTags)&&const DeepCollectionEquality().equals(other.ruleIdentifiers, ruleIdentifiers)&&(identical(other.popularity, popularity) || other.popularity == popularity)&&const DeepCollectionEquality().equals(other.definitions, definitions)&&(identical(other.sequenceNumber, sequenceNumber) || other.sequenceNumber == sequenceNumber)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,term,reading,const DeepCollectionEquality().hash(definitionTags),const DeepCollectionEquality().hash(ruleIdentifiers),popularity,const DeepCollectionEquality().hash(definitions),sequenceNumber,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TermBankV3Entry(term: $term, reading: $reading, definitionTags: $definitionTags, ruleIdentifiers: $ruleIdentifiers, popularity: $popularity, definitions: $definitions, sequenceNumber: $sequenceNumber, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TermBankV3EntryCopyWith<$Res> implements $TermBankV3EntryCopyWith<$Res> {
  factory _$TermBankV3EntryCopyWith(_TermBankV3Entry value, $Res Function(_TermBankV3Entry) _then) = __$TermBankV3EntryCopyWithImpl;
@override @useResult
$Res call({
 String term, String reading, List<String> definitionTags, List<String> ruleIdentifiers, int popularity, List<String>? definitions, int sequenceNumber, List<TagBankV3Entry> tags
});




}
/// @nodoc
class __$TermBankV3EntryCopyWithImpl<$Res>
    implements _$TermBankV3EntryCopyWith<$Res> {
  __$TermBankV3EntryCopyWithImpl(this._self, this._then);

  final _TermBankV3Entry _self;
  final $Res Function(_TermBankV3Entry) _then;

/// Create a copy of TermBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? term = null,Object? reading = null,Object? definitionTags = null,Object? ruleIdentifiers = null,Object? popularity = null,Object? definitions = freezed,Object? sequenceNumber = null,Object? tags = null,}) {
  return _then(_TermBankV3Entry(
term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,reading: null == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as String,definitionTags: null == definitionTags ? _self.definitionTags : definitionTags // ignore: cast_nullable_to_non_nullable
as List<String>,ruleIdentifiers: null == ruleIdentifiers ? _self.ruleIdentifiers : ruleIdentifiers // ignore: cast_nullable_to_non_nullable
as List<String>,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,definitions: freezed == definitions ? _self.definitions : definitions // ignore: cast_nullable_to_non_nullable
as List<String>?,sequenceNumber: null == sequenceNumber ? _self.sequenceNumber : sequenceNumber // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,
  ));
}


}

// dart format on
