// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dojg_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDojgEntryCollection on Isar {
  IsarCollection<DojgEntry> get dojgEntrys => this.collection();
}

const DojgEntrySchema = CollectionSchema(
  name: r'DojgEntry',
  id: 8385415138983881154,
  properties: {
    r'antonymExpression': PropertySchema(
      id: 0,
      name: r'antonymExpression',
      type: IsarType.string,
    ),
    r'cloze': PropertySchema(
      id: 1,
      name: r'cloze',
      type: IsarType.string,
    ),
    r'equivalent': PropertySchema(
      id: 2,
      name: r'equivalent',
      type: IsarType.string,
    ),
    r'examplesEn': PropertySchema(
      id: 3,
      name: r'examplesEn',
      type: IsarType.stringList,
    ),
    r'examplesJp': PropertySchema(
      id: 4,
      name: r'examplesJp',
      type: IsarType.stringList,
    ),
    r'formation': PropertySchema(
      id: 5,
      name: r'formation',
      type: IsarType.string,
    ),
    r'grammaticalConcept': PropertySchema(
      id: 6,
      name: r'grammaticalConcept',
      type: IsarType.string,
    ),
    r'keySentencesEn': PropertySchema(
      id: 7,
      name: r'keySentencesEn',
      type: IsarType.stringList,
    ),
    r'keySentencesJp': PropertySchema(
      id: 8,
      name: r'keySentencesJp',
      type: IsarType.stringList,
    ),
    r'note': PropertySchema(
      id: 9,
      name: r'note',
      type: IsarType.string,
    ),
    r'noteImageName': PropertySchema(
      id: 10,
      name: r'noteImageName',
      type: IsarType.string,
    ),
    r'page': PropertySchema(
      id: 11,
      name: r'page',
      type: IsarType.long,
    ),
    r'pos': PropertySchema(
      id: 12,
      name: r'pos',
      type: IsarType.string,
    ),
    r'relatedExpression': PropertySchema(
      id: 13,
      name: r'relatedExpression',
      type: IsarType.string,
    ),
    r'usage': PropertySchema(
      id: 14,
      name: r'usage',
      type: IsarType.string,
    ),
    r'volume': PropertySchema(
      id: 15,
      name: r'volume',
      type: IsarType.string,
    ),
    r'volumeJp': PropertySchema(
      id: 16,
      name: r'volumeJp',
      type: IsarType.string,
    ),
    r'volumeTag': PropertySchema(
      id: 17,
      name: r'volumeTag',
      type: IsarType.string,
    )
  },
  estimateSize: _dojgEntryEstimateSize,
  serialize: _dojgEntrySerialize,
  deserialize: _dojgEntryDeserialize,
  deserializeProp: _dojgEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'grammaticalConcept': IndexSchema(
      id: -2220787007569051775,
      name: r'grammaticalConcept',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'grammaticalConcept',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dojgEntryGetId,
  getLinks: _dojgEntryGetLinks,
  attach: _dojgEntryAttach,
  version: '3.1.8',
);

int _dojgEntryEstimateSize(
  DojgEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.antonymExpression;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.cloze.length * 3;
  {
    final value = object.equivalent;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.examplesEn.length * 3;
  {
    for (var i = 0; i < object.examplesEn.length; i++) {
      final value = object.examplesEn[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.examplesJp.length * 3;
  {
    for (var i = 0; i < object.examplesJp.length; i++) {
      final value = object.examplesJp[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.formation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.grammaticalConcept.length * 3;
  bytesCount += 3 + object.keySentencesEn.length * 3;
  {
    for (var i = 0; i < object.keySentencesEn.length; i++) {
      final value = object.keySentencesEn[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.keySentencesJp.length * 3;
  {
    for (var i = 0; i < object.keySentencesJp.length; i++) {
      final value = object.keySentencesJp[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.noteImageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pos;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.relatedExpression;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.usage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.volume.length * 3;
  bytesCount += 3 + object.volumeJp.length * 3;
  bytesCount += 3 + object.volumeTag.length * 3;
  return bytesCount;
}

void _dojgEntrySerialize(
  DojgEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.antonymExpression);
  writer.writeString(offsets[1], object.cloze);
  writer.writeString(offsets[2], object.equivalent);
  writer.writeStringList(offsets[3], object.examplesEn);
  writer.writeStringList(offsets[4], object.examplesJp);
  writer.writeString(offsets[5], object.formation);
  writer.writeString(offsets[6], object.grammaticalConcept);
  writer.writeStringList(offsets[7], object.keySentencesEn);
  writer.writeStringList(offsets[8], object.keySentencesJp);
  writer.writeString(offsets[9], object.note);
  writer.writeString(offsets[10], object.noteImageName);
  writer.writeLong(offsets[11], object.page);
  writer.writeString(offsets[12], object.pos);
  writer.writeString(offsets[13], object.relatedExpression);
  writer.writeString(offsets[14], object.usage);
  writer.writeString(offsets[15], object.volume);
  writer.writeString(offsets[16], object.volumeJp);
  writer.writeString(offsets[17], object.volumeTag);
}

DojgEntry _dojgEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DojgEntry(
    antonymExpression: reader.readStringOrNull(offsets[0]),
    cloze: reader.readString(offsets[1]),
    equivalent: reader.readStringOrNull(offsets[2]),
    examplesEn: reader.readStringList(offsets[3]) ?? [],
    examplesJp: reader.readStringList(offsets[4]) ?? [],
    formation: reader.readStringOrNull(offsets[5]),
    grammaticalConcept: reader.readString(offsets[6]),
    keySentencesEn: reader.readStringList(offsets[7]) ?? [],
    keySentencesJp: reader.readStringList(offsets[8]) ?? [],
    note: reader.readStringOrNull(offsets[9]),
    noteImageName: reader.readStringOrNull(offsets[10]),
    page: reader.readLong(offsets[11]),
    pos: reader.readStringOrNull(offsets[12]),
    relatedExpression: reader.readStringOrNull(offsets[13]),
    usage: reader.readStringOrNull(offsets[14]),
    volume: reader.readString(offsets[15]),
    volumeJp: reader.readString(offsets[16]),
    volumeTag: reader.readString(offsets[17]),
  );
  object.id = id;
  return object;
}

P _dojgEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readStringList(offset) ?? []) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dojgEntryGetId(DojgEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dojgEntryGetLinks(DojgEntry object) {
  return [];
}

void _dojgEntryAttach(IsarCollection<dynamic> col, Id id, DojgEntry object) {
  object.id = id;
}

extension DojgEntryQueryWhereSort
    on QueryBuilder<DojgEntry, DojgEntry, QWhere> {
  QueryBuilder<DojgEntry, DojgEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DojgEntryQueryWhere
    on QueryBuilder<DojgEntry, DojgEntry, QWhereClause> {
  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause> idBetween(
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

  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause>
      grammaticalConceptEqualTo(String grammaticalConcept) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'grammaticalConcept',
        value: [grammaticalConcept],
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterWhereClause>
      grammaticalConceptNotEqualTo(String grammaticalConcept) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'grammaticalConcept',
              lower: [],
              upper: [grammaticalConcept],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'grammaticalConcept',
              lower: [grammaticalConcept],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'grammaticalConcept',
              lower: [grammaticalConcept],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'grammaticalConcept',
              lower: [],
              upper: [grammaticalConcept],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DojgEntryQueryFilter
    on QueryBuilder<DojgEntry, DojgEntry, QFilterCondition> {
  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'antonymExpression',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'antonymExpression',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'antonymExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'antonymExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'antonymExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'antonymExpression',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'antonymExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'antonymExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'antonymExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'antonymExpression',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'antonymExpression',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      antonymExpressionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'antonymExpression',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cloze',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cloze',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cloze',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cloze',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cloze',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cloze',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cloze',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cloze',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cloze',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> clozeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cloze',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'equivalent',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      equivalentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'equivalent',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equivalent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      equivalentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'equivalent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'equivalent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'equivalent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      equivalentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'equivalent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'equivalent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'equivalent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> equivalentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'equivalent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      equivalentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equivalent',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      equivalentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'equivalent',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examplesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'examplesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'examplesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'examplesEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'examplesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'examplesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'examplesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'examplesEn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examplesEn',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'examplesEn',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesEn',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesEn',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesEn',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesEn',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesEn',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesEnLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesEn',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examplesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'examplesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'examplesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'examplesJp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'examplesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'examplesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'examplesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'examplesJp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examplesJp',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'examplesJp',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesJp',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesJp',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesJp',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesJp',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesJp',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      examplesJpLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examplesJp',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'formation',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      formationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'formation',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      formationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> formationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formation',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      formationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formation',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grammaticalConcept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grammaticalConcept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grammaticalConcept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grammaticalConcept',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'grammaticalConcept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'grammaticalConcept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'grammaticalConcept',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'grammaticalConcept',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grammaticalConcept',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      grammaticalConceptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'grammaticalConcept',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keySentencesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keySentencesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keySentencesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keySentencesEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keySentencesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keySentencesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keySentencesEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keySentencesEn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keySentencesEn',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keySentencesEn',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesEn',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesEn',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesEn',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesEn',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesEn',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesEnLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesEn',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keySentencesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keySentencesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keySentencesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keySentencesJp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keySentencesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keySentencesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keySentencesJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keySentencesJp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keySentencesJp',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keySentencesJp',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesJp',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesJp',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesJp',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesJp',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesJp',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      keySentencesJpLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keySentencesJp',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'noteImageName',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'noteImageName',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteImageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteImageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteImageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteImageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'noteImageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'noteImageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'noteImageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'noteImageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteImageName',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      noteImageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'noteImageName',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> pageEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> pageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> pageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> pageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'page',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pos',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pos',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pos',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> posIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pos',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedExpression',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedExpression',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedExpression',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relatedExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relatedExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relatedExpression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relatedExpression',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedExpression',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      relatedExpressionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relatedExpression',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usage',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usage',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'usage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'usage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'usage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'usage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'usage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'usage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'usage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usage',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> usageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'usage',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volume',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'volume',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'volume',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'volume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'volume',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'volume',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'volume',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'volume',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volume',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'volume',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volumeJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'volumeJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'volumeJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'volumeJp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'volumeJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'volumeJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'volumeJp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'volumeJp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeJpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volumeJp',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      volumeJpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'volumeJp',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volumeTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      volumeTagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'volumeTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'volumeTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'volumeTag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'volumeTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'volumeTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'volumeTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'volumeTag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition> volumeTagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'volumeTag',
        value: '',
      ));
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterFilterCondition>
      volumeTagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'volumeTag',
        value: '',
      ));
    });
  }
}

extension DojgEntryQueryObject
    on QueryBuilder<DojgEntry, DojgEntry, QFilterCondition> {}

extension DojgEntryQueryLinks
    on QueryBuilder<DojgEntry, DojgEntry, QFilterCondition> {}

extension DojgEntryQuerySortBy on QueryBuilder<DojgEntry, DojgEntry, QSortBy> {
  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByAntonymExpression() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antonymExpression', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy>
      sortByAntonymExpressionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antonymExpression', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByCloze() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloze', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByClozeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloze', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByEquivalent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equivalent', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByEquivalentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equivalent', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByFormation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByFormationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByGrammaticalConcept() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grammaticalConcept', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy>
      sortByGrammaticalConceptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grammaticalConcept', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByNoteImageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteImageName', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByNoteImageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteImageName', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByPos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pos', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByPosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pos', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByRelatedExpression() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedExpression', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy>
      sortByRelatedExpressionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedExpression', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByUsage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usage', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByUsageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usage', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByVolumeJp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeJp', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByVolumeJpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeJp', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByVolumeTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeTag', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> sortByVolumeTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeTag', Sort.desc);
    });
  }
}

extension DojgEntryQuerySortThenBy
    on QueryBuilder<DojgEntry, DojgEntry, QSortThenBy> {
  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByAntonymExpression() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antonymExpression', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy>
      thenByAntonymExpressionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'antonymExpression', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByCloze() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloze', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByClozeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cloze', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByEquivalent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equivalent', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByEquivalentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equivalent', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByFormation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByFormationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByGrammaticalConcept() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grammaticalConcept', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy>
      thenByGrammaticalConceptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grammaticalConcept', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByNoteImageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteImageName', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByNoteImageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteImageName', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByPos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pos', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByPosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pos', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByRelatedExpression() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedExpression', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy>
      thenByRelatedExpressionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedExpression', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByUsage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usage', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByUsageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usage', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volume', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByVolumeJp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeJp', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByVolumeJpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeJp', Sort.desc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByVolumeTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeTag', Sort.asc);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QAfterSortBy> thenByVolumeTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'volumeTag', Sort.desc);
    });
  }
}

extension DojgEntryQueryWhereDistinct
    on QueryBuilder<DojgEntry, DojgEntry, QDistinct> {
  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByAntonymExpression(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'antonymExpression',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByCloze(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cloze', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByEquivalent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equivalent', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByExamplesEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'examplesEn');
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByExamplesJp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'examplesJp');
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByFormation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByGrammaticalConcept(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grammaticalConcept',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByKeySentencesEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keySentencesEn');
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByKeySentencesJp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keySentencesJp');
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByNoteImageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteImageName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'page');
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByPos(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByRelatedExpression(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedExpression',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByUsage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByVolume(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'volume', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByVolumeJp(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'volumeJp', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DojgEntry, DojgEntry, QDistinct> distinctByVolumeTag(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'volumeTag', caseSensitive: caseSensitive);
    });
  }
}

