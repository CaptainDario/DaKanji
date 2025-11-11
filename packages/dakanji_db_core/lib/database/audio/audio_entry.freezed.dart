// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioEntry {

 int get id; set id(int value); IndexEntry get indexEntry; set indexEntry(IndexEntry value); List<String> get terms; String? get reading; int? get pitchAccentPattern; String? get filePath; String get fileName; Uint8List get fileData;
/// Create a copy of AudioEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioEntryCopyWith<AudioEntry> get copyWith => _$AudioEntryCopyWithImpl<AudioEntry>(this as AudioEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.indexEntry, indexEntry) || other.indexEntry == indexEntry)&&const DeepCollectionEquality().equals(other.terms, terms)&&(identical(other.reading, reading) || other.reading == reading)&&(identical(other.pitchAccentPattern, pitchAccentPattern) || other.pitchAccentPattern == pitchAccentPattern)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&const DeepCollectionEquality().equals(other.fileData, fileData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,indexEntry,const DeepCollectionEquality().hash(terms),reading,pitchAccentPattern,filePath,fileName,const DeepCollectionEquality().hash(fileData));

@override
String toString() {
  return 'AudioEntry(id: $id, indexEntry: $indexEntry, terms: $terms, reading: $reading, pitchAccentPattern: $pitchAccentPattern, filePath: $filePath, fileName: $fileName, fileData: $fileData)';
}


}

/// @nodoc
abstract mixin class $AudioEntryCopyWith<$Res>  {
  factory $AudioEntryCopyWith(AudioEntry value, $Res Function(AudioEntry) _then) = _$AudioEntryCopyWithImpl;
@useResult
$Res call({
 int id, IndexEntry indexEntry, List<String> terms, String? reading, int? pitchAccentPattern, String? filePath, String fileName, Uint8List fileData
});




}
/// @nodoc
class _$AudioEntryCopyWithImpl<$Res>
    implements $AudioEntryCopyWith<$Res> {
  _$AudioEntryCopyWithImpl(this._self, this._then);

  final AudioEntry _self;
  final $Res Function(AudioEntry) _then;

/// Create a copy of AudioEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? indexEntry = null,Object? terms = null,Object? reading = freezed,Object? pitchAccentPattern = freezed,Object? filePath = freezed,Object? fileName = null,Object? fileData = null,}) {
  return _then(AudioEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,indexEntry: null == indexEntry ? _self.indexEntry : indexEntry // ignore: cast_nullable_to_non_nullable
as IndexEntry,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as String?,pitchAccentPattern: freezed == pitchAccentPattern ? _self.pitchAccentPattern : pitchAccentPattern // ignore: cast_nullable_to_non_nullable
as int?,filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileData: null == fileData ? _self.fileData : fileData // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioEntry].
extension AudioEntryPatterns on AudioEntry {
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
