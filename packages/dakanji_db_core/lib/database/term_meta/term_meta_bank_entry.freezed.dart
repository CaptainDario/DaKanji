// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_meta_bank_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TermMetaBankV3Entry {

/// The id of this entry in the sqlite database
 int get id;/// The index (dictionary) in which this entry was found
@IndexEntryJsonConverter() IndexEntry get indexEntry;/// The term of this entry
 String get term;/// The type of this entry
 String get type;/// The reading of this entry
 String? get reading;/// the frequency of this entry as a numeric value
 int? get frequency;/// the frequency of this entry as a string for displaying
 String? get frequencyDisplayValue;/// Pitch data of this entry
 List<TermMetaBankV3PitchEntry> get pitchs;/// Ipa transcription data of this entry
 List<TermMetaBankV3IpaEntry> get ipas;
/// Create a copy of TermMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermMetaBankV3EntryCopyWith<TermMetaBankV3Entry> get copyWith => _$TermMetaBankV3EntryCopyWithImpl<TermMetaBankV3Entry>(this as TermMetaBankV3Entry, _$identity);

  /// Serializes this TermMetaBankV3Entry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermMetaBankV3Entry&&(identical(other.id, id) || other.id == id)&&(identical(other.indexEntry, indexEntry) || other.indexEntry == indexEntry)&&(identical(other.term, term) || other.term == term)&&(identical(other.type, type) || other.type == type)&&(identical(other.reading, reading) || other.reading == reading)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.frequencyDisplayValue, frequencyDisplayValue) || other.frequencyDisplayValue == frequencyDisplayValue)&&const DeepCollectionEquality().equals(other.pitchs, pitchs)&&const DeepCollectionEquality().equals(other.ipas, ipas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,indexEntry,term,type,reading,frequency,frequencyDisplayValue,const DeepCollectionEquality().hash(pitchs),const DeepCollectionEquality().hash(ipas));

@override
String toString() {
  return 'TermMetaBankV3Entry(id: $id, indexEntry: $indexEntry, term: $term, type: $type, reading: $reading, frequency: $frequency, frequencyDisplayValue: $frequencyDisplayValue, pitchs: $pitchs, ipas: $ipas)';
}


}

/// @nodoc
abstract mixin class $TermMetaBankV3EntryCopyWith<$Res>  {
  factory $TermMetaBankV3EntryCopyWith(TermMetaBankV3Entry value, $Res Function(TermMetaBankV3Entry) _then) = _$TermMetaBankV3EntryCopyWithImpl;
@useResult
$Res call({
 int id,@IndexEntryJsonConverter() IndexEntry indexEntry, String term, String type, String? reading, int? frequency, String? frequencyDisplayValue, List<TermMetaBankV3PitchEntry> pitchs, List<TermMetaBankV3IpaEntry> ipas
});


$IndexEntryCopyWith<$Res> get indexEntry;

}
/// @nodoc
class _$TermMetaBankV3EntryCopyWithImpl<$Res>
    implements $TermMetaBankV3EntryCopyWith<$Res> {
  _$TermMetaBankV3EntryCopyWithImpl(this._self, this._then);

  final TermMetaBankV3Entry _self;
  final $Res Function(TermMetaBankV3Entry) _then;

/// Create a copy of TermMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? indexEntry = null,Object? term = null,Object? type = null,Object? reading = freezed,Object? frequency = freezed,Object? frequencyDisplayValue = freezed,Object? pitchs = null,Object? ipas = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,indexEntry: null == indexEntry ? _self.indexEntry : indexEntry // ignore: cast_nullable_to_non_nullable
as IndexEntry,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as int?,frequencyDisplayValue: freezed == frequencyDisplayValue ? _self.frequencyDisplayValue : frequencyDisplayValue // ignore: cast_nullable_to_non_nullable
as String?,pitchs: null == pitchs ? _self.pitchs : pitchs // ignore: cast_nullable_to_non_nullable
as List<TermMetaBankV3PitchEntry>,ipas: null == ipas ? _self.ipas : ipas // ignore: cast_nullable_to_non_nullable
as List<TermMetaBankV3IpaEntry>,
  ));
}
/// Create a copy of TermMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndexEntryCopyWith<$Res> get indexEntry {
  
  return $IndexEntryCopyWith<$Res>(_self.indexEntry, (value) {
    return _then(_self.copyWith(indexEntry: value));
  });
}
}


