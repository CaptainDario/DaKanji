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

/// the ipa transcription of this entry
 String get ipa;/// all tags of this pitch entry
@TagBankV3EntryConverter() List<TagBankV3Entry> get tags;
/// Create a copy of TermMetaBankV3IpaEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermMetaBankV3IpaEntryCopyWith<TermMetaBankV3IpaEntry> get copyWith => _$TermMetaBankV3IpaEntryCopyWithImpl<TermMetaBankV3IpaEntry>(this as TermMetaBankV3IpaEntry, _$identity);

  /// Serializes this TermMetaBankV3IpaEntry to a JSON map.
  Map<String, dynamic> toJson();


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
 String ipa,@TagBankV3EntryConverter() List<TagBankV3Entry> tags
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
  return _then(_self.copyWith(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TermMetaBankV3IpaEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TermMetaBankV3IpaEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TermMetaBankV3IpaEntry value)  $default,){
final _that = this;
switch (_that) {
case _TermMetaBankV3IpaEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TermMetaBankV3IpaEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TermMetaBankV3IpaEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ipa, @TagBankV3EntryConverter()  List<TagBankV3Entry> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TermMetaBankV3IpaEntry() when $default != null:
return $default(_that.ipa,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ipa, @TagBankV3EntryConverter()  List<TagBankV3Entry> tags)  $default,) {final _that = this;
switch (_that) {
case _TermMetaBankV3IpaEntry():
return $default(_that.ipa,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ipa, @TagBankV3EntryConverter()  List<TagBankV3Entry> tags)?  $default,) {final _that = this;
switch (_that) {
case _TermMetaBankV3IpaEntry() when $default != null:
return $default(_that.ipa,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TermMetaBankV3IpaEntry implements TermMetaBankV3IpaEntry {
  const _TermMetaBankV3IpaEntry({required this.ipa, @TagBankV3EntryConverter() this.tags = const []});
  factory _TermMetaBankV3IpaEntry.fromJson(Map<String, dynamic> json) => _$TermMetaBankV3IpaEntryFromJson(json);

/// the ipa transcription of this entry
@override final  String ipa;
/// all tags of this pitch entry
@override@JsonKey()@TagBankV3EntryConverter() final  List<TagBankV3Entry> tags;

/// Create a copy of TermMetaBankV3IpaEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermMetaBankV3IpaEntryCopyWith<_TermMetaBankV3IpaEntry> get copyWith => __$TermMetaBankV3IpaEntryCopyWithImpl<_TermMetaBankV3IpaEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermMetaBankV3IpaEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermMetaBankV3IpaEntry&&(identical(other.ipa, ipa) || other.ipa == ipa)&&const DeepCollectionEquality().equals(other.tags, tags));
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
abstract mixin class _$TermMetaBankV3IpaEntryCopyWith<$Res> implements $TermMetaBankV3IpaEntryCopyWith<$Res> {
  factory _$TermMetaBankV3IpaEntryCopyWith(_TermMetaBankV3IpaEntry value, $Res Function(_TermMetaBankV3IpaEntry) _then) = __$TermMetaBankV3IpaEntryCopyWithImpl;
@override @useResult
$Res call({
 String ipa,@TagBankV3EntryConverter() List<TagBankV3Entry> tags
});




}
/// @nodoc
class __$TermMetaBankV3IpaEntryCopyWithImpl<$Res>
    implements _$TermMetaBankV3IpaEntryCopyWith<$Res> {
  __$TermMetaBankV3IpaEntryCopyWithImpl(this._self, this._then);

  final _TermMetaBankV3IpaEntry _self;
  final $Res Function(_TermMetaBankV3IpaEntry) _then;

/// Create a copy of TermMetaBankV3IpaEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ipa = null,Object? tags = null,}) {
  return _then(_TermMetaBankV3IpaEntry(
ipa: null == ipa ? _self.ipa : ipa // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagBankV3Entry>,
  ));
}


}

// dart format on
