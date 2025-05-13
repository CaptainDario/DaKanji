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
      map['children_i_ds'] = Variable<String>(
          $WordListNodesSQLTable.$converterchildrenIDs.toSql(childrenIDs));
    }
    {
      map['type'] =
          Variable<int>($WordListNodesSQLTable.$convertertype.toSql(type));
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
  WordListNodesSQLData copyWithCompanion(WordListNodesSQLCompanion data) {
    return WordListNodesSQLData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      childrenIDs:
          data.childrenIDs.present ? data.childrenIDs.value : this.childrenIDs,
      type: data.type.present ? data.type.value : this.type,
      isExpanded:
          data.isExpanded.present ? data.isExpanded.value : this.isExpanded,
    );
  }

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
      map['children_i_ds'] = Variable<String>($WordListNodesSQLTable
          .$converterchildrenIDs
          .toSql(childrenIDs.value));
    }
    if (type.present) {
      map['type'] = Variable<int>(
          $WordListNodesSQLTable.$convertertype.toSql(type.value));
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
  static const VerificationMeta _timeAddedMeta =
      const VerificationMeta('timeAdded');
  @override
  late final GeneratedColumn<DateTime> timeAdded = GeneratedColumn<DateTime>(
      'time_added', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [wordListID, dictEntryID, timeAdded];
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
    if (data.containsKey('time_added')) {
      context.handle(_timeAddedMeta,
          timeAdded.isAcceptableOrUnknown(data['time_added']!, _timeAddedMeta));
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
      timeAdded: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_added'])!,
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

  /// The date time when this was added
  final DateTime timeAdded;
  const WordListEntriesSQLData(
      {required this.wordListID,
      required this.dictEntryID,
      required this.timeAdded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_list_i_d'] = Variable<int>(wordListID);
    map['dict_entry_i_d'] = Variable<int>(dictEntryID);
    map['time_added'] = Variable<DateTime>(timeAdded);
    return map;
  }

  WordListEntriesSQLCompanion toCompanion(bool nullToAbsent) {
    return WordListEntriesSQLCompanion(
      wordListID: Value(wordListID),
      dictEntryID: Value(dictEntryID),
      timeAdded: Value(timeAdded),
    );
  }

  factory WordListEntriesSQLData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListEntriesSQLData(
      wordListID: serializer.fromJson<int>(json['wordListID']),
      dictEntryID: serializer.fromJson<int>(json['dictEntryID']),
      timeAdded: serializer.fromJson<DateTime>(json['timeAdded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordListID': serializer.toJson<int>(wordListID),
      'dictEntryID': serializer.toJson<int>(dictEntryID),
      'timeAdded': serializer.toJson<DateTime>(timeAdded),
    };
  }

  WordListEntriesSQLData copyWith(
          {int? wordListID, int? dictEntryID, DateTime? timeAdded}) =>
      WordListEntriesSQLData(
        wordListID: wordListID ?? this.wordListID,
        dictEntryID: dictEntryID ?? this.dictEntryID,
        timeAdded: timeAdded ?? this.timeAdded,
      );
  WordListEntriesSQLData copyWithCompanion(WordListEntriesSQLCompanion data) {
    return WordListEntriesSQLData(
      wordListID:
          data.wordListID.present ? data.wordListID.value : this.wordListID,
      dictEntryID:
          data.dictEntryID.present ? data.dictEntryID.value : this.dictEntryID,
      timeAdded: data.timeAdded.present ? data.timeAdded.value : this.timeAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordListEntriesSQLData(')
          ..write('wordListID: $wordListID, ')
          ..write('dictEntryID: $dictEntryID, ')
          ..write('timeAdded: $timeAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordListID, dictEntryID, timeAdded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordListEntriesSQLData &&
          other.wordListID == this.wordListID &&
          other.dictEntryID == this.dictEntryID &&
          other.timeAdded == this.timeAdded);
}

class WordListEntriesSQLCompanion
    extends UpdateCompanion<WordListEntriesSQLData> {
  final Value<int> wordListID;
  final Value<int> dictEntryID;
  final Value<DateTime> timeAdded;
  final Value<int> rowid;
  const WordListEntriesSQLCompanion({
    this.wordListID = const Value.absent(),
    this.dictEntryID = const Value.absent(),
    this.timeAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordListEntriesSQLCompanion.insert({
    required int wordListID,
    required int dictEntryID,
    this.timeAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : wordListID = Value(wordListID),
        dictEntryID = Value(dictEntryID);
  static Insertable<WordListEntriesSQLData> custom({
    Expression<int>? wordListID,
    Expression<int>? dictEntryID,
    Expression<DateTime>? timeAdded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordListID != null) 'word_list_i_d': wordListID,
      if (dictEntryID != null) 'dict_entry_i_d': dictEntryID,
      if (timeAdded != null) 'time_added': timeAdded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordListEntriesSQLCompanion copyWith(
      {Value<int>? wordListID,
      Value<int>? dictEntryID,
      Value<DateTime>? timeAdded,
      Value<int>? rowid}) {
    return WordListEntriesSQLCompanion(
      wordListID: wordListID ?? this.wordListID,
      dictEntryID: dictEntryID ?? this.dictEntryID,
      timeAdded: timeAdded ?? this.timeAdded,
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
    if (timeAdded.present) {
      map['time_added'] = Variable<DateTime>(timeAdded.value);
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
          ..write('timeAdded: $timeAdded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$WordListsSQLDatabase extends GeneratedDatabase {
  _$WordListsSQLDatabase(QueryExecutor e) : super(e);
  $WordListsSQLDatabaseManager get managers =>
      $WordListsSQLDatabaseManager(this);
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

typedef $$WordListNodesSQLTableCreateCompanionBuilder
    = WordListNodesSQLCompanion Function({
  Value<int> id,
  required String name,
  required List<int> childrenIDs,
  required WordListNodeType type,
  Value<bool> isExpanded,
});
typedef $$WordListNodesSQLTableUpdateCompanionBuilder
    = WordListNodesSQLCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<List<int>> childrenIDs,
  Value<WordListNodeType> type,
  Value<bool> isExpanded,
});

class $$WordListNodesSQLTableFilterComposer
    extends Composer<_$WordListsSQLDatabase, $WordListNodesSQLTable> {
  $$WordListNodesSQLTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
      get childrenIDs => $composableBuilder(
          column: $table.childrenIDs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<WordListNodeType, WordListNodeType, int>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isExpanded => $composableBuilder(
      column: $table.isExpanded, builder: (column) => ColumnFilters(column));
}

class $$WordListNodesSQLTableOrderingComposer
    extends Composer<_$WordListsSQLDatabase, $WordListNodesSQLTable> {
  $$WordListNodesSQLTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childrenIDs => $composableBuilder(
      column: $table.childrenIDs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isExpanded => $composableBuilder(
      column: $table.isExpanded, builder: (column) => ColumnOrderings(column));
}

class $$WordListNodesSQLTableAnnotationComposer
    extends Composer<_$WordListsSQLDatabase, $WordListNodesSQLTable> {
  $$WordListNodesSQLTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>, String> get childrenIDs =>
      $composableBuilder(
          column: $table.childrenIDs, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WordListNodeType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isExpanded => $composableBuilder(
      column: $table.isExpanded, builder: (column) => column);
}

class $$WordListNodesSQLTableTableManager extends RootTableManager<
    _$WordListsSQLDatabase,
    $WordListNodesSQLTable,
    WordListNodesSQLData,
    $$WordListNodesSQLTableFilterComposer,
    $$WordListNodesSQLTableOrderingComposer,
    $$WordListNodesSQLTableAnnotationComposer,
    $$WordListNodesSQLTableCreateCompanionBuilder,
    $$WordListNodesSQLTableUpdateCompanionBuilder,
    (
      WordListNodesSQLData,
      BaseReferences<_$WordListsSQLDatabase, $WordListNodesSQLTable,
          WordListNodesSQLData>
    ),
    WordListNodesSQLData,
    PrefetchHooks Function()> {
  $$WordListNodesSQLTableTableManager(
      _$WordListsSQLDatabase db, $WordListNodesSQLTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordListNodesSQLTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordListNodesSQLTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordListNodesSQLTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<List<int>> childrenIDs = const Value.absent(),
            Value<WordListNodeType> type = const Value.absent(),
            Value<bool> isExpanded = const Value.absent(),
          }) =>
              WordListNodesSQLCompanion(
            id: id,
            name: name,
            childrenIDs: childrenIDs,
            type: type,
            isExpanded: isExpanded,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required List<int> childrenIDs,
            required WordListNodeType type,
            Value<bool> isExpanded = const Value.absent(),
          }) =>
              WordListNodesSQLCompanion.insert(
            id: id,
            name: name,
            childrenIDs: childrenIDs,
            type: type,
            isExpanded: isExpanded,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WordListNodesSQLTableProcessedTableManager = ProcessedTableManager<
    _$WordListsSQLDatabase,
    $WordListNodesSQLTable,
    WordListNodesSQLData,
    $$WordListNodesSQLTableFilterComposer,
    $$WordListNodesSQLTableOrderingComposer,
    $$WordListNodesSQLTableAnnotationComposer,
    $$WordListNodesSQLTableCreateCompanionBuilder,
    $$WordListNodesSQLTableUpdateCompanionBuilder,
    (
      WordListNodesSQLData,
      BaseReferences<_$WordListsSQLDatabase, $WordListNodesSQLTable,
          WordListNodesSQLData>
    ),
    WordListNodesSQLData,
    PrefetchHooks Function()>;
typedef $$WordListEntriesSQLTableCreateCompanionBuilder
    = WordListEntriesSQLCompanion Function({
  required int wordListID,
  required int dictEntryID,
  Value<DateTime> timeAdded,
  Value<int> rowid,
});
typedef $$WordListEntriesSQLTableUpdateCompanionBuilder
    = WordListEntriesSQLCompanion Function({
  Value<int> wordListID,
  Value<int> dictEntryID,
  Value<DateTime> timeAdded,
  Value<int> rowid,
});

class $$WordListEntriesSQLTableFilterComposer
    extends Composer<_$WordListsSQLDatabase, $WordListEntriesSQLTable> {
  $$WordListEntriesSQLTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get wordListID => $composableBuilder(
      column: $table.wordListID, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dictEntryID => $composableBuilder(
      column: $table.dictEntryID, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeAdded => $composableBuilder(
      column: $table.timeAdded, builder: (column) => ColumnFilters(column));
}

class $$WordListEntriesSQLTableOrderingComposer
    extends Composer<_$WordListsSQLDatabase, $WordListEntriesSQLTable> {
  $$WordListEntriesSQLTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get wordListID => $composableBuilder(
      column: $table.wordListID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dictEntryID => $composableBuilder(
      column: $table.dictEntryID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeAdded => $composableBuilder(
      column: $table.timeAdded, builder: (column) => ColumnOrderings(column));
}

class $$WordListEntriesSQLTableAnnotationComposer
    extends Composer<_$WordListsSQLDatabase, $WordListEntriesSQLTable> {
  $$WordListEntriesSQLTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get wordListID => $composableBuilder(
      column: $table.wordListID, builder: (column) => column);

  GeneratedColumn<int> get dictEntryID => $composableBuilder(
      column: $table.dictEntryID, builder: (column) => column);

  GeneratedColumn<DateTime> get timeAdded =>
      $composableBuilder(column: $table.timeAdded, builder: (column) => column);
}

class $$WordListEntriesSQLTableTableManager extends RootTableManager<
    _$WordListsSQLDatabase,
    $WordListEntriesSQLTable,
    WordListEntriesSQLData,
    $$WordListEntriesSQLTableFilterComposer,
    $$WordListEntriesSQLTableOrderingComposer,
    $$WordListEntriesSQLTableAnnotationComposer,
    $$WordListEntriesSQLTableCreateCompanionBuilder,
    $$WordListEntriesSQLTableUpdateCompanionBuilder,
    (
      WordListEntriesSQLData,
      BaseReferences<_$WordListsSQLDatabase, $WordListEntriesSQLTable,
          WordListEntriesSQLData>
    ),
    WordListEntriesSQLData,
    PrefetchHooks Function()> {
  $$WordListEntriesSQLTableTableManager(
      _$WordListsSQLDatabase db, $WordListEntriesSQLTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordListEntriesSQLTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordListEntriesSQLTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordListEntriesSQLTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> wordListID = const Value.absent(),
            Value<int> dictEntryID = const Value.absent(),
            Value<DateTime> timeAdded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordListEntriesSQLCompanion(
            wordListID: wordListID,
            dictEntryID: dictEntryID,
            timeAdded: timeAdded,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int wordListID,
            required int dictEntryID,
            Value<DateTime> timeAdded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordListEntriesSQLCompanion.insert(
            wordListID: wordListID,
            dictEntryID: dictEntryID,
            timeAdded: timeAdded,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WordListEntriesSQLTableProcessedTableManager = ProcessedTableManager<
    _$WordListsSQLDatabase,
    $WordListEntriesSQLTable,
    WordListEntriesSQLData,
    $$WordListEntriesSQLTableFilterComposer,
    $$WordListEntriesSQLTableOrderingComposer,
    $$WordListEntriesSQLTableAnnotationComposer,
    $$WordListEntriesSQLTableCreateCompanionBuilder,
    $$WordListEntriesSQLTableUpdateCompanionBuilder,
    (
      WordListEntriesSQLData,
      BaseReferences<_$WordListsSQLDatabase, $WordListEntriesSQLTable,
          WordListEntriesSQLData>
    ),
    WordListEntriesSQLData,
    PrefetchHooks Function()>;

class $WordListsSQLDatabaseManager {
  final _$WordListsSQLDatabase _db;
  $WordListsSQLDatabaseManager(this._db);
  $$WordListNodesSQLTableTableManager get wordListNodesSQL =>
      $$WordListNodesSQLTableTableManager(_db, _db.wordListNodesSQL);
  $$WordListEntriesSQLTableTableManager get wordListEntriesSQL =>
      $$WordListEntriesSQLTableTableManager(_db, _db.wordListEntriesSQL);
}
