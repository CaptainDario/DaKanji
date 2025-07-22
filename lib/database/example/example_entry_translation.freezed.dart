// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_entry_translation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExampleEntryTranslation {

/// The example's translation
 String get translation;/// Language code of the language of this translation
 String get languageCode;
/// Create a copy of ExampleEntryTranslation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleEntryTranslationCopyWith<ExampleEntryTranslation> get copyWith => _$ExampleEntryTranslationCopyWithImpl<ExampleEntryTranslation>(this as ExampleEntryTranslation, _$identity);

  /// Serializes this ExampleEntryTranslation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleEntryTranslation&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,languageCode);

@override
String toString() {
  return 'ExampleEntryTranslation(translation: $translation, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $ExampleEntryTranslationCopyWith<$Res>  {
  factory $ExampleEntryTranslationCopyWith(ExampleEntryTranslation value, $Res Function(ExampleEntryTranslation) _then) = _$ExampleEntryTranslationCopyWithImpl;
@useResult
$Res call({
 String translation, String languageCode
});




}
/// @nodoc
class _$ExampleEntryTranslationCopyWithImpl<$Res>
    implements $ExampleEntryTranslationCopyWith<$Res> {
  _$ExampleEntryTranslationCopyWithImpl(this._self, this._then);

  final ExampleEntryTranslation _self;
  final $Res Function(ExampleEntryTranslation) _then;

/// Create a copy of ExampleEntryTranslation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? languageCode = null,}) {
  return _then(_self.copyWith(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExampleEntryTranslation].
extension ExampleEntryTranslationPatterns on ExampleEntryTranslation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExampleEntryTranslation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExampleEntryTranslation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExampleEntryTranslation value)  $default,){
final _that = this;
switch (_that) {
case _ExampleEntryTranslation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExampleEntryTranslation value)?  $default,){
final _that = this;
switch (_that) {
case _ExampleEntryTranslation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String translation,  String languageCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExampleEntryTranslation() when $default != null:
return $default(_that.translation,_that.languageCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String translation,  String languageCode)  $default,) {final _that = this;
switch (_that) {
case _ExampleEntryTranslation():
return $default(_that.translation,_that.languageCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String translation,  String languageCode)?  $default,) {final _that = this;
switch (_that) {
case _ExampleEntryTranslation() when $default != null:
return $default(_that.translation,_that.languageCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExampleEntryTranslation implements ExampleEntryTranslation {
  const _ExampleEntryTranslation({required this.translation, required this.languageCode});
  factory _ExampleEntryTranslation.fromJson(Map<String, dynamic> json) => _$ExampleEntryTranslationFromJson(json);

/// The example's translation
@override final  String translation;
/// Language code of the language of this translation
@override final  String languageCode;

/// Create a copy of ExampleEntryTranslation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleEntryTranslationCopyWith<_ExampleEntryTranslation> get copyWith => __$ExampleEntryTranslationCopyWithImpl<_ExampleEntryTranslation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExampleEntryTranslationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleEntryTranslation&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,languageCode);

@override
String toString() {
  return 'ExampleEntryTranslation(translation: $translation, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class _$ExampleEntryTranslationCopyWith<$Res> implements $ExampleEntryTranslationCopyWith<$Res> {
  factory _$ExampleEntryTranslationCopyWith(_ExampleEntryTranslation value, $Res Function(_ExampleEntryTranslation) _then) = __$ExampleEntryTranslationCopyWithImpl;
@override @useResult
$Res call({
 String translation, String languageCode
});




}
/// @nodoc
class __$ExampleEntryTranslationCopyWithImpl<$Res>
    implements _$ExampleEntryTranslationCopyWith<$Res> {
  __$ExampleEntryTranslationCopyWithImpl(this._self, this._then);

  final _ExampleEntryTranslation _self;
  final $Res Function(_ExampleEntryTranslation) _then;

/// Create a copy of ExampleEntryTranslation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? languageCode = null,}) {
  return _then(_ExampleEntryTranslation(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
