// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_db.dart';

// ignore_for_file: type=lint
class $WordListNodesTableTable extends WordListNodesTable
    with TableInfo<$WordListNodesTableTable, WordListNodesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordListNodesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> childrenIDs =
      GeneratedColumn<String>(
        'children_i_ds',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<int>>(
        $WordListNodesTableTable.$converterchildrenIDs,
      );
  @override
  late final GeneratedColumnWithTypeConverter<WordListNodeType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<WordListNodeType>(
        $WordListNodesTableTable.$convertertype,
      );
  static const VerificationMeta _isExpandedMeta = const VerificationMeta(
    'isExpanded',
  );
  @override
  late final GeneratedColumn<bool> isExpanded = GeneratedColumn<bool>(
    'is_expanded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_expanded" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    childrenIDs,
    type,
    isExpanded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_list_nodes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordListNodesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_expanded')) {
      context.handle(
        _isExpandedMeta,
        isExpanded.isAcceptableOrUnknown(data['is_expanded']!, _isExpandedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordListNodesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordListNodesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      childrenIDs: $WordListNodesTableTable.$converterchildrenIDs.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}children_i_ds'],
        )!,
      ),
      type: $WordListNodesTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      isExpanded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_expanded'],
      )!,
    );
  }

  @override
  $WordListNodesTableTable createAlias(String alias) {
    return $WordListNodesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterchildrenIDs =
      const ListIntConverter();
  static JsonTypeConverter2<WordListNodeType, int, int> $convertertype =
      const EnumIndexConverter<WordListNodeType>(WordListNodeType.values);
}

class WordListNodesTableData extends DataClass
    implements Insertable<WordListNodesTableData> {
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
  const WordListNodesTableData({
    required this.id,
    required this.name,
    required this.childrenIDs,
    required this.type,
    required this.isExpanded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['children_i_ds'] = Variable<String>(
        $WordListNodesTableTable.$converterchildrenIDs.toSql(childrenIDs),
      );
    }
    {
      map['type'] = Variable<int>(
        $WordListNodesTableTable.$convertertype.toSql(type),
      );
    }
    map['is_expanded'] = Variable<bool>(isExpanded);
    return map;
  }

  WordListNodesTableCompanion toCompanion(bool nullToAbsent) {
    return WordListNodesTableCompanion(
      id: Value(id),
      name: Value(name),
      childrenIDs: Value(childrenIDs),
      type: Value(type),
      isExpanded: Value(isExpanded),
    );
  }

  factory WordListNodesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListNodesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      childrenIDs: serializer.fromJson<List<int>>(json['childrenIDs']),
      type: $WordListNodesTableTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
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
      'type': serializer.toJson<int>(
        $WordListNodesTableTable.$convertertype.toJson(type),
      ),
      'isExpanded': serializer.toJson<bool>(isExpanded),
    };
  }

  WordListNodesTableData copyWith({
    int? id,
    String? name,
    List<int>? childrenIDs,
    WordListNodeType? type,
    bool? isExpanded,
  }) => WordListNodesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    childrenIDs: childrenIDs ?? this.childrenIDs,
    type: type ?? this.type,
    isExpanded: isExpanded ?? this.isExpanded,
  );
  WordListNodesTableData copyWithCompanion(WordListNodesTableCompanion data) {
    return WordListNodesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      childrenIDs: data.childrenIDs.present
          ? data.childrenIDs.value
          : this.childrenIDs,
      type: data.type.present ? data.type.value : this.type,
      isExpanded: data.isExpanded.present
          ? data.isExpanded.value
          : this.isExpanded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordListNodesTableData(')
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
      (other is WordListNodesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.childrenIDs == this.childrenIDs &&
          other.type == this.type &&
          other.isExpanded == this.isExpanded);
}

class WordListNodesTableCompanion
    extends UpdateCompanion<WordListNodesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<int>> childrenIDs;
  final Value<WordListNodeType> type;
  final Value<bool> isExpanded;
  const WordListNodesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.childrenIDs = const Value.absent(),
    this.type = const Value.absent(),
    this.isExpanded = const Value.absent(),
  });
  WordListNodesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required List<int> childrenIDs,
    required WordListNodeType type,
    this.isExpanded = const Value.absent(),
  }) : name = Value(name),
       childrenIDs = Value(childrenIDs),
       type = Value(type);
  static Insertable<WordListNodesTableData> custom({
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

  WordListNodesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<List<int>>? childrenIDs,
    Value<WordListNodeType>? type,
    Value<bool>? isExpanded,
  }) {
    return WordListNodesTableCompanion(
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
      map['children_i_ds'] = Variable<String>(
        $WordListNodesTableTable.$converterchildrenIDs.toSql(childrenIDs.value),
      );
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $WordListNodesTableTable.$convertertype.toSql(type.value),
      );
    }
    if (isExpanded.present) {
      map['is_expanded'] = Variable<bool>(isExpanded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordListNodesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('childrenIDs: $childrenIDs, ')
          ..write('type: $type, ')
          ..write('isExpanded: $isExpanded')
          ..write(')'))
        .toString();
  }
}

