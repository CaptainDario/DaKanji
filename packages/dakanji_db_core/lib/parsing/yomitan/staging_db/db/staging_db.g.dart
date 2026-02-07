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

class $TermMetaStagingTableTable extends TermMetaStagingTable
    with TableInfo<$TermMetaStagingTableTable, TermMetaStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
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
  static const VerificationMeta _freqValueMeta = const VerificationMeta(
    'freqValue',
  );
  @override
  late final GeneratedColumn<int> freqValue = GeneratedColumn<int>(
    'freq_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _freqDisplayMeta = const VerificationMeta(
    'freqDisplay',
  );
  @override
  late final GeneratedColumn<String> freqDisplay = GeneratedColumn<String>(
    'freq_display',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    term,
    termNormalized,
    termTokens,
    termTokensNormalized,
    mode,
    reading,
    readingNormalized,
    freqValue,
    freqDisplay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermMetaStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('term')) {
      context.handle(
        _termMeta,
        term.isAcceptableOrUnknown(data['term']!, _termMeta),
      );
    } else if (isInserting) {
      context.missing(_termMeta);
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
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(
        _readingMeta,
        reading.isAcceptableOrUnknown(data['reading']!, _readingMeta),
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
    if (data.containsKey('freq_value')) {
      context.handle(
        _freqValueMeta,
        freqValue.isAcceptableOrUnknown(data['freq_value']!, _freqValueMeta),
      );
    }
    if (data.containsKey('freq_display')) {
      context.handle(
        _freqDisplayMeta,
        freqDisplay.isAcceptableOrUnknown(
          data['freq_display']!,
          _freqDisplayMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermMetaStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaStagingTableData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      term: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term'],
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
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      reading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading'],
      ),
      readingNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_normalized'],
      ),
      freqValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}freq_value'],
      ),
      freqDisplay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}freq_display'],
      ),
    );
  }

  @override
  $TermMetaStagingTableTable createAlias(String alias) {
    return $TermMetaStagingTableTable(attachedDatabase, alias);
  }
}

