// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_sql.dart';

// ignore_for_file: type=lint
class $SearchHistorySQLTable extends SearchHistorySQL
    with TableInfo<$SearchHistorySQLTable, SearchHistorySQLData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistorySQLTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateSearchedMeta =
      const VerificationMeta('dateSearched');
  @override
  late final GeneratedColumn<DateTime> dateSearched = GeneratedColumn<DateTime>(
      'date_searched', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dictEntryIDMeta =
      const VerificationMeta('dictEntryID');
  @override
  late final GeneratedColumn<int> dictEntryID = GeneratedColumn<int>(
      'dict_entry_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dateSearched, dictEntryID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_s_q_l';
  @override
  VerificationContext validateIntegrity(
      Insertable<SearchHistorySQLData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_searched')) {
      context.handle(
          _dateSearchedMeta,
          dateSearched.isAcceptableOrUnknown(
              data['date_searched']!, _dateSearchedMeta));
    } else if (isInserting) {
      context.missing(_dateSearchedMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistorySQLData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistorySQLData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dateSearched: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_searched'])!,
      dictEntryID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_entry_i_d'])!,
    );
  }

  @override
  $SearchHistorySQLTable createAlias(String alias) {
    return $SearchHistorySQLTable(attachedDatabase, alias);
  }
}

class SearchHistorySQLData extends DataClass
    implements Insertable<SearchHistorySQLData> {
  /// Id of this row
  final int id;

  /// The timestamp of when this entry was searched
  final DateTime dateSearched;

  /// The id of the dictionary entry that has been looked up
  final int dictEntryID;
  const SearchHistorySQLData(
      {required this.id,
      required this.dateSearched,
      required this.dictEntryID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date_searched'] = Variable<DateTime>(dateSearched);
    map['dict_entry_i_d'] = Variable<int>(dictEntryID);
    return map;
  }

  SearchHistorySQLCompanion toCompanion(bool nullToAbsent) {
    return SearchHistorySQLCompanion(
      id: Value(id),
      dateSearched: Value(dateSearched),
      dictEntryID: Value(dictEntryID),
    );
  }

  factory SearchHistorySQLData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistorySQLData(
      id: serializer.fromJson<int>(json['id']),
      dateSearched: serializer.fromJson<DateTime>(json['dateSearched']),
      dictEntryID: serializer.fromJson<int>(json['dictEntryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateSearched': serializer.toJson<DateTime>(dateSearched),
      'dictEntryID': serializer.toJson<int>(dictEntryID),
    };
  }

  SearchHistorySQLData copyWith(
          {int? id, DateTime? dateSearched, int? dictEntryID}) =>
      SearchHistorySQLData(
        id: id ?? this.id,
        dateSearched: dateSearched ?? this.dateSearched,
        dictEntryID: dictEntryID ?? this.dictEntryID,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistorySQLData(')
          ..write('id: $id, ')
          ..write('dateSearched: $dateSearched, ')
          ..write('dictEntryID: $dictEntryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dateSearched, dictEntryID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistorySQLData &&
          other.id == this.id &&
          other.dateSearched == this.dateSearched &&
          other.dictEntryID == this.dictEntryID);
}

class SearchHistorySQLCompanion extends UpdateCompanion<SearchHistorySQLData> {
  final Value<int> id;
  final Value<DateTime> dateSearched;
  final Value<int> dictEntryID;
  const SearchHistorySQLCompanion({
    this.id = const Value.absent(),
    this.dateSearched = const Value.absent(),
    this.dictEntryID = const Value.absent(),
  });
  SearchHistorySQLCompanion.insert({
    this.id = const Value.absent(),
    required DateTime dateSearched,
    required int dictEntryID,
  })  : dateSearched = Value(dateSearched),
        dictEntryID = Value(dictEntryID);
  static Insertable<SearchHistorySQLData> custom({
    Expression<int>? id,
    Expression<DateTime>? dateSearched,
    Expression<int>? dictEntryID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateSearched != null) 'date_searched': dateSearched,
      if (dictEntryID != null) 'dict_entry_i_d': dictEntryID,
    });
  }

  SearchHistorySQLCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? dateSearched,
      Value<int>? dictEntryID}) {
    return SearchHistorySQLCompanion(
      id: id ?? this.id,
      dateSearched: dateSearched ?? this.dateSearched,
      dictEntryID: dictEntryID ?? this.dictEntryID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateSearched.present) {
      map['date_searched'] = Variable<DateTime>(dateSearched.value);
    }
    if (dictEntryID.present) {
      map['dict_entry_i_d'] = Variable<int>(dictEntryID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorySQLCompanion(')
          ..write('id: $id, ')
          ..write('dateSearched: $dateSearched, ')
          ..write('dictEntryID: $dictEntryID')
          ..write(')'))
        .toString();
  }
}

abstract class _$SearchHistorySQLDatabase extends GeneratedDatabase {
  _$SearchHistorySQLDatabase(QueryExecutor e) : super(e);
  _$SearchHistorySQLDatabaseManager get managers =>
      _$SearchHistorySQLDatabaseManager(this);
  late final $SearchHistorySQLTable searchHistorySQL =
      $SearchHistorySQLTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [searchHistorySQL];
}

typedef $$SearchHistorySQLTableInsertCompanionBuilder
    = SearchHistorySQLCompanion Function({
  Value<int> id,
  required DateTime dateSearched,
  required int dictEntryID,
});
typedef $$SearchHistorySQLTableUpdateCompanionBuilder
    = SearchHistorySQLCompanion Function({
  Value<int> id,
  Value<DateTime> dateSearched,
  Value<int> dictEntryID,
});

class $$SearchHistorySQLTableTableManager extends RootTableManager<
    _$SearchHistorySQLDatabase,
    $SearchHistorySQLTable,
    SearchHistorySQLData,
    $$SearchHistorySQLTableFilterComposer,
    $$SearchHistorySQLTableOrderingComposer,
    $$SearchHistorySQLTableProcessedTableManager,
    $$SearchHistorySQLTableInsertCompanionBuilder,
    $$SearchHistorySQLTableUpdateCompanionBuilder> {
  $$SearchHistorySQLTableTableManager(
      _$SearchHistorySQLDatabase db, $SearchHistorySQLTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SearchHistorySQLTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SearchHistorySQLTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SearchHistorySQLTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> dateSearched = const Value.absent(),
            Value<int> dictEntryID = const Value.absent(),
          }) =>
              SearchHistorySQLCompanion(
            id: id,
            dateSearched: dateSearched,
            dictEntryID: dictEntryID,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required DateTime dateSearched,
            required int dictEntryID,
          }) =>
              SearchHistorySQLCompanion.insert(
            id: id,
            dateSearched: dateSearched,
            dictEntryID: dictEntryID,
          ),
        ));
}

