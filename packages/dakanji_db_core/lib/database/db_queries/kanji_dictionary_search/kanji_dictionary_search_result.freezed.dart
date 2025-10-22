// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_dictionary_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KanjiDictionarySearchResult {

 IndexTableEntry get indexTableEntry; set indexTableEntry(IndexTableEntry value); KanjiBankV3Entry get kanjiBankEntry; set kanjiBankEntry(KanjiBankV3Entry value); List<KanjiMetaBankV3Entry> get kanjiMetaBankEntry; set kanjiMetaBankEntry(List<KanjiMetaBankV3Entry> value);
/// Create a copy of KanjiDictionarySearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanjiDictionarySearchResultCopyWith<KanjiDictionarySearchResult> get copyWith => _$KanjiDictionarySearchResultCopyWithImpl<KanjiDictionarySearchResult>(this as KanjiDictionarySearchResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanjiDictionarySearchResult&&(identical(other.indexTableEntry, indexTableEntry) || other.indexTableEntry == indexTableEntry)&&(identical(other.kanjiBankEntry, kanjiBankEntry) || other.kanjiBankEntry == kanjiBankEntry)&&const DeepCollectionEquality().equals(other.kanjiMetaBankEntry, kanjiMetaBankEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,indexTableEntry,kanjiBankEntry,const DeepCollectionEquality().hash(kanjiMetaBankEntry));

@override
String toString() {
  return 'KanjiDictionarySearchResult(indexTableEntry: $indexTableEntry, kanjiBankEntry: $kanjiBankEntry, kanjiMetaBankEntry: $kanjiMetaBankEntry)';
}


}

/// @nodoc
abstract mixin class $KanjiDictionarySearchResultCopyWith<$Res>  {
  factory $KanjiDictionarySearchResultCopyWith(KanjiDictionarySearchResult value, $Res Function(KanjiDictionarySearchResult) _then) = _$KanjiDictionarySearchResultCopyWithImpl;
@useResult
$Res call({
 IndexTableEntry indexTableEntry, KanjiBankV3Entry kanjiBankEntry, List<KanjiMetaBankV3Entry> kanjiMetaBankEntry
});




}
/// @nodoc
class _$KanjiDictionarySearchResultCopyWithImpl<$Res>
    implements $KanjiDictionarySearchResultCopyWith<$Res> {
  _$KanjiDictionarySearchResultCopyWithImpl(this._self, this._then);

  final KanjiDictionarySearchResult _self;
  final $Res Function(KanjiDictionarySearchResult) _then;

/// Create a copy of KanjiDictionarySearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? indexTableEntry = null,Object? kanjiBankEntry = null,Object? kanjiMetaBankEntry = null,}) {
  return _then(KanjiDictionarySearchResult(
indexTableEntry: null == indexTableEntry ? _self.indexTableEntry : indexTableEntry // ignore: cast_nullable_to_non_nullable
as IndexTableEntry,kanjiBankEntry: null == kanjiBankEntry ? _self.kanjiBankEntry : kanjiBankEntry // ignore: cast_nullable_to_non_nullable
as KanjiBankV3Entry,kanjiMetaBankEntry: null == kanjiMetaBankEntry ? _self.kanjiMetaBankEntry : kanjiMetaBankEntry // ignore: cast_nullable_to_non_nullable
as List<KanjiMetaBankV3Entry>,
  ));
}

}


/// Adds pattern-matching-related methods to [KanjiDictionarySearchResult].
extension KanjiDictionarySearchResultPatterns on KanjiDictionarySearchResult {
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
