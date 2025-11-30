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

class $SearchHistoryTableTable extends SearchHistoryTable
    with TableInfo<$SearchHistoryTableTable, SearchHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dateSearchedMeta = const VerificationMeta(
    'dateSearched',
  );
  @override
  late final GeneratedColumn<DateTime> dateSearched = GeneratedColumn<DateTime>(
    'date_searched',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [id, dateSearched, dictEntryID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_searched')) {
      context.handle(
        _dateSearchedMeta,
        dateSearched.isAcceptableOrUnknown(
          data['date_searched']!,
          _dateSearchedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateSearchedMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dateSearched: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_searched'],
      )!,
      dictEntryID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dict_entry_i_d'],
      )!,
    );
  }

  @override
  $SearchHistoryTableTable createAlias(String alias) {
    return $SearchHistoryTableTable(attachedDatabase, alias);
  }
}

class SearchHistoryTableData extends DataClass
    implements Insertable<SearchHistoryTableData> {
  /// Id of this row
  final int id;

  /// The timestamp of when this entry was searched
  final DateTime dateSearched;

  /// The id of the dictionary entry that has been looked up
  final int dictEntryID;
  const SearchHistoryTableData({
    required this.id,
    required this.dateSearched,
    required this.dictEntryID,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date_searched'] = Variable<DateTime>(dateSearched);
    map['dict_entry_i_d'] = Variable<int>(dictEntryID);
    return map;
  }

  SearchHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoryTableCompanion(
      id: Value(id),
      dateSearched: Value(dateSearched),
      dictEntryID: Value(dictEntryID),
    );
  }

  factory SearchHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryTableData(
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

  SearchHistoryTableData copyWith({
    int? id,
    DateTime? dateSearched,
    int? dictEntryID,
  }) => SearchHistoryTableData(
    id: id ?? this.id,
    dateSearched: dateSearched ?? this.dateSearched,
    dictEntryID: dictEntryID ?? this.dictEntryID,
  );
  SearchHistoryTableData copyWithCompanion(SearchHistoryTableCompanion data) {
    return SearchHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      dateSearched: data.dateSearched.present
          ? data.dateSearched.value
          : this.dateSearched,
      dictEntryID: data.dictEntryID.present
          ? data.dictEntryID.value
          : this.dictEntryID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryTableData(')
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
      (other is SearchHistoryTableData &&
          other.id == this.id &&
          other.dateSearched == this.dateSearched &&
          other.dictEntryID == this.dictEntryID);
}

class SearchHistoryTableCompanion
    extends UpdateCompanion<SearchHistoryTableData> {
  final Value<int> id;
  final Value<DateTime> dateSearched;
  final Value<int> dictEntryID;
  const SearchHistoryTableCompanion({
    this.id = const Value.absent(),
    this.dateSearched = const Value.absent(),
    this.dictEntryID = const Value.absent(),
  });
  SearchHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime dateSearched,
    required int dictEntryID,
  }) : dateSearched = Value(dateSearched),
       dictEntryID = Value(dictEntryID);
  static Insertable<SearchHistoryTableData> custom({
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

  SearchHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? dateSearched,
    Value<int>? dictEntryID,
  }) {
    return SearchHistoryTableCompanion(
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
    return (StringBuffer('SearchHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('dateSearched: $dateSearched, ')
          ..write('dictEntryID: $dictEntryID')
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, category, tag, isCompleted];
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
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
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
      ),
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
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
  final String? category;
  final String? tag;
  final bool isCompleted;
  const TimeTrackingTableData({
    required this.id,
    this.category,
    this.tag,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  TimeTrackingTableCompanion toCompanion(bool nullToAbsent) {
    return TimeTrackingTableCompanion(
      id: Value(id),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      isCompleted: Value(isCompleted),
    );
  }

  factory TimeTrackingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeTrackingTableData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String?>(json['category']),
      tag: serializer.fromJson<String?>(json['tag']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String?>(category),
      'tag': serializer.toJson<String?>(tag),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  TimeTrackingTableData copyWith({
    int? id,
    Value<String?> category = const Value.absent(),
    Value<String?> tag = const Value.absent(),
    bool? isCompleted,
  }) => TimeTrackingTableData(
    id: id ?? this.id,
    category: category.present ? category.value : this.category,
    tag: tag.present ? tag.value : this.tag,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  TimeTrackingTableData copyWithCompanion(TimeTrackingTableCompanion data) {
    return TimeTrackingTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      tag: data.tag.present ? data.tag.value : this.tag,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingTableData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('tag: $tag, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, tag, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeTrackingTableData &&
          other.id == this.id &&
          other.category == this.category &&
          other.tag == this.tag &&
          other.isCompleted == this.isCompleted);
}

class TimeTrackingTableCompanion
    extends UpdateCompanion<TimeTrackingTableData> {
  final Value<int> id;
  final Value<String?> category;
  final Value<String?> tag;
  final Value<bool> isCompleted;
  const TimeTrackingTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.tag = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TimeTrackingTableCompanion.insert({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.tag = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  static Insertable<TimeTrackingTableData> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? tag,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (tag != null) 'tag': tag,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  TimeTrackingTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? category,
    Value<String?>? tag,
    Value<bool>? isCompleted,
  }) {
    return TimeTrackingTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      tag: tag ?? this.tag,
      isCompleted: isCompleted ?? this.isCompleted,
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
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('tag: $tag, ')
          ..write('isCompleted: $isCompleted')
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

class $TimeTrackingCategoriesTableTable extends TimeTrackingCategoriesTable
    with
        TableInfo<
          $TimeTrackingCategoriesTableTable,
          TimeTrackingCategoriesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeTrackingCategoriesTableTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, category, isSelected];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_tracking_categories_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeTrackingCategoriesTableData> instance, {
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
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeTrackingCategoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeTrackingCategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
    );
  }

  @override
  $TimeTrackingCategoriesTableTable createAlias(String alias) {
    return $TimeTrackingCategoriesTableTable(attachedDatabase, alias);
  }
}

class TimeTrackingCategoriesTableData extends DataClass
    implements Insertable<TimeTrackingCategoriesTableData> {
  final int id;
  final String category;
  final bool isSelected;
  const TimeTrackingCategoriesTableData({
    required this.id,
    required this.category,
    required this.isSelected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['is_selected'] = Variable<bool>(isSelected);
    return map;
  }

  TimeTrackingCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return TimeTrackingCategoriesTableCompanion(
      id: Value(id),
      category: Value(category),
      isSelected: Value(isSelected),
    );
  }

  factory TimeTrackingCategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeTrackingCategoriesTableData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'isSelected': serializer.toJson<bool>(isSelected),
    };
  }

  TimeTrackingCategoriesTableData copyWith({
    int? id,
    String? category,
    bool? isSelected,
  }) => TimeTrackingCategoriesTableData(
    id: id ?? this.id,
    category: category ?? this.category,
    isSelected: isSelected ?? this.isSelected,
  );
  TimeTrackingCategoriesTableData copyWithCompanion(
    TimeTrackingCategoriesTableCompanion data,
  ) {
    return TimeTrackingCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingCategoriesTableData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, isSelected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeTrackingCategoriesTableData &&
          other.id == this.id &&
          other.category == this.category &&
          other.isSelected == this.isSelected);
}

class TimeTrackingCategoriesTableCompanion
    extends UpdateCompanion<TimeTrackingCategoriesTableData> {
  final Value<int> id;
  final Value<String> category;
  final Value<bool> isSelected;
  const TimeTrackingCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  TimeTrackingCategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    this.isSelected = const Value.absent(),
  }) : category = Value(category);
  static Insertable<TimeTrackingCategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<bool>? isSelected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (isSelected != null) 'is_selected': isSelected,
    });
  }

  TimeTrackingCategoriesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<bool>? isSelected,
  }) {
    return TimeTrackingCategoriesTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      isSelected: isSelected ?? this.isSelected,
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
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }
}

