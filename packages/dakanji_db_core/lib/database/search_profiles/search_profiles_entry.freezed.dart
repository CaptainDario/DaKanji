// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_profiles_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchProfilesEntry {

/// The unique ID of the profile.
 int get id;/// The name of the profile.
 String get name;/// Whether this profile is the active profile.
 bool get isActiveProfile;/// 1st level sort order for search results.
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
 bool get showSearchResultSeparationHeaders;/// Whether to show Kanji entries at the top search results when searching
/// for single characters
 bool get showKanjiEntriesInSearchResults;/// Whether to show tags in [DictionaryMatchWidget]s.
 bool get showTags;/// Whether to show meta entries in [DictionaryMatchWidget]s.
 bool get showMetaEntries;/// Maximum height for compact definitions.
 double get definitionsMaxHeight;/// Whether to use katakana for furigana instead of hiragana.
 bool get useKatakanaForFurigana;/// The maximum number of typo corrections to consider.
 int get spellfixMaxResults;/// The maximum cost for typo correction searches.
 int get spellfixMaxCost;/// Maximum number of results to return when search (does apply to each 
/// of the four independent searches **separately**).
 int get searchResultLimit;
/// Create a copy of SearchProfilesEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchProfilesEntryCopyWith<SearchProfilesEntry> get copyWith => _$SearchProfilesEntryCopyWithImpl<SearchProfilesEntry>(this as SearchProfilesEntry, _$identity);

  /// Serializes this SearchProfilesEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchProfilesEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isActiveProfile, isActiveProfile) || other.isActiveProfile == isActiveProfile)&&const DeepCollectionEquality().equals(other.firstSortOrder, firstSortOrder)&&const DeepCollectionEquality().equals(other.secondSortOrder, secondSortOrder)&&(identical(other.normalizeSearchConvertsRomajiToHiragana, normalizeSearchConvertsRomajiToHiragana) || other.normalizeSearchConvertsRomajiToHiragana == normalizeSearchConvertsRomajiToHiragana)&&const DeepCollectionEquality().equals(other.groupingRules, groupingRules)&&(identical(other.showSearchResultSeparationHeaders, showSearchResultSeparationHeaders) || other.showSearchResultSeparationHeaders == showSearchResultSeparationHeaders)&&(identical(other.showKanjiEntriesInSearchResults, showKanjiEntriesInSearchResults) || other.showKanjiEntriesInSearchResults == showKanjiEntriesInSearchResults)&&(identical(other.showTags, showTags) || other.showTags == showTags)&&(identical(other.showMetaEntries, showMetaEntries) || other.showMetaEntries == showMetaEntries)&&(identical(other.definitionsMaxHeight, definitionsMaxHeight) || other.definitionsMaxHeight == definitionsMaxHeight)&&(identical(other.useKatakanaForFurigana, useKatakanaForFurigana) || other.useKatakanaForFurigana == useKatakanaForFurigana)&&(identical(other.spellfixMaxResults, spellfixMaxResults) || other.spellfixMaxResults == spellfixMaxResults)&&(identical(other.spellfixMaxCost, spellfixMaxCost) || other.spellfixMaxCost == spellfixMaxCost)&&(identical(other.searchResultLimit, searchResultLimit) || other.searchResultLimit == searchResultLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isActiveProfile,const DeepCollectionEquality().hash(firstSortOrder),const DeepCollectionEquality().hash(secondSortOrder),normalizeSearchConvertsRomajiToHiragana,const DeepCollectionEquality().hash(groupingRules),showSearchResultSeparationHeaders,showKanjiEntriesInSearchResults,showTags,showMetaEntries,definitionsMaxHeight,useKatakanaForFurigana,spellfixMaxResults,spellfixMaxCost,searchResultLimit);

@override
String toString() {
  return 'SearchProfilesEntry(id: $id, name: $name, isActiveProfile: $isActiveProfile, firstSortOrder: $firstSortOrder, secondSortOrder: $secondSortOrder, normalizeSearchConvertsRomajiToHiragana: $normalizeSearchConvertsRomajiToHiragana, groupingRules: $groupingRules, showSearchResultSeparationHeaders: $showSearchResultSeparationHeaders, showKanjiEntriesInSearchResults: $showKanjiEntriesInSearchResults, showTags: $showTags, showMetaEntries: $showMetaEntries, definitionsMaxHeight: $definitionsMaxHeight, useKatakanaForFurigana: $useKatakanaForFurigana, spellfixMaxResults: $spellfixMaxResults, spellfixMaxCost: $spellfixMaxCost, searchResultLimit: $searchResultLimit)';
}


}

