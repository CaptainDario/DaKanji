// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KanjiBankV3Entry {

 String get kanji; set kanji(String value); int get indexId; set indexId(int value); List<String>? get onyomis; set onyomis(List<String>? value); List<String>? get kunyomis; set kunyomis(List<String>? value); List<TagBankV3Entry>? get tags; set tags(List<TagBankV3Entry>? value); List<String>? get definitions; set definitions(List<String>? value); List<KanjiBankV3EntryStat>? get stats; set stats(List<KanjiBankV3EntryStat>? value);
/// Create a copy of KanjiBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanjiBankV3EntryCopyWith<KanjiBankV3Entry> get copyWith => _$KanjiBankV3EntryCopyWithImpl<KanjiBankV3Entry>(this as KanjiBankV3Entry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanjiBankV3Entry&&(identical(other.kanji, kanji) || other.kanji == kanji)&&(identical(other.indexId, indexId) || other.indexId == indexId)&&const DeepCollectionEquality().equals(other.onyomis, onyomis)&&const DeepCollectionEquality().equals(other.kunyomis, kunyomis)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.definitions, definitions)&&const DeepCollectionEquality().equals(other.stats, stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kanji,indexId,const DeepCollectionEquality().hash(onyomis),const DeepCollectionEquality().hash(kunyomis),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(definitions),const DeepCollectionEquality().hash(stats));

@override
String toString() {
  return 'KanjiBankV3Entry(kanji: $kanji, indexId: $indexId, onyomis: $onyomis, kunyomis: $kunyomis, tags: $tags, definitions: $definitions, stats: $stats)';
}


}

/// @nodoc
abstract mixin class $KanjiBankV3EntryCopyWith<$Res>  {
  factory $KanjiBankV3EntryCopyWith(KanjiBankV3Entry value, $Res Function(KanjiBankV3Entry) _then) = _$KanjiBankV3EntryCopyWithImpl;
@useResult
$Res call({
 String kanji, int indexId, List<String>? onyomis, List<String>? kunyomis, List<TagBankV3Entry>? tags, List<String>? definitions, List<KanjiBankV3EntryStat>? stats
});




}
/// @nodoc
class _$KanjiBankV3EntryCopyWithImpl<$Res>
    implements $KanjiBankV3EntryCopyWith<$Res> {
  _$KanjiBankV3EntryCopyWithImpl(this._self, this._then);

  final KanjiBankV3Entry _self;
  final $Res Function(KanjiBankV3Entry) _then;

/// Create a copy of KanjiBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kanji = null,Object? indexId = null,Object? onyomis = freezed,Object? kunyomis = freezed,Object? tags = freezed,Object? definitions = freezed,Object? stats = freezed,}) {
  return _then(KanjiBankV3Entry(
kanji: null == kanji ? _self.kanji : kanji // ignore: cast_nullable_to_non_nullable
as String,indexId: null == indexId ? _self.indexId : indexId // ignore: cast_nullable_to_non_nullable
as int,onyomis: freezed == onyomis ? _self.onyomis : onyomis // ignore: cast_nullable_to_non_nullable
as List<String>?,kunyomis: freezed == kunyomis ? _self.kunyomis : kunyomis // ignore: cast_nullable_to_non_nullable
as List<String>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>?,definitions: freezed == definitions ? _self.definitions : definitions // ignore: cast_nullable_to_non_nullable
as List<String>?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<KanjiBankV3EntryStat>?,
  ));
}

}


/// Adds pattern-matching-related methods to [KanjiBankV3Entry].
extension KanjiBankV3EntryPatterns on KanjiBankV3Entry {
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
