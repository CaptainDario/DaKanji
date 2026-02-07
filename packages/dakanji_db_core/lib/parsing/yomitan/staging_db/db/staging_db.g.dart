// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staging_db.dart';

// ignore_for_file: type=lint
class $TagStagingTableTable extends TagStagingTable
    with TableInfo<$TagStagingTableTable, TagStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tagNameMeta = const VerificationMeta(
    'tagName',
  );
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
    'tag_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _sortingOrderMeta = const VerificationMeta(
    'sortingOrder',
  );
  @override
  late final GeneratedColumn<int> sortingOrder = GeneratedColumn<int>(
    'sorting_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    tagName,
    category,
    sortingOrder,
    notes,
    score,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tag_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('sorting_order')) {
      context.handle(
        _sortingOrderMeta,
        sortingOrder.isAcceptableOrUnknown(
          data['sorting_order']!,
          _sortingOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sortingOrderMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TagStagingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagStagingTableData(
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      sortingOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sorting_order'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
    );
  }

  @override
  $TagStagingTableTable createAlias(String alias) {
    return $TagStagingTableTable(attachedDatabase, alias);
  }
}

class TagStagingTableData extends DataClass
    implements Insertable<TagStagingTableData> {
  final String tagName;
  final String category;
  final int sortingOrder;
  final String notes;
  final int score;
  const TagStagingTableData({
    required this.tagName,
    required this.category,
    required this.sortingOrder,
    required this.notes,
    required this.score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tag_name'] = Variable<String>(tagName);
    map['category'] = Variable<String>(category);
    map['sorting_order'] = Variable<int>(sortingOrder);
    map['notes'] = Variable<String>(notes);
    map['score'] = Variable<int>(score);
    return map;
  }

  TagStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TagStagingTableCompanion(
      tagName: Value(tagName),
      category: Value(category),
      sortingOrder: Value(sortingOrder),
      notes: Value(notes),
      score: Value(score),
    );
  }

  factory TagStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagStagingTableData(
      tagName: serializer.fromJson<String>(json['tagName']),
      category: serializer.fromJson<String>(json['category']),
      sortingOrder: serializer.fromJson<int>(json['sortingOrder']),
      notes: serializer.fromJson<String>(json['notes']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagName': serializer.toJson<String>(tagName),
      'category': serializer.toJson<String>(category),
      'sortingOrder': serializer.toJson<int>(sortingOrder),
      'notes': serializer.toJson<String>(notes),
      'score': serializer.toJson<int>(score),
    };
  }

  TagStagingTableData copyWith({
    String? tagName,
    String? category,
    int? sortingOrder,
    String? notes,
    int? score,
  }) => TagStagingTableData(
    tagName: tagName ?? this.tagName,
    category: category ?? this.category,
    sortingOrder: sortingOrder ?? this.sortingOrder,
    notes: notes ?? this.notes,
    score: score ?? this.score,
  );
  TagStagingTableData copyWithCompanion(TagStagingTableCompanion data) {
    return TagStagingTableData(
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
      category: data.category.present ? data.category.value : this.category,
      sortingOrder: data.sortingOrder.present
          ? data.sortingOrder.value
          : this.sortingOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagStagingTableData(')
          ..write('tagName: $tagName, ')
          ..write('category: $category, ')
          ..write('sortingOrder: $sortingOrder, ')
          ..write('notes: $notes, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(tagName, category, sortingOrder, notes, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagStagingTableData &&
          other.tagName == this.tagName &&
          other.category == this.category &&
          other.sortingOrder == this.sortingOrder &&
          other.notes == this.notes &&
          other.score == this.score);
}

class TagStagingTableCompanion extends UpdateCompanion<TagStagingTableData> {
  final Value<String> tagName;
  final Value<String> category;
  final Value<int> sortingOrder;
  final Value<String> notes;
  final Value<int> score;
  final Value<int> rowid;
  const TagStagingTableCompanion({
    this.tagName = const Value.absent(),
    this.category = const Value.absent(),
    this.sortingOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagStagingTableCompanion.insert({
    required String tagName,
    required String category,
    required int sortingOrder,
    required String notes,
    required int score,
    this.rowid = const Value.absent(),
  }) : tagName = Value(tagName),
       category = Value(category),
       sortingOrder = Value(sortingOrder),
       notes = Value(notes),
       score = Value(score);
  static Insertable<TagStagingTableData> custom({
    Expression<String>? tagName,
    Expression<String>? category,
    Expression<int>? sortingOrder,
    Expression<String>? notes,
    Expression<int>? score,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tagName != null) 'tag_name': tagName,
      if (category != null) 'category': category,
      if (sortingOrder != null) 'sorting_order': sortingOrder,
      if (notes != null) 'notes': notes,
      if (score != null) 'score': score,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagStagingTableCompanion copyWith({
    Value<String>? tagName,
    Value<String>? category,
    Value<int>? sortingOrder,
    Value<String>? notes,
    Value<int>? score,
    Value<int>? rowid,
  }) {
    return TagStagingTableCompanion(
      tagName: tagName ?? this.tagName,
      category: category ?? this.category,
      sortingOrder: sortingOrder ?? this.sortingOrder,
      notes: notes ?? this.notes,
      score: score ?? this.score,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (sortingOrder.present) {
      map['sorting_order'] = Variable<int>(sortingOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagStagingTableCompanion(')
          ..write('tagName: $tagName, ')
          ..write('category: $category, ')
          ..write('sortingOrder: $sortingOrder, ')
          ..write('notes: $notes, ')
          ..write('score: $score, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermStagingTableTable extends TermStagingTable
    with TableInfo<$TermStagingTableTable, TermStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
    'term',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readingMeta = const VerificationMeta(
    'reading',
  );
  @override
  late final GeneratedColumn<String> reading = GeneratedColumn<String>(
    'reading',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _termNormalizedMeta = const VerificationMeta(
    'termNormalized',
  );
  @override
  late final GeneratedColumn<String> termNormalized = GeneratedColumn<String>(
    'term_normalized',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termTokensMeta = const VerificationMeta(
    'termTokens',
  );
  @override
  late final GeneratedColumn<String> termTokens = GeneratedColumn<String>(
    'term_tokens',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termTokensNormalizedMeta =
      const VerificationMeta('termTokensNormalized');
  @override
  late final GeneratedColumn<String> termTokensNormalized =
      GeneratedColumn<String>(
        'term_tokens_normalized',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _readingNormalizedMeta = const VerificationMeta(
    'readingNormalized',
  );
  @override
  late final GeneratedColumn<String> readingNormalized =
      GeneratedColumn<String>(
        'reading_normalized',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<int> popularity = GeneratedColumn<int>(
    'popularity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sequenceNumberMeta = const VerificationMeta(
    'sequenceNumber',
  );
  @override
  late final GeneratedColumn<int> sequenceNumber = GeneratedColumn<int>(
    'sequence_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<String?, Uint8List> originalJson =
      GeneratedColumn<Uint8List>(
        'original_json',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      ).withConverter<String?>($TermStagingTableTable.$converteroriginalJsonn);
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    term,
    reading,
    termNormalized,
    termTokens,
    termTokensNormalized,
    readingNormalized,
    popularity,
    sequenceNumber,
    originalJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('term')) {
      context.handle(
        _termMeta,
        term.isAcceptableOrUnknown(data['term']!, _termMeta),
      );
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(
        _readingMeta,
        reading.isAcceptableOrUnknown(data['reading']!, _readingMeta),
      );
    } else if (isInserting) {
      context.missing(_readingMeta);
    }
    if (data.containsKey('term_normalized')) {
      context.handle(
        _termNormalizedMeta,
        termNormalized.isAcceptableOrUnknown(
          data['term_normalized']!,
          _termNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('term_tokens')) {
      context.handle(
        _termTokensMeta,
        termTokens.isAcceptableOrUnknown(data['term_tokens']!, _termTokensMeta),
      );
    }
    if (data.containsKey('term_tokens_normalized')) {
      context.handle(
        _termTokensNormalizedMeta,
        termTokensNormalized.isAcceptableOrUnknown(
          data['term_tokens_normalized']!,
          _termTokensNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('reading_normalized')) {
      context.handle(
        _readingNormalizedMeta,
        readingNormalized.isAcceptableOrUnknown(
          data['reading_normalized']!,
          _readingNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('sequence_number')) {
      context.handle(
        _sequenceNumberMeta,
        sequenceNumber.isAcceptableOrUnknown(
          data['sequence_number']!,
          _sequenceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sequenceNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  TermStagingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermStagingTableData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      term: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term'],
      )!,
      reading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading'],
      )!,
      termNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term_normalized'],
      ),
      termTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term_tokens'],
      ),
      termTokensNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term_tokens_normalized'],
      ),
      readingNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_normalized'],
      ),
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}popularity'],
      )!,
      sequenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_number'],
      )!,
      originalJson: $TermStagingTableTable.$converteroriginalJsonn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}original_json'],
        ),
      ),
    );
  }

  @override
  $TermStagingTableTable createAlias(String alias) {
    return $TermStagingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<String, Uint8List> $converteroriginalJson =
      const ZlibStringConverter();
  static TypeConverter<String?, Uint8List?> $converteroriginalJsonn =
      NullAwareTypeConverter.wrap($converteroriginalJson);
}

class TermStagingTableData extends DataClass
    implements Insertable<TermStagingTableData> {
  final int localId;
  final String term;
  final String reading;
  final String? termNormalized;
  final String? termTokens;
  final String? termTokensNormalized;
  final String? readingNormalized;
  final int popularity;
  final int sequenceNumber;
  final String? originalJson;
  const TermStagingTableData({
    required this.localId,
    required this.term,
    required this.reading,
    this.termNormalized,
    this.termTokens,
    this.termTokensNormalized,
    this.readingNormalized,
    required this.popularity,
    required this.sequenceNumber,
    this.originalJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['term'] = Variable<String>(term);
    map['reading'] = Variable<String>(reading);
    if (!nullToAbsent || termNormalized != null) {
      map['term_normalized'] = Variable<String>(termNormalized);
    }
    if (!nullToAbsent || termTokens != null) {
      map['term_tokens'] = Variable<String>(termTokens);
    }
    if (!nullToAbsent || termTokensNormalized != null) {
      map['term_tokens_normalized'] = Variable<String>(termTokensNormalized);
    }
    if (!nullToAbsent || readingNormalized != null) {
      map['reading_normalized'] = Variable<String>(readingNormalized);
    }
    map['popularity'] = Variable<int>(popularity);
    map['sequence_number'] = Variable<int>(sequenceNumber);
    if (!nullToAbsent || originalJson != null) {
      map['original_json'] = Variable<Uint8List>(
        $TermStagingTableTable.$converteroriginalJsonn.toSql(originalJson),
      );
    }
    return map;
  }

  TermStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermStagingTableCompanion(
      localId: Value(localId),
      term: Value(term),
      reading: Value(reading),
      termNormalized: termNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(termNormalized),
      termTokens: termTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(termTokens),
      termTokensNormalized: termTokensNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(termTokensNormalized),
      readingNormalized: readingNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(readingNormalized),
      popularity: Value(popularity),
      sequenceNumber: Value(sequenceNumber),
      originalJson: originalJson == null && nullToAbsent
          ? const Value.absent()
          : Value(originalJson),
    );
  }

  factory TermStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermStagingTableData(
      localId: serializer.fromJson<int>(json['localId']),
      term: serializer.fromJson<String>(json['term']),
      reading: serializer.fromJson<String>(json['reading']),
      termNormalized: serializer.fromJson<String?>(json['termNormalized']),
      termTokens: serializer.fromJson<String?>(json['termTokens']),
      termTokensNormalized: serializer.fromJson<String?>(
        json['termTokensNormalized'],
      ),
      readingNormalized: serializer.fromJson<String?>(
        json['readingNormalized'],
      ),
      popularity: serializer.fromJson<int>(json['popularity']),
      sequenceNumber: serializer.fromJson<int>(json['sequenceNumber']),
      originalJson: serializer.fromJson<String?>(json['originalJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'term': serializer.toJson<String>(term),
      'reading': serializer.toJson<String>(reading),
      'termNormalized': serializer.toJson<String?>(termNormalized),
      'termTokens': serializer.toJson<String?>(termTokens),
      'termTokensNormalized': serializer.toJson<String?>(termTokensNormalized),
      'readingNormalized': serializer.toJson<String?>(readingNormalized),
      'popularity': serializer.toJson<int>(popularity),
      'sequenceNumber': serializer.toJson<int>(sequenceNumber),
      'originalJson': serializer.toJson<String?>(originalJson),
    };
  }

  TermStagingTableData copyWith({
    int? localId,
    String? term,
    String? reading,
    Value<String?> termNormalized = const Value.absent(),
    Value<String?> termTokens = const Value.absent(),
    Value<String?> termTokensNormalized = const Value.absent(),
    Value<String?> readingNormalized = const Value.absent(),
    int? popularity,
    int? sequenceNumber,
    Value<String?> originalJson = const Value.absent(),
  }) => TermStagingTableData(
    localId: localId ?? this.localId,
    term: term ?? this.term,
    reading: reading ?? this.reading,
    termNormalized: termNormalized.present
        ? termNormalized.value
        : this.termNormalized,
    termTokens: termTokens.present ? termTokens.value : this.termTokens,
    termTokensNormalized: termTokensNormalized.present
        ? termTokensNormalized.value
        : this.termTokensNormalized,
    readingNormalized: readingNormalized.present
        ? readingNormalized.value
        : this.readingNormalized,
    popularity: popularity ?? this.popularity,
    sequenceNumber: sequenceNumber ?? this.sequenceNumber,
    originalJson: originalJson.present ? originalJson.value : this.originalJson,
  );
  TermStagingTableData copyWithCompanion(TermStagingTableCompanion data) {
    return TermStagingTableData(
      localId: data.localId.present ? data.localId.value : this.localId,
      term: data.term.present ? data.term.value : this.term,
      reading: data.reading.present ? data.reading.value : this.reading,
      termNormalized: data.termNormalized.present
          ? data.termNormalized.value
          : this.termNormalized,
      termTokens: data.termTokens.present
          ? data.termTokens.value
          : this.termTokens,
      termTokensNormalized: data.termTokensNormalized.present
          ? data.termTokensNormalized.value
          : this.termTokensNormalized,
      readingNormalized: data.readingNormalized.present
          ? data.readingNormalized.value
          : this.readingNormalized,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      sequenceNumber: data.sequenceNumber.present
          ? data.sequenceNumber.value
          : this.sequenceNumber,
      originalJson: data.originalJson.present
          ? data.originalJson.value
          : this.originalJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermStagingTableData(')
          ..write('localId: $localId, ')
          ..write('term: $term, ')
          ..write('reading: $reading, ')
          ..write('termNormalized: $termNormalized, ')
          ..write('termTokens: $termTokens, ')
          ..write('termTokensNormalized: $termTokensNormalized, ')
          ..write('readingNormalized: $readingNormalized, ')
          ..write('popularity: $popularity, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('originalJson: $originalJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    term,
    reading,
    termNormalized,
    termTokens,
    termTokensNormalized,
    readingNormalized,
    popularity,
    sequenceNumber,
    originalJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermStagingTableData &&
          other.localId == this.localId &&
          other.term == this.term &&
          other.reading == this.reading &&
          other.termNormalized == this.termNormalized &&
          other.termTokens == this.termTokens &&
          other.termTokensNormalized == this.termTokensNormalized &&
          other.readingNormalized == this.readingNormalized &&
          other.popularity == this.popularity &&
          other.sequenceNumber == this.sequenceNumber &&
          other.originalJson == this.originalJson);
}

class TermStagingTableCompanion extends UpdateCompanion<TermStagingTableData> {
  final Value<int> localId;
  final Value<String> term;
  final Value<String> reading;
  final Value<String?> termNormalized;
  final Value<String?> termTokens;
  final Value<String?> termTokensNormalized;
  final Value<String?> readingNormalized;
  final Value<int> popularity;
  final Value<int> sequenceNumber;
  final Value<String?> originalJson;
  const TermStagingTableCompanion({
    this.localId = const Value.absent(),
    this.term = const Value.absent(),
    this.reading = const Value.absent(),
    this.termNormalized = const Value.absent(),
    this.termTokens = const Value.absent(),
    this.termTokensNormalized = const Value.absent(),
    this.readingNormalized = const Value.absent(),
    this.popularity = const Value.absent(),
    this.sequenceNumber = const Value.absent(),
    this.originalJson = const Value.absent(),
  });
  TermStagingTableCompanion.insert({
    this.localId = const Value.absent(),
    required String term,
    required String reading,
    this.termNormalized = const Value.absent(),
    this.termTokens = const Value.absent(),
    this.termTokensNormalized = const Value.absent(),
    this.readingNormalized = const Value.absent(),
    required int popularity,
    required int sequenceNumber,
    this.originalJson = const Value.absent(),
  }) : term = Value(term),
       reading = Value(reading),
       popularity = Value(popularity),
       sequenceNumber = Value(sequenceNumber);
  static Insertable<TermStagingTableData> custom({
    Expression<int>? localId,
    Expression<String>? term,
    Expression<String>? reading,
    Expression<String>? termNormalized,
    Expression<String>? termTokens,
    Expression<String>? termTokensNormalized,
    Expression<String>? readingNormalized,
    Expression<int>? popularity,
    Expression<int>? sequenceNumber,
    Expression<Uint8List>? originalJson,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (term != null) 'term': term,
      if (reading != null) 'reading': reading,
      if (termNormalized != null) 'term_normalized': termNormalized,
      if (termTokens != null) 'term_tokens': termTokens,
      if (termTokensNormalized != null)
        'term_tokens_normalized': termTokensNormalized,
      if (readingNormalized != null) 'reading_normalized': readingNormalized,
      if (popularity != null) 'popularity': popularity,
      if (sequenceNumber != null) 'sequence_number': sequenceNumber,
      if (originalJson != null) 'original_json': originalJson,
    });
  }

  TermStagingTableCompanion copyWith({
    Value<int>? localId,
    Value<String>? term,
    Value<String>? reading,
    Value<String?>? termNormalized,
    Value<String?>? termTokens,
    Value<String?>? termTokensNormalized,
    Value<String?>? readingNormalized,
    Value<int>? popularity,
    Value<int>? sequenceNumber,
    Value<String?>? originalJson,
  }) {
    return TermStagingTableCompanion(
      localId: localId ?? this.localId,
      term: term ?? this.term,
      reading: reading ?? this.reading,
      termNormalized: termNormalized ?? this.termNormalized,
      termTokens: termTokens ?? this.termTokens,
      termTokensNormalized: termTokensNormalized ?? this.termTokensNormalized,
      readingNormalized: readingNormalized ?? this.readingNormalized,
      popularity: popularity ?? this.popularity,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      originalJson: originalJson ?? this.originalJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (termNormalized.present) {
      map['term_normalized'] = Variable<String>(termNormalized.value);
    }
    if (termTokens.present) {
      map['term_tokens'] = Variable<String>(termTokens.value);
    }
    if (termTokensNormalized.present) {
      map['term_tokens_normalized'] = Variable<String>(
        termTokensNormalized.value,
      );
    }
    if (readingNormalized.present) {
      map['reading_normalized'] = Variable<String>(readingNormalized.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<int>(popularity.value);
    }
    if (sequenceNumber.present) {
      map['sequence_number'] = Variable<int>(sequenceNumber.value);
    }
    if (originalJson.present) {
      map['original_json'] = Variable<Uint8List>(
        $TermStagingTableTable.$converteroriginalJsonn.toSql(
          originalJson.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermStagingTableCompanion(')
          ..write('localId: $localId, ')
          ..write('term: $term, ')
          ..write('reading: $reading, ')
          ..write('termNormalized: $termNormalized, ')
          ..write('termTokens: $termTokens, ')
          ..write('termTokensNormalized: $termTokensNormalized, ')
          ..write('readingNormalized: $readingNormalized, ')
          ..write('popularity: $popularity, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('originalJson: $originalJson')
          ..write(')'))
        .toString();
  }
}

class $TermDefinitionStagingTableTable extends TermDefinitionStagingTable
    with
        TableInfo<
          $TermDefinitionStagingTableTable,
          TermDefinitionStagingTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermDefinitionStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termLocalIdMeta = const VerificationMeta(
    'termLocalId',
  );
  @override
  late final GeneratedColumn<int> termLocalId = GeneratedColumn<int>(
    'term_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [termLocalId, definition];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_definition_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermDefinitionStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('term_local_id')) {
      context.handle(
        _termLocalIdMeta,
        termLocalId.isAcceptableOrUnknown(
          data['term_local_id']!,
          _termLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_termLocalIdMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermDefinitionStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermDefinitionStagingTableData(
      termLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}term_local_id'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
    );
  }

  @override
  $TermDefinitionStagingTableTable createAlias(String alias) {
    return $TermDefinitionStagingTableTable(attachedDatabase, alias);
  }
}

class TermDefinitionStagingTableData extends DataClass
    implements Insertable<TermDefinitionStagingTableData> {
  final int termLocalId;
  final String definition;
  const TermDefinitionStagingTableData({
    required this.termLocalId,
    required this.definition,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term_local_id'] = Variable<int>(termLocalId);
    map['definition'] = Variable<String>(definition);
    return map;
  }

  TermDefinitionStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermDefinitionStagingTableCompanion(
      termLocalId: Value(termLocalId),
      definition: Value(definition),
    );
  }

  factory TermDefinitionStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermDefinitionStagingTableData(
      termLocalId: serializer.fromJson<int>(json['termLocalId']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termLocalId': serializer.toJson<int>(termLocalId),
      'definition': serializer.toJson<String>(definition),
    };
  }

  TermDefinitionStagingTableData copyWith({
    int? termLocalId,
    String? definition,
  }) => TermDefinitionStagingTableData(
    termLocalId: termLocalId ?? this.termLocalId,
    definition: definition ?? this.definition,
  );
  TermDefinitionStagingTableData copyWithCompanion(
    TermDefinitionStagingTableCompanion data,
  ) {
    return TermDefinitionStagingTableData(
      termLocalId: data.termLocalId.present
          ? data.termLocalId.value
          : this.termLocalId,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermDefinitionStagingTableData(')
          ..write('termLocalId: $termLocalId, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termLocalId, definition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermDefinitionStagingTableData &&
          other.termLocalId == this.termLocalId &&
          other.definition == this.definition);
}

class TermDefinitionStagingTableCompanion
    extends UpdateCompanion<TermDefinitionStagingTableData> {
  final Value<int> termLocalId;
  final Value<String> definition;
  final Value<int> rowid;
  const TermDefinitionStagingTableCompanion({
    this.termLocalId = const Value.absent(),
    this.definition = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermDefinitionStagingTableCompanion.insert({
    required int termLocalId,
    required String definition,
    this.rowid = const Value.absent(),
  }) : termLocalId = Value(termLocalId),
       definition = Value(definition);
  static Insertable<TermDefinitionStagingTableData> custom({
    Expression<int>? termLocalId,
    Expression<String>? definition,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termLocalId != null) 'term_local_id': termLocalId,
      if (definition != null) 'definition': definition,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermDefinitionStagingTableCompanion copyWith({
    Value<int>? termLocalId,
    Value<String>? definition,
    Value<int>? rowid,
  }) {
    return TermDefinitionStagingTableCompanion(
      termLocalId: termLocalId ?? this.termLocalId,
      definition: definition ?? this.definition,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termLocalId.present) {
      map['term_local_id'] = Variable<int>(termLocalId.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermDefinitionStagingTableCompanion(')
          ..write('termLocalId: $termLocalId, ')
          ..write('definition: $definition, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermTagStagingTableTable extends TermTagStagingTable
    with TableInfo<$TermTagStagingTableTable, TermTagStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermTagStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termLocalIdMeta = const VerificationMeta(
    'termLocalId',
  );
  @override
  late final GeneratedColumn<int> termLocalId = GeneratedColumn<int>(
    'term_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagNameMeta = const VerificationMeta(
    'tagName',
  );
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
    'tag_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefinitionTagMeta = const VerificationMeta(
    'isDefinitionTag',
  );
  @override
  late final GeneratedColumn<bool> isDefinitionTag = GeneratedColumn<bool>(
    'is_definition_tag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_definition_tag" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [termLocalId, tagName, isDefinitionTag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_tag_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermTagStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('term_local_id')) {
      context.handle(
        _termLocalIdMeta,
        termLocalId.isAcceptableOrUnknown(
          data['term_local_id']!,
          _termLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_termLocalIdMeta);
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    if (data.containsKey('is_definition_tag')) {
      context.handle(
        _isDefinitionTagMeta,
        isDefinitionTag.isAcceptableOrUnknown(
          data['is_definition_tag']!,
          _isDefinitionTagMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isDefinitionTagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermTagStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermTagStagingTableData(
      termLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}term_local_id'],
      )!,
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      )!,
      isDefinitionTag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_definition_tag'],
      )!,
    );
  }

  @override
  $TermTagStagingTableTable createAlias(String alias) {
    return $TermTagStagingTableTable(attachedDatabase, alias);
  }
}

class TermTagStagingTableData extends DataClass
    implements Insertable<TermTagStagingTableData> {
  final int termLocalId;
  final String tagName;
  final bool isDefinitionTag;
  const TermTagStagingTableData({
    required this.termLocalId,
    required this.tagName,
    required this.isDefinitionTag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term_local_id'] = Variable<int>(termLocalId);
    map['tag_name'] = Variable<String>(tagName);
    map['is_definition_tag'] = Variable<bool>(isDefinitionTag);
    return map;
  }

  TermTagStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermTagStagingTableCompanion(
      termLocalId: Value(termLocalId),
      tagName: Value(tagName),
      isDefinitionTag: Value(isDefinitionTag),
    );
  }

  factory TermTagStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermTagStagingTableData(
      termLocalId: serializer.fromJson<int>(json['termLocalId']),
      tagName: serializer.fromJson<String>(json['tagName']),
      isDefinitionTag: serializer.fromJson<bool>(json['isDefinitionTag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termLocalId': serializer.toJson<int>(termLocalId),
      'tagName': serializer.toJson<String>(tagName),
      'isDefinitionTag': serializer.toJson<bool>(isDefinitionTag),
    };
  }

  TermTagStagingTableData copyWith({
    int? termLocalId,
    String? tagName,
    bool? isDefinitionTag,
  }) => TermTagStagingTableData(
    termLocalId: termLocalId ?? this.termLocalId,
    tagName: tagName ?? this.tagName,
    isDefinitionTag: isDefinitionTag ?? this.isDefinitionTag,
  );
  TermTagStagingTableData copyWithCompanion(TermTagStagingTableCompanion data) {
    return TermTagStagingTableData(
      termLocalId: data.termLocalId.present
          ? data.termLocalId.value
          : this.termLocalId,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
      isDefinitionTag: data.isDefinitionTag.present
          ? data.isDefinitionTag.value
          : this.isDefinitionTag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermTagStagingTableData(')
          ..write('termLocalId: $termLocalId, ')
          ..write('tagName: $tagName, ')
          ..write('isDefinitionTag: $isDefinitionTag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termLocalId, tagName, isDefinitionTag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermTagStagingTableData &&
          other.termLocalId == this.termLocalId &&
          other.tagName == this.tagName &&
          other.isDefinitionTag == this.isDefinitionTag);
}

class TermTagStagingTableCompanion
    extends UpdateCompanion<TermTagStagingTableData> {
  final Value<int> termLocalId;
  final Value<String> tagName;
  final Value<bool> isDefinitionTag;
  final Value<int> rowid;
  const TermTagStagingTableCompanion({
    this.termLocalId = const Value.absent(),
    this.tagName = const Value.absent(),
    this.isDefinitionTag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermTagStagingTableCompanion.insert({
    required int termLocalId,
    required String tagName,
    required bool isDefinitionTag,
    this.rowid = const Value.absent(),
  }) : termLocalId = Value(termLocalId),
       tagName = Value(tagName),
       isDefinitionTag = Value(isDefinitionTag);
  static Insertable<TermTagStagingTableData> custom({
    Expression<int>? termLocalId,
    Expression<String>? tagName,
    Expression<bool>? isDefinitionTag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termLocalId != null) 'term_local_id': termLocalId,
      if (tagName != null) 'tag_name': tagName,
      if (isDefinitionTag != null) 'is_definition_tag': isDefinitionTag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermTagStagingTableCompanion copyWith({
    Value<int>? termLocalId,
    Value<String>? tagName,
    Value<bool>? isDefinitionTag,
    Value<int>? rowid,
  }) {
    return TermTagStagingTableCompanion(
      termLocalId: termLocalId ?? this.termLocalId,
      tagName: tagName ?? this.tagName,
      isDefinitionTag: isDefinitionTag ?? this.isDefinitionTag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termLocalId.present) {
      map['term_local_id'] = Variable<int>(termLocalId.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (isDefinitionTag.present) {
      map['is_definition_tag'] = Variable<bool>(isDefinitionTag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermTagStagingTableCompanion(')
          ..write('termLocalId: $termLocalId, ')
          ..write('tagName: $tagName, ')
          ..write('isDefinitionTag: $isDefinitionTag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermRuleStagingTableTable extends TermRuleStagingTable
    with TableInfo<$TermRuleStagingTableTable, TermRuleStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermRuleStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termLocalIdMeta = const VerificationMeta(
    'termLocalId',
  );
  @override
  late final GeneratedColumn<int> termLocalId = GeneratedColumn<int>(
    'term_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
    'rule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [termLocalId, ruleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_rule_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermRuleStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('term_local_id')) {
      context.handle(
        _termLocalIdMeta,
        termLocalId.isAcceptableOrUnknown(
          data['term_local_id']!,
          _termLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_termLocalIdMeta);
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermRuleStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermRuleStagingTableData(
      termLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}term_local_id'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_id'],
      )!,
    );
  }

  @override
  $TermRuleStagingTableTable createAlias(String alias) {
    return $TermRuleStagingTableTable(attachedDatabase, alias);
  }
}

class TermRuleStagingTableData extends DataClass
    implements Insertable<TermRuleStagingTableData> {
  final int termLocalId;
  final String ruleId;
  const TermRuleStagingTableData({
    required this.termLocalId,
    required this.ruleId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term_local_id'] = Variable<int>(termLocalId);
    map['rule_id'] = Variable<String>(ruleId);
    return map;
  }

  TermRuleStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermRuleStagingTableCompanion(
      termLocalId: Value(termLocalId),
      ruleId: Value(ruleId),
    );
  }

  factory TermRuleStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermRuleStagingTableData(
      termLocalId: serializer.fromJson<int>(json['termLocalId']),
      ruleId: serializer.fromJson<String>(json['ruleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'termLocalId': serializer.toJson<int>(termLocalId),
      'ruleId': serializer.toJson<String>(ruleId),
    };
  }

  TermRuleStagingTableData copyWith({int? termLocalId, String? ruleId}) =>
      TermRuleStagingTableData(
        termLocalId: termLocalId ?? this.termLocalId,
        ruleId: ruleId ?? this.ruleId,
      );
  TermRuleStagingTableData copyWithCompanion(
    TermRuleStagingTableCompanion data,
  ) {
    return TermRuleStagingTableData(
      termLocalId: data.termLocalId.present
          ? data.termLocalId.value
          : this.termLocalId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermRuleStagingTableData(')
          ..write('termLocalId: $termLocalId, ')
          ..write('ruleId: $ruleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(termLocalId, ruleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermRuleStagingTableData &&
          other.termLocalId == this.termLocalId &&
          other.ruleId == this.ruleId);
}

class TermRuleStagingTableCompanion
    extends UpdateCompanion<TermRuleStagingTableData> {
  final Value<int> termLocalId;
  final Value<String> ruleId;
  final Value<int> rowid;
  const TermRuleStagingTableCompanion({
    this.termLocalId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermRuleStagingTableCompanion.insert({
    required int termLocalId,
    required String ruleId,
    this.rowid = const Value.absent(),
  }) : termLocalId = Value(termLocalId),
       ruleId = Value(ruleId);
  static Insertable<TermRuleStagingTableData> custom({
    Expression<int>? termLocalId,
    Expression<String>? ruleId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (termLocalId != null) 'term_local_id': termLocalId,
      if (ruleId != null) 'rule_id': ruleId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermRuleStagingTableCompanion copyWith({
    Value<int>? termLocalId,
    Value<String>? ruleId,
    Value<int>? rowid,
  }) {
    return TermRuleStagingTableCompanion(
      termLocalId: termLocalId ?? this.termLocalId,
      ruleId: ruleId ?? this.ruleId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (termLocalId.present) {
      map['term_local_id'] = Variable<int>(termLocalId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermRuleStagingTableCompanion(')
          ..write('termLocalId: $termLocalId, ')
          ..write('ruleId: $ruleId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$StagingDatabase extends GeneratedDatabase {
  _$StagingDatabase(QueryExecutor e) : super(e);
  $StagingDatabaseManager get managers => $StagingDatabaseManager(this);
  late final $TagStagingTableTable tagStagingTable = $TagStagingTableTable(
    this,
  );
  late final $TermStagingTableTable termStagingTable = $TermStagingTableTable(
    this,
  );
  late final $TermDefinitionStagingTableTable termDefinitionStagingTable =
      $TermDefinitionStagingTableTable(this);
  late final $TermTagStagingTableTable termTagStagingTable =
      $TermTagStagingTableTable(this);
  late final $TermRuleStagingTableTable termRuleStagingTable =
      $TermRuleStagingTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tagStagingTable,
    termStagingTable,
    termDefinitionStagingTable,
    termTagStagingTable,
    termRuleStagingTable,
  ];
}

typedef $$TagStagingTableTableCreateCompanionBuilder =
    TagStagingTableCompanion Function({
      required String tagName,
      required String category,
      required int sortingOrder,
      required String notes,
      required int score,
      Value<int> rowid,
    });
typedef $$TagStagingTableTableUpdateCompanionBuilder =
    TagStagingTableCompanion Function({
      Value<String> tagName,
      Value<String> category,
      Value<int> sortingOrder,
      Value<String> notes,
      Value<int> score,
      Value<int> rowid,
    });

class $$TagStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TagStagingTableTable> {
  $$TagStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortingOrder => $composableBuilder(
    column: $table.sortingOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TagStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TagStagingTableTable> {
  $$TagStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortingOrder => $composableBuilder(
    column: $table.sortingOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TagStagingTableTable> {
  $$TagStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get sortingOrder => $composableBuilder(
    column: $table.sortingOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);
}

class $$TagStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TagStagingTableTable,
          TagStagingTableData,
          $$TagStagingTableTableFilterComposer,
          $$TagStagingTableTableOrderingComposer,
          $$TagStagingTableTableAnnotationComposer,
          $$TagStagingTableTableCreateCompanionBuilder,
          $$TagStagingTableTableUpdateCompanionBuilder,
          (
            TagStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TagStagingTableTable,
              TagStagingTableData
            >,
          ),
          TagStagingTableData,
          PrefetchHooks Function()
        > {
  $$TagStagingTableTableTableManager(
    _$StagingDatabase db,
    $TagStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagStagingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagStagingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tagName = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> sortingOrder = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagStagingTableCompanion(
                tagName: tagName,
                category: category,
                sortingOrder: sortingOrder,
                notes: notes,
                score: score,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tagName,
                required String category,
                required int sortingOrder,
                required String notes,
                required int score,
                Value<int> rowid = const Value.absent(),
              }) => TagStagingTableCompanion.insert(
                tagName: tagName,
                category: category,
                sortingOrder: sortingOrder,
                notes: notes,
                score: score,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TagStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TagStagingTableTable,
      TagStagingTableData,
      $$TagStagingTableTableFilterComposer,
      $$TagStagingTableTableOrderingComposer,
      $$TagStagingTableTableAnnotationComposer,
      $$TagStagingTableTableCreateCompanionBuilder,
      $$TagStagingTableTableUpdateCompanionBuilder,
      (
        TagStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TagStagingTableTable,
          TagStagingTableData
        >,
      ),
      TagStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermStagingTableTableCreateCompanionBuilder =
    TermStagingTableCompanion Function({
      Value<int> localId,
      required String term,
      required String reading,
      Value<String?> termNormalized,
      Value<String?> termTokens,
      Value<String?> termTokensNormalized,
      Value<String?> readingNormalized,
      required int popularity,
      required int sequenceNumber,
      Value<String?> originalJson,
    });
typedef $$TermStagingTableTableUpdateCompanionBuilder =
    TermStagingTableCompanion Function({
      Value<int> localId,
      Value<String> term,
      Value<String> reading,
      Value<String?> termNormalized,
      Value<String?> termTokens,
      Value<String?> termTokensNormalized,
      Value<String?> readingNormalized,
      Value<int> popularity,
      Value<int> sequenceNumber,
      Value<String?> originalJson,
    });

class $$TermStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermStagingTableTable> {
  $$TermStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termNormalized => $composableBuilder(
    column: $table.termNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termTokens => $composableBuilder(
    column: $table.termTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termTokensNormalized => $composableBuilder(
    column: $table.termTokensNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<String?, String, Uint8List> get originalJson =>
      $composableBuilder(
        column: $table.originalJson,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$TermStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermStagingTableTable> {
  $$TermStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termNormalized => $composableBuilder(
    column: $table.termNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termTokens => $composableBuilder(
    column: $table.termTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termTokensNormalized => $composableBuilder(
    column: $table.termTokensNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get originalJson => $composableBuilder(
    column: $table.originalJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermStagingTableTable> {
  $$TermStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<String> get termNormalized => $composableBuilder(
    column: $table.termNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get termTokens => $composableBuilder(
    column: $table.termTokens,
    builder: (column) => column,
  );

  GeneratedColumn<String> get termTokensNormalized => $composableBuilder(
    column: $table.termTokensNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<int> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<String?, Uint8List> get originalJson =>
      $composableBuilder(
        column: $table.originalJson,
        builder: (column) => column,
      );
}

class $$TermStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermStagingTableTable,
          TermStagingTableData,
          $$TermStagingTableTableFilterComposer,
          $$TermStagingTableTableOrderingComposer,
          $$TermStagingTableTableAnnotationComposer,
          $$TermStagingTableTableCreateCompanionBuilder,
          $$TermStagingTableTableUpdateCompanionBuilder,
          (
            TermStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermStagingTableTable,
              TermStagingTableData
            >,
          ),
          TermStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermStagingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermStagingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String> term = const Value.absent(),
                Value<String> reading = const Value.absent(),
                Value<String?> termNormalized = const Value.absent(),
                Value<String?> termTokens = const Value.absent(),
                Value<String?> termTokensNormalized = const Value.absent(),
                Value<String?> readingNormalized = const Value.absent(),
                Value<int> popularity = const Value.absent(),
                Value<int> sequenceNumber = const Value.absent(),
                Value<String?> originalJson = const Value.absent(),
              }) => TermStagingTableCompanion(
                localId: localId,
                term: term,
                reading: reading,
                termNormalized: termNormalized,
                termTokens: termTokens,
                termTokensNormalized: termTokensNormalized,
                readingNormalized: readingNormalized,
                popularity: popularity,
                sequenceNumber: sequenceNumber,
                originalJson: originalJson,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required String term,
                required String reading,
                Value<String?> termNormalized = const Value.absent(),
                Value<String?> termTokens = const Value.absent(),
                Value<String?> termTokensNormalized = const Value.absent(),
                Value<String?> readingNormalized = const Value.absent(),
                required int popularity,
                required int sequenceNumber,
                Value<String?> originalJson = const Value.absent(),
              }) => TermStagingTableCompanion.insert(
                localId: localId,
                term: term,
                reading: reading,
                termNormalized: termNormalized,
                termTokens: termTokens,
                termTokensNormalized: termTokensNormalized,
                readingNormalized: readingNormalized,
                popularity: popularity,
                sequenceNumber: sequenceNumber,
                originalJson: originalJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermStagingTableTable,
      TermStagingTableData,
      $$TermStagingTableTableFilterComposer,
      $$TermStagingTableTableOrderingComposer,
      $$TermStagingTableTableAnnotationComposer,
      $$TermStagingTableTableCreateCompanionBuilder,
      $$TermStagingTableTableUpdateCompanionBuilder,
      (
        TermStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermStagingTableTable,
          TermStagingTableData
        >,
      ),
      TermStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermDefinitionStagingTableTableCreateCompanionBuilder =
    TermDefinitionStagingTableCompanion Function({
      required int termLocalId,
      required String definition,
      Value<int> rowid,
    });
typedef $$TermDefinitionStagingTableTableUpdateCompanionBuilder =
    TermDefinitionStagingTableCompanion Function({
      Value<int> termLocalId,
      Value<String> definition,
      Value<int> rowid,
    });

class $$TermDefinitionStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermDefinitionStagingTableTable> {
  $$TermDefinitionStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermDefinitionStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermDefinitionStagingTableTable> {
  $$TermDefinitionStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermDefinitionStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermDefinitionStagingTableTable> {
  $$TermDefinitionStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );
}

class $$TermDefinitionStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermDefinitionStagingTableTable,
          TermDefinitionStagingTableData,
          $$TermDefinitionStagingTableTableFilterComposer,
          $$TermDefinitionStagingTableTableOrderingComposer,
          $$TermDefinitionStagingTableTableAnnotationComposer,
          $$TermDefinitionStagingTableTableCreateCompanionBuilder,
          $$TermDefinitionStagingTableTableUpdateCompanionBuilder,
          (
            TermDefinitionStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermDefinitionStagingTableTable,
              TermDefinitionStagingTableData
            >,
          ),
          TermDefinitionStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermDefinitionStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermDefinitionStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermDefinitionStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TermDefinitionStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermDefinitionStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> termLocalId = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermDefinitionStagingTableCompanion(
                termLocalId: termLocalId,
                definition: definition,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int termLocalId,
                required String definition,
                Value<int> rowid = const Value.absent(),
              }) => TermDefinitionStagingTableCompanion.insert(
                termLocalId: termLocalId,
                definition: definition,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermDefinitionStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermDefinitionStagingTableTable,
      TermDefinitionStagingTableData,
      $$TermDefinitionStagingTableTableFilterComposer,
      $$TermDefinitionStagingTableTableOrderingComposer,
      $$TermDefinitionStagingTableTableAnnotationComposer,
      $$TermDefinitionStagingTableTableCreateCompanionBuilder,
      $$TermDefinitionStagingTableTableUpdateCompanionBuilder,
      (
        TermDefinitionStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermDefinitionStagingTableTable,
          TermDefinitionStagingTableData
        >,
      ),
      TermDefinitionStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermTagStagingTableTableCreateCompanionBuilder =
    TermTagStagingTableCompanion Function({
      required int termLocalId,
      required String tagName,
      required bool isDefinitionTag,
      Value<int> rowid,
    });
typedef $$TermTagStagingTableTableUpdateCompanionBuilder =
    TermTagStagingTableCompanion Function({
      Value<int> termLocalId,
      Value<String> tagName,
      Value<bool> isDefinitionTag,
      Value<int> rowid,
    });

class $$TermTagStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermTagStagingTableTable> {
  $$TermTagStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefinitionTag => $composableBuilder(
    column: $table.isDefinitionTag,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermTagStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermTagStagingTableTable> {
  $$TermTagStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefinitionTag => $composableBuilder(
    column: $table.isDefinitionTag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermTagStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermTagStagingTableTable> {
  $$TermTagStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);

  GeneratedColumn<bool> get isDefinitionTag => $composableBuilder(
    column: $table.isDefinitionTag,
    builder: (column) => column,
  );
}

class $$TermTagStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermTagStagingTableTable,
          TermTagStagingTableData,
          $$TermTagStagingTableTableFilterComposer,
          $$TermTagStagingTableTableOrderingComposer,
          $$TermTagStagingTableTableAnnotationComposer,
          $$TermTagStagingTableTableCreateCompanionBuilder,
          $$TermTagStagingTableTableUpdateCompanionBuilder,
          (
            TermTagStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermTagStagingTableTable,
              TermTagStagingTableData
            >,
          ),
          TermTagStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermTagStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermTagStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermTagStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermTagStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermTagStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> termLocalId = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<bool> isDefinitionTag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermTagStagingTableCompanion(
                termLocalId: termLocalId,
                tagName: tagName,
                isDefinitionTag: isDefinitionTag,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int termLocalId,
                required String tagName,
                required bool isDefinitionTag,
                Value<int> rowid = const Value.absent(),
              }) => TermTagStagingTableCompanion.insert(
                termLocalId: termLocalId,
                tagName: tagName,
                isDefinitionTag: isDefinitionTag,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermTagStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermTagStagingTableTable,
      TermTagStagingTableData,
      $$TermTagStagingTableTableFilterComposer,
      $$TermTagStagingTableTableOrderingComposer,
      $$TermTagStagingTableTableAnnotationComposer,
      $$TermTagStagingTableTableCreateCompanionBuilder,
      $$TermTagStagingTableTableUpdateCompanionBuilder,
      (
        TermTagStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermTagStagingTableTable,
          TermTagStagingTableData
        >,
      ),
      TermTagStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermRuleStagingTableTableCreateCompanionBuilder =
    TermRuleStagingTableCompanion Function({
      required int termLocalId,
      required String ruleId,
      Value<int> rowid,
    });
typedef $$TermRuleStagingTableTableUpdateCompanionBuilder =
    TermRuleStagingTableCompanion Function({
      Value<int> termLocalId,
      Value<String> ruleId,
      Value<int> rowid,
    });

class $$TermRuleStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermRuleStagingTableTable> {
  $$TermRuleStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermRuleStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermRuleStagingTableTable> {
  $$TermRuleStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermRuleStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermRuleStagingTableTable> {
  $$TermRuleStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get termLocalId => $composableBuilder(
    column: $table.termLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleId =>
      $composableBuilder(column: $table.ruleId, builder: (column) => column);
}

class $$TermRuleStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermRuleStagingTableTable,
          TermRuleStagingTableData,
          $$TermRuleStagingTableTableFilterComposer,
          $$TermRuleStagingTableTableOrderingComposer,
          $$TermRuleStagingTableTableAnnotationComposer,
          $$TermRuleStagingTableTableCreateCompanionBuilder,
          $$TermRuleStagingTableTableUpdateCompanionBuilder,
          (
            TermRuleStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermRuleStagingTableTable,
              TermRuleStagingTableData
            >,
          ),
          TermRuleStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermRuleStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermRuleStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermRuleStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermRuleStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermRuleStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> termLocalId = const Value.absent(),
                Value<String> ruleId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermRuleStagingTableCompanion(
                termLocalId: termLocalId,
                ruleId: ruleId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int termLocalId,
                required String ruleId,
                Value<int> rowid = const Value.absent(),
              }) => TermRuleStagingTableCompanion.insert(
                termLocalId: termLocalId,
                ruleId: ruleId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermRuleStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermRuleStagingTableTable,
      TermRuleStagingTableData,
      $$TermRuleStagingTableTableFilterComposer,
      $$TermRuleStagingTableTableOrderingComposer,
      $$TermRuleStagingTableTableAnnotationComposer,
      $$TermRuleStagingTableTableCreateCompanionBuilder,
      $$TermRuleStagingTableTableUpdateCompanionBuilder,
      (
        TermRuleStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermRuleStagingTableTable,
          TermRuleStagingTableData
        >,
      ),
      TermRuleStagingTableData,
      PrefetchHooks Function()
    >;

class $StagingDatabaseManager {
  final _$StagingDatabase _db;
  $StagingDatabaseManager(this._db);
  $$TagStagingTableTableTableManager get tagStagingTable =>
      $$TagStagingTableTableTableManager(_db, _db.tagStagingTable);
  $$TermStagingTableTableTableManager get termStagingTable =>
      $$TermStagingTableTableTableManager(_db, _db.termStagingTable);
  $$TermDefinitionStagingTableTableTableManager
  get termDefinitionStagingTable =>
      $$TermDefinitionStagingTableTableTableManager(
        _db,
        _db.termDefinitionStagingTable,
      );
  $$TermTagStagingTableTableTableManager get termTagStagingTable =>
      $$TermTagStagingTableTableTableManager(_db, _db.termTagStagingTable);
  $$TermRuleStagingTableTableTableManager get termRuleStagingTable =>
      $$TermRuleStagingTableTableTableManager(_db, _db.termRuleStagingTable);
}