class $$SearchHistorySQLTableProcessedTableManager
    extends ProcessedTableManager<
        _$SearchHistorySQLDatabase,
        $SearchHistorySQLTable,
        SearchHistorySQLData,
        $$SearchHistorySQLTableFilterComposer,
        $$SearchHistorySQLTableOrderingComposer,
        $$SearchHistorySQLTableProcessedTableManager,
        $$SearchHistorySQLTableInsertCompanionBuilder,
        $$SearchHistorySQLTableUpdateCompanionBuilder> {
  $$SearchHistorySQLTableProcessedTableManager(super.$state);
}

class $$SearchHistorySQLTableFilterComposer
    extends FilterComposer<_$SearchHistorySQLDatabase, $SearchHistorySQLTable> {
  $$SearchHistorySQLTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateSearched => $state.composableBuilder(
      column: $state.table.dateSearched,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get dictEntryID => $state.composableBuilder(
      column: $state.table.dictEntryID,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SearchHistorySQLTableOrderingComposer extends OrderingComposer<
    _$SearchHistorySQLDatabase, $SearchHistorySQLTable> {
  $$SearchHistorySQLTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateSearched => $state.composableBuilder(
      column: $state.table.dateSearched,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get dictEntryID => $state.composableBuilder(
      column: $state.table.dictEntryID,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$SearchHistorySQLDatabaseManager {
  final _$SearchHistorySQLDatabase _db;
  _$SearchHistorySQLDatabaseManager(this._db);
  $$SearchHistorySQLTableTableManager get searchHistorySQL =>
      $$SearchHistorySQLTableTableManager(_db, _db.searchHistorySQL);
}
