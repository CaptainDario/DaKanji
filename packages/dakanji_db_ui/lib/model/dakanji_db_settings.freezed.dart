// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dakanji_db_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DaKanjiDbSettingsInternal _$DaKanjiDbSettingsInternalFromJson(
  Map<String, dynamic> json
) {
    return _DaKanjiDbSettings.fromJson(
      json
    );
}

/// @nodoc
mixin _$DaKanjiDbSettingsInternal {

/// 1st level sort order for search results.
/// If an entry of [DaKanjiDbSearch1stSortOrder] is not included here, it
/// will not be searched for.
/// 
/// Default is:
/// - queryMatch
/// - normalizedMatch
/// - deconjugationMatch
/// - spellfixMatch
 List<(DakanjiDbSearchResult1stSortOrder, bool)> get firstSortOrder;/// 2nd level sort order for search results.
/// If an entry of [DakanjiDbSearchResult2ndSortOrder] is not included here, it
/// will not be searched for.
/// 
/// Default is:
/// - exactMatch
/// - prefixMatch
/// - subwordMatch
/// - wildcardMatch
 List<(DakanjiDbSearchResult2ndSortOrder, bool)> get secondSortOrder;/// Whether to convert romaji to hiragana in normalized searches.
 bool get normalizeSearchConvertsRomajiToHiragana;/// The grouping rules to apply to the search.
 List<DictionaryGroupingRule> get groupingRules;/// Whether to show the separation headers such as "Exact Matches",
/// "Prefix Matches", etc.
 bool get showSearchResultSeparationHeaders;/// Whether to show tags in [DictionaryMatchWidget]s.
 bool get showTags;/// Whether to show meta entries in [DictionaryMatchWidget]s.
 bool get showMetaEntries;/// Maximum height for compact definitions.
 double get definitionsMaxHeight;/// Whether to use katakana for furigana instead of hiragana.
 bool get useKatakanaForFurigana;/// Maximum number of results to return when search (does apply to each 
/// of the four independent searches **separately**).
 int get searchResultLimit;
/// Create a copy of DaKanjiDbSettingsInternal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DaKanjiDbSettingsInternalCopyWith<DaKanjiDbSettingsInternal> get copyWith => _$DaKanjiDbSettingsInternalCopyWithImpl<DaKanjiDbSettingsInternal>(this as DaKanjiDbSettingsInternal, _$identity);

  /// Serializes this DaKanjiDbSettingsInternal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DaKanjiDbSettingsInternal&&const DeepCollectionEquality().equals(other.firstSortOrder, firstSortOrder)&&const DeepCollectionEquality().equals(other.secondSortOrder, secondSortOrder)&&(identical(other.normalizeSearchConvertsRomajiToHiragana, normalizeSearchConvertsRomajiToHiragana) || other.normalizeSearchConvertsRomajiToHiragana == normalizeSearchConvertsRomajiToHiragana)&&const DeepCollectionEquality().equals(other.groupingRules, groupingRules)&&(identical(other.showSearchResultSeparationHeaders, showSearchResultSeparationHeaders) || other.showSearchResultSeparationHeaders == showSearchResultSeparationHeaders)&&(identical(other.showTags, showTags) || other.showTags == showTags)&&(identical(other.showMetaEntries, showMetaEntries) || other.showMetaEntries == showMetaEntries)&&(identical(other.definitionsMaxHeight, definitionsMaxHeight) || other.definitionsMaxHeight == definitionsMaxHeight)&&(identical(other.useKatakanaForFurigana, useKatakanaForFurigana) || other.useKatakanaForFurigana == useKatakanaForFurigana)&&(identical(other.searchResultLimit, searchResultLimit) || other.searchResultLimit == searchResultLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(firstSortOrder),const DeepCollectionEquality().hash(secondSortOrder),normalizeSearchConvertsRomajiToHiragana,const DeepCollectionEquality().hash(groupingRules),showSearchResultSeparationHeaders,showTags,showMetaEntries,definitionsMaxHeight,useKatakanaForFurigana,searchResultLimit);

@override
String toString() {
  return 'DaKanjiDbSettingsInternal(firstSortOrder: $firstSortOrder, secondSortOrder: $secondSortOrder, normalizeSearchConvertsRomajiToHiragana: $normalizeSearchConvertsRomajiToHiragana, groupingRules: $groupingRules, showSearchResultSeparationHeaders: $showSearchResultSeparationHeaders, showTags: $showTags, showMetaEntries: $showMetaEntries, definitionsMaxHeight: $definitionsMaxHeight, useKatakanaForFurigana: $useKatakanaForFurigana, searchResultLimit: $searchResultLimit)';
}


}