/// Adds pattern-matching-related methods to [TermMetaBankV3Entry].
extension TermMetaBankV3EntryPatterns on TermMetaBankV3Entry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TermMetaBankV3Entry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TermMetaBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TermMetaBankV3Entry value)  $default,){
final _that = this;
switch (_that) {
case _TermMetaBankV3Entry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TermMetaBankV3Entry value)?  $default,){
final _that = this;
switch (_that) {
case _TermMetaBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @IndexEntryJsonConverter()  IndexEntry indexEntry,  String term,  String type,  String? reading,  int? frequency,  String? frequencyDisplayValue,  List<TermMetaBankV3PitchEntry> pitchs,  List<TermMetaBankV3IpaEntry> ipas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TermMetaBankV3Entry() when $default != null:
return $default(_that.id,_that.indexEntry,_that.term,_that.type,_that.reading,_that.frequency,_that.frequencyDisplayValue,_that.pitchs,_that.ipas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @IndexEntryJsonConverter()  IndexEntry indexEntry,  String term,  String type,  String? reading,  int? frequency,  String? frequencyDisplayValue,  List<TermMetaBankV3PitchEntry> pitchs,  List<TermMetaBankV3IpaEntry> ipas)  $default,) {final _that = this;
switch (_that) {
case _TermMetaBankV3Entry():
return $default(_that.id,_that.indexEntry,_that.term,_that.type,_that.reading,_that.frequency,_that.frequencyDisplayValue,_that.pitchs,_that.ipas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @IndexEntryJsonConverter()  IndexEntry indexEntry,  String term,  String type,  String? reading,  int? frequency,  String? frequencyDisplayValue,  List<TermMetaBankV3PitchEntry> pitchs,  List<TermMetaBankV3IpaEntry> ipas)?  $default,) {final _that = this;
switch (_that) {
case _TermMetaBankV3Entry() when $default != null:
return $default(_that.id,_that.indexEntry,_that.term,_that.type,_that.reading,_that.frequency,_that.frequencyDisplayValue,_that.pitchs,_that.ipas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TermMetaBankV3Entry implements TermMetaBankV3Entry {
  const _TermMetaBankV3Entry({required this.id, @IndexEntryJsonConverter() required this.indexEntry, required this.term, required this.type, this.reading, this.frequency, this.frequencyDisplayValue, required this.pitchs, required this.ipas});
  factory _TermMetaBankV3Entry.fromJson(Map<String, dynamic> json) => _$TermMetaBankV3EntryFromJson(json);

/// The id of this entry in the sqlite database
@override final  int id;
/// The index (dictionary) in which this entry was found
@override@IndexEntryJsonConverter() final  IndexEntry indexEntry;
/// The term of this entry
@override final  String term;
/// The type of this entry
@override final  String type;
/// The reading of this entry
@override final  String? reading;
/// the frequency of this entry as a numeric value
@override final  int? frequency;
/// the frequency of this entry as a string for displaying
@override final  String? frequencyDisplayValue;
/// Pitch data of this entry
@override final  List<TermMetaBankV3PitchEntry> pitchs;
/// Ipa transcription data of this entry
@override final  List<TermMetaBankV3IpaEntry> ipas;

/// Create a copy of TermMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermMetaBankV3EntryCopyWith<_TermMetaBankV3Entry> get copyWith => __$TermMetaBankV3EntryCopyWithImpl<_TermMetaBankV3Entry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermMetaBankV3EntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermMetaBankV3Entry&&(identical(other.id, id) || other.id == id)&&(identical(other.indexEntry, indexEntry) || other.indexEntry == indexEntry)&&(identical(other.term, term) || other.term == term)&&(identical(other.type, type) || other.type == type)&&(identical(other.reading, reading) || other.reading == reading)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.frequencyDisplayValue, frequencyDisplayValue) || other.frequencyDisplayValue == frequencyDisplayValue)&&const DeepCollectionEquality().equals(other.pitchs, pitchs)&&const DeepCollectionEquality().equals(other.ipas, ipas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,indexEntry,term,type,reading,frequency,frequencyDisplayValue,const DeepCollectionEquality().hash(pitchs),const DeepCollectionEquality().hash(ipas));

@override
String toString() {
  return 'TermMetaBankV3Entry(id: $id, indexEntry: $indexEntry, term: $term, type: $type, reading: $reading, frequency: $frequency, frequencyDisplayValue: $frequencyDisplayValue, pitchs: $pitchs, ipas: $ipas)';
}


}

/// @nodoc
abstract mixin class _$TermMetaBankV3EntryCopyWith<$Res> implements $TermMetaBankV3EntryCopyWith<$Res> {
  factory _$TermMetaBankV3EntryCopyWith(_TermMetaBankV3Entry value, $Res Function(_TermMetaBankV3Entry) _then) = __$TermMetaBankV3EntryCopyWithImpl;
@override @useResult
$Res call({
 int id,@IndexEntryJsonConverter() IndexEntry indexEntry, String term, String type, String? reading, int? frequency, String? frequencyDisplayValue, List<TermMetaBankV3PitchEntry> pitchs, List<TermMetaBankV3IpaEntry> ipas
});


@override $IndexEntryCopyWith<$Res> get indexEntry;

}
/// @nodoc
class __$TermMetaBankV3EntryCopyWithImpl<$Res>
    implements _$TermMetaBankV3EntryCopyWith<$Res> {
  __$TermMetaBankV3EntryCopyWithImpl(this._self, this._then);

  final _TermMetaBankV3Entry _self;
  final $Res Function(_TermMetaBankV3Entry) _then;

/// Create a copy of TermMetaBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? indexEntry = null,Object? term = null,Object? type = null,Object? reading = freezed,Object? frequency = freezed,Object? frequencyDisplayValue = freezed,Object? pitchs = null,Object? ipas = null,}) {
  return _then(_TermMetaBankV3Entry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,indexEntry: null == indexEntry ? _self.indexEntry : indexEntry // ignore: cast_nullable_to_non_nullable
as IndexEntry,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,reading: freezed == reading ? _self.reading : reading // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as int?,frequencyDisplayValue: freezed == frequencyDisplayValue ? _self.frequencyDisplayValue : frequencyDisplayValue // ignore: cast_nullable_to_non_nullable
as String?,pitchs: null == pitchs ? _self.pitchs : pitchs // ignore: cast_nullable_to_non_nullable
as List<TermMetaBankV3PitchEntry>,ipas: null == ipas ? _self.ipas : ipas // ignore: cast_nullable_to_non_nullable
as List<TermMetaBankV3IpaEntry>,
  ));
}

/// Create a copy of TermMetaBankV3Entry
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
