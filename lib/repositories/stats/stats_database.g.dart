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
  late final $DictStatsTableTable dictStatsTable = $DictStatsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dictStatsTable];
}