/// @nodoc
abstract mixin class $DaKanjiDbSettingsInternalCopyWith<$Res>  {
  factory $DaKanjiDbSettingsInternalCopyWith(DaKanjiDbSettingsInternal value, $Res Function(DaKanjiDbSettingsInternal) _then) = _$DaKanjiDbSettingsInternalCopyWithImpl;
@useResult
$Res call({
 List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder, List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder, bool normalizeSearchConvertsRomajiToHiragana, List<DictionaryGroupingRule> groupingRules, bool showSearchResultSeparationHeaders, bool showTags, bool showMetaEntries, double definitionsMaxHeight, bool useKatakanaForFurigana, int searchResultLimit
});




}
/// @nodoc
class _$DaKanjiDbSettingsInternalCopyWithImpl<$Res>
    implements $DaKanjiDbSettingsInternalCopyWith<$Res> {
  _$DaKanjiDbSettingsInternalCopyWithImpl(this._self, this._then);

  final DaKanjiDbSettingsInternal _self;
  final $Res Function(DaKanjiDbSettingsInternal) _then;

/// Create a copy of DaKanjiDbSettingsInternal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstSortOrder = null,Object? secondSortOrder = null,Object? normalizeSearchConvertsRomajiToHiragana = null,Object? groupingRules = null,Object? showSearchResultSeparationHeaders = null,Object? showTags = null,Object? showMetaEntries = null,Object? definitionsMaxHeight = null,Object? useKatakanaForFurigana = null,Object? searchResultLimit = null,}) {
  return _then(_self.copyWith(
firstSortOrder: null == firstSortOrder ? _self.firstSortOrder : firstSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult1stSortOrder, bool)>,secondSortOrder: null == secondSortOrder ? _self.secondSortOrder : secondSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult2ndSortOrder, bool)>,normalizeSearchConvertsRomajiToHiragana: null == normalizeSearchConvertsRomajiToHiragana ? _self.normalizeSearchConvertsRomajiToHiragana : normalizeSearchConvertsRomajiToHiragana // ignore: cast_nullable_to_non_nullable
as bool,groupingRules: null == groupingRules ? _self.groupingRules : groupingRules // ignore: cast_nullable_to_non_nullable
as List<DictionaryGroupingRule>,showSearchResultSeparationHeaders: null == showSearchResultSeparationHeaders ? _self.showSearchResultSeparationHeaders : showSearchResultSeparationHeaders // ignore: cast_nullable_to_non_nullable
as bool,showTags: null == showTags ? _self.showTags : showTags // ignore: cast_nullable_to_non_nullable
as bool,showMetaEntries: null == showMetaEntries ? _self.showMetaEntries : showMetaEntries // ignore: cast_nullable_to_non_nullable
as bool,definitionsMaxHeight: null == definitionsMaxHeight ? _self.definitionsMaxHeight : definitionsMaxHeight // ignore: cast_nullable_to_non_nullable
as double,useKatakanaForFurigana: null == useKatakanaForFurigana ? _self.useKatakanaForFurigana : useKatakanaForFurigana // ignore: cast_nullable_to_non_nullable
as bool,searchResultLimit: null == searchResultLimit ? _self.searchResultLimit : searchResultLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DaKanjiDbSettingsInternal].
extension DaKanjiDbSettingsInternalPatterns on DaKanjiDbSettingsInternal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DaKanjiDbSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DaKanjiDbSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DaKanjiDbSettings value)  $default,){
final _that = this;
switch (_that) {
case _DaKanjiDbSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DaKanjiDbSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DaKanjiDbSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,  bool normalizeSearchConvertsRomajiToHiragana,  List<DictionaryGroupingRule> groupingRules,  bool showSearchResultSeparationHeaders,  bool showTags,  bool showMetaEntries,  double definitionsMaxHeight,  bool useKatakanaForFurigana,  int searchResultLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DaKanjiDbSettings() when $default != null:
return $default(_that.firstSortOrder,_that.secondSortOrder,_that.normalizeSearchConvertsRomajiToHiragana,_that.groupingRules,_that.showSearchResultSeparationHeaders,_that.showTags,_that.showMetaEntries,_that.definitionsMaxHeight,_that.useKatakanaForFurigana,_that.searchResultLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,  bool normalizeSearchConvertsRomajiToHiragana,  List<DictionaryGroupingRule> groupingRules,  bool showSearchResultSeparationHeaders,  bool showTags,  bool showMetaEntries,  double definitionsMaxHeight,  bool useKatakanaForFurigana,  int searchResultLimit)  $default,) {final _that = this;
switch (_that) {
case _DaKanjiDbSettings():
return $default(_that.firstSortOrder,_that.secondSortOrder,_that.normalizeSearchConvertsRomajiToHiragana,_that.groupingRules,_that.showSearchResultSeparationHeaders,_that.showTags,_that.showMetaEntries,_that.definitionsMaxHeight,_that.useKatakanaForFurigana,_that.searchResultLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,  bool normalizeSearchConvertsRomajiToHiragana,  List<DictionaryGroupingRule> groupingRules,  bool showSearchResultSeparationHeaders,  bool showTags,  bool showMetaEntries,  double definitionsMaxHeight,  bool useKatakanaForFurigana,  int searchResultLimit)?  $default,) {final _that = this;
switch (_that) {
case _DaKanjiDbSettings() when $default != null:
return $default(_that.firstSortOrder,_that.secondSortOrder,_that.normalizeSearchConvertsRomajiToHiragana,_that.groupingRules,_that.showSearchResultSeparationHeaders,_that.showTags,_that.showMetaEntries,_that.definitionsMaxHeight,_that.useKatakanaForFurigana,_that.searchResultLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DaKanjiDbSettings extends DaKanjiDbSettingsInternal {
  const _DaKanjiDbSettings({final  List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder = const [(DakanjiDbSearchResult1stSortOrder.queryMatch, true), (DakanjiDbSearchResult1stSortOrder.normalizedMatch, true), (DakanjiDbSearchResult1stSortOrder.deconjugationMatch, true), (DakanjiDbSearchResult1stSortOrder.spellfixMatch, true)], final  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder = const [(DakanjiDbSearchResult2ndSortOrder.exactMatch, true), (DakanjiDbSearchResult2ndSortOrder.prefixMatch, true), (DakanjiDbSearchResult2ndSortOrder.subwordMatch, true), (DakanjiDbSearchResult2ndSortOrder.wildcardMatch, true)], this.normalizeSearchConvertsRomajiToHiragana = true, final  List<DictionaryGroupingRule> groupingRules = const [], this.showSearchResultSeparationHeaders = true, this.showTags = true, this.showMetaEntries = true, this.definitionsMaxHeight = 60.0, this.useKatakanaForFurigana = false, this.searchResultLimit = 100}): _firstSortOrder = firstSortOrder,_secondSortOrder = secondSortOrder,_groupingRules = groupingRules,super._();
  factory _DaKanjiDbSettings.fromJson(Map<String, dynamic> json) => _$DaKanjiDbSettingsFromJson(json);

/// 1st level sort order for search results.
/// If an entry of [DaKanjiDbSearch1stSortOrder] is not included here, it
/// will not be searched for.
/// 
/// Default is:
/// - queryMatch
/// - normalizedMatch
/// - deconjugationMatch
/// - spellfixMatch
 final  List<(DakanjiDbSearchResult1stSortOrder, bool)> _firstSortOrder;
/// 1st level sort order for search results.
/// If an entry of [DaKanjiDbSearch1stSortOrder] is not included here, it
/// will not be searched for.
/// 
/// Default is:
/// - queryMatch
/// - normalizedMatch
/// - deconjugationMatch
/// - spellfixMatch
@override@JsonKey() List<(DakanjiDbSearchResult1stSortOrder, bool)> get firstSortOrder {
  if (_firstSortOrder is EqualUnmodifiableListView) return _firstSortOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_firstSortOrder);
}

/// 2nd level sort order for search results.
/// If an entry of [DakanjiDbSearchResult2ndSortOrder] is not included here, it
/// will not be searched for.
/// 
/// Default is:
/// - exactMatch
/// - prefixMatch
/// - subwordMatch
/// - wildcardMatch
 final  List<(DakanjiDbSearchResult2ndSortOrder, bool)> _secondSortOrder;
/// 2nd level sort order for search results.
/// If an entry of [DakanjiDbSearchResult2ndSortOrder] is not included here, it
/// will not be searched for.
/// 
/// Default is:
/// - exactMatch
/// - prefixMatch
/// - subwordMatch
/// - wildcardMatch
@override@JsonKey() List<(DakanjiDbSearchResult2ndSortOrder, bool)> get secondSortOrder {
  if (_secondSortOrder is EqualUnmodifiableListView) return _secondSortOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondSortOrder);
}

/// Whether to convert romaji to hiragana in normalized searches.
@override@JsonKey() final  bool normalizeSearchConvertsRomajiToHiragana;
/// The grouping rules to apply to the search.
 final  List<DictionaryGroupingRule> _groupingRules;
/// The grouping rules to apply to the search.
@override@JsonKey() List<DictionaryGroupingRule> get groupingRules {
  if (_groupingRules is EqualUnmodifiableListView) return _groupingRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupingRules);
}

/// Whether to show the separation headers such as "Exact Matches",
/// "Prefix Matches", etc.
@override@JsonKey() final  bool showSearchResultSeparationHeaders;
/// Whether to show tags in [DictionaryMatchWidget]s.
@override@JsonKey() final  bool showTags;
/// Whether to show meta entries in [DictionaryMatchWidget]s.
@override@JsonKey() final  bool showMetaEntries;
/// Maximum height for compact definitions.
@override@JsonKey() final  double definitionsMaxHeight;
/// Whether to use katakana for furigana instead of hiragana.
@override@JsonKey() final  bool useKatakanaForFurigana;
/// Maximum number of results to return when search (does apply to each 
/// of the four independent searches **separately**).
@override@JsonKey() final  int searchResultLimit;

/// Create a copy of DaKanjiDbSettingsInternal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DaKanjiDbSettingsCopyWith<_DaKanjiDbSettings> get copyWith => __$DaKanjiDbSettingsCopyWithImpl<_DaKanjiDbSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DaKanjiDbSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DaKanjiDbSettings&&const DeepCollectionEquality().equals(other._firstSortOrder, _firstSortOrder)&&const DeepCollectionEquality().equals(other._secondSortOrder, _secondSortOrder)&&(identical(other.normalizeSearchConvertsRomajiToHiragana, normalizeSearchConvertsRomajiToHiragana) || other.normalizeSearchConvertsRomajiToHiragana == normalizeSearchConvertsRomajiToHiragana)&&const DeepCollectionEquality().equals(other._groupingRules, _groupingRules)&&(identical(other.showSearchResultSeparationHeaders, showSearchResultSeparationHeaders) || other.showSearchResultSeparationHeaders == showSearchResultSeparationHeaders)&&(identical(other.showTags, showTags) || other.showTags == showTags)&&(identical(other.showMetaEntries, showMetaEntries) || other.showMetaEntries == showMetaEntries)&&(identical(other.definitionsMaxHeight, definitionsMaxHeight) || other.definitionsMaxHeight == definitionsMaxHeight)&&(identical(other.useKatakanaForFurigana, useKatakanaForFurigana) || other.useKatakanaForFurigana == useKatakanaForFurigana)&&(identical(other.searchResultLimit, searchResultLimit) || other.searchResultLimit == searchResultLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_firstSortOrder),const DeepCollectionEquality().hash(_secondSortOrder),normalizeSearchConvertsRomajiToHiragana,const DeepCollectionEquality().hash(_groupingRules),showSearchResultSeparationHeaders,showTags,showMetaEntries,definitionsMaxHeight,useKatakanaForFurigana,searchResultLimit);

@override
String toString() {
  return 'DaKanjiDbSettingsInternal(firstSortOrder: $firstSortOrder, secondSortOrder: $secondSortOrder, normalizeSearchConvertsRomajiToHiragana: $normalizeSearchConvertsRomajiToHiragana, groupingRules: $groupingRules, showSearchResultSeparationHeaders: $showSearchResultSeparationHeaders, showTags: $showTags, showMetaEntries: $showMetaEntries, definitionsMaxHeight: $definitionsMaxHeight, useKatakanaForFurigana: $useKatakanaForFurigana, searchResultLimit: $searchResultLimit)';
}


}

/// @nodoc
abstract mixin class _$DaKanjiDbSettingsCopyWith<$Res> implements $DaKanjiDbSettingsInternalCopyWith<$Res> {
  factory _$DaKanjiDbSettingsCopyWith(_DaKanjiDbSettings value, $Res Function(_DaKanjiDbSettings) _then) = __$DaKanjiDbSettingsCopyWithImpl;
@override @useResult
$Res call({
 List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder, List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder, bool normalizeSearchConvertsRomajiToHiragana, List<DictionaryGroupingRule> groupingRules, bool showSearchResultSeparationHeaders, bool showTags, bool showMetaEntries, double definitionsMaxHeight, bool useKatakanaForFurigana, int searchResultLimit
});




}
/// @nodoc
class __$DaKanjiDbSettingsCopyWithImpl<$Res>
    implements _$DaKanjiDbSettingsCopyWith<$Res> {
  __$DaKanjiDbSettingsCopyWithImpl(this._self, this._then);

  final _DaKanjiDbSettings _self;
  final $Res Function(_DaKanjiDbSettings) _then;

/// Create a copy of DaKanjiDbSettingsInternal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstSortOrder = null,Object? secondSortOrder = null,Object? normalizeSearchConvertsRomajiToHiragana = null,Object? groupingRules = null,Object? showSearchResultSeparationHeaders = null,Object? showTags = null,Object? showMetaEntries = null,Object? definitionsMaxHeight = null,Object? useKatakanaForFurigana = null,Object? searchResultLimit = null,}) {
  return _then(_DaKanjiDbSettings(
firstSortOrder: null == firstSortOrder ? _self._firstSortOrder : firstSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult1stSortOrder, bool)>,secondSortOrder: null == secondSortOrder ? _self._secondSortOrder : secondSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult2ndSortOrder, bool)>,normalizeSearchConvertsRomajiToHiragana: null == normalizeSearchConvertsRomajiToHiragana ? _self.normalizeSearchConvertsRomajiToHiragana : normalizeSearchConvertsRomajiToHiragana // ignore: cast_nullable_to_non_nullable
as bool,groupingRules: null == groupingRules ? _self._groupingRules : groupingRules // ignore: cast_nullable_to_non_nullable
as List<DictionaryGroupingRule>,showSearchResultSeparationHeaders: null == showSearchResultSeparationHeaders ? _self.showSearchResultSeparationHeaders : showSearchResultSeparationHeaders // ignore: cast_nullable_to_non_nullable
as bool,showTags: null == showTags ? _self.showTags : showTags // ignore: cast_nullable_to_non_nullable
as bool,showMetaEntries: null == showMetaEntries ? _self.showMetaEntries : showMetaEntries // ignore: cast_nullable_to_non_nullable
as bool,definitionsMaxHeight: null == definitionsMaxHeight ? _self.definitionsMaxHeight : definitionsMaxHeight // ignore: cast_nullable_to_non_nullable
as double,useKatakanaForFurigana: null == useKatakanaForFurigana ? _self.useKatakanaForFurigana : useKatakanaForFurigana // ignore: cast_nullable_to_non_nullable
as bool,searchResultLimit: null == searchResultLimit ? _self.searchResultLimit : searchResultLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
