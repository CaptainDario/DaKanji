// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grouping_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SequenceGroupingRule {

 int? get sourceDictId; Set<int> get targetDictIds;
/// Create a copy of SequenceGroupingRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SequenceGroupingRuleCopyWith<SequenceGroupingRule> get copyWith => _$SequenceGroupingRuleCopyWithImpl<SequenceGroupingRule>(this as SequenceGroupingRule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SequenceGroupingRule&&(identical(other.sourceDictId, sourceDictId) || other.sourceDictId == sourceDictId)&&const DeepCollectionEquality().equals(other.targetDictIds, targetDictIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceDictId,const DeepCollectionEquality().hash(targetDictIds));

@override
String toString() {
  return 'SequenceGroupingRule(sourceDictId: $sourceDictId, targetDictIds: $targetDictIds)';
}


}

/// @nodoc
abstract mixin class $SequenceGroupingRuleCopyWith<$Res>  {
  factory $SequenceGroupingRuleCopyWith(SequenceGroupingRule value, $Res Function(SequenceGroupingRule) _then) = _$SequenceGroupingRuleCopyWithImpl;
@useResult
$Res call({
 int? sourceDictId, Set<int> targetDictIds
});




}
/// @nodoc
class _$SequenceGroupingRuleCopyWithImpl<$Res>
    implements $SequenceGroupingRuleCopyWith<$Res> {
  _$SequenceGroupingRuleCopyWithImpl(this._self, this._then);

  final SequenceGroupingRule _self;
  final $Res Function(SequenceGroupingRule) _then;

/// Create a copy of SequenceGroupingRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceDictId = freezed,Object? targetDictIds = null,}) {
  return _then(SequenceGroupingRule(
sourceDictId: freezed == sourceDictId ? _self.sourceDictId : sourceDictId // ignore: cast_nullable_to_non_nullable
as int?,targetDictIds: null == targetDictIds ? _self.targetDictIds : targetDictIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [SequenceGroupingRule].
extension SequenceGroupingRulePatterns on SequenceGroupingRule {
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


/// @nodoc
mixin _$TermAndReadingGroupingRule {

 Set<int> get targetDictIds;
/// Create a copy of TermAndReadingGroupingRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermAndReadingGroupingRuleCopyWith<TermAndReadingGroupingRule> get copyWith => _$TermAndReadingGroupingRuleCopyWithImpl<TermAndReadingGroupingRule>(this as TermAndReadingGroupingRule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermAndReadingGroupingRule&&const DeepCollectionEquality().equals(other.targetDictIds, targetDictIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(targetDictIds));

@override
String toString() {
  return 'TermAndReadingGroupingRule(targetDictIds: $targetDictIds)';
}


}

/// @nodoc
abstract mixin class $TermAndReadingGroupingRuleCopyWith<$Res>  {
  factory $TermAndReadingGroupingRuleCopyWith(TermAndReadingGroupingRule value, $Res Function(TermAndReadingGroupingRule) _then) = _$TermAndReadingGroupingRuleCopyWithImpl;
@useResult
$Res call({
 Set<int> targetDictIds
});




}
/// @nodoc
class _$TermAndReadingGroupingRuleCopyWithImpl<$Res>
    implements $TermAndReadingGroupingRuleCopyWith<$Res> {
  _$TermAndReadingGroupingRuleCopyWithImpl(this._self, this._then);

  final TermAndReadingGroupingRule _self;
  final $Res Function(TermAndReadingGroupingRule) _then;

/// Create a copy of TermAndReadingGroupingRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetDictIds = null,}) {
  return _then(TermAndReadingGroupingRule(
null == targetDictIds ? _self.targetDictIds : targetDictIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [TermAndReadingGroupingRule].
extension TermAndReadingGroupingRulePatterns on TermAndReadingGroupingRule {
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


/// @nodoc
mixin _$TermGroupingRule {

 Set<int> get targetDictIds;
/// Create a copy of TermGroupingRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermGroupingRuleCopyWith<TermGroupingRule> get copyWith => _$TermGroupingRuleCopyWithImpl<TermGroupingRule>(this as TermGroupingRule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermGroupingRule&&const DeepCollectionEquality().equals(other.targetDictIds, targetDictIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(targetDictIds));

@override
String toString() {
  return 'TermGroupingRule(targetDictIds: $targetDictIds)';
}


}

/// @nodoc
abstract mixin class $TermGroupingRuleCopyWith<$Res>  {
  factory $TermGroupingRuleCopyWith(TermGroupingRule value, $Res Function(TermGroupingRule) _then) = _$TermGroupingRuleCopyWithImpl;
@useResult
$Res call({
 Set<int> targetDictIds
});




}
/// @nodoc
class _$TermGroupingRuleCopyWithImpl<$Res>
    implements $TermGroupingRuleCopyWith<$Res> {
  _$TermGroupingRuleCopyWithImpl(this._self, this._then);

  final TermGroupingRule _self;
  final $Res Function(TermGroupingRule) _then;

/// Create a copy of TermGroupingRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetDictIds = null,}) {
  return _then(TermGroupingRule(
null == targetDictIds ? _self.targetDictIds : targetDictIds // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [TermGroupingRule].
extension TermGroupingRulePatterns on TermGroupingRule {
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


/// @nodoc
mixin _$NoGroupingRule {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoGroupingRule);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoGroupingRule()';
}


}

/// @nodoc
class $NoGroupingRuleCopyWith<$Res>  {
$NoGroupingRuleCopyWith(NoGroupingRule _, $Res Function(NoGroupingRule) __);
}


/// Adds pattern-matching-related methods to [NoGroupingRule].
extension NoGroupingRulePatterns on NoGroupingRule {
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
