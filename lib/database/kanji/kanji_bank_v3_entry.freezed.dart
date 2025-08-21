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

/// The kanji character of this entry
 String get kanji;/// The onyomi readings of this entry
 List<String>? get onyomis;/// The kunyomi readings of this entry
 List<String>? get kunyomis;/// The tags of this entry
 List<TagBankV3Entry>? get tags;/// The definition of this entry
 List<String>? get definitions;/// The stats of this entry
 List<KanjiBankV3EntryStat>? get stats;
/// Create a copy of KanjiBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanjiBankV3EntryCopyWith<KanjiBankV3Entry> get copyWith => _$KanjiBankV3EntryCopyWithImpl<KanjiBankV3Entry>(this as KanjiBankV3Entry, _$identity);

  /// Serializes this KanjiBankV3Entry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanjiBankV3Entry&&(identical(other.kanji, kanji) || other.kanji == kanji)&&const DeepCollectionEquality().equals(other.onyomis, onyomis)&&const DeepCollectionEquality().equals(other.kunyomis, kunyomis)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.definitions, definitions)&&const DeepCollectionEquality().equals(other.stats, stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kanji,const DeepCollectionEquality().hash(onyomis),const DeepCollectionEquality().hash(kunyomis),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(definitions),const DeepCollectionEquality().hash(stats));

@override
String toString() {
  return 'KanjiBankV3Entry(kanji: $kanji, onyomis: $onyomis, kunyomis: $kunyomis, tags: $tags, definitions: $definitions, stats: $stats)';
}


}

/// @nodoc
abstract mixin class $KanjiBankV3EntryCopyWith<$Res>  {
  factory $KanjiBankV3EntryCopyWith(KanjiBankV3Entry value, $Res Function(KanjiBankV3Entry) _then) = _$KanjiBankV3EntryCopyWithImpl;
@useResult
$Res call({
 String kanji, List<String>? onyomis, List<String>? kunyomis, List<TagBankV3Entry>? tags, List<String>? definitions, List<KanjiBankV3EntryStat>? stats
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
@pragma('vm:prefer-inline') @override $Res call({Object? kanji = null,Object? onyomis = freezed,Object? kunyomis = freezed,Object? tags = freezed,Object? definitions = freezed,Object? stats = freezed,}) {
  return _then(_self.copyWith(
kanji: null == kanji ? _self.kanji : kanji // ignore: cast_nullable_to_non_nullable
as String,onyomis: freezed == onyomis ? _self.onyomis : onyomis // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanjiBankV3Entry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanjiBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanjiBankV3Entry value)  $default,){
final _that = this;
switch (_that) {
case _KanjiBankV3Entry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanjiBankV3Entry value)?  $default,){
final _that = this;
switch (_that) {
case _KanjiBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kanji,  List<String>? onyomis,  List<String>? kunyomis,  List<TagBankV3Entry>? tags,  List<String>? definitions,  List<KanjiBankV3EntryStat>? stats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanjiBankV3Entry() when $default != null:
return $default(_that.kanji,_that.onyomis,_that.kunyomis,_that.tags,_that.definitions,_that.stats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kanji,  List<String>? onyomis,  List<String>? kunyomis,  List<TagBankV3Entry>? tags,  List<String>? definitions,  List<KanjiBankV3EntryStat>? stats)  $default,) {final _that = this;
switch (_that) {
case _KanjiBankV3Entry():
return $default(_that.kanji,_that.onyomis,_that.kunyomis,_that.tags,_that.definitions,_that.stats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kanji,  List<String>? onyomis,  List<String>? kunyomis,  List<TagBankV3Entry>? tags,  List<String>? definitions,  List<KanjiBankV3EntryStat>? stats)?  $default,) {final _that = this;
switch (_that) {
case _KanjiBankV3Entry() when $default != null:
return $default(_that.kanji,_that.onyomis,_that.kunyomis,_that.tags,_that.definitions,_that.stats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KanjiBankV3Entry implements KanjiBankV3Entry {
  const _KanjiBankV3Entry({required this.kanji, required this.onyomis, required this.kunyomis, required this.tags, required this.definitions, required this.stats});
  factory _KanjiBankV3Entry.fromJson(Map<String, dynamic> json) => _$KanjiBankV3EntryFromJson(json);

/// The kanji character of this entry
@override final  String kanji;
/// The onyomi readings of this entry
@override final  List<String>? onyomis;
/// The kunyomi readings of this entry
@override final  List<String>? kunyomis;
/// The tags of this entry
@override final  List<TagBankV3Entry>? tags;
/// The definition of this entry
@override final  List<String>? definitions;
/// The stats of this entry
@override final  List<KanjiBankV3EntryStat>? stats;

/// Create a copy of KanjiBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanjiBankV3EntryCopyWith<_KanjiBankV3Entry> get copyWith => __$KanjiBankV3EntryCopyWithImpl<_KanjiBankV3Entry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KanjiBankV3EntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanjiBankV3Entry&&(identical(other.kanji, kanji) || other.kanji == kanji)&&const DeepCollectionEquality().equals(other.onyomis, onyomis)&&const DeepCollectionEquality().equals(other.kunyomis, kunyomis)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.definitions, definitions)&&const DeepCollectionEquality().equals(other.stats, stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kanji,const DeepCollectionEquality().hash(onyomis),const DeepCollectionEquality().hash(kunyomis),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(definitions),const DeepCollectionEquality().hash(stats));

@override
String toString() {
  return 'KanjiBankV3Entry(kanji: $kanji, onyomis: $onyomis, kunyomis: $kunyomis, tags: $tags, definitions: $definitions, stats: $stats)';
}


}

/// @nodoc
abstract mixin class _$KanjiBankV3EntryCopyWith<$Res> implements $KanjiBankV3EntryCopyWith<$Res> {
  factory _$KanjiBankV3EntryCopyWith(_KanjiBankV3Entry value, $Res Function(_KanjiBankV3Entry) _then) = __$KanjiBankV3EntryCopyWithImpl;
@override @useResult
$Res call({
 String kanji, List<String>? onyomis, List<String>? kunyomis, List<TagBankV3Entry>? tags, List<String>? definitions, List<KanjiBankV3EntryStat>? stats
});




}
/// @nodoc
class __$KanjiBankV3EntryCopyWithImpl<$Res>
    implements _$KanjiBankV3EntryCopyWith<$Res> {
  __$KanjiBankV3EntryCopyWithImpl(this._self, this._then);

  final _KanjiBankV3Entry _self;
  final $Res Function(_KanjiBankV3Entry) _then;

/// Create a copy of KanjiBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kanji = null,Object? onyomis = freezed,Object? kunyomis = freezed,Object? tags = freezed,Object? definitions = freezed,Object? stats = freezed,}) {
  return _then(_KanjiBankV3Entry(
kanji: null == kanji ? _self.kanji : kanji // ignore: cast_nullable_to_non_nullable
as String,onyomis: freezed == onyomis ? _self.onyomis : onyomis // ignore: cast_nullable_to_non_nullable
as List<String>?,kunyomis: freezed == kunyomis ? _self.kunyomis : kunyomis // ignore: cast_nullable_to_non_nullable
as List<String>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>?,definitions: freezed == definitions ? _self.definitions : definitions // ignore: cast_nullable_to_non_nullable
as List<String>?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<KanjiBankV3EntryStat>?,
  ));
}


}

// dart format on
