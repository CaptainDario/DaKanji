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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<WordListNodeType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<WordListNodeType>($WordListsSQLTable.$convertertype);
  static const VerificationMeta _idsMeta = const VerificationMeta('ids');
  @override
  late final GeneratedColumn<String> ids = GeneratedColumn<String>(
      'ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isExpandedMeta =
      const VerificationMeta('isExpanded');
  @override
  late final GeneratedColumn<bool> isExpanded = GeneratedColumn<bool>(
      'is_expanded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_expanded" IN (0, 1))'));
  static const VerificationMeta _isCheckedMeta =
      const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
      'is_checked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_checked" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, ids, isExpanded, isChecked];
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
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('ids')) {
      context.handle(
          _idsMeta, ids.isAcceptableOrUnknown(data['ids']!, _idsMeta));
    } else if (isInserting) {
      context.missing(_idsMeta);
    }
    if (data.containsKey('is_expanded')) {
      context.handle(
          _isExpandedMeta,
          isExpanded.isAcceptableOrUnknown(
              data['is_expanded']!, _isExpandedMeta));
    } else if (isInserting) {
      context.missing(_isExpandedMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    } else if (isInserting) {
      context.missing(_isCheckedMeta);
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
      type: $WordListsSQLTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      ids: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ids'])!,
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

  static JsonTypeConverter2<WordListNodeType, int, int> $convertertype =
      const EnumIndexConverter<WordListNodeType>(WordListNodeType.values);
}

class WordListsSQLData extends DataClass
    implements Insertable<WordListsSQLData> {
  /// Id of this row
  final int id;

  /// The name of this entry
  final String name;

  /// The type of this entry
  final WordListNodeType type;

  /// all dictionary ids in this list
  final String ids;

  /// Is this entry currently expanded
  final bool isExpanded;

  /// Is this entry currently checked
  final bool isChecked;
  const WordListsSQLData(
      {required this.id,
      required this.name,
      required this.type,
      required this.ids,
      required this.isExpanded,
      required this.isChecked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $WordListsSQLTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    map['ids'] = Variable<String>(ids);
    map['is_expanded'] = Variable<bool>(isExpanded);
    map['is_checked'] = Variable<bool>(isChecked);
    return map;
  }

  WordListsSQLCompanion toCompanion(bool nullToAbsent) {
    return WordListsSQLCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      ids: Value(ids),
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
      type: $WordListsSQLTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      ids: serializer.fromJson<String>(json['ids']),
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
      'type': serializer
          .toJson<int>($WordListsSQLTable.$convertertype.toJson(type)),
      'ids': serializer.toJson<String>(ids),
      'isExpanded': serializer.toJson<bool>(isExpanded),
      'isChecked': serializer.toJson<bool>(isChecked),
    };
  }

  WordListsSQLData copyWith(
          {int? id,
          String? name,
          WordListNodeType? type,
          String? ids,
          bool? isExpanded,
          bool? isChecked}) =>
      WordListsSQLData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        ids: ids ?? this.ids,
        isExpanded: isExpanded ?? this.isExpanded,
        isChecked: isChecked ?? this.isChecked,
      );
  @override
  String toString() {
    return (StringBuffer('WordListsSQLData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('ids: $ids, ')
          ..write('isExpanded: $isExpanded, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, ids, isExpanded, isChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordListsSQLData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.ids == this.ids &&
          other.isExpanded == this.isExpanded &&
          other.isChecked == this.isChecked);
}

class WordListsSQLCompanion extends UpdateCompanion<WordListsSQLData> {
  final Value<int> id;
  final Value<String> name;
  final Value<WordListNodeType> type;
  final Value<String> ids;
  final Value<bool> isExpanded;
  final Value<bool> isChecked;
  const WordListsSQLCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.ids = const Value.absent(),
    this.isExpanded = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  WordListsSQLCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required WordListNodeType type,
    required String ids,
    required bool isExpanded,
    required bool isChecked,
  })  : name = Value(name),
        type = Value(type),
        ids = Value(ids),
        isExpanded = Value(isExpanded),
        isChecked = Value(isChecked);
  static Insertable<WordListsSQLData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? type,
    Expression<String>? ids,
    Expression<bool>? isExpanded,
    Expression<bool>? isChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (ids != null) 'ids': ids,
      if (isExpanded != null) 'is_expanded': isExpanded,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  WordListsSQLCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<WordListNodeType>? type,
      Value<String>? ids,
      Value<bool>? isExpanded,
      Value<bool>? isChecked}) {
    return WordListsSQLCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      ids: ids ?? this.ids,
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
    if (type.present) {
      final converter = $WordListsSQLTable.$convertertype;

      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (ids.present) {
      map['ids'] = Variable<String>(ids.value);
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
          ..write('type: $type, ')
          ..write('ids: $ids, ')
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
