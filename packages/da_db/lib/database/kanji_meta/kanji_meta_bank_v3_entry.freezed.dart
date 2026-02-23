// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanji_meta_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KanjiMetaBankV3Entry {

/// The unique id of this entry
 int get id;/// id of this entry's dictionary
@IndexEntryJsonConverter() IndexEntry get indexEntry;/// The kanji of this entry
 String get kanji;/// The type of this entry
 String get type;/// the numeric value of this entry's frequency
 int? get freqValue;/// The display value of this entry's frequency
 String? get freqDisplayValue;
/// Create a copy of KanjiMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KanjiMetaBankV3EntryCopyWith<KanjiMetaBankV3Entry> get copyWith => _$KanjiMetaBankV3EntryCopyWithImpl<KanjiMetaBankV3Entry>(this as KanjiMetaBankV3Entry, _$identity);

  /// Serializes this KanjiMetaBankV3Entry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KanjiMetaBankV3Entry&&(identical(other.id, id) || other.id == id)&&(identical(other.indexEntry, indexEntry) || other.indexEntry == indexEntry)&&(identical(other.kanji, kanji) || other.kanji == kanji)&&(identical(other.type, type) || other.type == type)&&(identical(other.freqValue, freqValue) || other.freqValue == freqValue)&&(identical(other.freqDisplayValue, freqDisplayValue) || other.freqDisplayValue == freqDisplayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,indexEntry,kanji,type,freqValue,freqDisplayValue);

@override
String toString() {
  return 'KanjiMetaBankV3Entry(id: $id, indexEntry: $indexEntry, kanji: $kanji, type: $type, freqValue: $freqValue, freqDisplayValue: $freqDisplayValue)';
}


}

/// @nodoc
abstract mixin class $KanjiMetaBankV3EntryCopyWith<$Res>  {
  factory $KanjiMetaBankV3EntryCopyWith(KanjiMetaBankV3Entry value, $Res Function(KanjiMetaBankV3Entry) _then) = _$KanjiMetaBankV3EntryCopyWithImpl;
@useResult
$Res call({
 int id,@IndexEntryJsonConverter() IndexEntry indexEntry, String kanji, String type, int? freqValue, String? freqDisplayValue
});


$IndexEntryCopyWith<$Res> get indexEntry;

}
/// @nodoc
class _$KanjiMetaBankV3EntryCopyWithImpl<$Res>
    implements $KanjiMetaBankV3EntryCopyWith<$Res> {
  _$KanjiMetaBankV3EntryCopyWithImpl(this._self, this._then);

  final KanjiMetaBankV3Entry _self;
  final $Res Function(KanjiMetaBankV3Entry) _then;

/// Create a copy of KanjiMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? indexEntry = null,Object? kanji = null,Object? type = null,Object? freqValue = freezed,Object? freqDisplayValue = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,indexEntry: null == indexEntry ? _self.indexEntry : indexEntry // ignore: cast_nullable_to_non_nullable
as IndexEntry,kanji: null == kanji ? _self.kanji : kanji // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,freqValue: freezed == freqValue ? _self.freqValue : freqValue // ignore: cast_nullable_to_non_nullable
as int?,freqDisplayValue: freezed == freqDisplayValue ? _self.freqDisplayValue : freqDisplayValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of KanjiMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndexEntryCopyWith<$Res> get indexEntry {
  
  return $IndexEntryCopyWith<$Res>(_self.indexEntry, (value) {
    return _then(_self.copyWith(indexEntry: value));
  });
}
}


