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
  static const VerificationMeta _parentIDMeta =
      const VerificationMeta('parentID');
  @override
  late final GeneratedColumn<int> parentID = GeneratedColumn<int>(
      'parent_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  static const VerificationMeta _isCheckedMeta =
      const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
      'is_checked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_checked" IN (0, 1))'),
      clientDefault: () => false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, parentID, childrenIDs, type, dictIDs, isExpanded, isChecked];
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
    if (data.containsKey('parent_i_d')) {
      context.handle(_parentIDMeta,
          parentID.isAcceptableOrUnknown(data['parent_i_d']!, _parentIDMeta));
    } else if (isInserting) {
      context.missing(_parentIDMeta);
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
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
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
      parentID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_i_d'])!,
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
      isChecked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_checked'])!,
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

  /// The parent's ID
  final int parentID;

  /// All children IDs
  final List<int> childrenIDs;

  /// The type of this entry
  final WordListNodeType type;

  /// All dictionary ids in this list
  final List<int> dictIDs;

  /// Is this entry currently expanded
  final bool isExpanded;

  /// Is this entry currently checked
  final bool isChecked;
  const WordListsSQLData(
      {required this.id,
      required this.name,
      required this.parentID,
      required this.childrenIDs,
      required this.type,
      required this.dictIDs,
      required this.isExpanded,
      required this.isChecked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['parent_i_d'] = Variable<int>(parentID);
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
    map['is_checked'] = Variable<bool>(isChecked);
    return map;
  }

  WordListsSQLCompanion toCompanion(bool nullToAbsent) {
    return WordListsSQLCompanion(
      id: Value(id),
      name: Value(name),
      parentID: Value(parentID),
      childrenIDs: Value(childrenIDs),
      type: Value(type),
      dictIDs: Value(dictIDs),
      isExpanded: Value(isExpanded),
      isChecked: Value(isChecked),
    );
  }

  factory WordListsSQLData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListsSQLData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentID: serializer.fromJson<int>(json['parentID']),
      childrenIDs: serializer.fromJson<List<int>>(json['childrenIDs']),
      type: $WordListsSQLTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      dictIDs: serializer.fromJson<List<int>>(json['dictIDs']),
      isExpanded: serializer.fromJson<bool>(json['isExpanded']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'parentID': serializer.toJson<int>(parentID),
      'childrenIDs': serializer.toJson<List<int>>(childrenIDs),
      'type': serializer
          .toJson<int>($WordListsSQLTable.$convertertype.toJson(type)),
      'dictIDs': serializer.toJson<List<int>>(dictIDs),
      'isExpanded': serializer.toJson<bool>(isExpanded),
      'isChecked': serializer.toJson<bool>(isChecked),
    };
  }

  WordListsSQLData copyWith(
          {int? id,
          String? name,
          int? parentID,
          List<int>? childrenIDs,
          WordListNodeType? type,
          List<int>? dictIDs,
          bool? isExpanded,
          bool? isChecked}) =>
      WordListsSQLData(
        id: id ?? this.id,
        name: name ?? this.name,
        parentID: parentID ?? this.parentID,
        childrenIDs: childrenIDs ?? this.childrenIDs,
        type: type ?? this.type,
        dictIDs: dictIDs ?? this.dictIDs,
        isExpanded: isExpanded ?? this.isExpanded,
        isChecked: isChecked ?? this.isChecked,
      );
  @override
  String toString() {
    return (StringBuffer('WordListsSQLData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentID: $parentID, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('dictIDs: $dictIDs, ')
          ..write('isExpanded: $isExpanded, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, parentID, childrenIDs, type, dictIDs, isExpanded, isChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordListsSQLData &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentID == this.parentID &&
          other.childrenIDs == this.childrenIDs &&
          other.type == this.type &&
          other.dictIDs == this.dictIDs &&
          other.isExpanded == this.isExpanded &&
          other.isChecked == this.isChecked);
}

class WordListsSQLCompanion extends UpdateCompanion<WordListsSQLData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> parentID;
  final Value<List<int>> childrenIDs;
  final Value<WordListNodeType> type;
  final Value<List<int>> dictIDs;
  final Value<bool> isExpanded;
  final Value<bool> isChecked;
  const WordListsSQLCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentID = const Value.absent(),
    this.childrenIDs = const Value.absent(),
    this.type = const Value.absent(),
    this.dictIDs = const Value.absent(),
    this.isExpanded = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  WordListsSQLCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int parentID,
    required List<int> childrenIDs,
    required WordListNodeType type,
    required List<int> dictIDs,
    this.isExpanded = const Value.absent(),
    this.isChecked = const Value.absent(),
  })  : name = Value(name),
        parentID = Value(parentID),
        childrenIDs = Value(childrenIDs),
        type = Value(type),
        dictIDs = Value(dictIDs);
  static Insertable<WordListsSQLData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? parentID,
    Expression<String>? childrenIDs,
    Expression<int>? type,
    Expression<String>? dictIDs,
    Expression<bool>? isExpanded,
    Expression<bool>? isChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentID != null) 'parent_i_d': parentID,
      if (childrenIDs != null) 'children_i_ds': childrenIDs,
      if (type != null) 'type': type,
      if (dictIDs != null) 'dict_i_ds': dictIDs,
      if (isExpanded != null) 'is_expanded': isExpanded,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  WordListsSQLCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? parentID,
      Value<List<int>>? childrenIDs,
      Value<WordListNodeType>? type,
      Value<List<int>>? dictIDs,
      Value<bool>? isExpanded,
      Value<bool>? isChecked}) {
    return WordListsSQLCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentID: parentID ?? this.parentID,
      childrenIDs: childrenIDs ?? this.childrenIDs,
      type: type ?? this.type,
      dictIDs: dictIDs ?? this.dictIDs,
      isExpanded: isExpanded ?? this.isExpanded,
      isChecked: isChecked ?? this.isChecked,
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
    if (parentID.present) {
      map['parent_i_d'] = Variable<int>(parentID.value);
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
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordListsSQLCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentID: $parentID, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('dictIDs: $dictIDs, ')
          ..write('isExpanded: $isExpanded, ')
          ..write('isChecked: $isChecked')
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
