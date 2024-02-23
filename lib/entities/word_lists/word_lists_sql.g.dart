// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lists_sql.dart';

// ignore_for_file: type=lint
class $WordListNodesSQLTable extends WordListNodesSQL
    with TableInfo<$WordListNodesSQLTable, WordListNodesSQLData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordListNodesSQLTable(this.attachedDatabase, [this._alias]);
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
          .withConverter<List<int>>(
              $WordListNodesSQLTable.$converterchildrenIDs);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<WordListNodeType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<WordListNodeType>(
              $WordListNodesSQLTable.$convertertype);
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
      [id, name, childrenIDs, type, isExpanded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_list_nodes_s_q_l';
  @override
  VerificationContext validateIntegrity(
      Insertable<WordListNodesSQLData> instance,
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
  WordListNodesSQLData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordListNodesSQLData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      childrenIDs: $WordListNodesSQLTable.$converterchildrenIDs.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}children_i_ds'])!),
      type: $WordListNodesSQLTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      isExpanded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_expanded'])!,
    );
  }

  @override
  $WordListNodesSQLTable createAlias(String alias) {
    return $WordListNodesSQLTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterchildrenIDs =
      const ListIntConverter();
  static JsonTypeConverter2<WordListNodeType, int, int> $convertertype =
      const EnumIndexConverter<WordListNodeType>(WordListNodeType.values);
}

class WordListNodesSQLData extends DataClass
    implements Insertable<WordListNodesSQLData> {
  /// Id of this row
  final int id;

  /// The name of this wordlist entry
  final String name;

  /// All children IDs
  final List<int> childrenIDs;

  /// The type of this entry
  final WordListNodeType type;

  /// Is this entry currently expanded
  final bool isExpanded;
  const WordListNodesSQLData(
      {required this.id,
      required this.name,
      required this.childrenIDs,
      required this.type,
      required this.isExpanded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $WordListNodesSQLTable.$converterchildrenIDs;
      map['children_i_ds'] = Variable<String>(converter.toSql(childrenIDs));
    }
    {
      final converter = $WordListNodesSQLTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    map['is_expanded'] = Variable<bool>(isExpanded);
    return map;
  }

  WordListNodesSQLCompanion toCompanion(bool nullToAbsent) {
    return WordListNodesSQLCompanion(
      id: Value(id),
      name: Value(name),
      childrenIDs: Value(childrenIDs),
      type: Value(type),
      isExpanded: Value(isExpanded),
    );
  }

  factory WordListNodesSQLData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListNodesSQLData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      childrenIDs: serializer.fromJson<List<int>>(json['childrenIDs']),
      type: $WordListNodesSQLTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
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
          .toJson<int>($WordListNodesSQLTable.$convertertype.toJson(type)),
      'isExpanded': serializer.toJson<bool>(isExpanded),
    };
  }

  WordListNodesSQLData copyWith(
          {int? id,
          String? name,
          List<int>? childrenIDs,
          WordListNodeType? type,
          bool? isExpanded}) =>
      WordListNodesSQLData(
        id: id ?? this.id,
        name: name ?? this.name,
        childrenIDs: childrenIDs ?? this.childrenIDs,
        type: type ?? this.type,
        isExpanded: isExpanded ?? this.isExpanded,
      );
  @override
  String toString() {
    return (StringBuffer('WordListNodesSQLData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('isExpanded: $isExpanded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, childrenIDs, type, isExpanded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordListNodesSQLData &&
          other.id == this.id &&
          other.name == this.name &&
          other.childrenIDs == this.childrenIDs &&
          other.type == this.type &&
          other.isExpanded == this.isExpanded);
}

class WordListNodesSQLCompanion extends UpdateCompanion<WordListNodesSQLData> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<int>> childrenIDs;
  final Value<WordListNodeType> type;
  final Value<bool> isExpanded;
  const WordListNodesSQLCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.childrenIDs = const Value.absent(),
    this.type = const Value.absent(),
    this.isExpanded = const Value.absent(),
  });
  WordListNodesSQLCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required List<int> childrenIDs,
    required WordListNodeType type,
    this.isExpanded = const Value.absent(),
  })  : name = Value(name),
        childrenIDs = Value(childrenIDs),
        type = Value(type);
  static Insertable<WordListNodesSQLData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? childrenIDs,
    Expression<int>? type,
    Expression<bool>? isExpanded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (childrenIDs != null) 'children_i_ds': childrenIDs,
      if (type != null) 'type': type,
      if (isExpanded != null) 'is_expanded': isExpanded,
    });
  }

  WordListNodesSQLCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<List<int>>? childrenIDs,
      Value<WordListNodeType>? type,
      Value<bool>? isExpanded}) {
    return WordListNodesSQLCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      childrenIDs: childrenIDs ?? this.childrenIDs,
      type: type ?? this.type,
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
      final converter = $WordListNodesSQLTable.$converterchildrenIDs;

      map['children_i_ds'] =
          Variable<String>(converter.toSql(childrenIDs.value));
    }
    if (type.present) {
      final converter = $WordListNodesSQLTable.$convertertype;

      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (isExpanded.present) {
      map['is_expanded'] = Variable<bool>(isExpanded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordListNodesSQLCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('isExpanded: $isExpanded')
          ..write(')'))
        .toString();
  }
}