extension DojgEntryQueryProperty
    on QueryBuilder<DojgEntry, DojgEntry, QQueryProperty> {
  QueryBuilder<DojgEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations>
      antonymExpressionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'antonymExpression');
    });
  }

  QueryBuilder<DojgEntry, String, QQueryOperations> clozeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cloze');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations> equivalentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equivalent');
    });
  }

  QueryBuilder<DojgEntry, List<String>, QQueryOperations> examplesEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'examplesEn');
    });
  }

  QueryBuilder<DojgEntry, List<String>, QQueryOperations> examplesJpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'examplesJp');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations> formationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formation');
    });
  }

  QueryBuilder<DojgEntry, String, QQueryOperations>
      grammaticalConceptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grammaticalConcept');
    });
  }

  QueryBuilder<DojgEntry, List<String>, QQueryOperations>
      keySentencesEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keySentencesEn');
    });
  }

  QueryBuilder<DojgEntry, List<String>, QQueryOperations>
      keySentencesJpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keySentencesJp');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations> noteImageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteImageName');
    });
  }

  QueryBuilder<DojgEntry, int, QQueryOperations> pageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'page');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations> posProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pos');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations>
      relatedExpressionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedExpression');
    });
  }

  QueryBuilder<DojgEntry, String?, QQueryOperations> usageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usage');
    });
  }

  QueryBuilder<DojgEntry, String, QQueryOperations> volumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'volume');
    });
  }

  QueryBuilder<DojgEntry, String, QQueryOperations> volumeJpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'volumeJp');
    });
  }

  QueryBuilder<DojgEntry, String, QQueryOperations> volumeTagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'volumeTag');
    });
  }
}
