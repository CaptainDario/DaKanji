// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staging_db.dart';

// ignore_for_file: type=lint
class $StagingTermTableTable extends StagingTermTable
    with TableInfo<$StagingTermTableTable, StagingTermTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StagingTermTableTable(this.attachedDatabase, [this._alias]);
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
      ).withConverter<String?>($StagingTermTableTable.$converteroriginalJsonn);
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
  static const String $name = 'staging_term_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<StagingTermTableData> instance, {
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
  StagingTermTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StagingTermTableData(
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
      originalJson: $StagingTermTableTable.$converteroriginalJsonn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}original_json'],
        ),
      ),
    );
  }

  @override
  $StagingTermTableTable createAlias(String alias) {
    return $StagingTermTableTable(attachedDatabase, alias);
  }

  static TypeConverter<String, Uint8List> $converteroriginalJson =
      const ZlibStringConverter();
  static TypeConverter<String?, Uint8List?> $converteroriginalJsonn =
      NullAwareTypeConverter.wrap($converteroriginalJson);
}

class StagingTermTableData extends DataClass
    implements Insertable<StagingTermTableData> {
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
  const StagingTermTableData({
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
        $StagingTermTableTable.$converteroriginalJsonn.toSql(originalJson),
      );
    }
    return map;
  }

  StagingTermTableCompanion toCompanion(bool nullToAbsent) {
    return StagingTermTableCompanion(
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

  factory StagingTermTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StagingTermTableData(
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

  StagingTermTableData copyWith({
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
  }) => StagingTermTableData(
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
  StagingTermTableData copyWithCompanion(StagingTermTableCompanion data) {
    return StagingTermTableData(
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
    return (StringBuffer('StagingTermTableData(')
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
      (other is StagingTermTableData &&
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

class StagingTermTableCompanion extends UpdateCompanion<StagingTermTableData> {
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
  const StagingTermTableCompanion({
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
  StagingTermTableCompanion.insert({
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
  static Insertable<StagingTermTableData> custom({
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

  StagingTermTableCompanion copyWith({
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
    return StagingTermTableCompanion(
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
        $StagingTermTableTable.$converteroriginalJsonn.toSql(
          originalJson.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StagingTermTableCompanion(')
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

class $StagingDefinitionTableTable extends StagingDefinitionTable
    with TableInfo<$StagingDefinitionTableTable, StagingDefinitionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StagingDefinitionTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'staging_definition_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<StagingDefinitionTableData> instance, {
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
  StagingDefinitionTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StagingDefinitionTableData(
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
  $StagingDefinitionTableTable createAlias(String alias) {
    return $StagingDefinitionTableTable(attachedDatabase, alias);
  }
}

class StagingDefinitionTableData extends DataClass
    implements Insertable<StagingDefinitionTableData> {
  final int termLocalId;
  final String definition;
  const StagingDefinitionTableData({
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

  StagingDefinitionTableCompanion toCompanion(bool nullToAbsent) {
    return StagingDefinitionTableCompanion(
      termLocalId: Value(termLocalId),
      definition: Value(definition),
    );
  }

  factory StagingDefinitionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StagingDefinitionTableData(
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

  StagingDefinitionTableData copyWith({int? termLocalId, String? definition}) =>
      StagingDefinitionTableData(
        termLocalId: termLocalId ?? this.termLocalId,
        definition: definition ?? this.definition,
      );
  StagingDefinitionTableData copyWithCompanion(
    StagingDefinitionTableCompanion data,
  ) {
    return StagingDefinitionTableData(
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
    return (StringBuffer('StagingDefinitionTableData(')
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
      (other is StagingDefinitionTableData &&
          other.termLocalId == this.termLocalId &&
          other.definition == this.definition);
}

class StagingDefinitionTableCompanion
    extends UpdateCompanion<StagingDefinitionTableData> {
  final Value<int> termLocalId;
  final Value<String> definition;
  final Value<int> rowid;
  const StagingDefinitionTableCompanion({
    this.termLocalId = const Value.absent(),
    this.definition = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StagingDefinitionTableCompanion.insert({
    required int termLocalId,
    required String definition,
    this.rowid = const Value.absent(),
  }) : termLocalId = Value(termLocalId),
       definition = Value(definition);
  static Insertable<StagingDefinitionTableData> custom({
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

  StagingDefinitionTableCompanion copyWith({
    Value<int>? termLocalId,
    Value<String>? definition,
    Value<int>? rowid,
  }) {
    return StagingDefinitionTableCompanion(
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
    return (StringBuffer('StagingDefinitionTableCompanion(')
          ..write('termLocalId: $termLocalId, ')
          ..write('definition: $definition, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StagingTagTableTable extends StagingTagTable
    with TableInfo<$StagingTagTableTable, StagingTagTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StagingTagTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'staging_tag_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<StagingTagTableData> instance, {
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
  StagingTagTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StagingTagTableData(
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
  $StagingTagTableTable createAlias(String alias) {
    return $StagingTagTableTable(attachedDatabase, alias);
  }
}

class StagingTagTableData extends DataClass
    implements Insertable<StagingTagTableData> {
  final int termLocalId;
  final String tagName;
  final bool isDefinitionTag;
  const StagingTagTableData({
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

  StagingTagTableCompanion toCompanion(bool nullToAbsent) {
    return StagingTagTableCompanion(
      termLocalId: Value(termLocalId),
      tagName: Value(tagName),
      isDefinitionTag: Value(isDefinitionTag),
    );
  }

  factory StagingTagTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StagingTagTableData(
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

  StagingTagTableData copyWith({
    int? termLocalId,
    String? tagName,
    bool? isDefinitionTag,
  }) => StagingTagTableData(
    termLocalId: termLocalId ?? this.termLocalId,
    tagName: tagName ?? this.tagName,
    isDefinitionTag: isDefinitionTag ?? this.isDefinitionTag,
  );
  StagingTagTableData copyWithCompanion(StagingTagTableCompanion data) {
    return StagingTagTableData(
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
    return (StringBuffer('StagingTagTableData(')
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
      (other is StagingTagTableData &&
          other.termLocalId == this.termLocalId &&
          other.tagName == this.tagName &&
          other.isDefinitionTag == this.isDefinitionTag);
}

class StagingTagTableCompanion extends UpdateCompanion<StagingTagTableData> {
  final Value<int> termLocalId;
  final Value<String> tagName;
  final Value<bool> isDefinitionTag;
  final Value<int> rowid;
  const StagingTagTableCompanion({
    this.termLocalId = const Value.absent(),
    this.tagName = const Value.absent(),
    this.isDefinitionTag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StagingTagTableCompanion.insert({
    required int termLocalId,
    required String tagName,
    required bool isDefinitionTag,
    this.rowid = const Value.absent(),
  }) : termLocalId = Value(termLocalId),
       tagName = Value(tagName),
       isDefinitionTag = Value(isDefinitionTag);
  static Insertable<StagingTagTableData> custom({
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

  StagingTagTableCompanion copyWith({
    Value<int>? termLocalId,
    Value<String>? tagName,
    Value<bool>? isDefinitionTag,
    Value<int>? rowid,
  }) {
    return StagingTagTableCompanion(
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
    return (StringBuffer('StagingTagTableCompanion(')
          ..write('termLocalId: $termLocalId, ')
          ..write('tagName: $tagName, ')
          ..write('isDefinitionTag: $isDefinitionTag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StagingRuleTableTable extends StagingRuleTable
    with TableInfo<$StagingRuleTableTable, StagingRuleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StagingRuleTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'staging_rule_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<StagingRuleTableData> instance, {
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
  StagingRuleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StagingRuleTableData(
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
  $StagingRuleTableTable createAlias(String alias) {
    return $StagingRuleTableTable(attachedDatabase, alias);
  }
}

class StagingRuleTableData extends DataClass
    implements Insertable<StagingRuleTableData> {
  final int termLocalId;
  final String ruleId;
  const StagingRuleTableData({required this.termLocalId, required this.ruleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term_local_id'] = Variable<int>(termLocalId);
    map['rule_id'] = Variable<String>(ruleId);
    return map;
  }

  StagingRuleTableCompanion toCompanion(bool nullToAbsent) {
    return StagingRuleTableCompanion(
      termLocalId: Value(termLocalId),
      ruleId: Value(ruleId),
    );
  }

  factory StagingRuleTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StagingRuleTableData(
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

  StagingRuleTableData copyWith({int? termLocalId, String? ruleId}) =>
      StagingRuleTableData(
        termLocalId: termLocalId ?? this.termLocalId,
        ruleId: ruleId ?? this.ruleId,
      );
  StagingRuleTableData copyWithCompanion(StagingRuleTableCompanion data) {
    return StagingRuleTableData(
      termLocalId: data.termLocalId.present
          ? data.termLocalId.value
          : this.termLocalId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StagingRuleTableData(')
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
      (other is StagingRuleTableData &&
          other.termLocalId == this.termLocalId &&
          other.ruleId == this.ruleId);
}

class StagingRuleTableCompanion extends UpdateCompanion<StagingRuleTableData> {
  final Value<int> termLocalId;
  final Value<String> ruleId;
  final Value<int> rowid;
  const StagingRuleTableCompanion({
    this.termLocalId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StagingRuleTableCompanion.insert({
    required int termLocalId,
    required String ruleId,
    this.rowid = const Value.absent(),
  }) : termLocalId = Value(termLocalId),
       ruleId = Value(ruleId);
  static Insertable<StagingRuleTableData> custom({
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

  StagingRuleTableCompanion copyWith({
    Value<int>? termLocalId,
    Value<String>? ruleId,
    Value<int>? rowid,
  }) {
    return StagingRuleTableCompanion(
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
    return (StringBuffer('StagingRuleTableCompanion(')
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
  late final $StagingTermTableTable stagingTermTable = $StagingTermTableTable(
    this,
  );
  late final $StagingDefinitionTableTable stagingDefinitionTable =
      $StagingDefinitionTableTable(this);
  late final $StagingTagTableTable stagingTagTable = $StagingTagTableTable(
    this,
  );
  late final $StagingRuleTableTable stagingRuleTable = $StagingRuleTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stagingTermTable,
    stagingDefinitionTable,
    stagingTagTable,
    stagingRuleTable,
  ];
}

typedef $$StagingTermTableTableCreateCompanionBuilder =
    StagingTermTableCompanion Function({
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
typedef $$StagingTermTableTableUpdateCompanionBuilder =
    StagingTermTableCompanion Function({
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

class $$StagingTermTableTableFilterComposer
    extends Composer<_$StagingDatabase, $StagingTermTableTable> {
  $$StagingTermTableTableFilterComposer({
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

class $$StagingTermTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $StagingTermTableTable> {
  $$StagingTermTableTableOrderingComposer({
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

class $$StagingTermTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $StagingTermTableTable> {
  $$StagingTermTableTableAnnotationComposer({
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

class $$StagingTermTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $StagingTermTableTable,
          StagingTermTableData,
          $$StagingTermTableTableFilterComposer,
          $$StagingTermTableTableOrderingComposer,
          $$StagingTermTableTableAnnotationComposer,
          $$StagingTermTableTableCreateCompanionBuilder,
          $$StagingTermTableTableUpdateCompanionBuilder,
          (
            StagingTermTableData,
            BaseReferences<
              _$StagingDatabase,
              $StagingTermTableTable,
              StagingTermTableData
            >,
          ),
          StagingTermTableData,
          PrefetchHooks Function()
        > {
  $$StagingTermTableTableTableManager(
    _$StagingDatabase db,
    $StagingTermTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StagingTermTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StagingTermTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StagingTermTableTableAnnotationComposer($db: db, $table: table),
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
              }) => StagingTermTableCompanion(
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
              }) => StagingTermTableCompanion.insert(
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

typedef $$StagingTermTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $StagingTermTableTable,
      StagingTermTableData,
      $$StagingTermTableTableFilterComposer,
      $$StagingTermTableTableOrderingComposer,
      $$StagingTermTableTableAnnotationComposer,
      $$StagingTermTableTableCreateCompanionBuilder,
      $$StagingTermTableTableUpdateCompanionBuilder,
      (
        StagingTermTableData,
        BaseReferences<
          _$StagingDatabase,
          $StagingTermTableTable,
          StagingTermTableData
        >,
      ),
      StagingTermTableData,
      PrefetchHooks Function()
    >;
typedef $$StagingDefinitionTableTableCreateCompanionBuilder =
    StagingDefinitionTableCompanion Function({
      required int termLocalId,
      required String definition,
      Value<int> rowid,
    });
typedef $$StagingDefinitionTableTableUpdateCompanionBuilder =
    StagingDefinitionTableCompanion Function({
      Value<int> termLocalId,
      Value<String> definition,
      Value<int> rowid,
    });

class $$StagingDefinitionTableTableFilterComposer
    extends Composer<_$StagingDatabase, $StagingDefinitionTableTable> {
  $$StagingDefinitionTableTableFilterComposer({
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

class $$StagingDefinitionTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $StagingDefinitionTableTable> {
  $$StagingDefinitionTableTableOrderingComposer({
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

class $$StagingDefinitionTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $StagingDefinitionTableTable> {
  $$StagingDefinitionTableTableAnnotationComposer({
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

class $$StagingDefinitionTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $StagingDefinitionTableTable,
          StagingDefinitionTableData,
          $$StagingDefinitionTableTableFilterComposer,
          $$StagingDefinitionTableTableOrderingComposer,
          $$StagingDefinitionTableTableAnnotationComposer,
          $$StagingDefinitionTableTableCreateCompanionBuilder,
          $$StagingDefinitionTableTableUpdateCompanionBuilder,
          (
            StagingDefinitionTableData,
            BaseReferences<
              _$StagingDatabase,
              $StagingDefinitionTableTable,
              StagingDefinitionTableData
            >,
          ),
          StagingDefinitionTableData,
          PrefetchHooks Function()
        > {
  $$StagingDefinitionTableTableTableManager(
    _$StagingDatabase db,
    $StagingDefinitionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StagingDefinitionTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StagingDefinitionTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StagingDefinitionTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> termLocalId = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StagingDefinitionTableCompanion(
                termLocalId: termLocalId,
                definition: definition,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int termLocalId,
                required String definition,
                Value<int> rowid = const Value.absent(),
              }) => StagingDefinitionTableCompanion.insert(
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

typedef $$StagingDefinitionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $StagingDefinitionTableTable,
      StagingDefinitionTableData,
      $$StagingDefinitionTableTableFilterComposer,
      $$StagingDefinitionTableTableOrderingComposer,
      $$StagingDefinitionTableTableAnnotationComposer,
      $$StagingDefinitionTableTableCreateCompanionBuilder,
      $$StagingDefinitionTableTableUpdateCompanionBuilder,
      (
        StagingDefinitionTableData,
        BaseReferences<
          _$StagingDatabase,
          $StagingDefinitionTableTable,
          StagingDefinitionTableData
        >,
      ),
      StagingDefinitionTableData,
      PrefetchHooks Function()
    >;
typedef $$StagingTagTableTableCreateCompanionBuilder =
    StagingTagTableCompanion Function({
      required int termLocalId,
      required String tagName,
      required bool isDefinitionTag,
      Value<int> rowid,
    });
typedef $$StagingTagTableTableUpdateCompanionBuilder =
    StagingTagTableCompanion Function({
      Value<int> termLocalId,
      Value<String> tagName,
      Value<bool> isDefinitionTag,
      Value<int> rowid,
    });

class $$StagingTagTableTableFilterComposer
    extends Composer<_$StagingDatabase, $StagingTagTableTable> {
  $$StagingTagTableTableFilterComposer({
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

class $$StagingTagTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $StagingTagTableTable> {
  $$StagingTagTableTableOrderingComposer({
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

class $$StagingTagTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $StagingTagTableTable> {
  $$StagingTagTableTableAnnotationComposer({
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

class $$StagingTagTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $StagingTagTableTable,
          StagingTagTableData,
          $$StagingTagTableTableFilterComposer,
          $$StagingTagTableTableOrderingComposer,
          $$StagingTagTableTableAnnotationComposer,
          $$StagingTagTableTableCreateCompanionBuilder,
          $$StagingTagTableTableUpdateCompanionBuilder,
          (
            StagingTagTableData,
            BaseReferences<
              _$StagingDatabase,
              $StagingTagTableTable,
              StagingTagTableData
            >,
          ),
          StagingTagTableData,
          PrefetchHooks Function()
        > {
  $$StagingTagTableTableTableManager(
    _$StagingDatabase db,
    $StagingTagTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StagingTagTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StagingTagTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StagingTagTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> termLocalId = const Value.absent(),
                Value<String> tagName = const Value.absent(),
                Value<bool> isDefinitionTag = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StagingTagTableCompanion(
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
              }) => StagingTagTableCompanion.insert(
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

typedef $$StagingTagTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $StagingTagTableTable,
      StagingTagTableData,
      $$StagingTagTableTableFilterComposer,
      $$StagingTagTableTableOrderingComposer,
      $$StagingTagTableTableAnnotationComposer,
      $$StagingTagTableTableCreateCompanionBuilder,
      $$StagingTagTableTableUpdateCompanionBuilder,
      (
        StagingTagTableData,
        BaseReferences<
          _$StagingDatabase,
          $StagingTagTableTable,
          StagingTagTableData
        >,
      ),
      StagingTagTableData,
      PrefetchHooks Function()
    >;
typedef $$StagingRuleTableTableCreateCompanionBuilder =
    StagingRuleTableCompanion Function({
      required int termLocalId,
      required String ruleId,
      Value<int> rowid,
    });
typedef $$StagingRuleTableTableUpdateCompanionBuilder =
    StagingRuleTableCompanion Function({
      Value<int> termLocalId,
      Value<String> ruleId,
      Value<int> rowid,
    });

class $$StagingRuleTableTableFilterComposer
    extends Composer<_$StagingDatabase, $StagingRuleTableTable> {
  $$StagingRuleTableTableFilterComposer({
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

class $$StagingRuleTableTableOrderingComposer
    extends Composer<_$StagingDatabase, $StagingRuleTableTable> {
  $$StagingRuleTableTableOrderingComposer({
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

class $$StagingRuleTableTableAnnotationComposer
    extends Composer<_$StagingDatabase, $StagingRuleTableTable> {
  $$StagingRuleTableTableAnnotationComposer({
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

class $$StagingRuleTableTableTableManager
    extends
        RootTableManager<
          _$StagingDatabase,
          $StagingRuleTableTable,
          StagingRuleTableData,
          $$StagingRuleTableTableFilterComposer,
          $$StagingRuleTableTableOrderingComposer,
          $$StagingRuleTableTableAnnotationComposer,
          $$StagingRuleTableTableCreateCompanionBuilder,
          $$StagingRuleTableTableUpdateCompanionBuilder,
          (
            StagingRuleTableData,
            BaseReferences<
              _$StagingDatabase,
              $StagingRuleTableTable,
              StagingRuleTableData
            >,
          ),
          StagingRuleTableData,
          PrefetchHooks Function()
        > {
  $$StagingRuleTableTableTableManager(
    _$StagingDatabase db,
    $StagingRuleTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StagingRuleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StagingRuleTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StagingRuleTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> termLocalId = const Value.absent(),
                Value<String> ruleId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StagingRuleTableCompanion(
                termLocalId: termLocalId,
                ruleId: ruleId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int termLocalId,
                required String ruleId,
                Value<int> rowid = const Value.absent(),
              }) => StagingRuleTableCompanion.insert(
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

typedef $$StagingRuleTableTableProcessedTableManager =
    ProcessedTableManager<
      _$StagingDatabase,
      $StagingRuleTableTable,
      StagingRuleTableData,
      $$StagingRuleTableTableFilterComposer,
      $$StagingRuleTableTableOrderingComposer,
      $$StagingRuleTableTableAnnotationComposer,
      $$StagingRuleTableTableCreateCompanionBuilder,
      $$StagingRuleTableTableUpdateCompanionBuilder,
      (
        StagingRuleTableData,
        BaseReferences<
          _$StagingDatabase,
          $StagingRuleTableTable,
          StagingRuleTableData
        >,
      ),
      StagingRuleTableData,
      PrefetchHooks Function()
    >;

class $StagingDatabaseManager {
  final _$StagingDatabase _db;
  $StagingDatabaseManager(this._db);
  $$StagingTermTableTableTableManager get stagingTermTable =>
      $$StagingTermTableTableTableManager(_db, _db.stagingTermTable);
  $$StagingDefinitionTableTableTableManager get stagingDefinitionTable =>
      $$StagingDefinitionTableTableTableManager(
        _db,
        _db.stagingDefinitionTable,
      );
  $$StagingTagTableTableTableManager get stagingTagTable =>
      $$StagingTagTableTableTableManager(_db, _db.stagingTagTable);
  $$StagingRuleTableTableTableManager get stagingRuleTable =>
      $$StagingRuleTableTableTableManager(_db, _db.stagingRuleTable);
}