class $WordListEntriesTableTable extends WordListEntriesTable
    with TableInfo<$WordListEntriesTableTable, WordListEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordListEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordListIDMeta = const VerificationMeta(
    'wordListID',
  );
  @override
  late final GeneratedColumn<int> wordListID = GeneratedColumn<int>(
    'word_list_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dictEntryIDMeta = const VerificationMeta(
    'dictEntryID',
  );
  @override
  late final GeneratedColumn<int> dictEntryID = GeneratedColumn<int>(
    'dict_entry_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeAddedMeta = const VerificationMeta(
    'timeAdded',
  );
  @override
  late final GeneratedColumn<DateTime> timeAdded = GeneratedColumn<DateTime>(
    'time_added',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [wordListID, dictEntryID, timeAdded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_list_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordListEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_list_i_d')) {
      context.handle(
        _wordListIDMeta,
        wordListID.isAcceptableOrUnknown(
          data['word_list_i_d']!,
          _wordListIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wordListIDMeta);
    }
    if (data.containsKey('dict_entry_i_d')) {
      context.handle(
        _dictEntryIDMeta,
        dictEntryID.isAcceptableOrUnknown(
          data['dict_entry_i_d']!,
          _dictEntryIDMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dictEntryIDMeta);
    }
    if (data.containsKey('time_added')) {
      context.handle(
        _timeAddedMeta,
        timeAdded.isAcceptableOrUnknown(data['time_added']!, _timeAddedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordListID, dictEntryID};
  @override
  WordListEntriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordListEntriesTableData(
      wordListID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_list_i_d'],
      )!,
      dictEntryID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dict_entry_i_d'],
      )!,
      timeAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time_added'],
      )!,
    );
  }

  @override
  $WordListEntriesTableTable createAlias(String alias) {
    return $WordListEntriesTableTable(attachedDatabase, alias);
  }
}

