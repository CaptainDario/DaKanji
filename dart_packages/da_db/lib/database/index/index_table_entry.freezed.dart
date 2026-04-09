// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'index_table_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IndexEntry {

 int get id; bool get isDefaultDictionary; bool get enabled; DictionaryTypes get dictionaryType; int get currentSortingOrder; bool get currentFrequencyDictionary; YomitanIndex get yomitanData;
/// Create a copy of IndexEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndexEntryCopyWith<IndexEntry> get copyWith => _$IndexEntryCopyWithImpl<IndexEntry>(this as IndexEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndexEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.isDefaultDictionary, isDefaultDictionary) || other.isDefaultDictionary == isDefaultDictionary)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.dictionaryType, dictionaryType) || other.dictionaryType == dictionaryType)&&(identical(other.currentSortingOrder, currentSortingOrder) || other.currentSortingOrder == currentSortingOrder)&&(identical(other.currentFrequencyDictionary, currentFrequencyDictionary) || other.currentFrequencyDictionary == currentFrequencyDictionary)&&(identical(other.yomitanData, yomitanData) || other.yomitanData == yomitanData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isDefaultDictionary,enabled,dictionaryType,currentSortingOrder,currentFrequencyDictionary,yomitanData);

@override
String toString() {
  return 'IndexEntry(id: $id, isDefaultDictionary: $isDefaultDictionary, enabled: $enabled, dictionaryType: $dictionaryType, currentSortingOrder: $currentSortingOrder, currentFrequencyDictionary: $currentFrequencyDictionary, yomitanData: $yomitanData)';
}


}

/// @nodoc
abstract mixin class $IndexEntryCopyWith<$Res>  {
  factory $IndexEntryCopyWith(IndexEntry value, $Res Function(IndexEntry) _then) = _$IndexEntryCopyWithImpl;
@useResult
$Res call({
 int id, bool isDefaultDictionary, bool enabled, DictionaryTypes dictionaryType, int currentSortingOrder, bool currentFrequencyDictionary, YomitanIndex yomitanData
});




}
/// @nodoc
class _$IndexEntryCopyWithImpl<$Res>
    implements $IndexEntryCopyWith<$Res> {
  _$IndexEntryCopyWithImpl(this._self, this._then);

  final IndexEntry _self;
  final $Res Function(IndexEntry) _then;

/// Create a copy of IndexEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? isDefaultDictionary = null,Object? enabled = null,Object? dictionaryType = null,Object? currentSortingOrder = null,Object? currentFrequencyDictionary = null,Object? yomitanData = null,}) {
  return _then(IndexEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,isDefaultDictionary: null == isDefaultDictionary ? _self.isDefaultDictionary : isDefaultDictionary // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,dictionaryType: null == dictionaryType ? _self.dictionaryType : dictionaryType // ignore: cast_nullable_to_non_nullable
as DictionaryTypes,currentSortingOrder: null == currentSortingOrder ? _self.currentSortingOrder : currentSortingOrder // ignore: cast_nullable_to_non_nullable
as int,currentFrequencyDictionary: null == currentFrequencyDictionary ? _self.currentFrequencyDictionary : currentFrequencyDictionary // ignore: cast_nullable_to_non_nullable
as bool,yomitanData: null == yomitanData ? _self.yomitanData : yomitanData // ignore: cast_nullable_to_non_nullable
as YomitanIndex,
  ));
}

}


/// Adds pattern-matching-related methods to [IndexEntry].
extension IndexEntryPatterns on IndexEntry {
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