class $TimeTrackingTagsTableTable extends TimeTrackingTagsTable
    with TableInfo<$TimeTrackingTagsTableTable, TimeTrackingTagsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeTrackingTagsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tag, isSelected];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_tracking_tags_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeTrackingTagsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeTrackingTagsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeTrackingTagsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
    );
  }

  @override
  $TimeTrackingTagsTableTable createAlias(String alias) {
    return $TimeTrackingTagsTableTable(attachedDatabase, alias);
  }
}

class TimeTrackingTagsTableData extends DataClass
    implements Insertable<TimeTrackingTagsTableData> {
  final int id;
  final String tag;
  final bool isSelected;
  const TimeTrackingTagsTableData({
    required this.id,
    required this.tag,
    required this.isSelected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag'] = Variable<String>(tag);
    map['is_selected'] = Variable<bool>(isSelected);
    return map;
  }

  TimeTrackingTagsTableCompanion toCompanion(bool nullToAbsent) {
    return TimeTrackingTagsTableCompanion(
      id: Value(id),
      tag: Value(tag),
      isSelected: Value(isSelected),
    );
  }

  factory TimeTrackingTagsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeTrackingTagsTableData(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String>(json['tag']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String>(tag),
      'isSelected': serializer.toJson<bool>(isSelected),
    };
  }

  TimeTrackingTagsTableData copyWith({
    int? id,
    String? tag,
    bool? isSelected,
  }) => TimeTrackingTagsTableData(
    id: id ?? this.id,
    tag: tag ?? this.tag,
    isSelected: isSelected ?? this.isSelected,
  );
  TimeTrackingTagsTableData copyWithCompanion(
    TimeTrackingTagsTableCompanion data,
  ) {
    return TimeTrackingTagsTableData(
      id: data.id.present ? data.id.value : this.id,
      tag: data.tag.present ? data.tag.value : this.tag,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingTagsTableData(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tag, isSelected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeTrackingTagsTableData &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.isSelected == this.isSelected);
}

class TimeTrackingTagsTableCompanion
    extends UpdateCompanion<TimeTrackingTagsTableData> {
  final Value<int> id;
  final Value<String> tag;
  final Value<bool> isSelected;
  const TimeTrackingTagsTableCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  TimeTrackingTagsTableCompanion.insert({
    this.id = const Value.absent(),
    required String tag,
    this.isSelected = const Value.absent(),
  }) : tag = Value(tag);
  static Insertable<TimeTrackingTagsTableData> custom({
    Expression<int>? id,
    Expression<String>? tag,
    Expression<bool>? isSelected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (isSelected != null) 'is_selected': isSelected,
    });
  }

  TimeTrackingTagsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? tag,
    Value<bool>? isSelected,
  }) {
    return TimeTrackingTagsTableCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeTrackingTagsTableCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('isSelected: $isSelected')
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
  late final $SearchHistoryTableTable searchHistoryTable =
      $SearchHistoryTableTable(this);
  late final $DictStatsTableTable dictStatsTable = $DictStatsTableTable(this);
  late final $TimeTrackingTableTable timeTrackingTable =
      $TimeTrackingTableTable(this);
  late final $TimeTrackingUnitTableTable timeTrackingUnitTable =
      $TimeTrackingUnitTableTable(this);
  late final $TimeTrackingCategoriesTableTable timeTrackingCategoriesTable =
      $TimeTrackingCategoriesTableTable(this);
  late final $TimeTrackingTagsTableTable timeTrackingTagsTable =
      $TimeTrackingTagsTableTable(this);
  late final Index timeTrackingIdIndex = Index(
    'timeTrackingIdIndex',
    'CREATE INDEX timeTrackingIdIndex ON time_tracking_unit_table (time_tracking_id)',
  );
  late final WordListsDao wordListsDao = WordListsDao(this as UserDataDB);
  late final SearchHistoryDao searchHistoryDao = SearchHistoryDao(
    this as UserDataDB,
  );
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
    searchHistoryTable,
    dictStatsTable,
    timeTrackingTable,
    timeTrackingUnitTable,
    timeTrackingCategoriesTable,
    timeTrackingTagsTable,
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
typedef $$SearchHistoryTableTableCreateCompanionBuilder =
    SearchHistoryTableCompanion Function({
      Value<int> id,
      required DateTime dateSearched,
      required int dictEntryID,
    });
typedef $$SearchHistoryTableTableUpdateCompanionBuilder =
    SearchHistoryTableCompanion Function({
      Value<int> id,
      Value<DateTime> dateSearched,
      Value<int> dictEntryID,
    });

class $$SearchHistoryTableTableFilterComposer
    extends Composer<_$UserDataDB, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableFilterComposer({
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

  ColumnFilters<DateTime> get dateSearched => $composableBuilder(
    column: $table.dateSearched,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dictEntryID => $composableBuilder(
    column: $table.dictEntryID,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchHistoryTableTableOrderingComposer
    extends Composer<_$UserDataDB, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get dateSearched => $composableBuilder(
    column: $table.dateSearched,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dictEntryID => $composableBuilder(
    column: $table.dictEntryID,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchHistoryTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateSearched => $composableBuilder(
    column: $table.dateSearched,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dictEntryID => $composableBuilder(
    column: $table.dictEntryID,
    builder: (column) => column,
  );
}

class $$SearchHistoryTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $SearchHistoryTableTable,
          SearchHistoryTableData,
          $$SearchHistoryTableTableFilterComposer,
          $$SearchHistoryTableTableOrderingComposer,
          $$SearchHistoryTableTableAnnotationComposer,
          $$SearchHistoryTableTableCreateCompanionBuilder,
          $$SearchHistoryTableTableUpdateCompanionBuilder,
          (
            SearchHistoryTableData,
            BaseReferences<
              _$UserDataDB,
              $SearchHistoryTableTable,
              SearchHistoryTableData
            >,
          ),
          SearchHistoryTableData,
          PrefetchHooks Function()
        > {
  $$SearchHistoryTableTableTableManager(
    _$UserDataDB db,
    $SearchHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> dateSearched = const Value.absent(),
                Value<int> dictEntryID = const Value.absent(),
              }) => SearchHistoryTableCompanion(
                id: id,
                dateSearched: dateSearched,
                dictEntryID: dictEntryID,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime dateSearched,
                required int dictEntryID,
              }) => SearchHistoryTableCompanion.insert(
                id: id,
                dateSearched: dateSearched,
                dictEntryID: dictEntryID,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $SearchHistoryTableTable,
      SearchHistoryTableData,
      $$SearchHistoryTableTableFilterComposer,
      $$SearchHistoryTableTableOrderingComposer,
      $$SearchHistoryTableTableAnnotationComposer,
      $$SearchHistoryTableTableCreateCompanionBuilder,
      $$SearchHistoryTableTableUpdateCompanionBuilder,
      (
        SearchHistoryTableData,
        BaseReferences<
          _$UserDataDB,
          $SearchHistoryTableTable,
          SearchHistoryTableData
        >,
      ),
      SearchHistoryTableData,
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
      Value<String?> category,
      Value<String?> tag,
      Value<bool> isCompleted,
    });
typedef $$TimeTrackingTableTableUpdateCompanionBuilder =
    TimeTrackingTableCompanion Function({
      Value<int> id,
      Value<String?> category,
      Value<String?> tag,
      Value<bool> isCompleted,
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

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
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

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
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

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

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
                Value<String?> category = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => TimeTrackingTableCompanion(
                id: id,
                category: category,
                tag: tag,
                isCompleted: isCompleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => TimeTrackingTableCompanion.insert(
                id: id,
                category: category,
                tag: tag,
                isCompleted: isCompleted,
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
typedef $$TimeTrackingCategoriesTableTableCreateCompanionBuilder =
    TimeTrackingCategoriesTableCompanion Function({
      Value<int> id,
      required String category,
      Value<bool> isSelected,
    });
typedef $$TimeTrackingCategoriesTableTableUpdateCompanionBuilder =
    TimeTrackingCategoriesTableCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<bool> isSelected,
    });

class $$TimeTrackingCategoriesTableTableFilterComposer
    extends Composer<_$UserDataDB, $TimeTrackingCategoriesTableTable> {
  $$TimeTrackingCategoriesTableTableFilterComposer({
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

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimeTrackingCategoriesTableTableOrderingComposer
    extends Composer<_$UserDataDB, $TimeTrackingCategoriesTableTable> {
  $$TimeTrackingCategoriesTableTableOrderingComposer({
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

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeTrackingCategoriesTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $TimeTrackingCategoriesTableTable> {
  $$TimeTrackingCategoriesTableTableAnnotationComposer({
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

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );
}

class $$TimeTrackingCategoriesTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $TimeTrackingCategoriesTableTable,
          TimeTrackingCategoriesTableData,
          $$TimeTrackingCategoriesTableTableFilterComposer,
          $$TimeTrackingCategoriesTableTableOrderingComposer,
          $$TimeTrackingCategoriesTableTableAnnotationComposer,
          $$TimeTrackingCategoriesTableTableCreateCompanionBuilder,
          $$TimeTrackingCategoriesTableTableUpdateCompanionBuilder,
          (
            TimeTrackingCategoriesTableData,
            BaseReferences<
              _$UserDataDB,
              $TimeTrackingCategoriesTableTable,
              TimeTrackingCategoriesTableData
            >,
          ),
          TimeTrackingCategoriesTableData,
          PrefetchHooks Function()
        > {
  $$TimeTrackingCategoriesTableTableTableManager(
    _$UserDataDB db,
    $TimeTrackingCategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeTrackingCategoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TimeTrackingCategoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TimeTrackingCategoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
              }) => TimeTrackingCategoriesTableCompanion(
                id: id,
                category: category,
                isSelected: isSelected,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String category,
                Value<bool> isSelected = const Value.absent(),
              }) => TimeTrackingCategoriesTableCompanion.insert(
                id: id,
                category: category,
                isSelected: isSelected,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimeTrackingCategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $TimeTrackingCategoriesTableTable,
      TimeTrackingCategoriesTableData,
      $$TimeTrackingCategoriesTableTableFilterComposer,
      $$TimeTrackingCategoriesTableTableOrderingComposer,
      $$TimeTrackingCategoriesTableTableAnnotationComposer,
      $$TimeTrackingCategoriesTableTableCreateCompanionBuilder,
      $$TimeTrackingCategoriesTableTableUpdateCompanionBuilder,
      (
        TimeTrackingCategoriesTableData,
        BaseReferences<
          _$UserDataDB,
          $TimeTrackingCategoriesTableTable,
          TimeTrackingCategoriesTableData
        >,
      ),
      TimeTrackingCategoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$TimeTrackingTagsTableTableCreateCompanionBuilder =
    TimeTrackingTagsTableCompanion Function({
      Value<int> id,
      required String tag,
      Value<bool> isSelected,
    });
typedef $$TimeTrackingTagsTableTableUpdateCompanionBuilder =
    TimeTrackingTagsTableCompanion Function({
      Value<int> id,
      Value<String> tag,
      Value<bool> isSelected,
    });

class $$TimeTrackingTagsTableTableFilterComposer
    extends Composer<_$UserDataDB, $TimeTrackingTagsTableTable> {
  $$TimeTrackingTagsTableTableFilterComposer({
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

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimeTrackingTagsTableTableOrderingComposer
    extends Composer<_$UserDataDB, $TimeTrackingTagsTableTable> {
  $$TimeTrackingTagsTableTableOrderingComposer({
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

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeTrackingTagsTableTableAnnotationComposer
    extends Composer<_$UserDataDB, $TimeTrackingTagsTableTable> {
  $$TimeTrackingTagsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );
}

class $$TimeTrackingTagsTableTableTableManager
    extends
        RootTableManager<
          _$UserDataDB,
          $TimeTrackingTagsTableTable,
          TimeTrackingTagsTableData,
          $$TimeTrackingTagsTableTableFilterComposer,
          $$TimeTrackingTagsTableTableOrderingComposer,
          $$TimeTrackingTagsTableTableAnnotationComposer,
          $$TimeTrackingTagsTableTableCreateCompanionBuilder,
          $$TimeTrackingTagsTableTableUpdateCompanionBuilder,
          (
            TimeTrackingTagsTableData,
            BaseReferences<
              _$UserDataDB,
              $TimeTrackingTagsTableTable,
              TimeTrackingTagsTableData
            >,
          ),
          TimeTrackingTagsTableData,
          PrefetchHooks Function()
        > {
  $$TimeTrackingTagsTableTableTableManager(
    _$UserDataDB db,
    $TimeTrackingTagsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeTrackingTagsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TimeTrackingTagsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TimeTrackingTagsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tag = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
              }) => TimeTrackingTagsTableCompanion(
                id: id,
                tag: tag,
                isSelected: isSelected,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tag,
                Value<bool> isSelected = const Value.absent(),
              }) => TimeTrackingTagsTableCompanion.insert(
                id: id,
                tag: tag,
                isSelected: isSelected,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimeTrackingTagsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$UserDataDB,
      $TimeTrackingTagsTableTable,
      TimeTrackingTagsTableData,
      $$TimeTrackingTagsTableTableFilterComposer,
      $$TimeTrackingTagsTableTableOrderingComposer,
      $$TimeTrackingTagsTableTableAnnotationComposer,
      $$TimeTrackingTagsTableTableCreateCompanionBuilder,
      $$TimeTrackingTagsTableTableUpdateCompanionBuilder,
      (
        TimeTrackingTagsTableData,
        BaseReferences<
          _$UserDataDB,
          $TimeTrackingTagsTableTable,
          TimeTrackingTagsTableData
        >,
      ),
      TimeTrackingTagsTableData,
      PrefetchHooks Function()
    >;

class $UserDataDBManager {
  final _$UserDataDB _db;
  $UserDataDBManager(this._db);
  $$WordListNodesTableTableTableManager get wordListNodesTable =>
      $$WordListNodesTableTableTableManager(_db, _db.wordListNodesTable);
  $$WordListEntriesTableTableTableManager get wordListEntriesTable =>
      $$WordListEntriesTableTableTableManager(_db, _db.wordListEntriesTable);
  $$SearchHistoryTableTableTableManager get searchHistoryTable =>
      $$SearchHistoryTableTableTableManager(_db, _db.searchHistoryTable);
  $$DictStatsTableTableTableManager get dictStatsTable =>
      $$DictStatsTableTableTableManager(_db, _db.dictStatsTable);
  $$TimeTrackingTableTableTableManager get timeTrackingTable =>
      $$TimeTrackingTableTableTableManager(_db, _db.timeTrackingTable);
  $$TimeTrackingUnitTableTableTableManager get timeTrackingUnitTable =>
      $$TimeTrackingUnitTableTableTableManager(_db, _db.timeTrackingUnitTable);
  $$TimeTrackingCategoriesTableTableTableManager
  get timeTrackingCategoriesTable =>
      $$TimeTrackingCategoriesTableTableTableManager(
        _db,
        _db.timeTrackingCategoriesTable,
      );
  $$TimeTrackingTagsTableTableTableManager get timeTrackingTagsTable =>
      $$TimeTrackingTagsTableTableTableManager(_db, _db.timeTrackingTagsTable);
}