class WordListEntriesTableData extends DataClass
    implements Insertable<WordListEntriesTableData> {
  /// The id of the entry in the corresponding [WordListNodesTable]
  final int wordListID;

  /// The id of this entry in the dictionary
  final int dictEntryID;

  /// The date time when this was added
  final DateTime timeAdded;
  const WordListEntriesTableData({
    required this.wordListID,
    required this.dictEntryID,
    required this.timeAdded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_list_i_d'] = Variable<int>(wordListID);
    map['dict_entry_i_d'] = Variable<int>(dictEntryID);
    map['time_added'] = Variable<DateTime>(timeAdded);
    return map;
  }

  WordListEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return WordListEntriesTableCompanion(
      wordListID: Value(wordListID),
      dictEntryID: Value(dictEntryID),
      timeAdded: Value(timeAdded),
    );
  }

  factory WordListEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordListEntriesTableData(
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

  WordListEntriesTableData copyWith({
    int? wordListID,
    int? dictEntryID,
    DateTime? timeAdded,
  }) => WordListEntriesTableData(
    wordListID: wordListID ?? this.wordListID,
    dictEntryID: dictEntryID ?? this.dictEntryID,
    timeAdded: timeAdded ?? this.timeAdded,
  );
  WordListEntriesTableData copyWithCompanion(
    WordListEntriesTableCompanion data,
  ) {
    return WordListEntriesTableData(
      wordListID: data.wordListID.present
          ? data.wordListID.value
          : this.wordListID,
      dictEntryID: data.dictEntryID.present
          ? data.dictEntryID.value
          : this.dictEntryID,
      timeAdded: data.timeAdded.present ? data.timeAdded.value : this.timeAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordListEntriesTableData(')
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
      (other is WordListEntriesTableData &&
          other.wordListID == this.wordListID &&
          other.dictEntryID == this.dictEntryID &&
          other.timeAdded == this.timeAdded);
}

class WordListEntriesTableCompanion
    extends UpdateCompanion<WordListEntriesTableData> {
  final Value<int> wordListID;
  final Value<int> dictEntryID;
  final Value<DateTime> timeAdded;
  final Value<int> rowid;
  const WordListEntriesTableCompanion({
    this.wordListID = const Value.absent(),
    this.dictEntryID = const Value.absent(),
    this.timeAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordListEntriesTableCompanion.insert({
    required int wordListID,
    required int dictEntryID,
    this.timeAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : wordListID = Value(wordListID),
       dictEntryID = Value(dictEntryID);
  static Insertable<WordListEntriesTableData> custom({
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

  WordListEntriesTableCompanion copyWith({
    Value<int>? wordListID,
    Value<int>? dictEntryID,
    Value<DateTime>? timeAdded,
    Value<int>? rowid,
  }) {
    return WordListEntriesTableCompanion(
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
    return (StringBuffer('WordListEntriesTableCompanion(')
          ..write('wordListID: $wordListID, ')
          ..write('dictEntryID: $dictEntryID, ')
          ..write('timeAdded: $timeAdded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DictStatsTableTable extends DictStatsTable
    with TableInfo<$DictStatsTableTable, DictStatsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictStatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dict_stats_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DictStatsTableData> instance, {
    bool isInserting = false,
  }) {
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
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
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
    return DictStatsTableCompanion(id: Value(id));
  }

  factory DictStatsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictStatsTableData(id: serializer.fromJson<int>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<int>(id)};
  }

  DictStatsTableData copyWith({int? id}) =>
      DictStatsTableData(id: id ?? this.id);
  DictStatsTableData copyWithCompanion(DictStatsTableCompanion data) {
    return DictStatsTableData(id: data.id.present ? data.id.value : this.id);
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
  const DictStatsTableCompanion({this.id = const Value.absent()});
  DictStatsTableCompanion.insert({this.id = const Value.absent()});
  static Insertable<DictStatsTableData> custom({Expression<int>? id}) {
    return RawValuesInsertable({if (id != null) 'id': id});
  }

  DictStatsTableCompanion copyWith({Value<int>? id}) {
    return DictStatsTableCompanion(id: id ?? this.id);
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

class $TimeTrackingTableTable extends TimeTrackingTable
    with TableInfo<$TimeTrackingTableTable, TimeTrackingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeTrackingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, category, tags];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_tracking_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeTrackingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeTrackingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeTrackingTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $TimeTrackingTableTable createAlias(String alias) {
    return $TimeTrackingTableTable(attachedDatabase, alias);
  }
}

class TimeTrackingTableData extends DataClass
    implements Insertable<TimeTrackingTableData> {
  final int id;
  final String category;
  final String tags;
  const TimeTrackingTableData({
    required this.id,
    required this.category,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['tags'] = Variable<String>(tags);
    return map;
  }

  TimeTrackingTableCompanion toCompanion(bool nullToAbsent) {
    return TimeTrackingTableCompanion(
      id: Value(id),
      category: Value(category),
      tags: Value(tags),
    );
  }

  factory TimeTrackingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeTrackingTableData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'tags': serializer.toJson<String>(tags),
    };
  }

  TimeTrackingTableData copyWith({int? id, String? category, String? tags}) =>
      TimeTrackingTableData(
        id: id ?? this.id,
        category: category ?? this.category,
        tags: tags ?? this.tags,
      );
  TimeTrackingTableData copyWithCompanion(TimeTrackingTableCompanion data) {
    return TimeTrackingTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingTableData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeTrackingTableData &&
          other.id == this.id &&
          other.category == this.category &&
          other.tags == this.tags);
}

class TimeTrackingTableCompanion
    extends UpdateCompanion<TimeTrackingTableData> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> tags;
  const TimeTrackingTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
  });
  TimeTrackingTableCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String tags,
  }) : category = Value(category),
       tags = Value(tags);
  static Insertable<TimeTrackingTableData> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (tags != null) 'tags': tags,
    });
  }

  TimeTrackingTableCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<String>? tags,
  }) {
    return TimeTrackingTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $TimeTrackingUnitTableTable extends TimeTrackingUnitTable
    with TableInfo<$TimeTrackingUnitTableTable, TimeTrackingUnitTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeTrackingUnitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timeTrackingIdMeta = const VerificationMeta(
    'timeTrackingId',
  );
  @override
  late final GeneratedColumn<int> timeTrackingId = GeneratedColumn<int>(
    'time_tracking_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES time_tracking_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timeTrackingId,
    startTime,
    endTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_tracking_unit_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeTrackingUnitTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time_tracking_id')) {
      context.handle(
        _timeTrackingIdMeta,
        timeTrackingId.isAcceptableOrUnknown(
          data['time_tracking_id']!,
          _timeTrackingIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeTrackingIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeTrackingUnitTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeTrackingUnitTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timeTrackingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_tracking_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
    );
  }

  @override
  $TimeTrackingUnitTableTable createAlias(String alias) {
    return $TimeTrackingUnitTableTable(attachedDatabase, alias);
  }
}

class TimeTrackingUnitTableData extends DataClass
    implements Insertable<TimeTrackingUnitTableData> {
  final int id;
  final int timeTrackingId;
  final DateTime startTime;
  final DateTime? endTime;
  const TimeTrackingUnitTableData({
    required this.id,
    required this.timeTrackingId,
    required this.startTime,
    this.endTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['time_tracking_id'] = Variable<int>(timeTrackingId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    return map;
  }

  TimeTrackingUnitTableCompanion toCompanion(bool nullToAbsent) {
    return TimeTrackingUnitTableCompanion(
      id: Value(id),
      timeTrackingId: Value(timeTrackingId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
    );
  }

  factory TimeTrackingUnitTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeTrackingUnitTableData(
      id: serializer.fromJson<int>(json['id']),
      timeTrackingId: serializer.fromJson<int>(json['timeTrackingId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timeTrackingId': serializer.toJson<int>(timeTrackingId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
    };
  }

  TimeTrackingUnitTableData copyWith({
    int? id,
    int? timeTrackingId,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
  }) => TimeTrackingUnitTableData(
    id: id ?? this.id,
    timeTrackingId: timeTrackingId ?? this.timeTrackingId,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
  );
  TimeTrackingUnitTableData copyWithCompanion(
    TimeTrackingUnitTableCompanion data,
  ) {
    return TimeTrackingUnitTableData(
      id: data.id.present ? data.id.value : this.id,
      timeTrackingId: data.timeTrackingId.present
          ? data.timeTrackingId.value
          : this.timeTrackingId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingUnitTableData(')
          ..write('id: $id, ')
          ..write('timeTrackingId: $timeTrackingId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, timeTrackingId, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeTrackingUnitTableData &&
          other.id == this.id &&
          other.timeTrackingId == this.timeTrackingId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class TimeTrackingUnitTableCompanion
    extends UpdateCompanion<TimeTrackingUnitTableData> {
  final Value<int> id;
  final Value<int> timeTrackingId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  const TimeTrackingUnitTableCompanion({
    this.id = const Value.absent(),
    this.timeTrackingId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  TimeTrackingUnitTableCompanion.insert({
    this.id = const Value.absent(),
    required int timeTrackingId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
  }) : timeTrackingId = Value(timeTrackingId),
       startTime = Value(startTime);
  static Insertable<TimeTrackingUnitTableData> custom({
    Expression<int>? id,
    Expression<int>? timeTrackingId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timeTrackingId != null) 'time_tracking_id': timeTrackingId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  TimeTrackingUnitTableCompanion copyWith({
    Value<int>? id,
    Value<int>? timeTrackingId,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
  }) {
    return TimeTrackingUnitTableCompanion(
      id: id ?? this.id,
      timeTrackingId: timeTrackingId ?? this.timeTrackingId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timeTrackingId.present) {
      map['time_tracking_id'] = Variable<int>(timeTrackingId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingUnitTableCompanion(')
          ..write('id: $id, ')
          ..write('timeTrackingId: $timeTrackingId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$UserDataDB extends GeneratedDatabase {
  _$UserDataDB(QueryExecutor e) : super(e);
  $UserDataDBManager get managers => $UserDataDBManager(this);
  late final $WordListNodesTableTable wordListNodesTable =
      $WordListNodesTableTable(this);
  late final $WordListEntriesTableTable wordListEntriesTable =
      $WordListEntriesTableTable(this);
  late final $DictStatsTableTable dictStatsTable = $DictStatsTableTable(this);
  late final $TimeTrackingTableTable timeTrackingTable =
      $TimeTrackingTableTable(this);
  late final $TimeTrackingUnitTableTable timeTrackingUnitTable =
      $TimeTrackingUnitTableTable(this);
  late final Index timeTrackingIdIndex = Index(
    'timeTrackingIdIndex',
    'CREATE INDEX timeTrackingIdIndex ON time_tracking_unit_table (time_tracking_id)',
  );
  late final WordListsDao wordListsDao = WordListsDao(this as UserDataDB);
  late final TimeTrackingDao timeTrackingDao = TimeTrackingDao(
    this as UserDataDB,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    wordListNodesTable,
    wordListEntriesTable,
    dictStatsTable,
    timeTrackingTable,
    timeTrackingUnitTable,
    timeTrackingIdIndex,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'time_tracking_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('time_tracking_unit_table', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$WordListNodesTableTableCreateCompanionBuilder =
    WordListNodesTableCompanion Function({
      Value<int> id,
      required String name,
      required List<int> childrenIDs,
      required WordListNodeType type,
      Value<bool> isExpanded,
    });
typedef $$WordListNodesTableTableUpdateCompanionBuilder =
    WordListNodesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<List<int>> childrenIDs,
      Value<WordListNodeType> type,
      Value<bool> isExpanded,
    });

class $$WordListNodesTableTableFilterComposer
    extends Composer<_$UserDataDB, $WordListNodesTableTable> {
  $$WordListNodesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get childrenIDs => $composableBuilder(
    column: $table.childrenIDs,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<WordListNodeType, WordListNodeType, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isExpanded => $composableBuilder(
    column: $table.isExpanded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordListNodesTableTableOrderingComposer
    extends Composer<_$UserDataDB, $WordListNodesTableTable> {
  $$WordListNodesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childrenIDs => $composableBuilder(
    column: $table.childrenIDs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExpanded => $composableBuilder(
    column: $table.isExpanded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordListNodesTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $WordListNodesTableTable> {
  $$WordListNodesTableTableAnnotationComposer({
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
        column: $table.childrenIDs,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<WordListNodeType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isExpanded => $composableBuilder(
    column: $table.isExpanded,
    builder: (column) => column,
  );
}

class $$WordListNodesTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $WordListNodesTableTable,
          WordListNodesTableData,
          $$WordListNodesTableTableFilterComposer,
          $$WordListNodesTableTableOrderingComposer,
          $$WordListNodesTableTableAnnotationComposer,
          $$WordListNodesTableTableCreateCompanionBuilder,
          $$WordListNodesTableTableUpdateCompanionBuilder,
          (
            WordListNodesTableData,
            BaseReferences<
              _$UserDataDB,
              $WordListNodesTableTable,
              WordListNodesTableData
            >,
          ),
          WordListNodesTableData,
          PrefetchHooks Function()
        > {
  $$WordListNodesTableTableTableManager(
    _$UserDataDB db,
    $WordListNodesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordListNodesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordListNodesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordListNodesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<List<int>> childrenIDs = const Value.absent(),
                Value<WordListNodeType> type = const Value.absent(),
                Value<bool> isExpanded = const Value.absent(),
              }) => WordListNodesTableCompanion(
                id: id,
                name: name,
                childrenIDs: childrenIDs,
                type: type,
                isExpanded: isExpanded,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required List<int> childrenIDs,
                required WordListNodeType type,
                Value<bool> isExpanded = const Value.absent(),
              }) => WordListNodesTableCompanion.insert(
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
        ),
      );
}

typedef $$WordListNodesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $WordListNodesTableTable,
      WordListNodesTableData,
      $$WordListNodesTableTableFilterComposer,
      $$WordListNodesTableTableOrderingComposer,
      $$WordListNodesTableTableAnnotationComposer,
      $$WordListNodesTableTableCreateCompanionBuilder,
      $$WordListNodesTableTableUpdateCompanionBuilder,
      (
        WordListNodesTableData,
        BaseReferences<
          _$UserDataDB,
          $WordListNodesTableTable,
          WordListNodesTableData
        >,
      ),
      WordListNodesTableData,
      PrefetchHooks Function()
    >;
typedef $$WordListEntriesTableTableCreateCompanionBuilder =
    WordListEntriesTableCompanion Function({
      required int wordListID,
      required int dictEntryID,
      Value<DateTime> timeAdded,
      Value<int> rowid,
    });
typedef $$WordListEntriesTableTableUpdateCompanionBuilder =
    WordListEntriesTableCompanion Function({
      Value<int> wordListID,
      Value<int> dictEntryID,
      Value<DateTime> timeAdded,
      Value<int> rowid,
    });

class $$WordListEntriesTableTableFilterComposer
    extends Composer<_$UserDataDB, $WordListEntriesTableTable> {
  $$WordListEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get wordListID => $composableBuilder(
    column: $table.wordListID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dictEntryID => $composableBuilder(
    column: $table.dictEntryID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timeAdded => $composableBuilder(
    column: $table.timeAdded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordListEntriesTableTableOrderingComposer
    extends Composer<_$UserDataDB, $WordListEntriesTableTable> {
  $$WordListEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get wordListID => $composableBuilder(
    column: $table.wordListID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dictEntryID => $composableBuilder(
    column: $table.dictEntryID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timeAdded => $composableBuilder(
    column: $table.timeAdded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordListEntriesTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $WordListEntriesTableTable> {
  $$WordListEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get wordListID => $composableBuilder(
    column: $table.wordListID,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dictEntryID => $composableBuilder(
    column: $table.dictEntryID,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timeAdded =>
      $composableBuilder(column: $table.timeAdded, builder: (column) => column);
}

class $$WordListEntriesTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $WordListEntriesTableTable,
          WordListEntriesTableData,
          $$WordListEntriesTableTableFilterComposer,
          $$WordListEntriesTableTableOrderingComposer,
          $$WordListEntriesTableTableAnnotationComposer,
          $$WordListEntriesTableTableCreateCompanionBuilder,
          $$WordListEntriesTableTableUpdateCompanionBuilder,
          (
            WordListEntriesTableData,
            BaseReferences<
              _$UserDataDB,
              $WordListEntriesTableTable,
              WordListEntriesTableData
            >,
          ),
          WordListEntriesTableData,
          PrefetchHooks Function()
        > {
  $$WordListEntriesTableTableTableManager(
    _$UserDataDB db,
    $WordListEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordListEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordListEntriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WordListEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> wordListID = const Value.absent(),
                Value<int> dictEntryID = const Value.absent(),
                Value<DateTime> timeAdded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordListEntriesTableCompanion(
                wordListID: wordListID,
                dictEntryID: dictEntryID,
                timeAdded: timeAdded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int wordListID,
                required int dictEntryID,
                Value<DateTime> timeAdded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordListEntriesTableCompanion.insert(
                wordListID: wordListID,
                dictEntryID: dictEntryID,
                timeAdded: timeAdded,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordListEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $WordListEntriesTableTable,
      WordListEntriesTableData,
      $$WordListEntriesTableTableFilterComposer,
      $$WordListEntriesTableTableOrderingComposer,
      $$WordListEntriesTableTableAnnotationComposer,
      $$WordListEntriesTableTableCreateCompanionBuilder,
      $$WordListEntriesTableTableUpdateCompanionBuilder,
      (
        WordListEntriesTableData,
        BaseReferences<
          _$UserDataDB,
          $WordListEntriesTableTable,
          WordListEntriesTableData
        >,
      ),
      WordListEntriesTableData,
      PrefetchHooks Function()
    >;
typedef $$DictStatsTableTableCreateCompanionBuilder =
    DictStatsTableCompanion Function({Value<int> id});
typedef $$DictStatsTableTableUpdateCompanionBuilder =
    DictStatsTableCompanion Function({Value<int> id});

class $$DictStatsTableTableFilterComposer
    extends Composer<_$UserDataDB, $DictStatsTableTable> {
  $$DictStatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DictStatsTableTableOrderingComposer
    extends Composer<_$UserDataDB, $DictStatsTableTable> {
  $$DictStatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DictStatsTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $DictStatsTableTable> {
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

class $$DictStatsTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $DictStatsTableTable,
          DictStatsTableData,
          $$DictStatsTableTableFilterComposer,
          $$DictStatsTableTableOrderingComposer,
          $$DictStatsTableTableAnnotationComposer,
          $$DictStatsTableTableCreateCompanionBuilder,
          $$DictStatsTableTableUpdateCompanionBuilder,
          (
            DictStatsTableData,
            BaseReferences<
              _$UserDataDB,
              $DictStatsTableTable,
              DictStatsTableData
            >,
          ),
          DictStatsTableData,
          PrefetchHooks Function()
        > {
  $$DictStatsTableTableTableManager(_$UserDataDB db, $DictStatsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictStatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictStatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DictStatsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({Value<int> id = const Value.absent()}) =>
              DictStatsTableCompanion(id: id),
          createCompanionCallback: ({Value<int> id = const Value.absent()}) =>
              DictStatsTableCompanion.insert(id: id),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DictStatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $DictStatsTableTable,
      DictStatsTableData,
      $$DictStatsTableTableFilterComposer,
      $$DictStatsTableTableOrderingComposer,
      $$DictStatsTableTableAnnotationComposer,
      $$DictStatsTableTableCreateCompanionBuilder,
      $$DictStatsTableTableUpdateCompanionBuilder,
      (
        DictStatsTableData,
        BaseReferences<_$UserDataDB, $DictStatsTableTable, DictStatsTableData>,
      ),
      DictStatsTableData,
      PrefetchHooks Function()
    >;
typedef $$TimeTrackingTableTableCreateCompanionBuilder =
    TimeTrackingTableCompanion Function({
      Value<int> id,
      required String category,
      required String tags,
    });
typedef $$TimeTrackingTableTableUpdateCompanionBuilder =
    TimeTrackingTableCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<String> tags,
    });

final class $$TimeTrackingTableTableReferences
    extends
        BaseReferences<
          _$UserDataDB,
          $TimeTrackingTableTable,
          TimeTrackingTableData
        > {
  $$TimeTrackingTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $TimeTrackingUnitTableTable,
    List<TimeTrackingUnitTableData>
  >
  _timeTrackingUnitTableRefsTable(_$UserDataDB db) =>
      MultiTypedResultKey.fromTable(
        db.timeTrackingUnitTable,
        aliasName: $_aliasNameGenerator(
          db.timeTrackingTable.id,
          db.timeTrackingUnitTable.timeTrackingId,
        ),
      );

  $$TimeTrackingUnitTableTableProcessedTableManager
  get timeTrackingUnitTableRefs {
    final manager = $$TimeTrackingUnitTableTableTableManager(
      $_db,
      $_db.timeTrackingUnitTable,
    ).filter((f) => f.timeTrackingId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _timeTrackingUnitTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TimeTrackingTableTableFilterComposer
    extends Composer<_$UserDataDB, $TimeTrackingTableTable> {
  $$TimeTrackingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> timeTrackingUnitTableRefs(
    Expression<bool> Function($$TimeTrackingUnitTableTableFilterComposer f) f,
  ) {
    final $$TimeTrackingUnitTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.timeTrackingUnitTable,
          getReferencedColumn: (t) => t.timeTrackingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TimeTrackingUnitTableTableFilterComposer(
                $db: $db,
                $table: $db.timeTrackingUnitTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TimeTrackingTableTableOrderingComposer
    extends Composer<_$UserDataDB, $TimeTrackingTableTable> {
  $$TimeTrackingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeTrackingTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $TimeTrackingTableTable> {
  $$TimeTrackingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  Expression<T> timeTrackingUnitTableRefs<T extends Object>(
    Expression<T> Function($$TimeTrackingUnitTableTableAnnotationComposer a) f,
  ) {
    final $$TimeTrackingUnitTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.timeTrackingUnitTable,
          getReferencedColumn: (t) => t.timeTrackingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TimeTrackingUnitTableTableAnnotationComposer(
                $db: $db,
                $table: $db.timeTrackingUnitTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TimeTrackingTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $TimeTrackingTableTable,
          TimeTrackingTableData,
          $$TimeTrackingTableTableFilterComposer,
          $$TimeTrackingTableTableOrderingComposer,
          $$TimeTrackingTableTableAnnotationComposer,
          $$TimeTrackingTableTableCreateCompanionBuilder,
          $$TimeTrackingTableTableUpdateCompanionBuilder,
          (TimeTrackingTableData, $$TimeTrackingTableTableReferences),
          TimeTrackingTableData,
          PrefetchHooks Function({bool timeTrackingUnitTableRefs})
        > {
  $$TimeTrackingTableTableTableManager(
    _$UserDataDB db,
    $TimeTrackingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeTrackingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeTrackingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeTrackingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => TimeTrackingTableCompanion(
                id: id,
                category: category,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String category,
                required String tags,
              }) => TimeTrackingTableCompanion.insert(
                id: id,
                category: category,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeTrackingTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({timeTrackingUnitTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (timeTrackingUnitTableRefs) db.timeTrackingUnitTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (timeTrackingUnitTableRefs)
                    await $_getPrefetchedData<
                      TimeTrackingTableData,
                      $TimeTrackingTableTable,
                      TimeTrackingUnitTableData
                    >(
                      currentTable: table,
                      referencedTable: $$TimeTrackingTableTableReferences
                          ._timeTrackingUnitTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TimeTrackingTableTableReferences(
                            db,
                            table,
                            p0,
                          ).timeTrackingUnitTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.timeTrackingId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TimeTrackingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $TimeTrackingTableTable,
      TimeTrackingTableData,
      $$TimeTrackingTableTableFilterComposer,
      $$TimeTrackingTableTableOrderingComposer,
      $$TimeTrackingTableTableAnnotationComposer,
      $$TimeTrackingTableTableCreateCompanionBuilder,
      $$TimeTrackingTableTableUpdateCompanionBuilder,
      (TimeTrackingTableData, $$TimeTrackingTableTableReferences),
      TimeTrackingTableData,
      PrefetchHooks Function({bool timeTrackingUnitTableRefs})
    >;
typedef $$TimeTrackingUnitTableTableCreateCompanionBuilder =
    TimeTrackingUnitTableCompanion Function({
      Value<int> id,
      required int timeTrackingId,
      required DateTime startTime,
      Value<DateTime?> endTime,
    });
typedef $$TimeTrackingUnitTableTableUpdateCompanionBuilder =
    TimeTrackingUnitTableCompanion Function({
      Value<int> id,
      Value<int> timeTrackingId,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
    });

final class $$TimeTrackingUnitTableTableReferences
    extends
        BaseReferences<
          _$UserDataDB,
          $TimeTrackingUnitTableTable,
          TimeTrackingUnitTableData
        > {
  $$TimeTrackingUnitTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TimeTrackingTableTable _timeTrackingIdTable(_$UserDataDB db) =>
      db.timeTrackingTable.createAlias(
        $_aliasNameGenerator(
          db.timeTrackingUnitTable.timeTrackingId,
          db.timeTrackingTable.id,
        ),
      );

  $$TimeTrackingTableTableProcessedTableManager get timeTrackingId {
    final $_column = $_itemColumn<int>('time_tracking_id')!;

    final manager = $$TimeTrackingTableTableTableManager(
      $_db,
      $_db.timeTrackingTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_timeTrackingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimeTrackingUnitTableTableFilterComposer
    extends Composer<_$UserDataDB, $TimeTrackingUnitTableTable> {
  $$TimeTrackingUnitTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  $$TimeTrackingTableTableFilterComposer get timeTrackingId {
    final $$TimeTrackingTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeTrackingId,
      referencedTable: $db.timeTrackingTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeTrackingTableTableFilterComposer(
            $db: $db,
            $table: $db.timeTrackingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeTrackingUnitTableTableOrderingComposer
    extends Composer<_$UserDataDB, $TimeTrackingUnitTableTable> {
  $$TimeTrackingUnitTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$TimeTrackingTableTableOrderingComposer get timeTrackingId {
    final $$TimeTrackingTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.timeTrackingId,
      referencedTable: $db.timeTrackingTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeTrackingTableTableOrderingComposer(
            $db: $db,
            $table: $db.timeTrackingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeTrackingUnitTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $TimeTrackingUnitTableTable> {
  $$TimeTrackingUnitTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  $$TimeTrackingTableTableAnnotationComposer get timeTrackingId {
    final $$TimeTrackingTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.timeTrackingId,
          referencedTable: $db.timeTrackingTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TimeTrackingTableTableAnnotationComposer(
                $db: $db,
                $table: $db.timeTrackingTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TimeTrackingUnitTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $TimeTrackingUnitTableTable,
          TimeTrackingUnitTableData,
          $$TimeTrackingUnitTableTableFilterComposer,
          $$TimeTrackingUnitTableTableOrderingComposer,
          $$TimeTrackingUnitTableTableAnnotationComposer,
          $$TimeTrackingUnitTableTableCreateCompanionBuilder,
          $$TimeTrackingUnitTableTableUpdateCompanionBuilder,
          (TimeTrackingUnitTableData, $$TimeTrackingUnitTableTableReferences),
          TimeTrackingUnitTableData,
          PrefetchHooks Function({bool timeTrackingId})
        > {
  $$TimeTrackingUnitTableTableTableManager(
    _$UserDataDB db,
    $TimeTrackingUnitTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeTrackingUnitTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TimeTrackingUnitTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TimeTrackingUnitTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> timeTrackingId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
              }) => TimeTrackingUnitTableCompanion(
                id: id,
                timeTrackingId: timeTrackingId,
                startTime: startTime,
                endTime: endTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int timeTrackingId,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
              }) => TimeTrackingUnitTableCompanion.insert(
                id: id,
                timeTrackingId: timeTrackingId,
                startTime: startTime,
                endTime: endTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeTrackingUnitTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({timeTrackingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (timeTrackingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.timeTrackingId,
                                referencedTable:
                                    $$TimeTrackingUnitTableTableReferences
                                        ._timeTrackingIdTable(db),
                                referencedColumn:
                                    $$TimeTrackingUnitTableTableReferences
                                        ._timeTrackingIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TimeTrackingUnitTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $TimeTrackingUnitTableTable,
      TimeTrackingUnitTableData,
      $$TimeTrackingUnitTableTableFilterComposer,
      $$TimeTrackingUnitTableTableOrderingComposer,
      $$TimeTrackingUnitTableTableAnnotationComposer,
      $$TimeTrackingUnitTableTableCreateCompanionBuilder,
      $$TimeTrackingUnitTableTableUpdateCompanionBuilder,
      (TimeTrackingUnitTableData, $$TimeTrackingUnitTableTableReferences),
      TimeTrackingUnitTableData,
      PrefetchHooks Function({bool timeTrackingId})
    >;

class $UserDataDBManager {
  final _$UserDataDB _db;
  $UserDataDBManager(this._db);
  $$WordListNodesTableTableTableManager get wordListNodesTable =>
      $$WordListNodesTableTableTableManager(_db, _db.wordListNodesTable);
  $$WordListEntriesTableTableTableManager get wordListEntriesTable =>
      $$WordListEntriesTableTableTableManager(_db, _db.wordListEntriesTable);
  $$DictStatsTableTableTableManager get dictStatsTable =>
      $$DictStatsTableTableTableManager(_db, _db.dictStatsTable);
  $$TimeTrackingTableTableTableManager get timeTrackingTable =>
      $$TimeTrackingTableTableTableManager(_db, _db.timeTrackingTable);
  $$TimeTrackingUnitTableTableTableManager get timeTrackingUnitTable =>
      $$TimeTrackingUnitTableTableTableManager(_db, _db.timeTrackingUnitTable);
}
