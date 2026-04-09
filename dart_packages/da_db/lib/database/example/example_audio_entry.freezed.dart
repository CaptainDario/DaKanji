// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_audio_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExampleAudioEntry {

 int get id; String get path; String get name; List<TagBankV3Entry> get tags; List<StatEntry> get stats;
/// Create a copy of ExampleAudioEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleAudioEntryCopyWith<ExampleAudioEntry> get copyWith => _$ExampleAudioEntryCopyWithImpl<ExampleAudioEntry>(this as ExampleAudioEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleAudioEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.stats, stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,path,name,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(stats));

@override
String toString() {
  return 'ExampleAudioEntry(id: $id, path: $path, name: $name, tags: $tags, stats: $stats)';
}


}

/// @nodoc
abstract mixin class $ExampleAudioEntryCopyWith<$Res>  {
  factory $ExampleAudioEntryCopyWith(ExampleAudioEntry value, $Res Function(ExampleAudioEntry) _then) = _$ExampleAudioEntryCopyWithImpl;
@useResult
$Res call({
 int id, String path, String name, List<TagBankV3Entry> tags, List<StatEntry> stats
});




}
/// @nodoc
class _$ExampleAudioEntryCopyWithImpl<$Res>
    implements $ExampleAudioEntryCopyWith<$Res> {
  _$ExampleAudioEntryCopyWithImpl(this._self, this._then);

  final ExampleAudioEntry _self;
  final $Res Function(ExampleAudioEntry) _then;

/// Create a copy of ExampleAudioEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? path = null,Object? name = null,Object? tags = null,Object? stats = null,}) {
  return _then(ExampleAudioEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExampleAudioEntry].
extension ExampleAudioEntryPatterns on ExampleAudioEntry {
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
