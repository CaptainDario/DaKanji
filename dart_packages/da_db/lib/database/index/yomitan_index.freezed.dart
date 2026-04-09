// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yomitan_index.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YomitanIndex {

 String get title; String get revision; bool? get sequenced; int? get format; int? get version; String? get author; bool? get isUpdatable; String? get indexUrl; String? get downloadUrl; String? get url; String? get description; String? get attribution; Iso639_3? get sourceLanguage; Iso639_3? get targetLanguage; FrequencyMode? get frequencyMode;
/// Create a copy of YomitanIndex
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YomitanIndexCopyWith<YomitanIndex> get copyWith => _$YomitanIndexCopyWithImpl<YomitanIndex>(this as YomitanIndex, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YomitanIndex&&(identical(other.title, title) || other.title == title)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.sequenced, sequenced) || other.sequenced == sequenced)&&(identical(other.format, format) || other.format == format)&&(identical(other.version, version) || other.version == version)&&(identical(other.author, author) || other.author == author)&&(identical(other.isUpdatable, isUpdatable) || other.isUpdatable == isUpdatable)&&(identical(other.indexUrl, indexUrl) || other.indexUrl == indexUrl)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.attribution, attribution) || other.attribution == attribution)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.frequencyMode, frequencyMode) || other.frequencyMode == frequencyMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,revision,sequenced,format,version,author,isUpdatable,indexUrl,downloadUrl,url,description,attribution,sourceLanguage,targetLanguage,frequencyMode);

@override
String toString() {
  return 'YomitanIndex(title: $title, revision: $revision, sequenced: $sequenced, format: $format, version: $version, author: $author, isUpdatable: $isUpdatable, indexUrl: $indexUrl, downloadUrl: $downloadUrl, url: $url, description: $description, attribution: $attribution, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, frequencyMode: $frequencyMode)';
}


}

/// @nodoc
abstract mixin class $YomitanIndexCopyWith<$Res>  {
  factory $YomitanIndexCopyWith(YomitanIndex value, $Res Function(YomitanIndex) _then) = _$YomitanIndexCopyWithImpl;
@useResult
$Res call({
 String title, String revision, bool? sequenced, int? format, int? version, String? author, bool? isUpdatable, String? indexUrl, String? downloadUrl, String? url, String? description, String? attribution, Iso639_3? sourceLanguage, Iso639_3? targetLanguage, FrequencyMode? frequencyMode
});




}
/// @nodoc
class _$YomitanIndexCopyWithImpl<$Res>
    implements $YomitanIndexCopyWith<$Res> {
  _$YomitanIndexCopyWithImpl(this._self, this._then);

  final YomitanIndex _self;
  final $Res Function(YomitanIndex) _then;

/// Create a copy of YomitanIndex
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? revision = null,Object? sequenced = freezed,Object? format = freezed,Object? version = freezed,Object? author = freezed,Object? isUpdatable = freezed,Object? indexUrl = freezed,Object? downloadUrl = freezed,Object? url = freezed,Object? description = freezed,Object? attribution = freezed,Object? sourceLanguage = freezed,Object? targetLanguage = freezed,Object? frequencyMode = freezed,}) {
  return _then(YomitanIndex(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,sequenced: freezed == sequenced ? _self.sequenced : sequenced // ignore: cast_nullable_to_non_nullable
as bool?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as int?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,isUpdatable: freezed == isUpdatable ? _self.isUpdatable : isUpdatable // ignore: cast_nullable_to_non_nullable
as bool?,indexUrl: freezed == indexUrl ? _self.indexUrl : indexUrl // ignore: cast_nullable_to_non_nullable
as String?,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,attribution: freezed == attribution ? _self.attribution : attribution // ignore: cast_nullable_to_non_nullable
as String?,sourceLanguage: freezed == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as Iso639_3?,targetLanguage: freezed == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as Iso639_3?,frequencyMode: freezed == frequencyMode ? _self.frequencyMode : frequencyMode // ignore: cast_nullable_to_non_nullable
as FrequencyMode?,
  ));
}

}


/// Adds pattern-matching-related methods to [YomitanIndex].
extension YomitanIndexPatterns on YomitanIndex {
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
