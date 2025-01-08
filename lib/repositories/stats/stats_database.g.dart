// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_database.dart';

// ignore_for_file: type=lint
class $DictStatsTableTable extends DictStatsTable
    with TableInfo<$DictStatsTableTable, DictStatsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictStatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dict_stats_table';
  @override
  VerificationContext validateIntegrity(Insertable<DictStatsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DictStatsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictStatsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $DictStatsTableTable createAlias(String alias) {
    return $DictStatsTableTable(attachedDatabase, alias);
  }
}

class DictStatsTableData extends DataClass
    implements Insertable<DictStatsTableData> {
  final int id;
  const DictStatsTableData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  DictStatsTableCompanion toCompanion(bool nullToAbsent) {
    return DictStatsTableCompanion(
      id: Value(id),
    );
  }

  factory DictStatsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictStatsTableData(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  DictStatsTableData copyWith({int? id}) => DictStatsTableData(
        id: id ?? this.id,
      );
  DictStatsTableData copyWithCompanion(DictStatsTableCompanion data) {
    return DictStatsTableData(
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictStatsTableData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictStatsTableData && other.id == this.id);
}

class DictStatsTableCompanion extends UpdateCompanion<DictStatsTableData> {
  final Value<int> id;
  const DictStatsTableCompanion({
    this.id = const Value.absent(),
  });
  DictStatsTableCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<DictStatsTableData> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  DictStatsTableCompanion copyWith({Value<int>? id}) {
    return DictStatsTableCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictStatsTableCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

abstract class _$StatsDatabase extends GeneratedDatabase {
  _$StatsDatabase(QueryExecutor e) : super(e);
  $StatsDatabaseManager get managers => $StatsDatabaseManager(this);
  late final $DictStatsTableTable dictStatsTable = $DictStatsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dictStatsTable];
}

typedef $$DictStatsTableTableCreateCompanionBuilder = DictStatsTableCompanion
    Function({
  Value<int> id,
});
typedef $$DictStatsTableTableUpdateCompanionBuilder = DictStatsTableCompanion
    Function({
  Value<int> id,
});

class $$DictStatsTableTableFilterComposer
    extends Composer<_$StatsDatabase, $DictStatsTableTable> {
  $$DictStatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));
}

class $$DictStatsTableTableOrderingComposer
    extends Composer<_$StatsDatabase, $DictStatsTableTable> {
  $$DictStatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));
}

class $$DictStatsTableTableAnnotationComposer
    extends Composer<_$StatsDatabase, $DictStatsTableTable> {
  $$DictStatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$DictStatsTableTableTableManager extends RootTableManager<
    _$StatsDatabase,
    $DictStatsTableTable,
    DictStatsTableData,
    $$DictStatsTableTableFilterComposer,
    $$DictStatsTableTableOrderingComposer,
    $$DictStatsTableTableAnnotationComposer,
    $$DictStatsTableTableCreateCompanionBuilder,
    $$DictStatsTableTableUpdateCompanionBuilder,
    (
      DictStatsTableData,
      BaseReferences<_$StatsDatabase, $DictStatsTableTable, DictStatsTableData>
    ),
    DictStatsTableData,
    PrefetchHooks Function()> {
  $$DictStatsTableTableTableManager(
      _$StatsDatabase db, $DictStatsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictStatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictStatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DictStatsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
          }) =>
              DictStatsTableCompanion(
            id: id,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
          }) =>
              DictStatsTableCompanion.insert(
            id: id,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DictStatsTableTableProcessedTableManager = ProcessedTableManager<
    _$StatsDatabase,
    $DictStatsTableTable,
    DictStatsTableData,
    $$DictStatsTableTableFilterComposer,
    $$DictStatsTableTableOrderingComposer,
    $$DictStatsTableTableAnnotationComposer,
    $$DictStatsTableTableCreateCompanionBuilder,
    $$DictStatsTableTableUpdateCompanionBuilder,
    (
      DictStatsTableData,
      BaseReferences<_$StatsDatabase, $DictStatsTableTable, DictStatsTableData>
    ),
    DictStatsTableData,
    PrefetchHooks Function()>;

class $StatsDatabaseManager {
  final _$StatsDatabase _db;
  $StatsDatabaseManager(this._db);
  $$DictStatsTableTableTableManager get dictStatsTable =>
      $$DictStatsTableTableTableManager(_db, _db.dictStatsTable);
}