class TermMetaStagingTableData extends DataClass
    implements Insertable<TermMetaStagingTableData> {
  final int localId;
  final String term;
  final String? termNormalized;
  final String? termTokens;
  final String? termTokensNormalized;
  final String mode;
  final String? reading;
  final String? readingNormalized;
  final int? freqValue;
  final String? freqDisplay;
  const TermMetaStagingTableData({
    required this.localId,
    required this.term,
    this.termNormalized,
    this.termTokens,
    this.termTokensNormalized,
    required this.mode,
    this.reading,
    this.readingNormalized,
    this.freqValue,
    this.freqDisplay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['term'] = Variable<String>(term);
    if (!nullToAbsent || termNormalized != null) {
      map['term_normalized'] = Variable<String>(termNormalized);
    }
    if (!nullToAbsent || termTokens != null) {
      map['term_tokens'] = Variable<String>(termTokens);
    }
    if (!nullToAbsent || termTokensNormalized != null) {
      map['term_tokens_normalized'] = Variable<String>(termTokensNormalized);
    }
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || reading != null) {
      map['reading'] = Variable<String>(reading);
    }
    if (!nullToAbsent || readingNormalized != null) {
      map['reading_normalized'] = Variable<String>(readingNormalized);
    }
    if (!nullToAbsent || freqValue != null) {
      map['freq_value'] = Variable<int>(freqValue);
    }
    if (!nullToAbsent || freqDisplay != null) {
      map['freq_display'] = Variable<String>(freqDisplay);
    }
    return map;
  }

  TermMetaStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaStagingTableCompanion(
      localId: Value(localId),
      term: Value(term),
      termNormalized: termNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(termNormalized),
      termTokens: termTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(termTokens),
      termTokensNormalized: termTokensNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(termTokensNormalized),
      mode: Value(mode),
      reading: reading == null && nullToAbsent
          ? const Value.absent()
          : Value(reading),
      readingNormalized: readingNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(readingNormalized),
      freqValue: freqValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqValue),
      freqDisplay: freqDisplay == null && nullToAbsent
          ? const Value.absent()
          : Value(freqDisplay),
    );
  }

  factory TermMetaStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaStagingTableData(
      localId: serializer.fromJson<int>(json['localId']),
      term: serializer.fromJson<String>(json['term']),
      termNormalized: serializer.fromJson<String?>(json['termNormalized']),
      termTokens: serializer.fromJson<String?>(json['termTokens']),
      termTokensNormalized: serializer.fromJson<String?>(
        json['termTokensNormalized'],
      ),
      mode: serializer.fromJson<String>(json['mode']),
      reading: serializer.fromJson<String?>(json['reading']),
      readingNormalized: serializer.fromJson<String?>(
        json['readingNormalized'],
      ),
      freqValue: serializer.fromJson<int?>(json['freqValue']),
      freqDisplay: serializer.fromJson<String?>(json['freqDisplay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'term': serializer.toJson<String>(term),
      'termNormalized': serializer.toJson<String?>(termNormalized),
      'termTokens': serializer.toJson<String?>(termTokens),
      'termTokensNormalized': serializer.toJson<String?>(termTokensNormalized),
      'mode': serializer.toJson<String>(mode),
      'reading': serializer.toJson<String?>(reading),
      'readingNormalized': serializer.toJson<String?>(readingNormalized),
      'freqValue': serializer.toJson<int?>(freqValue),
      'freqDisplay': serializer.toJson<String?>(freqDisplay),
    };
  }

  TermMetaStagingTableData copyWith({
    int? localId,
    String? term,
    Value<String?> termNormalized = const Value.absent(),
    Value<String?> termTokens = const Value.absent(),
    Value<String?> termTokensNormalized = const Value.absent(),
    String? mode,
    Value<String?> reading = const Value.absent(),
    Value<String?> readingNormalized = const Value.absent(),
    Value<int?> freqValue = const Value.absent(),
    Value<String?> freqDisplay = const Value.absent(),
  }) => TermMetaStagingTableData(
    localId: localId ?? this.localId,
    term: term ?? this.term,
    termNormalized: termNormalized.present
        ? termNormalized.value
        : this.termNormalized,
    termTokens: termTokens.present ? termTokens.value : this.termTokens,
    termTokensNormalized: termTokensNormalized.present
        ? termTokensNormalized.value
        : this.termTokensNormalized,
    mode: mode ?? this.mode,
    reading: reading.present ? reading.value : this.reading,
    readingNormalized: readingNormalized.present
        ? readingNormalized.value
        : this.readingNormalized,
    freqValue: freqValue.present ? freqValue.value : this.freqValue,
    freqDisplay: freqDisplay.present ? freqDisplay.value : this.freqDisplay,
  );
  TermMetaStagingTableData copyWithCompanion(
    TermMetaStagingTableCompanion data,
  ) {
    return TermMetaStagingTableData(
      localId: data.localId.present ? data.localId.value : this.localId,
      term: data.term.present ? data.term.value : this.term,
      termNormalized: data.termNormalized.present
          ? data.termNormalized.value
          : this.termNormalized,
      termTokens: data.termTokens.present
          ? data.termTokens.value
          : this.termTokens,
      termTokensNormalized: data.termTokensNormalized.present
          ? data.termTokensNormalized.value
          : this.termTokensNormalized,
      mode: data.mode.present ? data.mode.value : this.mode,
      reading: data.reading.present ? data.reading.value : this.reading,
      readingNormalized: data.readingNormalized.present
          ? data.readingNormalized.value
          : this.readingNormalized,
      freqValue: data.freqValue.present ? data.freqValue.value : this.freqValue,
      freqDisplay: data.freqDisplay.present
          ? data.freqDisplay.value
          : this.freqDisplay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaStagingTableData(')
          ..write('localId: $localId, ')
          ..write('term: $term, ')
          ..write('termNormalized: $termNormalized, ')
          ..write('termTokens: $termTokens, ')
          ..write('termTokensNormalized: $termTokensNormalized, ')
          ..write('mode: $mode, ')
          ..write('reading: $reading, ')
          ..write('readingNormalized: $readingNormalized, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplay: $freqDisplay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    term,
    termNormalized,
    termTokens,
    termTokensNormalized,
    mode,
    reading,
    readingNormalized,
    freqValue,
    freqDisplay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaStagingTableData &&
          other.localId == this.localId &&
          other.term == this.term &&
          other.termNormalized == this.termNormalized &&
          other.termTokens == this.termTokens &&
          other.termTokensNormalized == this.termTokensNormalized &&
          other.mode == this.mode &&
          other.reading == this.reading &&
          other.readingNormalized == this.readingNormalized &&
          other.freqValue == this.freqValue &&
          other.freqDisplay == this.freqDisplay);
}

class TermMetaStagingTableCompanion
    extends UpdateCompanion<TermMetaStagingTableData> {
  final Value<int> localId;
  final Value<String> term;
  final Value<String?> termNormalized;
  final Value<String?> termTokens;
  final Value<String?> termTokensNormalized;
  final Value<String> mode;
  final Value<String?> reading;
  final Value<String?> readingNormalized;
  final Value<int?> freqValue;
  final Value<String?> freqDisplay;
  final Value<int> rowid;
  const TermMetaStagingTableCompanion({
    this.localId = const Value.absent(),
    this.term = const Value.absent(),
    this.termNormalized = const Value.absent(),
    this.termTokens = const Value.absent(),
    this.termTokensNormalized = const Value.absent(),
    this.mode = const Value.absent(),
    this.reading = const Value.absent(),
    this.readingNormalized = const Value.absent(),
    this.freqValue = const Value.absent(),
    this.freqDisplay = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermMetaStagingTableCompanion.insert({
    required int localId,
    required String term,
    this.termNormalized = const Value.absent(),
    this.termTokens = const Value.absent(),
    this.termTokensNormalized = const Value.absent(),
    required String mode,
    this.reading = const Value.absent(),
    this.readingNormalized = const Value.absent(),
    this.freqValue = const Value.absent(),
    this.freqDisplay = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : localId = Value(localId),
       term = Value(term),
       mode = Value(mode);
  static Insertable<TermMetaStagingTableData> custom({
    Expression<int>? localId,
    Expression<String>? term,
    Expression<String>? termNormalized,
    Expression<String>? termTokens,
    Expression<String>? termTokensNormalized,
    Expression<String>? mode,
    Expression<String>? reading,
    Expression<String>? readingNormalized,
    Expression<int>? freqValue,
    Expression<String>? freqDisplay,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (term != null) 'term': term,
      if (termNormalized != null) 'term_normalized': termNormalized,
      if (termTokens != null) 'term_tokens': termTokens,
      if (termTokensNormalized != null)
        'term_tokens_normalized': termTokensNormalized,
      if (mode != null) 'mode': mode,
      if (reading != null) 'reading': reading,
      if (readingNormalized != null) 'reading_normalized': readingNormalized,
      if (freqValue != null) 'freq_value': freqValue,
      if (freqDisplay != null) 'freq_display': freqDisplay,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermMetaStagingTableCompanion copyWith({
    Value<int>? localId,
    Value<String>? term,
    Value<String?>? termNormalized,
    Value<String?>? termTokens,
    Value<String?>? termTokensNormalized,
    Value<String>? mode,
    Value<String?>? reading,
    Value<String?>? readingNormalized,
    Value<int?>? freqValue,
    Value<String?>? freqDisplay,
    Value<int>? rowid,
  }) {
    return TermMetaStagingTableCompanion(
      localId: localId ?? this.localId,
      term: term ?? this.term,
      termNormalized: termNormalized ?? this.termNormalized,
      termTokens: termTokens ?? this.termTokens,
      termTokensNormalized: termTokensNormalized ?? this.termTokensNormalized,
      mode: mode ?? this.mode,
      reading: reading ?? this.reading,
      readingNormalized: readingNormalized ?? this.readingNormalized,
      freqValue: freqValue ?? this.freqValue,
      freqDisplay: freqDisplay ?? this.freqDisplay,
      rowid: rowid ?? this.rowid,
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
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (readingNormalized.present) {
      map['reading_normalized'] = Variable<String>(readingNormalized.value);
    }
    if (freqValue.present) {
      map['freq_value'] = Variable<int>(freqValue.value);
    }
    if (freqDisplay.present) {
      map['freq_display'] = Variable<String>(freqDisplay.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaStagingTableCompanion(')
          ..write('localId: $localId, ')
          ..write('term: $term, ')
          ..write('termNormalized: $termNormalized, ')
          ..write('termTokens: $termTokens, ')
          ..write('termTokensNormalized: $termTokensNormalized, ')
          ..write('mode: $mode, ')
          ..write('reading: $reading, ')
          ..write('readingNormalized: $readingNormalized, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplay: $freqDisplay, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermMetaPitchStagingTableTable extends TermMetaPitchStagingTable
    with
        TableInfo<
          $TermMetaPitchStagingTableTable,
          TermMetaPitchStagingTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaPitchStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pitchLocalIdMeta = const VerificationMeta(
    'pitchLocalId',
  );
  @override
  late final GeneratedColumn<int> pitchLocalId = GeneratedColumn<int>(
    'pitch_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metaLocalIdMeta = const VerificationMeta(
    'metaLocalId',
  );
  @override
  late final GeneratedColumn<int> metaLocalId = GeneratedColumn<int>(
    'meta_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nasalMeta = const VerificationMeta('nasal');
  @override
  late final GeneratedColumn<int> nasal = GeneratedColumn<int>(
    'nasal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _devoiceMeta = const VerificationMeta(
    'devoice',
  );
  @override
  late final GeneratedColumn<int> devoice = GeneratedColumn<int>(
    'devoice',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    pitchLocalId,
    metaLocalId,
    position,
    nasal,
    devoice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_pitch_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermMetaPitchStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pitch_local_id')) {
      context.handle(
        _pitchLocalIdMeta,
        pitchLocalId.isAcceptableOrUnknown(
          data['pitch_local_id']!,
          _pitchLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pitchLocalIdMeta);
    }
    if (data.containsKey('meta_local_id')) {
      context.handle(
        _metaLocalIdMeta,
        metaLocalId.isAcceptableOrUnknown(
          data['meta_local_id']!,
          _metaLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metaLocalIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('nasal')) {
      context.handle(
        _nasalMeta,
        nasal.isAcceptableOrUnknown(data['nasal']!, _nasalMeta),
      );
    }
    if (data.containsKey('devoice')) {
      context.handle(
        _devoiceMeta,
        devoice.isAcceptableOrUnknown(data['devoice']!, _devoiceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermMetaPitchStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaPitchStagingTableData(
      pitchLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pitch_local_id'],
      )!,
      metaLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_local_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      nasal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nasal'],
      ),
      devoice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}devoice'],
      ),
    );
  }

  @override
  $TermMetaPitchStagingTableTable createAlias(String alias) {
    return $TermMetaPitchStagingTableTable(attachedDatabase, alias);
  }
}

class TermMetaPitchStagingTableData extends DataClass
    implements Insertable<TermMetaPitchStagingTableData> {
  final int pitchLocalId;
  final int metaLocalId;
  final int position;
  final int? nasal;
  final int? devoice;
  const TermMetaPitchStagingTableData({
    required this.pitchLocalId,
    required this.metaLocalId,
    required this.position,
    this.nasal,
    this.devoice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pitch_local_id'] = Variable<int>(pitchLocalId);
    map['meta_local_id'] = Variable<int>(metaLocalId);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || nasal != null) {
      map['nasal'] = Variable<int>(nasal);
    }
    if (!nullToAbsent || devoice != null) {
      map['devoice'] = Variable<int>(devoice);
    }
    return map;
  }

  TermMetaPitchStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaPitchStagingTableCompanion(
      pitchLocalId: Value(pitchLocalId),
      metaLocalId: Value(metaLocalId),
      position: Value(position),
      nasal: nasal == null && nullToAbsent
          ? const Value.absent()
          : Value(nasal),
      devoice: devoice == null && nullToAbsent
          ? const Value.absent()
          : Value(devoice),
    );
  }

  factory TermMetaPitchStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaPitchStagingTableData(
      pitchLocalId: serializer.fromJson<int>(json['pitchLocalId']),
      metaLocalId: serializer.fromJson<int>(json['metaLocalId']),
      position: serializer.fromJson<int>(json['position']),
      nasal: serializer.fromJson<int?>(json['nasal']),
      devoice: serializer.fromJson<int?>(json['devoice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pitchLocalId': serializer.toJson<int>(pitchLocalId),
      'metaLocalId': serializer.toJson<int>(metaLocalId),
      'position': serializer.toJson<int>(position),
      'nasal': serializer.toJson<int?>(nasal),
      'devoice': serializer.toJson<int?>(devoice),
    };
  }

  TermMetaPitchStagingTableData copyWith({
    int? pitchLocalId,
    int? metaLocalId,
    int? position,
    Value<int?> nasal = const Value.absent(),
    Value<int?> devoice = const Value.absent(),
  }) => TermMetaPitchStagingTableData(
    pitchLocalId: pitchLocalId ?? this.pitchLocalId,
    metaLocalId: metaLocalId ?? this.metaLocalId,
    position: position ?? this.position,
    nasal: nasal.present ? nasal.value : this.nasal,
    devoice: devoice.present ? devoice.value : this.devoice,
  );
  TermMetaPitchStagingTableData copyWithCompanion(
    TermMetaPitchStagingTableCompanion data,
  ) {
    return TermMetaPitchStagingTableData(
      pitchLocalId: data.pitchLocalId.present
          ? data.pitchLocalId.value
          : this.pitchLocalId,
      metaLocalId: data.metaLocalId.present
          ? data.metaLocalId.value
          : this.metaLocalId,
      position: data.position.present ? data.position.value : this.position,
      nasal: data.nasal.present ? data.nasal.value : this.nasal,
      devoice: data.devoice.present ? data.devoice.value : this.devoice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaPitchStagingTableData(')
          ..write('pitchLocalId: $pitchLocalId, ')
          ..write('metaLocalId: $metaLocalId, ')
          ..write('position: $position, ')
          ..write('nasal: $nasal, ')
          ..write('devoice: $devoice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(pitchLocalId, metaLocalId, position, nasal, devoice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaPitchStagingTableData &&
          other.pitchLocalId == this.pitchLocalId &&
          other.metaLocalId == this.metaLocalId &&
          other.position == this.position &&
          other.nasal == this.nasal &&
          other.devoice == this.devoice);
}

class TermMetaPitchStagingTableCompanion
    extends UpdateCompanion<TermMetaPitchStagingTableData> {
  final Value<int> pitchLocalId;
  final Value<int> metaLocalId;
  final Value<int> position;
  final Value<int?> nasal;
  final Value<int?> devoice;
  final Value<int> rowid;
  const TermMetaPitchStagingTableCompanion({
    this.pitchLocalId = const Value.absent(),
    this.metaLocalId = const Value.absent(),
    this.position = const Value.absent(),
    this.nasal = const Value.absent(),
    this.devoice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermMetaPitchStagingTableCompanion.insert({
    required int pitchLocalId,
    required int metaLocalId,
    required int position,
    this.nasal = const Value.absent(),
    this.devoice = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pitchLocalId = Value(pitchLocalId),
       metaLocalId = Value(metaLocalId),
       position = Value(position);
  static Insertable<TermMetaPitchStagingTableData> custom({
    Expression<int>? pitchLocalId,
    Expression<int>? metaLocalId,
    Expression<int>? position,
    Expression<int>? nasal,
    Expression<int>? devoice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pitchLocalId != null) 'pitch_local_id': pitchLocalId,
      if (metaLocalId != null) 'meta_local_id': metaLocalId,
      if (position != null) 'position': position,
      if (nasal != null) 'nasal': nasal,
      if (devoice != null) 'devoice': devoice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermMetaPitchStagingTableCompanion copyWith({
    Value<int>? pitchLocalId,
    Value<int>? metaLocalId,
    Value<int>? position,
    Value<int?>? nasal,
    Value<int?>? devoice,
    Value<int>? rowid,
  }) {
    return TermMetaPitchStagingTableCompanion(
      pitchLocalId: pitchLocalId ?? this.pitchLocalId,
      metaLocalId: metaLocalId ?? this.metaLocalId,
      position: position ?? this.position,
      nasal: nasal ?? this.nasal,
      devoice: devoice ?? this.devoice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pitchLocalId.present) {
      map['pitch_local_id'] = Variable<int>(pitchLocalId.value);
    }
    if (metaLocalId.present) {
      map['meta_local_id'] = Variable<int>(metaLocalId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (nasal.present) {
      map['nasal'] = Variable<int>(nasal.value);
    }
    if (devoice.present) {
      map['devoice'] = Variable<int>(devoice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaPitchStagingTableCompanion(')
          ..write('pitchLocalId: $pitchLocalId, ')
          ..write('metaLocalId: $metaLocalId, ')
          ..write('position: $position, ')
          ..write('nasal: $nasal, ')
          ..write('devoice: $devoice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermMetaIpaStagingTableTable extends TermMetaIpaStagingTable
    with TableInfo<$TermMetaIpaStagingTableTable, TermMetaIpaStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaIpaStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ipaLocalIdMeta = const VerificationMeta(
    'ipaLocalId',
  );
  @override
  late final GeneratedColumn<int> ipaLocalId = GeneratedColumn<int>(
    'ipa_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metaLocalIdMeta = const VerificationMeta(
    'metaLocalId',
  );
  @override
  late final GeneratedColumn<int> metaLocalId = GeneratedColumn<int>(
    'meta_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ipaMeta = const VerificationMeta('ipa');
  @override
  late final GeneratedColumn<String> ipa = GeneratedColumn<String>(
    'ipa',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [ipaLocalId, metaLocalId, ipa];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_ipa_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermMetaIpaStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ipa_local_id')) {
      context.handle(
        _ipaLocalIdMeta,
        ipaLocalId.isAcceptableOrUnknown(
          data['ipa_local_id']!,
          _ipaLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ipaLocalIdMeta);
    }
    if (data.containsKey('meta_local_id')) {
      context.handle(
        _metaLocalIdMeta,
        metaLocalId.isAcceptableOrUnknown(
          data['meta_local_id']!,
          _metaLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metaLocalIdMeta);
    }
    if (data.containsKey('ipa')) {
      context.handle(
        _ipaMeta,
        ipa.isAcceptableOrUnknown(data['ipa']!, _ipaMeta),
      );
    } else if (isInserting) {
      context.missing(_ipaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermMetaIpaStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaIpaStagingTableData(
      ipaLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ipa_local_id'],
      )!,
      metaLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_local_id'],
      )!,
      ipa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ipa'],
      )!,
    );
  }

  @override
  $TermMetaIpaStagingTableTable createAlias(String alias) {
    return $TermMetaIpaStagingTableTable(attachedDatabase, alias);
  }
}

class TermMetaIpaStagingTableData extends DataClass
    implements Insertable<TermMetaIpaStagingTableData> {
  final int ipaLocalId;
  final int metaLocalId;
  final String ipa;
  const TermMetaIpaStagingTableData({
    required this.ipaLocalId,
    required this.metaLocalId,
    required this.ipa,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ipa_local_id'] = Variable<int>(ipaLocalId);
    map['meta_local_id'] = Variable<int>(metaLocalId);
    map['ipa'] = Variable<String>(ipa);
    return map;
  }

  TermMetaIpaStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaIpaStagingTableCompanion(
      ipaLocalId: Value(ipaLocalId),
      metaLocalId: Value(metaLocalId),
      ipa: Value(ipa),
    );
  }

  factory TermMetaIpaStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaIpaStagingTableData(
      ipaLocalId: serializer.fromJson<int>(json['ipaLocalId']),
      metaLocalId: serializer.fromJson<int>(json['metaLocalId']),
      ipa: serializer.fromJson<String>(json['ipa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ipaLocalId': serializer.toJson<int>(ipaLocalId),
      'metaLocalId': serializer.toJson<int>(metaLocalId),
      'ipa': serializer.toJson<String>(ipa),
    };
  }

  TermMetaIpaStagingTableData copyWith({
    int? ipaLocalId,
    int? metaLocalId,
    String? ipa,
  }) => TermMetaIpaStagingTableData(
    ipaLocalId: ipaLocalId ?? this.ipaLocalId,
    metaLocalId: metaLocalId ?? this.metaLocalId,
    ipa: ipa ?? this.ipa,
  );
  TermMetaIpaStagingTableData copyWithCompanion(
    TermMetaIpaStagingTableCompanion data,
  ) {
    return TermMetaIpaStagingTableData(
      ipaLocalId: data.ipaLocalId.present
          ? data.ipaLocalId.value
          : this.ipaLocalId,
      metaLocalId: data.metaLocalId.present
          ? data.metaLocalId.value
          : this.metaLocalId,
      ipa: data.ipa.present ? data.ipa.value : this.ipa,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaIpaStagingTableData(')
          ..write('ipaLocalId: $ipaLocalId, ')
          ..write('metaLocalId: $metaLocalId, ')
          ..write('ipa: $ipa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ipaLocalId, metaLocalId, ipa);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaIpaStagingTableData &&
          other.ipaLocalId == this.ipaLocalId &&
          other.metaLocalId == this.metaLocalId &&
          other.ipa == this.ipa);
}

class TermMetaIpaStagingTableCompanion
    extends UpdateCompanion<TermMetaIpaStagingTableData> {
  final Value<int> ipaLocalId;
  final Value<int> metaLocalId;
  final Value<String> ipa;
  final Value<int> rowid;
  const TermMetaIpaStagingTableCompanion({
    this.ipaLocalId = const Value.absent(),
    this.metaLocalId = const Value.absent(),
    this.ipa = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermMetaIpaStagingTableCompanion.insert({
    required int ipaLocalId,
    required int metaLocalId,
    required String ipa,
    this.rowid = const Value.absent(),
  }) : ipaLocalId = Value(ipaLocalId),
       metaLocalId = Value(metaLocalId),
       ipa = Value(ipa);
  static Insertable<TermMetaIpaStagingTableData> custom({
    Expression<int>? ipaLocalId,
    Expression<int>? metaLocalId,
    Expression<String>? ipa,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ipaLocalId != null) 'ipa_local_id': ipaLocalId,
      if (metaLocalId != null) 'meta_local_id': metaLocalId,
      if (ipa != null) 'ipa': ipa,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermMetaIpaStagingTableCompanion copyWith({
    Value<int>? ipaLocalId,
    Value<int>? metaLocalId,
    Value<String>? ipa,
    Value<int>? rowid,
  }) {
    return TermMetaIpaStagingTableCompanion(
      ipaLocalId: ipaLocalId ?? this.ipaLocalId,
      metaLocalId: metaLocalId ?? this.metaLocalId,
      ipa: ipa ?? this.ipa,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ipaLocalId.present) {
      map['ipa_local_id'] = Variable<int>(ipaLocalId.value);
    }
    if (metaLocalId.present) {
      map['meta_local_id'] = Variable<int>(metaLocalId.value);
    }
    if (ipa.present) {
      map['ipa'] = Variable<String>(ipa.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaIpaStagingTableCompanion(')
          ..write('ipaLocalId: $ipaLocalId, ')
          ..write('metaLocalId: $metaLocalId, ')
          ..write('ipa: $ipa, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TermMetaTagStagingTableTable extends TermMetaTagStagingTable
    with TableInfo<$TermMetaTagStagingTableTable, TermMetaTagStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaTagStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _parentLocalIdMeta = const VerificationMeta(
    'parentLocalId',
  );
  @override
  late final GeneratedColumn<int> parentLocalId = GeneratedColumn<int>(
    'parent_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentTypeMeta = const VerificationMeta(
    'parentType',
  );
  @override
  late final GeneratedColumn<String> parentType = GeneratedColumn<String>(
    'parent_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  @override
  List<GeneratedColumn> get $columns => [parentLocalId, parentType, tagName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_tag_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermMetaTagStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('parent_local_id')) {
      context.handle(
        _parentLocalIdMeta,
        parentLocalId.isAcceptableOrUnknown(
          data['parent_local_id']!,
          _parentLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parentLocalIdMeta);
    }
    if (data.containsKey('parent_type')) {
      context.handle(
        _parentTypeMeta,
        parentType.isAcceptableOrUnknown(data['parent_type']!, _parentTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_parentTypeMeta);
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TermMetaTagStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaTagStagingTableData(
      parentLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_local_id'],
      )!,
      parentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_type'],
      )!,
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      )!,
    );
  }

  @override
  $TermMetaTagStagingTableTable createAlias(String alias) {
    return $TermMetaTagStagingTableTable(attachedDatabase, alias);
  }
}

class TermMetaTagStagingTableData extends DataClass
    implements Insertable<TermMetaTagStagingTableData> {
  final int parentLocalId;
  final String parentType;
  final String tagName;
  const TermMetaTagStagingTableData({
    required this.parentLocalId,
    required this.parentType,
    required this.tagName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['parent_local_id'] = Variable<int>(parentLocalId);
    map['parent_type'] = Variable<String>(parentType);
    map['tag_name'] = Variable<String>(tagName);
    return map;
  }

  TermMetaTagStagingTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaTagStagingTableCompanion(
      parentLocalId: Value(parentLocalId),
      parentType: Value(parentType),
      tagName: Value(tagName),
    );
  }

  factory TermMetaTagStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaTagStagingTableData(
      parentLocalId: serializer.fromJson<int>(json['parentLocalId']),
      parentType: serializer.fromJson<String>(json['parentType']),
      tagName: serializer.fromJson<String>(json['tagName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'parentLocalId': serializer.toJson<int>(parentLocalId),
      'parentType': serializer.toJson<String>(parentType),
      'tagName': serializer.toJson<String>(tagName),
    };
  }

  TermMetaTagStagingTableData copyWith({
    int? parentLocalId,
    String? parentType,
    String? tagName,
  }) => TermMetaTagStagingTableData(
    parentLocalId: parentLocalId ?? this.parentLocalId,
    parentType: parentType ?? this.parentType,
    tagName: tagName ?? this.tagName,
  );
  TermMetaTagStagingTableData copyWithCompanion(
    TermMetaTagStagingTableCompanion data,
  ) {
    return TermMetaTagStagingTableData(
      parentLocalId: data.parentLocalId.present
          ? data.parentLocalId.value
          : this.parentLocalId,
      parentType: data.parentType.present
          ? data.parentType.value
          : this.parentType,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaTagStagingTableData(')
          ..write('parentLocalId: $parentLocalId, ')
          ..write('parentType: $parentType, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(parentLocalId, parentType, tagName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaTagStagingTableData &&
          other.parentLocalId == this.parentLocalId &&
          other.parentType == this.parentType &&
          other.tagName == this.tagName);
}

class TermMetaTagStagingTableCompanion
    extends UpdateCompanion<TermMetaTagStagingTableData> {
  final Value<int> parentLocalId;
  final Value<String> parentType;
  final Value<String> tagName;
  final Value<int> rowid;
  const TermMetaTagStagingTableCompanion({
    this.parentLocalId = const Value.absent(),
    this.parentType = const Value.absent(),
    this.tagName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermMetaTagStagingTableCompanion.insert({
    required int parentLocalId,
    required String parentType,
    required String tagName,
    this.rowid = const Value.absent(),
  }) : parentLocalId = Value(parentLocalId),
       parentType = Value(parentType),
       tagName = Value(tagName);
  static Insertable<TermMetaTagStagingTableData> custom({
    Expression<int>? parentLocalId,
    Expression<String>? parentType,
    Expression<String>? tagName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (parentLocalId != null) 'parent_local_id': parentLocalId,
      if (parentType != null) 'parent_type': parentType,
      if (tagName != null) 'tag_name': tagName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermMetaTagStagingTableCompanion copyWith({
    Value<int>? parentLocalId,
    Value<String>? parentType,
    Value<String>? tagName,
    Value<int>? rowid,
  }) {
    return TermMetaTagStagingTableCompanion(
      parentLocalId: parentLocalId ?? this.parentLocalId,
      parentType: parentType ?? this.parentType,
      tagName: tagName ?? this.tagName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (parentLocalId.present) {
      map['parent_local_id'] = Variable<int>(parentLocalId.value);
    }
    if (parentType.present) {
      map['parent_type'] = Variable<String>(parentType.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaTagStagingTableCompanion(')
          ..write('parentLocalId: $parentLocalId, ')
          ..write('parentType: $parentType, ')
          ..write('tagName: $tagName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiStagingTableTable extends KanjiStagingTable
    with TableInfo<$KanjiStagingTableTable, KanjiStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
    'kanji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalOnyomiMeta = const VerificationMeta(
    'originalOnyomi',
  );
  @override
  late final GeneratedColumn<String> originalOnyomi = GeneratedColumn<String>(
    'original_onyomi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalKunyomiMeta = const VerificationMeta(
    'originalKunyomi',
  );
  @override
  late final GeneratedColumn<String> originalKunyomi = GeneratedColumn<String>(
    'original_kunyomi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    kanji,
    originalOnyomi,
    originalKunyomi,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('kanji')) {
      context.handle(
        _kanjiMeta,
        kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta),
      );
    } else if (isInserting) {
      context.missing(_kanjiMeta);
    }
    if (data.containsKey('original_onyomi')) {
      context.handle(
        _originalOnyomiMeta,
        originalOnyomi.isAcceptableOrUnknown(
          data['original_onyomi']!,
          _originalOnyomiMeta,
        ),
      );
    }
    if (data.containsKey('original_kunyomi')) {
      context.handle(
        _originalKunyomiMeta,
        originalKunyomi.isAcceptableOrUnknown(
          data['original_kunyomi']!,
          _originalKunyomiMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  KanjiStagingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiStagingTableData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      kanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji'],
      )!,
      originalOnyomi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_onyomi'],
      ),
      originalKunyomi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_kunyomi'],
      ),
    );
  }

  @override
  $KanjiStagingTableTable createAlias(String alias) {
    return $KanjiStagingTableTable(attachedDatabase, alias);
  }
}

class KanjiStagingTableData extends DataClass
    implements Insertable<KanjiStagingTableData> {
  final int localId;
  final String kanji;
  final String? originalOnyomi;
  final String? originalKunyomi;
  const KanjiStagingTableData({
    required this.localId,
    required this.kanji,
    this.originalOnyomi,
    this.originalKunyomi,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['kanji'] = Variable<String>(kanji);
    if (!nullToAbsent || originalOnyomi != null) {
      map['original_onyomi'] = Variable<String>(originalOnyomi);
    }
    if (!nullToAbsent || originalKunyomi != null) {
      map['original_kunyomi'] = Variable<String>(originalKunyomi);
    }
    return map;
  }

  KanjiStagingTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiStagingTableCompanion(
      localId: Value(localId),
      kanji: Value(kanji),
      originalOnyomi: originalOnyomi == null && nullToAbsent
          ? const Value.absent()
          : Value(originalOnyomi),
      originalKunyomi: originalKunyomi == null && nullToAbsent
          ? const Value.absent()
          : Value(originalKunyomi),
    );
  }

  factory KanjiStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiStagingTableData(
      localId: serializer.fromJson<int>(json['localId']),
      kanji: serializer.fromJson<String>(json['kanji']),
      originalOnyomi: serializer.fromJson<String?>(json['originalOnyomi']),
      originalKunyomi: serializer.fromJson<String?>(json['originalKunyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'kanji': serializer.toJson<String>(kanji),
      'originalOnyomi': serializer.toJson<String?>(originalOnyomi),
      'originalKunyomi': serializer.toJson<String?>(originalKunyomi),
    };
  }

  KanjiStagingTableData copyWith({
    int? localId,
    String? kanji,
    Value<String?> originalOnyomi = const Value.absent(),
    Value<String?> originalKunyomi = const Value.absent(),
  }) => KanjiStagingTableData(
    localId: localId ?? this.localId,
    kanji: kanji ?? this.kanji,
    originalOnyomi: originalOnyomi.present
        ? originalOnyomi.value
        : this.originalOnyomi,
    originalKunyomi: originalKunyomi.present
        ? originalKunyomi.value
        : this.originalKunyomi,
  );
  KanjiStagingTableData copyWithCompanion(KanjiStagingTableCompanion data) {
    return KanjiStagingTableData(
      localId: data.localId.present ? data.localId.value : this.localId,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
      originalOnyomi: data.originalOnyomi.present
          ? data.originalOnyomi.value
          : this.originalOnyomi,
      originalKunyomi: data.originalKunyomi.present
          ? data.originalKunyomi.value
          : this.originalKunyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiStagingTableData(')
          ..write('localId: $localId, ')
          ..write('kanji: $kanji, ')
          ..write('originalOnyomi: $originalOnyomi, ')
          ..write('originalKunyomi: $originalKunyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(localId, kanji, originalOnyomi, originalKunyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiStagingTableData &&
          other.localId == this.localId &&
          other.kanji == this.kanji &&
          other.originalOnyomi == this.originalOnyomi &&
          other.originalKunyomi == this.originalKunyomi);
}

class KanjiStagingTableCompanion
    extends UpdateCompanion<KanjiStagingTableData> {
  final Value<int> localId;
  final Value<String> kanji;
  final Value<String?> originalOnyomi;
  final Value<String?> originalKunyomi;
  final Value<int> rowid;
  const KanjiStagingTableCompanion({
    this.localId = const Value.absent(),
    this.kanji = const Value.absent(),
    this.originalOnyomi = const Value.absent(),
    this.originalKunyomi = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiStagingTableCompanion.insert({
    required int localId,
    required String kanji,
    this.originalOnyomi = const Value.absent(),
    this.originalKunyomi = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : localId = Value(localId),
       kanji = Value(kanji);
  static Insertable<KanjiStagingTableData> custom({
    Expression<int>? localId,
    Expression<String>? kanji,
    Expression<String>? originalOnyomi,
    Expression<String>? originalKunyomi,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (kanji != null) 'kanji': kanji,
      if (originalOnyomi != null) 'original_onyomi': originalOnyomi,
      if (originalKunyomi != null) 'original_kunyomi': originalKunyomi,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiStagingTableCompanion copyWith({
    Value<int>? localId,
    Value<String>? kanji,
    Value<String?>? originalOnyomi,
    Value<String?>? originalKunyomi,
    Value<int>? rowid,
  }) {
    return KanjiStagingTableCompanion(
      localId: localId ?? this.localId,
      kanji: kanji ?? this.kanji,
      originalOnyomi: originalOnyomi ?? this.originalOnyomi,
      originalKunyomi: originalKunyomi ?? this.originalKunyomi,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    if (originalOnyomi.present) {
      map['original_onyomi'] = Variable<String>(originalOnyomi.value);
    }
    if (originalKunyomi.present) {
      map['original_kunyomi'] = Variable<String>(originalKunyomi.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiStagingTableCompanion(')
          ..write('localId: $localId, ')
          ..write('kanji: $kanji, ')
          ..write('originalOnyomi: $originalOnyomi, ')
          ..write('originalKunyomi: $originalKunyomi, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiReadingStagingTableTable extends KanjiReadingStagingTable
    with
        TableInfo<
          $KanjiReadingStagingTableTable,
          KanjiReadingStagingTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiReadingStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kanjiLocalIdMeta = const VerificationMeta(
    'kanjiLocalId',
  );
  @override
  late final GeneratedColumn<int> kanjiLocalId = GeneratedColumn<int>(
    'kanji_local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    kanjiLocalId,
    reading,
    readingNormalized,
    type,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_reading_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiReadingStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kanji_local_id')) {
      context.handle(
        _kanjiLocalIdMeta,
        kanjiLocalId.isAcceptableOrUnknown(
          data['kanji_local_id']!,
          _kanjiLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kanjiLocalIdMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(
        _readingMeta,
        reading.isAcceptableOrUnknown(data['reading']!, _readingMeta),
      );
    } else if (isInserting) {
      context.missing(_readingMeta);
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  KanjiReadingStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiReadingStagingTableData(
      kanjiLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kanji_local_id'],
      )!,
      reading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading'],
      )!,
      readingNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_normalized'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $KanjiReadingStagingTableTable createAlias(String alias) {
    return $KanjiReadingStagingTableTable(attachedDatabase, alias);
  }
}

class KanjiReadingStagingTableData extends DataClass
    implements Insertable<KanjiReadingStagingTableData> {
  final int kanjiLocalId;
  final String reading;
  final String? readingNormalized;
  final String type;
  final int position;
  const KanjiReadingStagingTableData({
    required this.kanjiLocalId,
    required this.reading,
    this.readingNormalized,
    required this.type,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kanji_local_id'] = Variable<int>(kanjiLocalId);
    map['reading'] = Variable<String>(reading);
    if (!nullToAbsent || readingNormalized != null) {
      map['reading_normalized'] = Variable<String>(readingNormalized);
    }
    map['type'] = Variable<String>(type);
    map['position'] = Variable<int>(position);
    return map;
  }

  KanjiReadingStagingTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiReadingStagingTableCompanion(
      kanjiLocalId: Value(kanjiLocalId),
      reading: Value(reading),
      readingNormalized: readingNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(readingNormalized),
      type: Value(type),
      position: Value(position),
    );
  }

  factory KanjiReadingStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiReadingStagingTableData(
      kanjiLocalId: serializer.fromJson<int>(json['kanjiLocalId']),
      reading: serializer.fromJson<String>(json['reading']),
      readingNormalized: serializer.fromJson<String?>(
        json['readingNormalized'],
      ),
      type: serializer.fromJson<String>(json['type']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kanjiLocalId': serializer.toJson<int>(kanjiLocalId),
      'reading': serializer.toJson<String>(reading),
      'readingNormalized': serializer.toJson<String?>(readingNormalized),
      'type': serializer.toJson<String>(type),
      'position': serializer.toJson<int>(position),
    };
  }

  KanjiReadingStagingTableData copyWith({
    int? kanjiLocalId,
    String? reading,
    Value<String?> readingNormalized = const Value.absent(),
    String? type,
    int? position,
  }) => KanjiReadingStagingTableData(
    kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
    reading: reading ?? this.reading,
    readingNormalized: readingNormalized.present
        ? readingNormalized.value
        : this.readingNormalized,
    type: type ?? this.type,
    position: position ?? this.position,
  );
  KanjiReadingStagingTableData copyWithCompanion(
    KanjiReadingStagingTableCompanion data,
  ) {
    return KanjiReadingStagingTableData(
      kanjiLocalId: data.kanjiLocalId.present
          ? data.kanjiLocalId.value
          : this.kanjiLocalId,
      reading: data.reading.present ? data.reading.value : this.reading,
      readingNormalized: data.readingNormalized.present
          ? data.readingNormalized.value
          : this.readingNormalized,
      type: data.type.present ? data.type.value : this.type,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiReadingStagingTableData(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('reading: $reading, ')
          ..write('readingNormalized: $readingNormalized, ')
          ..write('type: $type, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(kanjiLocalId, reading, readingNormalized, type, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiReadingStagingTableData &&
          other.kanjiLocalId == this.kanjiLocalId &&
          other.reading == this.reading &&
          other.readingNormalized == this.readingNormalized &&
          other.type == this.type &&
          other.position == this.position);
}

class KanjiReadingStagingTableCompanion
    extends UpdateCompanion<KanjiReadingStagingTableData> {
  final Value<int> kanjiLocalId;
  final Value<String> reading;
  final Value<String?> readingNormalized;
  final Value<String> type;
  final Value<int> position;
  final Value<int> rowid;
  const KanjiReadingStagingTableCompanion({
    this.kanjiLocalId = const Value.absent(),
    this.reading = const Value.absent(),
    this.readingNormalized = const Value.absent(),
    this.type = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiReadingStagingTableCompanion.insert({
    required int kanjiLocalId,
    required String reading,
    this.readingNormalized = const Value.absent(),
    required String type,
    required int position,
    this.rowid = const Value.absent(),
  }) : kanjiLocalId = Value(kanjiLocalId),
       reading = Value(reading),
       type = Value(type),
       position = Value(position);
  static Insertable<KanjiReadingStagingTableData> custom({
    Expression<int>? kanjiLocalId,
    Expression<String>? reading,
    Expression<String>? readingNormalized,
    Expression<String>? type,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kanjiLocalId != null) 'kanji_local_id': kanjiLocalId,
      if (reading != null) 'reading': reading,
      if (readingNormalized != null) 'reading_normalized': readingNormalized,
      if (type != null) 'type': type,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiReadingStagingTableCompanion copyWith({
    Value<int>? kanjiLocalId,
    Value<String>? reading,
    Value<String?>? readingNormalized,
    Value<String>? type,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return KanjiReadingStagingTableCompanion(
      kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
      reading: reading ?? this.reading,
      readingNormalized: readingNormalized ?? this.readingNormalized,
      type: type ?? this.type,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kanjiLocalId.present) {
      map['kanji_local_id'] = Variable<int>(kanjiLocalId.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (readingNormalized.present) {
      map['reading_normalized'] = Variable<String>(readingNormalized.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiReadingStagingTableCompanion(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('reading: $reading, ')
          ..write('readingNormalized: $readingNormalized, ')
          ..write('type: $type, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiDefinitionStagingTableTable extends KanjiDefinitionStagingTable
    with
        TableInfo<
          $KanjiDefinitionStagingTableTable,
          KanjiDefinitionStagingTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiDefinitionStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kanjiLocalIdMeta = const VerificationMeta(
    'kanjiLocalId',
  );
  @override
  late final GeneratedColumn<int> kanjiLocalId = GeneratedColumn<int>(
    'kanji_local_id',
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
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [kanjiLocalId, definition, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_definition_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiDefinitionStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kanji_local_id')) {
      context.handle(
        _kanjiLocalIdMeta,
        kanjiLocalId.isAcceptableOrUnknown(
          data['kanji_local_id']!,
          _kanjiLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kanjiLocalIdMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  KanjiDefinitionStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiDefinitionStagingTableData(
      kanjiLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kanji_local_id'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $KanjiDefinitionStagingTableTable createAlias(String alias) {
    return $KanjiDefinitionStagingTableTable(attachedDatabase, alias);
  }
}

class KanjiDefinitionStagingTableData extends DataClass
    implements Insertable<KanjiDefinitionStagingTableData> {
  final int kanjiLocalId;
  final String definition;
  final int position;
  const KanjiDefinitionStagingTableData({
    required this.kanjiLocalId,
    required this.definition,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kanji_local_id'] = Variable<int>(kanjiLocalId);
    map['definition'] = Variable<String>(definition);
    map['position'] = Variable<int>(position);
    return map;
  }

  KanjiDefinitionStagingTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiDefinitionStagingTableCompanion(
      kanjiLocalId: Value(kanjiLocalId),
      definition: Value(definition),
      position: Value(position),
    );
  }

  factory KanjiDefinitionStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiDefinitionStagingTableData(
      kanjiLocalId: serializer.fromJson<int>(json['kanjiLocalId']),
      definition: serializer.fromJson<String>(json['definition']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kanjiLocalId': serializer.toJson<int>(kanjiLocalId),
      'definition': serializer.toJson<String>(definition),
      'position': serializer.toJson<int>(position),
    };
  }

  KanjiDefinitionStagingTableData copyWith({
    int? kanjiLocalId,
    String? definition,
    int? position,
  }) => KanjiDefinitionStagingTableData(
    kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
    definition: definition ?? this.definition,
    position: position ?? this.position,
  );
  KanjiDefinitionStagingTableData copyWithCompanion(
    KanjiDefinitionStagingTableCompanion data,
  ) {
    return KanjiDefinitionStagingTableData(
      kanjiLocalId: data.kanjiLocalId.present
          ? data.kanjiLocalId.value
          : this.kanjiLocalId,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiDefinitionStagingTableData(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('definition: $definition, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kanjiLocalId, definition, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiDefinitionStagingTableData &&
          other.kanjiLocalId == this.kanjiLocalId &&
          other.definition == this.definition &&
          other.position == this.position);
}

class KanjiDefinitionStagingTableCompanion
    extends UpdateCompanion<KanjiDefinitionStagingTableData> {
  final Value<int> kanjiLocalId;
  final Value<String> definition;
  final Value<int> position;
  final Value<int> rowid;
  const KanjiDefinitionStagingTableCompanion({
    this.kanjiLocalId = const Value.absent(),
    this.definition = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiDefinitionStagingTableCompanion.insert({
    required int kanjiLocalId,
    required String definition,
    required int position,
    this.rowid = const Value.absent(),
  }) : kanjiLocalId = Value(kanjiLocalId),
       definition = Value(definition),
       position = Value(position);
  static Insertable<KanjiDefinitionStagingTableData> custom({
    Expression<int>? kanjiLocalId,
    Expression<String>? definition,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kanjiLocalId != null) 'kanji_local_id': kanjiLocalId,
      if (definition != null) 'definition': definition,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiDefinitionStagingTableCompanion copyWith({
    Value<int>? kanjiLocalId,
    Value<String>? definition,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return KanjiDefinitionStagingTableCompanion(
      kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
      definition: definition ?? this.definition,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kanjiLocalId.present) {
      map['kanji_local_id'] = Variable<int>(kanjiLocalId.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiDefinitionStagingTableCompanion(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('definition: $definition, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiTagStagingTableTable extends KanjiTagStagingTable
    with TableInfo<$KanjiTagStagingTableTable, KanjiTagStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiTagStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kanjiLocalIdMeta = const VerificationMeta(
    'kanjiLocalId',
  );
  @override
  late final GeneratedColumn<int> kanjiLocalId = GeneratedColumn<int>(
    'kanji_local_id',
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
  @override
  List<GeneratedColumn> get $columns => [kanjiLocalId, tagName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_tag_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiTagStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kanji_local_id')) {
      context.handle(
        _kanjiLocalIdMeta,
        kanjiLocalId.isAcceptableOrUnknown(
          data['kanji_local_id']!,
          _kanjiLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kanjiLocalIdMeta);
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  KanjiTagStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiTagStagingTableData(
      kanjiLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kanji_local_id'],
      )!,
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      )!,
    );
  }

  @override
  $KanjiTagStagingTableTable createAlias(String alias) {
    return $KanjiTagStagingTableTable(attachedDatabase, alias);
  }
}

class KanjiTagStagingTableData extends DataClass
    implements Insertable<KanjiTagStagingTableData> {
  final int kanjiLocalId;
  final String tagName;
  const KanjiTagStagingTableData({
    required this.kanjiLocalId,
    required this.tagName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kanji_local_id'] = Variable<int>(kanjiLocalId);
    map['tag_name'] = Variable<String>(tagName);
    return map;
  }

  KanjiTagStagingTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiTagStagingTableCompanion(
      kanjiLocalId: Value(kanjiLocalId),
      tagName: Value(tagName),
    );
  }

  factory KanjiTagStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiTagStagingTableData(
      kanjiLocalId: serializer.fromJson<int>(json['kanjiLocalId']),
      tagName: serializer.fromJson<String>(json['tagName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kanjiLocalId': serializer.toJson<int>(kanjiLocalId),
      'tagName': serializer.toJson<String>(tagName),
    };
  }

  KanjiTagStagingTableData copyWith({int? kanjiLocalId, String? tagName}) =>
      KanjiTagStagingTableData(
        kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
        tagName: tagName ?? this.tagName,
      );
  KanjiTagStagingTableData copyWithCompanion(
    KanjiTagStagingTableCompanion data,
  ) {
    return KanjiTagStagingTableData(
      kanjiLocalId: data.kanjiLocalId.present
          ? data.kanjiLocalId.value
          : this.kanjiLocalId,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiTagStagingTableData(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kanjiLocalId, tagName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiTagStagingTableData &&
          other.kanjiLocalId == this.kanjiLocalId &&
          other.tagName == this.tagName);
}

class KanjiTagStagingTableCompanion
    extends UpdateCompanion<KanjiTagStagingTableData> {
  final Value<int> kanjiLocalId;
  final Value<String> tagName;
  final Value<int> rowid;
  const KanjiTagStagingTableCompanion({
    this.kanjiLocalId = const Value.absent(),
    this.tagName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiTagStagingTableCompanion.insert({
    required int kanjiLocalId,
    required String tagName,
    this.rowid = const Value.absent(),
  }) : kanjiLocalId = Value(kanjiLocalId),
       tagName = Value(tagName);
  static Insertable<KanjiTagStagingTableData> custom({
    Expression<int>? kanjiLocalId,
    Expression<String>? tagName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kanjiLocalId != null) 'kanji_local_id': kanjiLocalId,
      if (tagName != null) 'tag_name': tagName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiTagStagingTableCompanion copyWith({
    Value<int>? kanjiLocalId,
    Value<String>? tagName,
    Value<int>? rowid,
  }) {
    return KanjiTagStagingTableCompanion(
      kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
      tagName: tagName ?? this.tagName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kanjiLocalId.present) {
      map['kanji_local_id'] = Variable<int>(kanjiLocalId.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiTagStagingTableCompanion(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('tagName: $tagName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiStatStagingTableTable extends KanjiStatStagingTable
    with TableInfo<$KanjiStatStagingTableTable, KanjiStatStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiStatStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kanjiLocalIdMeta = const VerificationMeta(
    'kanjiLocalId',
  );
  @override
  late final GeneratedColumn<int> kanjiLocalId = GeneratedColumn<int>(
    'kanji_local_id',
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
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [kanjiLocalId, tagName, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_stat_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiStatStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kanji_local_id')) {
      context.handle(
        _kanjiLocalIdMeta,
        kanjiLocalId.isAcceptableOrUnknown(
          data['kanji_local_id']!,
          _kanjiLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kanjiLocalIdMeta);
    }
    if (data.containsKey('tag_name')) {
      context.handle(
        _tagNameMeta,
        tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  KanjiStatStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiStatStagingTableData(
      kanjiLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kanji_local_id'],
      )!,
      tagName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_name'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KanjiStatStagingTableTable createAlias(String alias) {
    return $KanjiStatStagingTableTable(attachedDatabase, alias);
  }
}

class KanjiStatStagingTableData extends DataClass
    implements Insertable<KanjiStatStagingTableData> {
  final int kanjiLocalId;
  final String tagName;
  final String value;
  const KanjiStatStagingTableData({
    required this.kanjiLocalId,
    required this.tagName,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kanji_local_id'] = Variable<int>(kanjiLocalId);
    map['tag_name'] = Variable<String>(tagName);
    map['value'] = Variable<String>(value);
    return map;
  }

  KanjiStatStagingTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiStatStagingTableCompanion(
      kanjiLocalId: Value(kanjiLocalId),
      tagName: Value(tagName),
      value: Value(value),
    );
  }

  factory KanjiStatStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiStatStagingTableData(
      kanjiLocalId: serializer.fromJson<int>(json['kanjiLocalId']),
      tagName: serializer.fromJson<String>(json['tagName']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kanjiLocalId': serializer.toJson<int>(kanjiLocalId),
      'tagName': serializer.toJson<String>(tagName),
      'value': serializer.toJson<String>(value),
    };
  }

  KanjiStatStagingTableData copyWith({
    int? kanjiLocalId,
    String? tagName,
    String? value,
  }) => KanjiStatStagingTableData(
    kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
    tagName: tagName ?? this.tagName,
    value: value ?? this.value,
  );
  KanjiStatStagingTableData copyWithCompanion(
    KanjiStatStagingTableCompanion data,
  ) {
    return KanjiStatStagingTableData(
      kanjiLocalId: data.kanjiLocalId.present
          ? data.kanjiLocalId.value
          : this.kanjiLocalId,
      tagName: data.tagName.present ? data.tagName.value : this.tagName,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiStatStagingTableData(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('tagName: $tagName, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kanjiLocalId, tagName, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiStatStagingTableData &&
          other.kanjiLocalId == this.kanjiLocalId &&
          other.tagName == this.tagName &&
          other.value == this.value);
}

class KanjiStatStagingTableCompanion
    extends UpdateCompanion<KanjiStatStagingTableData> {
  final Value<int> kanjiLocalId;
  final Value<String> tagName;
  final Value<String> value;
  final Value<int> rowid;
  const KanjiStatStagingTableCompanion({
    this.kanjiLocalId = const Value.absent(),
    this.tagName = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiStatStagingTableCompanion.insert({
    required int kanjiLocalId,
    required String tagName,
    required String value,
    this.rowid = const Value.absent(),
  }) : kanjiLocalId = Value(kanjiLocalId),
       tagName = Value(tagName),
       value = Value(value);
  static Insertable<KanjiStatStagingTableData> custom({
    Expression<int>? kanjiLocalId,
    Expression<String>? tagName,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kanjiLocalId != null) 'kanji_local_id': kanjiLocalId,
      if (tagName != null) 'tag_name': tagName,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiStatStagingTableCompanion copyWith({
    Value<int>? kanjiLocalId,
    Value<String>? tagName,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KanjiStatStagingTableCompanion(
      kanjiLocalId: kanjiLocalId ?? this.kanjiLocalId,
      tagName: tagName ?? this.tagName,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kanjiLocalId.present) {
      map['kanji_local_id'] = Variable<int>(kanjiLocalId.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiStatStagingTableCompanion(')
          ..write('kanjiLocalId: $kanjiLocalId, ')
          ..write('tagName: $tagName, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KanjiMetaStagingTableTable extends KanjiMetaStagingTable
    with TableInfo<$KanjiMetaStagingTableTable, KanjiMetaStagingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiMetaStagingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
    'kanji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _freqValueMeta = const VerificationMeta(
    'freqValue',
  );
  @override
  late final GeneratedColumn<int> freqValue = GeneratedColumn<int>(
    'freq_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _freqDisplayValueMeta = const VerificationMeta(
    'freqDisplayValue',
  );
  @override
  late final GeneratedColumn<String> freqDisplayValue = GeneratedColumn<String>(
    'freq_display_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    kanji,
    type,
    freqValue,
    freqDisplayValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_meta_staging_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KanjiMetaStagingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('kanji')) {
      context.handle(
        _kanjiMeta,
        kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta),
      );
    } else if (isInserting) {
      context.missing(_kanjiMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('freq_value')) {
      context.handle(
        _freqValueMeta,
        freqValue.isAcceptableOrUnknown(data['freq_value']!, _freqValueMeta),
      );
    }
    if (data.containsKey('freq_display_value')) {
      context.handle(
        _freqDisplayValueMeta,
        freqDisplayValue.isAcceptableOrUnknown(
          data['freq_display_value']!,
          _freqDisplayValueMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  KanjiMetaStagingTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiMetaStagingTableData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      kanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      freqValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}freq_value'],
      ),
      freqDisplayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}freq_display_value'],
      ),
    );
  }

  @override
  $KanjiMetaStagingTableTable createAlias(String alias) {
    return $KanjiMetaStagingTableTable(attachedDatabase, alias);
  }
}

class KanjiMetaStagingTableData extends DataClass
    implements Insertable<KanjiMetaStagingTableData> {
  final int localId;
  final String kanji;
  final String type;
  final int? freqValue;
  final String? freqDisplayValue;
  const KanjiMetaStagingTableData({
    required this.localId,
    required this.kanji,
    required this.type,
    this.freqValue,
    this.freqDisplayValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['kanji'] = Variable<String>(kanji);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || freqValue != null) {
      map['freq_value'] = Variable<int>(freqValue);
    }
    if (!nullToAbsent || freqDisplayValue != null) {
      map['freq_display_value'] = Variable<String>(freqDisplayValue);
    }
    return map;
  }

  KanjiMetaStagingTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiMetaStagingTableCompanion(
      localId: Value(localId),
      kanji: Value(kanji),
      type: Value(type),
      freqValue: freqValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqValue),
      freqDisplayValue: freqDisplayValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqDisplayValue),
    );
  }

  factory KanjiMetaStagingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiMetaStagingTableData(
      localId: serializer.fromJson<int>(json['localId']),
      kanji: serializer.fromJson<String>(json['kanji']),
      type: serializer.fromJson<String>(json['type']),
      freqValue: serializer.fromJson<int?>(json['freqValue']),
      freqDisplayValue: serializer.fromJson<String?>(json['freqDisplayValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'kanji': serializer.toJson<String>(kanji),
      'type': serializer.toJson<String>(type),
      'freqValue': serializer.toJson<int?>(freqValue),
      'freqDisplayValue': serializer.toJson<String?>(freqDisplayValue),
    };
  }

  KanjiMetaStagingTableData copyWith({
    int? localId,
    String? kanji,
    String? type,
    Value<int?> freqValue = const Value.absent(),
    Value<String?> freqDisplayValue = const Value.absent(),
  }) => KanjiMetaStagingTableData(
    localId: localId ?? this.localId,
    kanji: kanji ?? this.kanji,
    type: type ?? this.type,
    freqValue: freqValue.present ? freqValue.value : this.freqValue,
    freqDisplayValue: freqDisplayValue.present
        ? freqDisplayValue.value
        : this.freqDisplayValue,
  );
  KanjiMetaStagingTableData copyWithCompanion(
    KanjiMetaStagingTableCompanion data,
  ) {
    return KanjiMetaStagingTableData(
      localId: data.localId.present ? data.localId.value : this.localId,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
      type: data.type.present ? data.type.value : this.type,
      freqValue: data.freqValue.present ? data.freqValue.value : this.freqValue,
      freqDisplayValue: data.freqDisplayValue.present
          ? data.freqDisplayValue.value
          : this.freqDisplayValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiMetaStagingTableData(')
          ..write('localId: $localId, ')
          ..write('kanji: $kanji, ')
          ..write('type: $type, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplayValue: $freqDisplayValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(localId, kanji, type, freqValue, freqDisplayValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiMetaStagingTableData &&
          other.localId == this.localId &&
          other.kanji == this.kanji &&
          other.type == this.type &&
          other.freqValue == this.freqValue &&
          other.freqDisplayValue == this.freqDisplayValue);
}

class KanjiMetaStagingTableCompanion
    extends UpdateCompanion<KanjiMetaStagingTableData> {
  final Value<int> localId;
  final Value<String> kanji;
  final Value<String> type;
  final Value<int?> freqValue;
  final Value<String?> freqDisplayValue;
  final Value<int> rowid;
  const KanjiMetaStagingTableCompanion({
    this.localId = const Value.absent(),
    this.kanji = const Value.absent(),
    this.type = const Value.absent(),
    this.freqValue = const Value.absent(),
    this.freqDisplayValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KanjiMetaStagingTableCompanion.insert({
    required int localId,
    required String kanji,
    required String type,
    this.freqValue = const Value.absent(),
    this.freqDisplayValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : localId = Value(localId),
       kanji = Value(kanji),
       type = Value(type);
  static Insertable<KanjiMetaStagingTableData> custom({
    Expression<int>? localId,
    Expression<String>? kanji,
    Expression<String>? type,
    Expression<int>? freqValue,
    Expression<String>? freqDisplayValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (kanji != null) 'kanji': kanji,
      if (type != null) 'type': type,
      if (freqValue != null) 'freq_value': freqValue,
      if (freqDisplayValue != null) 'freq_display_value': freqDisplayValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KanjiMetaStagingTableCompanion copyWith({
    Value<int>? localId,
    Value<String>? kanji,
    Value<String>? type,
    Value<int?>? freqValue,
    Value<String?>? freqDisplayValue,
    Value<int>? rowid,
  }) {
    return KanjiMetaStagingTableCompanion(
      localId: localId ?? this.localId,
      kanji: kanji ?? this.kanji,
      type: type ?? this.type,
      freqValue: freqValue ?? this.freqValue,
      freqDisplayValue: freqDisplayValue ?? this.freqDisplayValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (freqValue.present) {
      map['freq_value'] = Variable<int>(freqValue.value);
    }
    if (freqDisplayValue.present) {
      map['freq_display_value'] = Variable<String>(freqDisplayValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiMetaStagingTableCompanion(')
          ..write('localId: $localId, ')
          ..write('kanji: $kanji, ')
          ..write('type: $type, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplayValue: $freqDisplayValue, ')
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
  late final $TermMetaStagingTableTable termMetaStagingTable =
      $TermMetaStagingTableTable(this);
  late final $TermMetaPitchStagingTableTable termMetaPitchStagingTable =
      $TermMetaPitchStagingTableTable(this);
  late final $TermMetaIpaStagingTableTable termMetaIpaStagingTable =
      $TermMetaIpaStagingTableTable(this);
  late final $TermMetaTagStagingTableTable termMetaTagStagingTable =
      $TermMetaTagStagingTableTable(this);
  late final $KanjiStagingTableTable kanjiStagingTable =
      $KanjiStagingTableTable(this);
  late final $KanjiReadingStagingTableTable kanjiReadingStagingTable =
      $KanjiReadingStagingTableTable(this);
  late final $KanjiDefinitionStagingTableTable kanjiDefinitionStagingTable =
      $KanjiDefinitionStagingTableTable(this);
  late final $KanjiTagStagingTableTable kanjiTagStagingTable =
      $KanjiTagStagingTableTable(this);
  late final $KanjiStatStagingTableTable kanjiStatStagingTable =
      $KanjiStatStagingTableTable(this);
  late final $KanjiMetaStagingTableTable kanjiMetaStagingTable =
      $KanjiMetaStagingTableTable(this);
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
    termMetaStagingTable,
    termMetaPitchStagingTable,
    termMetaIpaStagingTable,
    termMetaTagStagingTable,
    kanjiStagingTable,
    kanjiReadingStagingTable,
    kanjiDefinitionStagingTable,
    kanjiTagStagingTable,
    kanjiStatStagingTable,
    kanjiMetaStagingTable,
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
typedef $$TermMetaStagingTableTableCreateCompanionBuilder =
    TermMetaStagingTableCompanion Function({
      required int localId,
      required String term,
      Value<String?> termNormalized,
      Value<String?> termTokens,
      Value<String?> termTokensNormalized,
      required String mode,
      Value<String?> reading,
      Value<String?> readingNormalized,
      Value<int?> freqValue,
      Value<String?> freqDisplay,
      Value<int> rowid,
    });
typedef $$TermMetaStagingTableTableUpdateCompanionBuilder =
    TermMetaStagingTableCompanion Function({
      Value<int> localId,
      Value<String> term,
      Value<String?> termNormalized,
      Value<String?> termTokens,
      Value<String?> termTokensNormalized,
      Value<String> mode,
      Value<String?> reading,
      Value<String?> readingNormalized,
      Value<int?> freqValue,
      Value<String?> freqDisplay,
      Value<int> rowid,
    });

class $$TermMetaStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermMetaStagingTableTable> {
  $$TermMetaStagingTableTableFilterComposer({
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

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get freqValue => $composableBuilder(
    column: $table.freqValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get freqDisplay => $composableBuilder(
    column: $table.freqDisplay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermMetaStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermMetaStagingTableTable> {
  $$TermMetaStagingTableTableOrderingComposer({
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

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get freqValue => $composableBuilder(
    column: $table.freqValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get freqDisplay => $composableBuilder(
    column: $table.freqDisplay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermMetaStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermMetaStagingTableTable> {
  $$TermMetaStagingTableTableAnnotationComposer({
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

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<int> get freqValue =>
      $composableBuilder(column: $table.freqValue, builder: (column) => column);

  GeneratedColumn<String> get freqDisplay => $composableBuilder(
    column: $table.freqDisplay,
    builder: (column) => column,
  );
}

class $$TermMetaStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermMetaStagingTableTable,
          TermMetaStagingTableData,
          $$TermMetaStagingTableTableFilterComposer,
          $$TermMetaStagingTableTableOrderingComposer,
          $$TermMetaStagingTableTableAnnotationComposer,
          $$TermMetaStagingTableTableCreateCompanionBuilder,
          $$TermMetaStagingTableTableUpdateCompanionBuilder,
          (
            TermMetaStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermMetaStagingTableTable,
              TermMetaStagingTableData
            >,
          ),
          TermMetaStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermMetaStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermMetaStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermMetaStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermMetaStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String> term = const Value.absent(),
                Value<String?> termNormalized = const Value.absent(),
                Value<String?> termTokens = const Value.absent(),
                Value<String?> termTokensNormalized = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String?> reading = const Value.absent(),
                Value<String?> readingNormalized = const Value.absent(),
                Value<int?> freqValue = const Value.absent(),
                Value<String?> freqDisplay = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermMetaStagingTableCompanion(
                localId: localId,
                term: term,
                termNormalized: termNormalized,
                termTokens: termTokens,
                termTokensNormalized: termTokensNormalized,
                mode: mode,
                reading: reading,
                readingNormalized: readingNormalized,
                freqValue: freqValue,
                freqDisplay: freqDisplay,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int localId,
                required String term,
                Value<String?> termNormalized = const Value.absent(),
                Value<String?> termTokens = const Value.absent(),
                Value<String?> termTokensNormalized = const Value.absent(),
                required String mode,
                Value<String?> reading = const Value.absent(),
                Value<String?> readingNormalized = const Value.absent(),
                Value<int?> freqValue = const Value.absent(),
                Value<String?> freqDisplay = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermMetaStagingTableCompanion.insert(
                localId: localId,
                term: term,
                termNormalized: termNormalized,
                termTokens: termTokens,
                termTokensNormalized: termTokensNormalized,
                mode: mode,
                reading: reading,
                readingNormalized: readingNormalized,
                freqValue: freqValue,
                freqDisplay: freqDisplay,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermMetaStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermMetaStagingTableTable,
      TermMetaStagingTableData,
      $$TermMetaStagingTableTableFilterComposer,
      $$TermMetaStagingTableTableOrderingComposer,
      $$TermMetaStagingTableTableAnnotationComposer,
      $$TermMetaStagingTableTableCreateCompanionBuilder,
      $$TermMetaStagingTableTableUpdateCompanionBuilder,
      (
        TermMetaStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermMetaStagingTableTable,
          TermMetaStagingTableData
        >,
      ),
      TermMetaStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermMetaPitchStagingTableTableCreateCompanionBuilder =
    TermMetaPitchStagingTableCompanion Function({
      required int pitchLocalId,
      required int metaLocalId,
      required int position,
      Value<int?> nasal,
      Value<int?> devoice,
      Value<int> rowid,
    });
typedef $$TermMetaPitchStagingTableTableUpdateCompanionBuilder =
    TermMetaPitchStagingTableCompanion Function({
      Value<int> pitchLocalId,
      Value<int> metaLocalId,
      Value<int> position,
      Value<int?> nasal,
      Value<int?> devoice,
      Value<int> rowid,
    });

class $$TermMetaPitchStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermMetaPitchStagingTableTable> {
  $$TermMetaPitchStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pitchLocalId => $composableBuilder(
    column: $table.pitchLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get metaLocalId => $composableBuilder(
    column: $table.metaLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nasal => $composableBuilder(
    column: $table.nasal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get devoice => $composableBuilder(
    column: $table.devoice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermMetaPitchStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermMetaPitchStagingTableTable> {
  $$TermMetaPitchStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pitchLocalId => $composableBuilder(
    column: $table.pitchLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get metaLocalId => $composableBuilder(
    column: $table.metaLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nasal => $composableBuilder(
    column: $table.nasal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get devoice => $composableBuilder(
    column: $table.devoice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermMetaPitchStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermMetaPitchStagingTableTable> {
  $$TermMetaPitchStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pitchLocalId => $composableBuilder(
    column: $table.pitchLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get metaLocalId => $composableBuilder(
    column: $table.metaLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get nasal =>
      $composableBuilder(column: $table.nasal, builder: (column) => column);

  GeneratedColumn<int> get devoice =>
      $composableBuilder(column: $table.devoice, builder: (column) => column);
}

class $$TermMetaPitchStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermMetaPitchStagingTableTable,
          TermMetaPitchStagingTableData,
          $$TermMetaPitchStagingTableTableFilterComposer,
          $$TermMetaPitchStagingTableTableOrderingComposer,
          $$TermMetaPitchStagingTableTableAnnotationComposer,
          $$TermMetaPitchStagingTableTableCreateCompanionBuilder,
          $$TermMetaPitchStagingTableTableUpdateCompanionBuilder,
          (
            TermMetaPitchStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermMetaPitchStagingTableTable,
              TermMetaPitchStagingTableData
            >,
          ),
          TermMetaPitchStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermMetaPitchStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermMetaPitchStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaPitchStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TermMetaPitchStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermMetaPitchStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pitchLocalId = const Value.absent(),
                Value<int> metaLocalId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int?> nasal = const Value.absent(),
                Value<int?> devoice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermMetaPitchStagingTableCompanion(
                pitchLocalId: pitchLocalId,
                metaLocalId: metaLocalId,
                position: position,
                nasal: nasal,
                devoice: devoice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pitchLocalId,
                required int metaLocalId,
                required int position,
                Value<int?> nasal = const Value.absent(),
                Value<int?> devoice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermMetaPitchStagingTableCompanion.insert(
                pitchLocalId: pitchLocalId,
                metaLocalId: metaLocalId,
                position: position,
                nasal: nasal,
                devoice: devoice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermMetaPitchStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermMetaPitchStagingTableTable,
      TermMetaPitchStagingTableData,
      $$TermMetaPitchStagingTableTableFilterComposer,
      $$TermMetaPitchStagingTableTableOrderingComposer,
      $$TermMetaPitchStagingTableTableAnnotationComposer,
      $$TermMetaPitchStagingTableTableCreateCompanionBuilder,
      $$TermMetaPitchStagingTableTableUpdateCompanionBuilder,
      (
        TermMetaPitchStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermMetaPitchStagingTableTable,
          TermMetaPitchStagingTableData
        >,
      ),
      TermMetaPitchStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermMetaIpaStagingTableTableCreateCompanionBuilder =
    TermMetaIpaStagingTableCompanion Function({
      required int ipaLocalId,
      required int metaLocalId,
      required String ipa,
      Value<int> rowid,
    });
typedef $$TermMetaIpaStagingTableTableUpdateCompanionBuilder =
    TermMetaIpaStagingTableCompanion Function({
      Value<int> ipaLocalId,
      Value<int> metaLocalId,
      Value<String> ipa,
      Value<int> rowid,
    });

class $$TermMetaIpaStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermMetaIpaStagingTableTable> {
  $$TermMetaIpaStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ipaLocalId => $composableBuilder(
    column: $table.ipaLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get metaLocalId => $composableBuilder(
    column: $table.metaLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipa => $composableBuilder(
    column: $table.ipa,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermMetaIpaStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermMetaIpaStagingTableTable> {
  $$TermMetaIpaStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ipaLocalId => $composableBuilder(
    column: $table.ipaLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get metaLocalId => $composableBuilder(
    column: $table.metaLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipa => $composableBuilder(
    column: $table.ipa,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermMetaIpaStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermMetaIpaStagingTableTable> {
  $$TermMetaIpaStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ipaLocalId => $composableBuilder(
    column: $table.ipaLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get metaLocalId => $composableBuilder(
    column: $table.metaLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ipa =>
      $composableBuilder(column: $table.ipa, builder: (column) => column);
}

class $$TermMetaIpaStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermMetaIpaStagingTableTable,
          TermMetaIpaStagingTableData,
          $$TermMetaIpaStagingTableTableFilterComposer,
          $$TermMetaIpaStagingTableTableOrderingComposer,
          $$TermMetaIpaStagingTableTableAnnotationComposer,
          $$TermMetaIpaStagingTableTableCreateCompanionBuilder,
          $$TermMetaIpaStagingTableTableUpdateCompanionBuilder,
          (
            TermMetaIpaStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermMetaIpaStagingTableTable,
              TermMetaIpaStagingTableData
            >,
          ),
          TermMetaIpaStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermMetaIpaStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermMetaIpaStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaIpaStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TermMetaIpaStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermMetaIpaStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> ipaLocalId = const Value.absent(),
                Value<int> metaLocalId = const Value.absent(),
                Value<String> ipa = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermMetaIpaStagingTableCompanion(
                ipaLocalId: ipaLocalId,
                metaLocalId: metaLocalId,
                ipa: ipa,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int ipaLocalId,
                required int metaLocalId,
                required String ipa,
                Value<int> rowid = const Value.absent(),
              }) => TermMetaIpaStagingTableCompanion.insert(
                ipaLocalId: ipaLocalId,
                metaLocalId: metaLocalId,
                ipa: ipa,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermMetaIpaStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermMetaIpaStagingTableTable,
      TermMetaIpaStagingTableData,
      $$TermMetaIpaStagingTableTableFilterComposer,
      $$TermMetaIpaStagingTableTableOrderingComposer,
      $$TermMetaIpaStagingTableTableAnnotationComposer,
      $$TermMetaIpaStagingTableTableCreateCompanionBuilder,
      $$TermMetaIpaStagingTableTableUpdateCompanionBuilder,
      (
        TermMetaIpaStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermMetaIpaStagingTableTable,
          TermMetaIpaStagingTableData
        >,
      ),
      TermMetaIpaStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$TermMetaTagStagingTableTableCreateCompanionBuilder =
    TermMetaTagStagingTableCompanion Function({
      required int parentLocalId,
      required String parentType,
      required String tagName,
      Value<int> rowid,
    });
typedef $$TermMetaTagStagingTableTableUpdateCompanionBuilder =
    TermMetaTagStagingTableCompanion Function({
      Value<int> parentLocalId,
      Value<String> parentType,
      Value<String> tagName,
      Value<int> rowid,
    });

class $$TermMetaTagStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $TermMetaTagStagingTableTable> {
  $$TermMetaTagStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get parentLocalId => $composableBuilder(
    column: $table.parentLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentType => $composableBuilder(
    column: $table.parentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermMetaTagStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $TermMetaTagStagingTableTable> {
  $$TermMetaTagStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get parentLocalId => $composableBuilder(
    column: $table.parentLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentType => $composableBuilder(
    column: $table.parentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermMetaTagStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $TermMetaTagStagingTableTable> {
  $$TermMetaTagStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get parentLocalId => $composableBuilder(
    column: $table.parentLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentType => $composableBuilder(
    column: $table.parentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);
}

class $$TermMetaTagStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $TermMetaTagStagingTableTable,
          TermMetaTagStagingTableData,
          $$TermMetaTagStagingTableTableFilterComposer,
          $$TermMetaTagStagingTableTableOrderingComposer,
          $$TermMetaTagStagingTableTableAnnotationComposer,
          $$TermMetaTagStagingTableTableCreateCompanionBuilder,
          $$TermMetaTagStagingTableTableUpdateCompanionBuilder,
          (
            TermMetaTagStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $TermMetaTagStagingTableTable,
              TermMetaTagStagingTableData
            >,
          ),
          TermMetaTagStagingTableData,
          PrefetchHooks Function()
        > {
  $$TermMetaTagStagingTableTableTableManager(
    _$StagingDatabase db,
    $TermMetaTagStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaTagStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TermMetaTagStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TermMetaTagStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> parentLocalId = const Value.absent(),
                Value<String> parentType = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TermMetaTagStagingTableCompanion(
                parentLocalId: parentLocalId,
                parentType: parentType,
                tagName: tagName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int parentLocalId,
                required String parentType,
                required String tagName,
                Value<int> rowid = const Value.absent(),
              }) => TermMetaTagStagingTableCompanion.insert(
                parentLocalId: parentLocalId,
                parentType: parentType,
                tagName: tagName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermMetaTagStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $TermMetaTagStagingTableTable,
      TermMetaTagStagingTableData,
      $$TermMetaTagStagingTableTableFilterComposer,
      $$TermMetaTagStagingTableTableOrderingComposer,
      $$TermMetaTagStagingTableTableAnnotationComposer,
      $$TermMetaTagStagingTableTableCreateCompanionBuilder,
      $$TermMetaTagStagingTableTableUpdateCompanionBuilder,
      (
        TermMetaTagStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $TermMetaTagStagingTableTable,
          TermMetaTagStagingTableData
        >,
      ),
      TermMetaTagStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$KanjiStagingTableTableCreateCompanionBuilder =
    KanjiStagingTableCompanion Function({
      required int localId,
      required String kanji,
      Value<String?> originalOnyomi,
      Value<String?> originalKunyomi,
      Value<int> rowid,
    });
typedef $$KanjiStagingTableTableUpdateCompanionBuilder =
    KanjiStagingTableCompanion Function({
      Value<int> localId,
      Value<String> kanji,
      Value<String?> originalOnyomi,
      Value<String?> originalKunyomi,
      Value<int> rowid,
    });

class $$KanjiStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $KanjiStagingTableTable> {
  $$KanjiStagingTableTableFilterComposer({
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

  ColumnFilters<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalOnyomi => $composableBuilder(
    column: $table.originalOnyomi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalKunyomi => $composableBuilder(
    column: $table.originalKunyomi,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KanjiStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $KanjiStagingTableTable> {
  $$KanjiStagingTableTableOrderingComposer({
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

  ColumnOrderings<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalOnyomi => $composableBuilder(
    column: $table.originalOnyomi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalKunyomi => $composableBuilder(
    column: $table.originalKunyomi,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KanjiStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $KanjiStagingTableTable> {
  $$KanjiStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  GeneratedColumn<String> get originalOnyomi => $composableBuilder(
    column: $table.originalOnyomi,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalKunyomi => $composableBuilder(
    column: $table.originalKunyomi,
    builder: (column) => column,
  );
}

class $$KanjiStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $KanjiStagingTableTable,
          KanjiStagingTableData,
          $$KanjiStagingTableTableFilterComposer,
          $$KanjiStagingTableTableOrderingComposer,
          $$KanjiStagingTableTableAnnotationComposer,
          $$KanjiStagingTableTableCreateCompanionBuilder,
          $$KanjiStagingTableTableUpdateCompanionBuilder,
          (
            KanjiStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $KanjiStagingTableTable,
              KanjiStagingTableData
            >,
          ),
          KanjiStagingTableData,
          PrefetchHooks Function()
        > {
  $$KanjiStagingTableTableTableManager(
    _$StagingDatabase db,
    $KanjiStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiStagingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String> kanji = const Value.absent(),
                Value<String?> originalOnyomi = const Value.absent(),
                Value<String?> originalKunyomi = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiStagingTableCompanion(
                localId: localId,
                kanji: kanji,
                originalOnyomi: originalOnyomi,
                originalKunyomi: originalKunyomi,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int localId,
                required String kanji,
                Value<String?> originalOnyomi = const Value.absent(),
                Value<String?> originalKunyomi = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiStagingTableCompanion.insert(
                localId: localId,
                kanji: kanji,
                originalOnyomi: originalOnyomi,
                originalKunyomi: originalKunyomi,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KanjiStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $KanjiStagingTableTable,
      KanjiStagingTableData,
      $$KanjiStagingTableTableFilterComposer,
      $$KanjiStagingTableTableOrderingComposer,
      $$KanjiStagingTableTableAnnotationComposer,
      $$KanjiStagingTableTableCreateCompanionBuilder,
      $$KanjiStagingTableTableUpdateCompanionBuilder,
      (
        KanjiStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $KanjiStagingTableTable,
          KanjiStagingTableData
        >,
      ),
      KanjiStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$KanjiReadingStagingTableTableCreateCompanionBuilder =
    KanjiReadingStagingTableCompanion Function({
      required int kanjiLocalId,
      required String reading,
      Value<String?> readingNormalized,
      required String type,
      required int position,
      Value<int> rowid,
    });
typedef $$KanjiReadingStagingTableTableUpdateCompanionBuilder =
    KanjiReadingStagingTableCompanion Function({
      Value<int> kanjiLocalId,
      Value<String> reading,
      Value<String?> readingNormalized,
      Value<String> type,
      Value<int> position,
      Value<int> rowid,
    });

class $$KanjiReadingStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $KanjiReadingStagingTableTable> {
  $$KanjiReadingStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KanjiReadingStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $KanjiReadingStagingTableTable> {
  $$KanjiReadingStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KanjiReadingStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $KanjiReadingStagingTableTable> {
  $$KanjiReadingStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<String> get readingNormalized => $composableBuilder(
    column: $table.readingNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$KanjiReadingStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $KanjiReadingStagingTableTable,
          KanjiReadingStagingTableData,
          $$KanjiReadingStagingTableTableFilterComposer,
          $$KanjiReadingStagingTableTableOrderingComposer,
          $$KanjiReadingStagingTableTableAnnotationComposer,
          $$KanjiReadingStagingTableTableCreateCompanionBuilder,
          $$KanjiReadingStagingTableTableUpdateCompanionBuilder,
          (
            KanjiReadingStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $KanjiReadingStagingTableTable,
              KanjiReadingStagingTableData
            >,
          ),
          KanjiReadingStagingTableData,
          PrefetchHooks Function()
        > {
  $$KanjiReadingStagingTableTableTableManager(
    _$StagingDatabase db,
    $KanjiReadingStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiReadingStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$KanjiReadingStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KanjiReadingStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> kanjiLocalId = const Value.absent(),
                Value<String> reading = const Value.absent(),
                Value<String?> readingNormalized = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiReadingStagingTableCompanion(
                kanjiLocalId: kanjiLocalId,
                reading: reading,
                readingNormalized: readingNormalized,
                type: type,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int kanjiLocalId,
                required String reading,
                Value<String?> readingNormalized = const Value.absent(),
                required String type,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => KanjiReadingStagingTableCompanion.insert(
                kanjiLocalId: kanjiLocalId,
                reading: reading,
                readingNormalized: readingNormalized,
                type: type,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KanjiReadingStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $KanjiReadingStagingTableTable,
      KanjiReadingStagingTableData,
      $$KanjiReadingStagingTableTableFilterComposer,
      $$KanjiReadingStagingTableTableOrderingComposer,
      $$KanjiReadingStagingTableTableAnnotationComposer,
      $$KanjiReadingStagingTableTableCreateCompanionBuilder,
      $$KanjiReadingStagingTableTableUpdateCompanionBuilder,
      (
        KanjiReadingStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $KanjiReadingStagingTableTable,
          KanjiReadingStagingTableData
        >,
      ),
      KanjiReadingStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$KanjiDefinitionStagingTableTableCreateCompanionBuilder =
    KanjiDefinitionStagingTableCompanion Function({
      required int kanjiLocalId,
      required String definition,
      required int position,
      Value<int> rowid,
    });
typedef $$KanjiDefinitionStagingTableTableUpdateCompanionBuilder =
    KanjiDefinitionStagingTableCompanion Function({
      Value<int> kanjiLocalId,
      Value<String> definition,
      Value<int> position,
      Value<int> rowid,
    });

class $$KanjiDefinitionStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $KanjiDefinitionStagingTableTable> {
  $$KanjiDefinitionStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KanjiDefinitionStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $KanjiDefinitionStagingTableTable> {
  $$KanjiDefinitionStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KanjiDefinitionStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $KanjiDefinitionStagingTableTable> {
  $$KanjiDefinitionStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$KanjiDefinitionStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $KanjiDefinitionStagingTableTable,
          KanjiDefinitionStagingTableData,
          $$KanjiDefinitionStagingTableTableFilterComposer,
          $$KanjiDefinitionStagingTableTableOrderingComposer,
          $$KanjiDefinitionStagingTableTableAnnotationComposer,
          $$KanjiDefinitionStagingTableTableCreateCompanionBuilder,
          $$KanjiDefinitionStagingTableTableUpdateCompanionBuilder,
          (
            KanjiDefinitionStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $KanjiDefinitionStagingTableTable,
              KanjiDefinitionStagingTableData
            >,
          ),
          KanjiDefinitionStagingTableData,
          PrefetchHooks Function()
        > {
  $$KanjiDefinitionStagingTableTableTableManager(
    _$StagingDatabase db,
    $KanjiDefinitionStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiDefinitionStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$KanjiDefinitionStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KanjiDefinitionStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> kanjiLocalId = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiDefinitionStagingTableCompanion(
                kanjiLocalId: kanjiLocalId,
                definition: definition,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int kanjiLocalId,
                required String definition,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => KanjiDefinitionStagingTableCompanion.insert(
                kanjiLocalId: kanjiLocalId,
                definition: definition,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KanjiDefinitionStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $KanjiDefinitionStagingTableTable,
      KanjiDefinitionStagingTableData,
      $$KanjiDefinitionStagingTableTableFilterComposer,
      $$KanjiDefinitionStagingTableTableOrderingComposer,
      $$KanjiDefinitionStagingTableTableAnnotationComposer,
      $$KanjiDefinitionStagingTableTableCreateCompanionBuilder,
      $$KanjiDefinitionStagingTableTableUpdateCompanionBuilder,
      (
        KanjiDefinitionStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $KanjiDefinitionStagingTableTable,
          KanjiDefinitionStagingTableData
        >,
      ),
      KanjiDefinitionStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$KanjiTagStagingTableTableCreateCompanionBuilder =
    KanjiTagStagingTableCompanion Function({
      required int kanjiLocalId,
      required String tagName,
      Value<int> rowid,
    });
typedef $$KanjiTagStagingTableTableUpdateCompanionBuilder =
    KanjiTagStagingTableCompanion Function({
      Value<int> kanjiLocalId,
      Value<String> tagName,
      Value<int> rowid,
    });

class $$KanjiTagStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $KanjiTagStagingTableTable> {
  $$KanjiTagStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KanjiTagStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $KanjiTagStagingTableTable> {
  $$KanjiTagStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KanjiTagStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $KanjiTagStagingTableTable> {
  $$KanjiTagStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);
}

class $$KanjiTagStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $KanjiTagStagingTableTable,
          KanjiTagStagingTableData,
          $$KanjiTagStagingTableTableFilterComposer,
          $$KanjiTagStagingTableTableOrderingComposer,
          $$KanjiTagStagingTableTableAnnotationComposer,
          $$KanjiTagStagingTableTableCreateCompanionBuilder,
          $$KanjiTagStagingTableTableUpdateCompanionBuilder,
          (
            KanjiTagStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $KanjiTagStagingTableTable,
              KanjiTagStagingTableData
            >,
          ),
          KanjiTagStagingTableData,
          PrefetchHooks Function()
        > {
  $$KanjiTagStagingTableTableTableManager(
    _$StagingDatabase db,
    $KanjiTagStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiTagStagingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiTagStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KanjiTagStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> kanjiLocalId = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiTagStagingTableCompanion(
                kanjiLocalId: kanjiLocalId,
                tagName: tagName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int kanjiLocalId,
                required String tagName,
                Value<int> rowid = const Value.absent(),
              }) => KanjiTagStagingTableCompanion.insert(
                kanjiLocalId: kanjiLocalId,
                tagName: tagName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KanjiTagStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $KanjiTagStagingTableTable,
      KanjiTagStagingTableData,
      $$KanjiTagStagingTableTableFilterComposer,
      $$KanjiTagStagingTableTableOrderingComposer,
      $$KanjiTagStagingTableTableAnnotationComposer,
      $$KanjiTagStagingTableTableCreateCompanionBuilder,
      $$KanjiTagStagingTableTableUpdateCompanionBuilder,
      (
        KanjiTagStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $KanjiTagStagingTableTable,
          KanjiTagStagingTableData
        >,
      ),
      KanjiTagStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$KanjiStatStagingTableTableCreateCompanionBuilder =
    KanjiStatStagingTableCompanion Function({
      required int kanjiLocalId,
      required String tagName,
      required String value,
      Value<int> rowid,
    });
typedef $$KanjiStatStagingTableTableUpdateCompanionBuilder =
    KanjiStatStagingTableCompanion Function({
      Value<int> kanjiLocalId,
      Value<String> tagName,
      Value<String> value,
      Value<int> rowid,
    });

class $$KanjiStatStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $KanjiStatStagingTableTable> {
  $$KanjiStatStagingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KanjiStatStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $KanjiStatStagingTableTable> {
  $$KanjiStatStagingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagName => $composableBuilder(
    column: $table.tagName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KanjiStatStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $KanjiStatStagingTableTable> {
  $$KanjiStatStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get kanjiLocalId => $composableBuilder(
    column: $table.kanjiLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagName =>
      $composableBuilder(column: $table.tagName, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KanjiStatStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $KanjiStatStagingTableTable,
          KanjiStatStagingTableData,
          $$KanjiStatStagingTableTableFilterComposer,
          $$KanjiStatStagingTableTableOrderingComposer,
          $$KanjiStatStagingTableTableAnnotationComposer,
          $$KanjiStatStagingTableTableCreateCompanionBuilder,
          $$KanjiStatStagingTableTableUpdateCompanionBuilder,
          (
            KanjiStatStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $KanjiStatStagingTableTable,
              KanjiStatStagingTableData
            >,
          ),
          KanjiStatStagingTableData,
          PrefetchHooks Function()
        > {
  $$KanjiStatStagingTableTableTableManager(
    _$StagingDatabase db,
    $KanjiStatStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiStatStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$KanjiStatStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KanjiStatStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> kanjiLocalId = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiStatStagingTableCompanion(
                kanjiLocalId: kanjiLocalId,
                tagName: tagName,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int kanjiLocalId,
                required String tagName,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => KanjiStatStagingTableCompanion.insert(
                kanjiLocalId: kanjiLocalId,
                tagName: tagName,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KanjiStatStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $KanjiStatStagingTableTable,
      KanjiStatStagingTableData,
      $$KanjiStatStagingTableTableFilterComposer,
      $$KanjiStatStagingTableTableOrderingComposer,
      $$KanjiStatStagingTableTableAnnotationComposer,
      $$KanjiStatStagingTableTableCreateCompanionBuilder,
      $$KanjiStatStagingTableTableUpdateCompanionBuilder,
      (
        KanjiStatStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $KanjiStatStagingTableTable,
          KanjiStatStagingTableData
        >,
      ),
      KanjiStatStagingTableData,
      PrefetchHooks Function()
    >;
typedef $$KanjiMetaStagingTableTableCreateCompanionBuilder =
    KanjiMetaStagingTableCompanion Function({
      required int localId,
      required String kanji,
      required String type,
      Value<int?> freqValue,
      Value<String?> freqDisplayValue,
      Value<int> rowid,
    });
typedef $$KanjiMetaStagingTableTableUpdateCompanionBuilder =
    KanjiMetaStagingTableCompanion Function({
      Value<int> localId,
      Value<String> kanji,
      Value<String> type,
      Value<int?> freqValue,
      Value<String?> freqDisplayValue,
      Value<int> rowid,
    });

class $$KanjiMetaStagingTableTableFilterComposer
    extends Composer<_$StagingDatabase, $KanjiMetaStagingTableTable> {
  $$KanjiMetaStagingTableTableFilterComposer({
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

  ColumnFilters<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get freqValue => $composableBuilder(
    column: $table.freqValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get freqDisplayValue => $composableBuilder(
    column: $table.freqDisplayValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KanjiMetaStagingTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $KanjiMetaStagingTableTable> {
  $$KanjiMetaStagingTableTableOrderingComposer({
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

  ColumnOrderings<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get freqValue => $composableBuilder(
    column: $table.freqValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get freqDisplayValue => $composableBuilder(
    column: $table.freqDisplayValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KanjiMetaStagingTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $KanjiMetaStagingTableTable> {
  $$KanjiMetaStagingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get freqValue =>
      $composableBuilder(column: $table.freqValue, builder: (column) => column);

  GeneratedColumn<String> get freqDisplayValue => $composableBuilder(
    column: $table.freqDisplayValue,
    builder: (column) => column,
  );
}

class $$KanjiMetaStagingTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $KanjiMetaStagingTableTable,
          KanjiMetaStagingTableData,
          $$KanjiMetaStagingTableTableFilterComposer,
          $$KanjiMetaStagingTableTableOrderingComposer,
          $$KanjiMetaStagingTableTableAnnotationComposer,
          $$KanjiMetaStagingTableTableCreateCompanionBuilder,
          $$KanjiMetaStagingTableTableUpdateCompanionBuilder,
          (
            KanjiMetaStagingTableData,
            BaseReferences<
              _$StagingDatabase,
              $KanjiMetaStagingTableTable,
              KanjiMetaStagingTableData
            >,
          ),
          KanjiMetaStagingTableData,
          PrefetchHooks Function()
        > {
  $$KanjiMetaStagingTableTableTableManager(
    _$StagingDatabase db,
    $KanjiMetaStagingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiMetaStagingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$KanjiMetaStagingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KanjiMetaStagingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String> kanji = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> freqValue = const Value.absent(),
                Value<String?> freqDisplayValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiMetaStagingTableCompanion(
                localId: localId,
                kanji: kanji,
                type: type,
                freqValue: freqValue,
                freqDisplayValue: freqDisplayValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int localId,
                required String kanji,
                required String type,
                Value<int?> freqValue = const Value.absent(),
                Value<String?> freqDisplayValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KanjiMetaStagingTableCompanion.insert(
                localId: localId,
                kanji: kanji,
                type: type,
                freqValue: freqValue,
                freqDisplayValue: freqDisplayValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KanjiMetaStagingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $KanjiMetaStagingTableTable,
      KanjiMetaStagingTableData,
      $$KanjiMetaStagingTableTableFilterComposer,
      $$KanjiMetaStagingTableTableOrderingComposer,
      $$KanjiMetaStagingTableTableAnnotationComposer,
      $$KanjiMetaStagingTableTableCreateCompanionBuilder,
      $$KanjiMetaStagingTableTableUpdateCompanionBuilder,
      (
        KanjiMetaStagingTableData,
        BaseReferences<
          _$StagingDatabase,
          $KanjiMetaStagingTableTable,
          KanjiMetaStagingTableData
        >,
      ),
      KanjiMetaStagingTableData,
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
  $$TermMetaStagingTableTableTableManager get termMetaStagingTable =>
      $$TermMetaStagingTableTableTableManager(_db, _db.termMetaStagingTable);
  $$TermMetaPitchStagingTableTableTableManager get termMetaPitchStagingTable =>
      $$TermMetaPitchStagingTableTableTableManager(
        _db,
        _db.termMetaPitchStagingTable,
      );
  $$TermMetaIpaStagingTableTableTableManager get termMetaIpaStagingTable =>
      $$TermMetaIpaStagingTableTableTableManager(
        _db,
        _db.termMetaIpaStagingTable,
      );
  $$TermMetaTagStagingTableTableTableManager get termMetaTagStagingTable =>
      $$TermMetaTagStagingTableTableTableManager(
        _db,
        _db.termMetaTagStagingTable,
      );
  $$KanjiStagingTableTableTableManager get kanjiStagingTable =>
      $$KanjiStagingTableTableTableManager(_db, _db.kanjiStagingTable);
  $$KanjiReadingStagingTableTableTableManager get kanjiReadingStagingTable =>
      $$KanjiReadingStagingTableTableTableManager(
        _db,
        _db.kanjiReadingStagingTable,
      );
  $$KanjiDefinitionStagingTableTableTableManager
  get kanjiDefinitionStagingTable =>
      $$KanjiDefinitionStagingTableTableTableManager(
        _db,
        _db.kanjiDefinitionStagingTable,
      );
  $$KanjiTagStagingTableTableTableManager get kanjiTagStagingTable =>
      $$KanjiTagStagingTableTableTableManager(_db, _db.kanjiTagStagingTable);
  $$KanjiStatStagingTableTableTableManager get kanjiStatStagingTable =>
      $$KanjiStatStagingTableTableTableManager(_db, _db.kanjiStatStagingTable);
  $$KanjiMetaStagingTableTableTableManager get kanjiMetaStagingTable =>
      $$KanjiMetaStagingTableTableTableManager(_db, _db.kanjiMetaStagingTable);
}
