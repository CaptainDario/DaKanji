// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetSearchHistoryCollection on Isar {
  IsarCollection<SearchHistory> get searchHistorys => this.collection();
}

const SearchHistorySchema = CollectionSchema(
  name: r'SearchHistory',
  id: -4204570823138025228,
  properties: {
    r'dateSearched': PropertySchema(
      id: 0,
      name: r'dateSearched',
      type: IsarType.dateTime,
    ),
    r'dictEntryId': PropertySchema(
      id: 1,
      name: r'dictEntryId',
      type: IsarType.long,
    ),
    r'schema': PropertySchema(
      id: 2,
      name: r'schema',
      type: IsarType.byte,
      enumMap: _SearchHistoryschemaEnumValueMap,
    )
  },
  estimateSize: _searchHistoryEstimateSize,
  serialize: _searchHistorySerialize,
  deserialize: _searchHistoryDeserialize,
  deserializeProp: _searchHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'dateSearched': IndexSchema(
      id: -2699424055465072237,
      name: r'dateSearched',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateSearched',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _searchHistoryGetId,
  getLinks: _searchHistoryGetLinks,
  attach: _searchHistoryAttach,
  version: '3.0.6-dev.0',
);

int _searchHistoryEstimateSize(
  SearchHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _searchHistorySerialize(
  SearchHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateSearched);
  writer.writeLong(offsets[1], object.dictEntryId);
  writer.writeByte(offsets[2], object.schema.index);
}

SearchHistory _searchHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SearchHistory();
  object.dateSearched = reader.readDateTime(offsets[0]);
  object.dictEntryId = reader.readLong(offsets[1]);
  object.id = id;
  object.schema =
      _SearchHistoryschemaValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          DatabaseType.None;
  return object;
}

P _searchHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_SearchHistoryschemaValueEnumMap[reader.readByteOrNull(offset)] ??
          DatabaseType.None) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SearchHistoryschemaEnumValueMap = {
  'None': 0,
  'JMDict': 1,
  'JMEdict': 2,
  'KanjiVG': 3,
  'KanjiDic2': 4,
};
const _SearchHistoryschemaValueEnumMap = {
  0: DatabaseType.None,
  1: DatabaseType.JMDict,
  2: DatabaseType.JMEdict,
  3: DatabaseType.KanjiVG,
  4: DatabaseType.KanjiDic2,
};

Id _searchHistoryGetId(SearchHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _searchHistoryGetLinks(SearchHistory object) {
  return [];
}

void _searchHistoryAttach(
    IsarCollection<dynamic> col, Id id, SearchHistory object) {
  object.id = id;
}

extension SearchHistoryQueryWhereSort
    on QueryBuilder<SearchHistory, SearchHistory, QWhere> {
  QueryBuilder<SearchHistory, SearchHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhere> anyDateSearched() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateSearched'),
      );
    });
  }
}

extension SearchHistoryQueryWhere
    on QueryBuilder<SearchHistory, SearchHistory, QWhereClause> {
  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause>
      dateSearchedEqualTo(DateTime dateSearched) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateSearched',
        value: [dateSearched],
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause>
      dateSearchedNotEqualTo(DateTime dateSearched) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateSearched',
              lower: [],
              upper: [dateSearched],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateSearched',
              lower: [dateSearched],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateSearched',
              lower: [dateSearched],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateSearched',
              lower: [],
              upper: [dateSearched],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause>
      dateSearchedGreaterThan(
    DateTime dateSearched, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateSearched',
        lower: [dateSearched],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause>
      dateSearchedLessThan(
    DateTime dateSearched, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateSearched',
        lower: [],
        upper: [dateSearched],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterWhereClause>
      dateSearchedBetween(
    DateTime lowerDateSearched,
    DateTime upperDateSearched, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateSearched',
        lower: [lowerDateSearched],
        includeLower: includeLower,
        upper: [upperDateSearched],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SearchHistoryQueryFilter
    on QueryBuilder<SearchHistory, SearchHistory, QFilterCondition> {
  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dateSearchedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateSearched',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dateSearchedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateSearched',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dateSearchedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateSearched',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dateSearchedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateSearched',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dictEntryIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dictEntryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dictEntryIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dictEntryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dictEntryIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dictEntryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      dictEntryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dictEntryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      schemaEqualTo(DatabaseType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'schema',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      schemaGreaterThan(
    DatabaseType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'schema',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      schemaLessThan(
    DatabaseType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'schema',
        value: value,
      ));
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterFilterCondition>
      schemaBetween(
    DatabaseType lower,
    DatabaseType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'schema',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SearchHistoryQueryObject
    on QueryBuilder<SearchHistory, SearchHistory, QFilterCondition> {}

extension SearchHistoryQueryLinks
    on QueryBuilder<SearchHistory, SearchHistory, QFilterCondition> {}

extension SearchHistoryQuerySortBy
    on QueryBuilder<SearchHistory, SearchHistory, QSortBy> {
  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy>
      sortByDateSearched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSearched', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy>
      sortByDateSearchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSearched', Sort.desc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> sortByDictEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dictEntryId', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy>
      sortByDictEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dictEntryId', Sort.desc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> sortBySchema() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schema', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> sortBySchemaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schema', Sort.desc);
    });
  }
}

extension SearchHistoryQuerySortThenBy
    on QueryBuilder<SearchHistory, SearchHistory, QSortThenBy> {
  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy>
      thenByDateSearched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSearched', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy>
      thenByDateSearchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateSearched', Sort.desc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> thenByDictEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dictEntryId', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy>
      thenByDictEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dictEntryId', Sort.desc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> thenBySchema() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schema', Sort.asc);
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QAfterSortBy> thenBySchemaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'schema', Sort.desc);
    });
  }
}

extension SearchHistoryQueryWhereDistinct
    on QueryBuilder<SearchHistory, SearchHistory, QDistinct> {
  QueryBuilder<SearchHistory, SearchHistory, QDistinct>
      distinctByDateSearched() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateSearched');
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QDistinct>
      distinctByDictEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dictEntryId');
    });
  }

  QueryBuilder<SearchHistory, SearchHistory, QDistinct> distinctBySchema() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'schema');
    });
  }
}

extension SearchHistoryQueryProperty
    on QueryBuilder<SearchHistory, SearchHistory, QQueryProperty> {
  QueryBuilder<SearchHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SearchHistory, DateTime, QQueryOperations>
      dateSearchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateSearched');
    });
  }

  QueryBuilder<SearchHistory, int, QQueryOperations> dictEntryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dictEntryId');
    });
  }

  QueryBuilder<SearchHistory, DatabaseType, QQueryOperations> schemaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'schema');
    });
  }
}