class $WordListEntriesSQLTable extends WordListEntriesSQL
    with TableInfo<$WordListEntriesSQLTable, WordListEntriesSQLData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordListEntriesSQLTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordListIDMeta =
      const VerificationMeta('wordListID');
  @override
  late final GeneratedColumn<int> wordListID = GeneratedColumn<int>(
      'word_list_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dictEntryIDMeta =
      const VerificationMeta('dictEntryID');
  @override
  late final GeneratedColumn<int> dictEntryID = GeneratedColumn<int>(
      'dict_entry_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [wordListID, dictEntryID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_list_entries_s_q_l';
  @override
  VerificationContext validateIntegrity(
      Insertable<WordListEntriesSQLData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_list_i_d')) {
      context.handle(
          _wordListIDMeta,
          wordListID.isAcceptableOrUnknown(
              data['word_list_i_d']!, _wordListIDMeta));
    } else if (isInserting) {
      context.missing(_wordListIDMeta);
    }
    if (data.containsKey('dict_entry_i_d')) {
      context.handle(
          _dictEntryIDMeta,
          dictEntryID.isAcceptableOrUnknown(
              data['dict_entry_i_d']!, _dictEntryIDMeta));
    } else if (isInserting) {
      context.missing(_dictEntryIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordListID, dictEntryID};
  @override
  WordListEntriesSQLData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordListEntriesSQLData(
      wordListID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_list_i_d'])!,
      dictEntryID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_entry_i_d'])!,
    );
  }

  @override
  $WordListEntriesSQLTable createAlias(String alias) {
    return $WordListEntriesSQLTable(attachedDatabase, alias);
  }
}

class WordListEntriesSQLData extends DataClass
    implements Insertable<WordListEntriesSQLData> {
  /// The id of the entry in the corresponding [WordListNodesSQL]
  final int wordListID;

  /// The id of this entry in the dictionary
  final int dictEntryID;
  const WordListEntriesSQLData(
      {required this.wordListID, required this.dictEntryID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_list_i_d'] = Variable<int>(wordListID);
    map['dict_entry_i_d'] = Variable<int>(dictEntryID);
    return map;
  }

  WordListEntriesSQLCompanion toCompanion(bool nullToAbsent) {
    return WordListEntriesSQLCompanion(
      wordListID: Value(wordListID),
      dictEntryID: Value(dictEntryID),
    );
  }

  factory WordListEntriesSQLData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListEntriesSQLData(
      wordListID: serializer.fromJson<int>(json['wordListID']),
      dictEntryID: serializer.fromJson<int>(json['dictEntryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordListID': serializer.toJson<int>(wordListID),
      'dictEntryID': serializer.toJson<int>(dictEntryID),
    };
  }

  WordListEntriesSQLData copyWith({int? wordListID, int? dictEntryID}) =>
      WordListEntriesSQLData(
        wordListID: wordListID ?? this.wordListID,
        dictEntryID: dictEntryID ?? this.dictEntryID,
      );
  @override
  String toString() {
    return (StringBuffer('WordListEntriesSQLData(')
          ..write('wordListID: $wordListID, ')
          ..write('dictEntryID: $dictEntryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordListID, dictEntryID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordListEntriesSQLData &&
          other.wordListID == this.wordListID &&
          other.dictEntryID == this.dictEntryID);
}

class WordListEntriesSQLCompanion
    extends UpdateCompanion<WordListEntriesSQLData> {
  final Value<int> wordListID;
  final Value<int> dictEntryID;
  final Value<int> rowid;
  const WordListEntriesSQLCompanion({
    this.wordListID = const Value.absent(),
    this.dictEntryID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordListEntriesSQLCompanion.insert({
    required int wordListID,
    required int dictEntryID,
    this.rowid = const Value.absent(),
  })  : wordListID = Value(wordListID),
        dictEntryID = Value(dictEntryID);
  static Insertable<WordListEntriesSQLData> custom({
    Expression<int>? wordListID,
    Expression<int>? dictEntryID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordListID != null) 'word_list_i_d': wordListID,
      if (dictEntryID != null) 'dict_entry_i_d': dictEntryID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordListEntriesSQLCompanion copyWith(
      {Value<int>? wordListID, Value<int>? dictEntryID, Value<int>? rowid}) {
    return WordListEntriesSQLCompanion(
      wordListID: wordListID ?? this.wordListID,
      dictEntryID: dictEntryID ?? this.dictEntryID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordListID.present) {
      map['word_list_i_d'] = Variable<int>(wordListID.value);
    }
    if (dictEntryID.present) {
      map['dict_entry_i_d'] = Variable<int>(dictEntryID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordListEntriesSQLCompanion(')
          ..write('wordListID: $wordListID, ')
          ..write('dictEntryID: $dictEntryID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$WordListsSQLDatabase extends GeneratedDatabase {
  _$WordListsSQLDatabase(QueryExecutor e) : super(e);
  late final $WordListNodesSQLTable wordListNodesSQL =
      $WordListNodesSQLTable(this);
  late final $WordListEntriesSQLTable wordListEntriesSQL =
      $WordListEntriesSQLTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [wordListNodesSQL, wordListEntriesSQL];
}
