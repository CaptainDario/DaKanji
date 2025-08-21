// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_bank_v3_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TagBankV3Entry {

/// Tag name.
 String get name;/// Categories for the tag.
 String get category;/// Sorting order for the tag.
 int get sortingOrder;/// Notes for the tag.
 String get notes;/// Score used to determine popularity. Negative values are more rare and
/// positive values are more frequent. This score is also used to sort search
/// results.
 int get score;
/// Create a copy of TagBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagBankV3EntryCopyWith<TagBankV3Entry> get copyWith => _$TagBankV3EntryCopyWithImpl<TagBankV3Entry>(this as TagBankV3Entry, _$identity);

  /// Serializes this TagBankV3Entry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagBankV3Entry&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.sortingOrder, sortingOrder) || other.sortingOrder == sortingOrder)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,category,sortingOrder,notes,score);

@override
String toString() {
  return 'TagBankV3Entry(name: $name, category: $category, sortingOrder: $sortingOrder, notes: $notes, score: $score)';
}


}

/// @nodoc
abstract mixin class $TagBankV3EntryCopyWith<$Res>  {
  factory $TagBankV3EntryCopyWith(TagBankV3Entry value, $Res Function(TagBankV3Entry) _then) = _$TagBankV3EntryCopyWithImpl;
@useResult
$Res call({
 String name, String category, int sortingOrder, String notes, int score
});




}
/// @nodoc
class _$TagBankV3EntryCopyWithImpl<$Res>
    implements $TagBankV3EntryCopyWith<$Res> {
  _$TagBankV3EntryCopyWithImpl(this._self, this._then);

  final TagBankV3Entry _self;
  final $Res Function(TagBankV3Entry) _then;

/// Create a copy of TagBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? category = null,Object? sortingOrder = null,Object? notes = null,Object? score = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,sortingOrder: null == sortingOrder ? _self.sortingOrder : sortingOrder // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TagBankV3Entry].
extension TagBankV3EntryPatterns on TagBankV3Entry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagBankV3Entry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagBankV3Entry value)  $default,){
final _that = this;
switch (_that) {
case _TagBankV3Entry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagBankV3Entry value)?  $default,){
final _that = this;
switch (_that) {
case _TagBankV3Entry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String category,  int sortingOrder,  String notes,  int score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagBankV3Entry() when $default != null:
return $default(_that.name,_that.category,_that.sortingOrder,_that.notes,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String category,  int sortingOrder,  String notes,  int score)  $default,) {final _that = this;
switch (_that) {
case _TagBankV3Entry():
return $default(_that.name,_that.category,_that.sortingOrder,_that.notes,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String category,  int sortingOrder,  String notes,  int score)?  $default,) {final _that = this;
switch (_that) {
case _TagBankV3Entry() when $default != null:
return $default(_that.name,_that.category,_that.sortingOrder,_that.notes,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TagBankV3Entry implements TagBankV3Entry {
  const _TagBankV3Entry({required this.name, required this.category, required this.sortingOrder, required this.notes, required this.score});
  factory _TagBankV3Entry.fromJson(Map<String, dynamic> json) => _$TagBankV3EntryFromJson(json);

/// Tag name.
@override final  String name;
/// Categories for the tag.
@override final  String category;
/// Sorting order for the tag.
@override final  int sortingOrder;
/// Notes for the tag.
@override final  String notes;
/// Score used to determine popularity. Negative values are more rare and
/// positive values are more frequent. This score is also used to sort search
/// results.
@override final  int score;

/// Create a copy of TagBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagBankV3EntryCopyWith<_TagBankV3Entry> get copyWith => __$TagBankV3EntryCopyWithImpl<_TagBankV3Entry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagBankV3EntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagBankV3Entry&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.sortingOrder, sortingOrder) || other.sortingOrder == sortingOrder)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,category,sortingOrder,notes,score);

@override
String toString() {
  return 'TagBankV3Entry(name: $name, category: $category, sortingOrder: $sortingOrder, notes: $notes, score: $score)';
}


}

/// @nodoc
abstract mixin class _$TagBankV3EntryCopyWith<$Res> implements $TagBankV3EntryCopyWith<$Res> {
  factory _$TagBankV3EntryCopyWith(_TagBankV3Entry value, $Res Function(_TagBankV3Entry) _then) = __$TagBankV3EntryCopyWithImpl;
@override @useResult
$Res call({
 String name, String category, int sortingOrder, String notes, int score
});




}
/// @nodoc
class __$TagBankV3EntryCopyWithImpl<$Res>
    implements _$TagBankV3EntryCopyWith<$Res> {
  __$TagBankV3EntryCopyWithImpl(this._self, this._then);

  final _TagBankV3Entry _self;
  final $Res Function(_TagBankV3Entry) _then;

/// Create a copy of TagBankV3Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? category = null,Object? sortingOrder = null,Object? notes = null,Object? score = null,}) {
  return _then(_TagBankV3Entry(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,sortingOrder: null == sortingOrder ? _self.sortingOrder : sortingOrder // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