/// Adds pattern-matching-related methods to [KanjiMetaBankV3Entry].
extension KanjiMetaBankV3EntryPatterns on KanjiMetaBankV3Entry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KanjiMetaBankV3Entry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KanjiMetaBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KanjiMetaBankV3Entry value)  $default,){
final _that = this;
switch (_that) {
case _KanjiMetaBankV3Entry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KanjiMetaBankV3Entry value)?  $default,){
final _that = this;
switch (_that) {
case _KanjiMetaBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @IndexEntryJsonConverter()  IndexEntry indexEntry,  String kanji,  String type,  int? freqValue,  String? freqDisplayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KanjiMetaBankV3Entry() when $default != null:
return $default(_that.id,_that.indexEntry,_that.kanji,_that.type,_that.freqValue,_that.freqDisplayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @IndexEntryJsonConverter()  IndexEntry indexEntry,  String kanji,  String type,  int? freqValue,  String? freqDisplayValue)  $default,) {final _that = this;
switch (_that) {
case _KanjiMetaBankV3Entry():
return $default(_that.id,_that.indexEntry,_that.kanji,_that.type,_that.freqValue,_that.freqDisplayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @IndexEntryJsonConverter()  IndexEntry indexEntry,  String kanji,  String type,  int? freqValue,  String? freqDisplayValue)?  $default,) {final _that = this;
switch (_that) {
case _KanjiMetaBankV3Entry() when $default != null:
return $default(_that.id,_that.indexEntry,_that.kanji,_that.type,_that.freqValue,_that.freqDisplayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KanjiMetaBankV3Entry implements KanjiMetaBankV3Entry {
  const _KanjiMetaBankV3Entry({required this.id, @IndexEntryJsonConverter() required this.indexEntry, required this.kanji, required this.type, this.freqValue, this.freqDisplayValue});
  factory _KanjiMetaBankV3Entry.fromJson(Map<String, dynamic> json) => _$KanjiMetaBankV3EntryFromJson(json);

/// The unique id of this entry
@override final  int id;
/// id of this entry's dictionary
@override@IndexEntryJsonConverter() final  IndexEntry indexEntry;
/// The kanji of this entry
@override final  String kanji;
/// The type of this entry
@override final  String type;
/// the numeric value of this entry's frequency
@override final  int? freqValue;
/// The display value of this entry's frequency
@override final  String? freqDisplayValue;

/// Create a copy of KanjiMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KanjiMetaBankV3EntryCopyWith<_KanjiMetaBankV3Entry> get copyWith => __$KanjiMetaBankV3EntryCopyWithImpl<_KanjiMetaBankV3Entry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KanjiMetaBankV3EntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KanjiMetaBankV3Entry&&(identical(other.id, id) || other.id == id)&&(identical(other.indexEntry, indexEntry) || other.indexEntry == indexEntry)&&(identical(other.kanji, kanji) || other.kanji == kanji)&&(identical(other.type, type) || other.type == type)&&(identical(other.freqValue, freqValue) || other.freqValue == freqValue)&&(identical(other.freqDisplayValue, freqDisplayValue) || other.freqDisplayValue == freqDisplayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,indexEntry,kanji,type,freqValue,freqDisplayValue);

@override
String toString() {
  return 'KanjiMetaBankV3Entry(id: $id, indexEntry: $indexEntry, kanji: $kanji, type: $type, freqValue: $freqValue, freqDisplayValue: $freqDisplayValue)';
}


}

/// @nodoc
abstract mixin class _$KanjiMetaBankV3EntryCopyWith<$Res> implements $KanjiMetaBankV3EntryCopyWith<$Res> {
  factory _$KanjiMetaBankV3EntryCopyWith(_KanjiMetaBankV3Entry value, $Res Function(_KanjiMetaBankV3Entry) _then) = __$KanjiMetaBankV3EntryCopyWithImpl;
@override @useResult
$Res call({
 int id,@IndexEntryJsonConverter() IndexEntry indexEntry, String kanji, String type, int? freqValue, String? freqDisplayValue
});


@override $IndexEntryCopyWith<$Res> get indexEntry;

}
/// @nodoc
class __$KanjiMetaBankV3EntryCopyWithImpl<$Res>
    implements _$KanjiMetaBankV3EntryCopyWith<$Res> {
  __$KanjiMetaBankV3EntryCopyWithImpl(this._self, this._then);

  final _KanjiMetaBankV3Entry _self;
  final $Res Function(_KanjiMetaBankV3Entry) _then;

/// Create a copy of KanjiMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? indexEntry = null,Object? kanji = null,Object? type = null,Object? freqValue = freezed,Object? freqDisplayValue = freezed,}) {
  return _then(_KanjiMetaBankV3Entry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,indexEntry: null == indexEntry ? _self.indexEntry : indexEntry // ignore: cast_nullable_to_non_nullable
as IndexEntry,kanji: null == kanji ? _self.kanji : kanji // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,freqValue: freezed == freqValue ? _self.freqValue : freqValue // ignore: cast_nullable_to_non_nullable
as int?,freqDisplayValue: freezed == freqDisplayValue ? _self.freqDisplayValue : freqDisplayValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of KanjiMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndexEntryCopyWith<$Res> get indexEntry {
  
  return $IndexEntryCopyWith<$Res>(_self.indexEntry, (value) {
    return _then(_self.copyWith(indexEntry: value));
  });
}
}

// dart format on
