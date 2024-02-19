// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lists_sql.dart';

// ignore_for_file: type=lint
class $WordListsSQLTable extends WordListsSQL
    with TableInfo<$WordListsSQLTable, WordListsSQLData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordListsSQLTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childrenIDsMeta =
      const VerificationMeta('childrenIDs');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> childrenIDs =
      GeneratedColumn<String>('children_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<int>>($WordListsSQLTable.$converterchildrenIDs);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<WordListNodeType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<WordListNodeType>($WordListsSQLTable.$convertertype);
  static const VerificationMeta _dictIDsMeta =
      const VerificationMeta('dictIDs');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> dictIDs =
      GeneratedColumn<String>('dict_i_ds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<int>>($WordListsSQLTable.$converterdictIDs);
  static const VerificationMeta _isExpandedMeta =
      const VerificationMeta('isExpanded');
  @override
  late final GeneratedColumn<bool> isExpanded = GeneratedColumn<bool>(
      'is_expanded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_expanded" IN (0, 1))'),
      clientDefault: () => false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, childrenIDs, type, dictIDs, isExpanded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_lists_s_q_l';
  @override
  VerificationContext validateIntegrity(Insertable<WordListsSQLData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_childrenIDsMeta, const VerificationResult.success());
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_dictIDsMeta, const VerificationResult.success());
    if (data.containsKey('is_expanded')) {
      context.handle(
          _isExpandedMeta,
          isExpanded.isAcceptableOrUnknown(
              data['is_expanded']!, _isExpandedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordListsSQLData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordListsSQLData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      childrenIDs: $WordListsSQLTable.$converterchildrenIDs.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}children_i_ds'])!),
      type: $WordListsSQLTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      dictIDs: $WordListsSQLTable.$converterdictIDs.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dict_i_ds'])!),
      isExpanded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_expanded'])!,
    );
  }

  @override
  $WordListsSQLTable createAlias(String alias) {
    return $WordListsSQLTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterchildrenIDs =
      const ListIntConverter();
  static JsonTypeConverter2<WordListNodeType, int, int> $convertertype =
      const EnumIndexConverter<WordListNodeType>(WordListNodeType.values);
  static TypeConverter<List<int>, String> $converterdictIDs =
      const ListIntConverter();
}

class WordListsSQLData extends DataClass
    implements Insertable<WordListsSQLData> {
  /// Id of this row
  final int id;

  /// The name of this wordlist entry
  final String name;

  /// All children IDs
  final List<int> childrenIDs;

  /// The type of this entry
  final WordListNodeType type;

  /// All dictionary ids in this list
  final List<int> dictIDs;

  /// Is this entry currently expanded
  final bool isExpanded;
  const WordListsSQLData(
      {required this.id,
      required this.name,
      required this.childrenIDs,
      required this.type,
      required this.dictIDs,
      required this.isExpanded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $WordListsSQLTable.$converterchildrenIDs;
      map['children_i_ds'] = Variable<String>(converter.toSql(childrenIDs));
    }
    {
      final converter = $WordListsSQLTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    {
      final converter = $WordListsSQLTable.$converterdictIDs;
      map['dict_i_ds'] = Variable<String>(converter.toSql(dictIDs));
    }
    map['is_expanded'] = Variable<bool>(isExpanded);
    return map;
  }

  WordListsSQLCompanion toCompanion(bool nullToAbsent) {
    return WordListsSQLCompanion(
      id: Value(id),
      name: Value(name),
      childrenIDs: Value(childrenIDs),
      type: Value(type),
      dictIDs: Value(dictIDs),
      isExpanded: Value(isExpanded),
    );
  }

  factory WordListsSQLData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListsSQLData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      childrenIDs: serializer.fromJson<List<int>>(json['childrenIDs']),
      type: $WordListsSQLTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      dictIDs: serializer.fromJson<List<int>>(json['dictIDs']),
      isExpanded: serializer.fromJson<bool>(json['isExpanded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'childrenIDs': serializer.toJson<List<int>>(childrenIDs),
      'type': serializer
          .toJson<int>($WordListsSQLTable.$convertertype.toJson(type)),
      'dictIDs': serializer.toJson<List<int>>(dictIDs),
      'isExpanded': serializer.toJson<bool>(isExpanded),
    };
  }

  WordListsSQLData copyWith(
          {int? id,
          String? name,
          List<int>? childrenIDs,
          WordListNodeType? type,
          List<int>? dictIDs,
          bool? isExpanded}) =>
      WordListsSQLData(
        id: id ?? this.id,
        name: name ?? this.name,
        childrenIDs: childrenIDs ?? this.childrenIDs,
        type: type ?? this.type,
        dictIDs: dictIDs ?? this.dictIDs,
        isExpanded: isExpanded ?? this.isExpanded,
      );
  @override
  String toString() {
    return (StringBuffer('WordListsSQLData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('dictIDs: $dictIDs, ')
          ..write('isExpanded: $isExpanded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, childrenIDs, type, dictIDs, isExpanded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordListsSQLData &&
          other.id == this.id &&
          other.name == this.name &&
          other.childrenIDs == this.childrenIDs &&
          other.type == this.type &&
          other.dictIDs == this.dictIDs &&
          other.isExpanded == this.isExpanded);
}

class WordListsSQLCompanion extends UpdateCompanion<WordListsSQLData> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<int>> childrenIDs;
  final Value<WordListNodeType> type;
  final Value<List<int>> dictIDs;
  final Value<bool> isExpanded;
  const WordListsSQLCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.childrenIDs = const Value.absent(),
    this.type = const Value.absent(),
    this.dictIDs = const Value.absent(),
    this.isExpanded = const Value.absent(),
  });
  WordListsSQLCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required List<int> childrenIDs,
    required WordListNodeType type,
    required List<int> dictIDs,
    this.isExpanded = const Value.absent(),
  })  : name = Value(name),
        childrenIDs = Value(childrenIDs),
        type = Value(type),
        dictIDs = Value(dictIDs);
  static Insertable<WordListsSQLData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? childrenIDs,
    Expression<int>? type,
    Expression<String>? dictIDs,
    Expression<bool>? isExpanded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (childrenIDs != null) 'children_i_ds': childrenIDs,
      if (type != null) 'type': type,
      if (dictIDs != null) 'dict_i_ds': dictIDs,
      if (isExpanded != null) 'is_expanded': isExpanded,
    });
  }

  WordListsSQLCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<List<int>>? childrenIDs,
      Value<WordListNodeType>? type,
      Value<List<int>>? dictIDs,
      Value<bool>? isExpanded}) {
    return WordListsSQLCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      childrenIDs: childrenIDs ?? this.childrenIDs,
      type: type ?? this.type,
      dictIDs: dictIDs ?? this.dictIDs,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (childrenIDs.present) {
      final converter = $WordListsSQLTable.$converterchildrenIDs;

      map['children_i_ds'] =
          Variable<String>(converter.toSql(childrenIDs.value));
    }
    if (type.present) {
      final converter = $WordListsSQLTable.$convertertype;

      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (dictIDs.present) {
      final converter = $WordListsSQLTable.$converterdictIDs;

      map['dict_i_ds'] = Variable<String>(converter.toSql(dictIDs.value));
    }
    if (isExpanded.present) {
      map['is_expanded'] = Variable<bool>(isExpanded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordListsSQLCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('dictIDs: $dictIDs, ')
          ..write('isExpanded: $isExpanded')
          ..write(')'))
        .toString();
  }
}

abstract class _$WordListsSQLDatabase extends GeneratedDatabase {
  _$WordListsSQLDatabase(QueryExecutor e) : super(e);
  late final $WordListsSQLTable wordListsSQL = $WordListsSQLTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wordListsSQL];
}
