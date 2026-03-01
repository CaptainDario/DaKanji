// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExampleEntry {

 int get id; IndexEntry get indexEntry; int get groupId; String get languageCode; String get sentence; List<TagBankV3Entry> get tags; List<StatEntry> get stats; List<ExampleAudioEntry> get audios;
/// Create a copy of ExampleEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleEntryCopyWith<ExampleEntry> get copyWith => _$ExampleEntryCopyWithImpl<ExampleEntry>(this as ExampleEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.indexEntry, indexEntry) || other.indexEntry == indexEntry)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.sentence, sentence) || other.sentence == sentence)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.stats, stats)&&const DeepCollectionEquality().equals(other.audios, audios));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,indexEntry,groupId,languageCode,sentence,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(stats),const DeepCollectionEquality().hash(audios));

@override
String toString() {
  return 'ExampleEntry(id: $id, indexEntry: $indexEntry, groupId: $groupId, languageCode: $languageCode, sentence: $sentence, tags: $tags, stats: $stats, audios: $audios)';
}


}

/// @nodoc
abstract mixin class $ExampleEntryCopyWith<$Res>  {
  factory $ExampleEntryCopyWith(ExampleEntry value, $Res Function(ExampleEntry) _then) = _$ExampleEntryCopyWithImpl;
@useResult
$Res call({
 int id, IndexEntry indexEntry, int groupId, String languageCode, String sentence, List<TagBankV3Entry> tags, List<StatEntry> stats, List<ExampleAudioEntry> audios
});




}
/// @nodoc
class _$ExampleEntryCopyWithImpl<$Res>
    implements $ExampleEntryCopyWith<$Res> {
  _$ExampleEntryCopyWithImpl(this._self, this._then);

  final ExampleEntry _self;
  final $Res Function(ExampleEntry) _then;

/// Create a copy of ExampleEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? indexEntry = null,Object? groupId = null,Object? languageCode = null,Object? sentence = null,Object? tags = null,Object? stats = null,Object? audios = null,}) {
  return _then(ExampleEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,indexEntry: null == indexEntry ? _self.indexEntry : indexEntry // ignore: cast_nullable_to_non_nullable
as IndexEntry,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,sentence: null == sentence ? _self.sentence : sentence // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatEntry>,audios: null == audios ? _self.audios : audios // ignore: cast_nullable_to_non_nullable
as List<ExampleAudioEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExampleEntry].
extension ExampleEntryPatterns on ExampleEntry {
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