/// @nodoc
abstract mixin class $SearchProfilesEntryCopyWith<$Res>  {
  factory $SearchProfilesEntryCopyWith(SearchProfilesEntry value, $Res Function(SearchProfilesEntry) _then) = _$SearchProfilesEntryCopyWithImpl;
@useResult
$Res call({
 int id, String name, bool isActiveProfile, List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder, List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder, bool normalizeSearchConvertsRomajiToHiragana, List<DictionaryGroupingRule> groupingRules, bool showSearchResultSeparationHeaders, bool showKanjiEntriesInSearchResults, bool showTags, bool showMetaEntries, double definitionsMaxHeight, bool useKatakanaForFurigana, int spellfixMaxResults, int spellfixMaxCost, int searchResultLimit
});




}
/// @nodoc
class _$SearchProfilesEntryCopyWithImpl<$Res>
    implements $SearchProfilesEntryCopyWith<$Res> {
  _$SearchProfilesEntryCopyWithImpl(this._self, this._then);

  final SearchProfilesEntry _self;
  final $Res Function(SearchProfilesEntry) _then;

/// Create a copy of SearchProfilesEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isActiveProfile = null,Object? firstSortOrder = null,Object? secondSortOrder = null,Object? normalizeSearchConvertsRomajiToHiragana = null,Object? groupingRules = null,Object? showSearchResultSeparationHeaders = null,Object? showKanjiEntriesInSearchResults = null,Object? showTags = null,Object? showMetaEntries = null,Object? definitionsMaxHeight = null,Object? useKatakanaForFurigana = null,Object? spellfixMaxResults = null,Object? spellfixMaxCost = null,Object? searchResultLimit = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isActiveProfile: null == isActiveProfile ? _self.isActiveProfile : isActiveProfile // ignore: cast_nullable_to_non_nullable
as bool,firstSortOrder: null == firstSortOrder ? _self.firstSortOrder : firstSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult1stSortOrder, bool)>,secondSortOrder: null == secondSortOrder ? _self.secondSortOrder : secondSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult2ndSortOrder, bool)>,normalizeSearchConvertsRomajiToHiragana: null == normalizeSearchConvertsRomajiToHiragana ? _self.normalizeSearchConvertsRomajiToHiragana : normalizeSearchConvertsRomajiToHiragana // ignore: cast_nullable_to_non_nullable
as bool,groupingRules: null == groupingRules ? _self.groupingRules : groupingRules // ignore: cast_nullable_to_non_nullable
as List<DictionaryGroupingRule>,showSearchResultSeparationHeaders: null == showSearchResultSeparationHeaders ? _self.showSearchResultSeparationHeaders : showSearchResultSeparationHeaders // ignore: cast_nullable_to_non_nullable
as bool,showKanjiEntriesInSearchResults: null == showKanjiEntriesInSearchResults ? _self.showKanjiEntriesInSearchResults : showKanjiEntriesInSearchResults // ignore: cast_nullable_to_non_nullable
as bool,showTags: null == showTags ? _self.showTags : showTags // ignore: cast_nullable_to_non_nullable
as bool,showMetaEntries: null == showMetaEntries ? _self.showMetaEntries : showMetaEntries // ignore: cast_nullable_to_non_nullable
as bool,definitionsMaxHeight: null == definitionsMaxHeight ? _self.definitionsMaxHeight : definitionsMaxHeight // ignore: cast_nullable_to_non_nullable
as double,useKatakanaForFurigana: null == useKatakanaForFurigana ? _self.useKatakanaForFurigana : useKatakanaForFurigana // ignore: cast_nullable_to_non_nullable
as bool,spellfixMaxResults: null == spellfixMaxResults ? _self.spellfixMaxResults : spellfixMaxResults // ignore: cast_nullable_to_non_nullable
as int,spellfixMaxCost: null == spellfixMaxCost ? _self.spellfixMaxCost : spellfixMaxCost // ignore: cast_nullable_to_non_nullable
as int,searchResultLimit: null == searchResultLimit ? _self.searchResultLimit : searchResultLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchProfilesEntry].
extension SearchProfilesEntryPatterns on SearchProfilesEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchProfilesEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchProfilesEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchProfilesEntry value)  $default,){
final _that = this;
switch (_that) {
case _SearchProfilesEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchProfilesEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SearchProfilesEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  bool isActiveProfile,  List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,  bool normalizeSearchConvertsRomajiToHiragana,  List<DictionaryGroupingRule> groupingRules,  bool showSearchResultSeparationHeaders,  bool showKanjiEntriesInSearchResults,  bool showTags,  bool showMetaEntries,  double definitionsMaxHeight,  bool useKatakanaForFurigana,  int spellfixMaxResults,  int spellfixMaxCost,  int searchResultLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchProfilesEntry() when $default != null:
return $default(_that.id,_that.name,_that.isActiveProfile,_that.firstSortOrder,_that.secondSortOrder,_that.normalizeSearchConvertsRomajiToHiragana,_that.groupingRules,_that.showSearchResultSeparationHeaders,_that.showKanjiEntriesInSearchResults,_that.showTags,_that.showMetaEntries,_that.definitionsMaxHeight,_that.useKatakanaForFurigana,_that.spellfixMaxResults,_that.spellfixMaxCost,_that.searchResultLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  bool isActiveProfile,  List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,  bool normalizeSearchConvertsRomajiToHiragana,  List<DictionaryGroupingRule> groupingRules,  bool showSearchResultSeparationHeaders,  bool showKanjiEntriesInSearchResults,  bool showTags,  bool showMetaEntries,  double definitionsMaxHeight,  bool useKatakanaForFurigana,  int spellfixMaxResults,  int spellfixMaxCost,  int searchResultLimit)  $default,) {final _that = this;
switch (_that) {
case _SearchProfilesEntry():
return $default(_that.id,_that.name,_that.isActiveProfile,_that.firstSortOrder,_that.secondSortOrder,_that.normalizeSearchConvertsRomajiToHiragana,_that.groupingRules,_that.showSearchResultSeparationHeaders,_that.showKanjiEntriesInSearchResults,_that.showTags,_that.showMetaEntries,_that.definitionsMaxHeight,_that.useKatakanaForFurigana,_that.spellfixMaxResults,_that.spellfixMaxCost,_that.searchResultLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  bool isActiveProfile,  List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder,  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder,  bool normalizeSearchConvertsRomajiToHiragana,  List<DictionaryGroupingRule> groupingRules,  bool showSearchResultSeparationHeaders,  bool showKanjiEntriesInSearchResults,  bool showTags,  bool showMetaEntries,  double definitionsMaxHeight,  bool useKatakanaForFurigana,  int spellfixMaxResults,  int spellfixMaxCost,  int searchResultLimit)?  $default,) {final _that = this;
switch (_that) {
case _SearchProfilesEntry() when $default != null:
return $default(_that.id,_that.name,_that.isActiveProfile,_that.firstSortOrder,_that.secondSortOrder,_that.normalizeSearchConvertsRomajiToHiragana,_that.groupingRules,_that.showSearchResultSeparationHeaders,_that.showKanjiEntriesInSearchResults,_that.showTags,_that.showMetaEntries,_that.definitionsMaxHeight,_that.useKatakanaForFurigana,_that.spellfixMaxResults,_that.spellfixMaxCost,_that.searchResultLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchProfilesEntry extends SearchProfilesEntry {
  const _SearchProfilesEntry({this.id = 0, this.name = '', this.isActiveProfile = false, final  List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder = const [(DakanjiDbSearchResult1stSortOrder.queryMatch, true), (DakanjiDbSearchResult1stSortOrder.normalizedMatch, true), (DakanjiDbSearchResult1stSortOrder.deconjugationMatch, true), (DakanjiDbSearchResult1stSortOrder.spellfixMatch, true)], final  List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder = const [(DakanjiDbSearchResult2ndSortOrder.exactMatch, true), (DakanjiDbSearchResult2ndSortOrder.prefixMatch, true), (DakanjiDbSearchResult2ndSortOrder.subwordMatch, true), (DakanjiDbSearchResult2ndSortOrder.wildcardMatch, true)], this.normalizeSearchConvertsRomajiToHiragana = true, final  List<DictionaryGroupingRule> groupingRules = const [], this.showSearchResultSeparationHeaders = true, this.showKanjiEntriesInSearchResults = true, this.showTags = true, this.showMetaEntries = true, this.definitionsMaxHeight = 60.0, this.useKatakanaForFurigana = false, this.spellfixMaxResults = 20, this.spellfixMaxCost = 10, this.searchResultLimit = 100}): _firstSortOrder = firstSortOrder,_secondSortOrder = secondSortOrder,_groupingRules = groupingRules,super._();
  factory _SearchProfilesEntry.fromJson(Map<String, dynamic> json) => _$SearchProfilesEntryFromJson(json);

/// The unique ID of the profile.
@override@JsonKey() final  int id;
/// The name of the profile.
@override@JsonKey() final  String name;
/// Whether this profile is the active profile.
@override@JsonKey() final  bool isActiveProfile;
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
/// Whether to show Kanji entries at the top search results when searching
/// for single characters
@override@JsonKey() final  bool showKanjiEntriesInSearchResults;
/// Whether to show tags in [DictionaryMatchWidget]s.
@override@JsonKey() final  bool showTags;
/// Whether to show meta entries in [DictionaryMatchWidget]s.
@override@JsonKey() final  bool showMetaEntries;
/// Maximum height for compact definitions.
@override@JsonKey() final  double definitionsMaxHeight;
/// Whether to use katakana for furigana instead of hiragana.
@override@JsonKey() final  bool useKatakanaForFurigana;
/// The maximum number of typo corrections to consider.
@override@JsonKey() final  int spellfixMaxResults;
/// The maximum cost for typo correction searches.
@override@JsonKey() final  int spellfixMaxCost;
/// Maximum number of results to return when search (does apply to each 
/// of the four independent searches **separately**).
@override@JsonKey() final  int searchResultLimit;

/// Create a copy of SearchProfilesEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchProfilesEntryCopyWith<_SearchProfilesEntry> get copyWith => __$SearchProfilesEntryCopyWithImpl<_SearchProfilesEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchProfilesEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchProfilesEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isActiveProfile, isActiveProfile) || other.isActiveProfile == isActiveProfile)&&const DeepCollectionEquality().equals(other._firstSortOrder, _firstSortOrder)&&const DeepCollectionEquality().equals(other._secondSortOrder, _secondSortOrder)&&(identical(other.normalizeSearchConvertsRomajiToHiragana, normalizeSearchConvertsRomajiToHiragana) || other.normalizeSearchConvertsRomajiToHiragana == normalizeSearchConvertsRomajiToHiragana)&&const DeepCollectionEquality().equals(other._groupingRules, _groupingRules)&&(identical(other.showSearchResultSeparationHeaders, showSearchResultSeparationHeaders) || other.showSearchResultSeparationHeaders == showSearchResultSeparationHeaders)&&(identical(other.showKanjiEntriesInSearchResults, showKanjiEntriesInSearchResults) || other.showKanjiEntriesInSearchResults == showKanjiEntriesInSearchResults)&&(identical(other.showTags, showTags) || other.showTags == showTags)&&(identical(other.showMetaEntries, showMetaEntries) || other.showMetaEntries == showMetaEntries)&&(identical(other.definitionsMaxHeight, definitionsMaxHeight) || other.definitionsMaxHeight == definitionsMaxHeight)&&(identical(other.useKatakanaForFurigana, useKatakanaForFurigana) || other.useKatakanaForFurigana == useKatakanaForFurigana)&&(identical(other.spellfixMaxResults, spellfixMaxResults) || other.spellfixMaxResults == spellfixMaxResults)&&(identical(other.spellfixMaxCost, spellfixMaxCost) || other.spellfixMaxCost == spellfixMaxCost)&&(identical(other.searchResultLimit, searchResultLimit) || other.searchResultLimit == searchResultLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isActiveProfile,const DeepCollectionEquality().hash(_firstSortOrder),const DeepCollectionEquality().hash(_secondSortOrder),normalizeSearchConvertsRomajiToHiragana,const DeepCollectionEquality().hash(_groupingRules),showSearchResultSeparationHeaders,showKanjiEntriesInSearchResults,showTags,showMetaEntries,definitionsMaxHeight,useKatakanaForFurigana,spellfixMaxResults,spellfixMaxCost,searchResultLimit);

@override
String toString() {
  return 'SearchProfilesEntry(id: $id, name: $name, isActiveProfile: $isActiveProfile, firstSortOrder: $firstSortOrder, secondSortOrder: $secondSortOrder, normalizeSearchConvertsRomajiToHiragana: $normalizeSearchConvertsRomajiToHiragana, groupingRules: $groupingRules, showSearchResultSeparationHeaders: $showSearchResultSeparationHeaders, showKanjiEntriesInSearchResults: $showKanjiEntriesInSearchResults, showTags: $showTags, showMetaEntries: $showMetaEntries, definitionsMaxHeight: $definitionsMaxHeight, useKatakanaForFurigana: $useKatakanaForFurigana, spellfixMaxResults: $spellfixMaxResults, spellfixMaxCost: $spellfixMaxCost, searchResultLimit: $searchResultLimit)';
}


}

/// @nodoc
abstract mixin class _$SearchProfilesEntryCopyWith<$Res> implements $SearchProfilesEntryCopyWith<$Res> {
  factory _$SearchProfilesEntryCopyWith(_SearchProfilesEntry value, $Res Function(_SearchProfilesEntry) _then) = __$SearchProfilesEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, bool isActiveProfile, List<(DakanjiDbSearchResult1stSortOrder, bool)> firstSortOrder, List<(DakanjiDbSearchResult2ndSortOrder, bool)> secondSortOrder, bool normalizeSearchConvertsRomajiToHiragana, List<DictionaryGroupingRule> groupingRules, bool showSearchResultSeparationHeaders, bool showKanjiEntriesInSearchResults, bool showTags, bool showMetaEntries, double definitionsMaxHeight, bool useKatakanaForFurigana, int spellfixMaxResults, int spellfixMaxCost, int searchResultLimit
});




}
/// @nodoc
class __$SearchProfilesEntryCopyWithImpl<$Res>
    implements _$SearchProfilesEntryCopyWith<$Res> {
  __$SearchProfilesEntryCopyWithImpl(this._self, this._then);

  final _SearchProfilesEntry _self;
  final $Res Function(_SearchProfilesEntry) _then;

/// Create a copy of SearchProfilesEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isActiveProfile = null,Object? firstSortOrder = null,Object? secondSortOrder = null,Object? normalizeSearchConvertsRomajiToHiragana = null,Object? groupingRules = null,Object? showSearchResultSeparationHeaders = null,Object? showKanjiEntriesInSearchResults = null,Object? showTags = null,Object? showMetaEntries = null,Object? definitionsMaxHeight = null,Object? useKatakanaForFurigana = null,Object? spellfixMaxResults = null,Object? spellfixMaxCost = null,Object? searchResultLimit = null,}) {
  return _then(_SearchProfilesEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isActiveProfile: null == isActiveProfile ? _self.isActiveProfile : isActiveProfile // ignore: cast_nullable_to_non_nullable
as bool,firstSortOrder: null == firstSortOrder ? _self._firstSortOrder : firstSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult1stSortOrder, bool)>,secondSortOrder: null == secondSortOrder ? _self._secondSortOrder : secondSortOrder // ignore: cast_nullable_to_non_nullable
as List<(DakanjiDbSearchResult2ndSortOrder, bool)>,normalizeSearchConvertsRomajiToHiragana: null == normalizeSearchConvertsRomajiToHiragana ? _self.normalizeSearchConvertsRomajiToHiragana : normalizeSearchConvertsRomajiToHiragana // ignore: cast_nullable_to_non_nullable
as bool,groupingRules: null == groupingRules ? _self._groupingRules : groupingRules // ignore: cast_nullable_to_non_nullable
as List<DictionaryGroupingRule>,showSearchResultSeparationHeaders: null == showSearchResultSeparationHeaders ? _self.showSearchResultSeparationHeaders : showSearchResultSeparationHeaders // ignore: cast_nullable_to_non_nullable
as bool,showKanjiEntriesInSearchResults: null == showKanjiEntriesInSearchResults ? _self.showKanjiEntriesInSearchResults : showKanjiEntriesInSearchResults // ignore: cast_nullable_to_non_nullable
as bool,showTags: null == showTags ? _self.showTags : showTags // ignore: cast_nullable_to_non_nullable
as bool,showMetaEntries: null == showMetaEntries ? _self.showMetaEntries : showMetaEntries // ignore: cast_nullable_to_non_nullable
as bool,definitionsMaxHeight: null == definitionsMaxHeight ? _self.definitionsMaxHeight : definitionsMaxHeight // ignore: cast_nullable_to_non_nullable
as double,useKatakanaForFurigana: null == useKatakanaForFurigana ? _self.useKatakanaForFurigana : useKatakanaForFurigana // ignore: cast_nullable_to_non_nullable
as bool,spellfixMaxResults: null == spellfixMaxResults ? _self.spellfixMaxResults : spellfixMaxResults // ignore: cast_nullable_to_non_nullable
as int,spellfixMaxCost: null == spellfixMaxCost ? _self.spellfixMaxCost : spellfixMaxCost // ignore: cast_nullable_to_non_nullable
as int,searchResultLimit: null == searchResultLimit ? _self.searchResultLimit : searchResultLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
