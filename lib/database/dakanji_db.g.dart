// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dakanji_db.dart';

// ignore_for_file: type=lint
class $KanjiTableTable extends KanjiTable
    with TableInfo<$KanjiTableTable, KanjiTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji =
      GeneratedColumn<String>('kanji', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, kanji];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_table';
  @override
  VerificationContext validateIntegrity(Insertable<KanjiTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji')) {
      context.handle(
          _kanjiMeta, kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta));
    } else if (isInserting) {
      context.missing(_kanjiMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kanji'])!,
    );
  }

  @override
  $KanjiTableTable createAlias(String alias) {
    return $KanjiTableTable(attachedDatabase, alias);
  }
}

class KanjiTableData extends DataClass implements Insertable<KanjiTableData> {
  /// id of this entry
  final int id;

  /// the kanji character of this entry
  final String kanji;
  const KanjiTableData({required this.id, required this.kanji});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji'] = Variable<String>(kanji);
    return map;
  }

  KanjiTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiTableCompanion(
      id: Value(id),
      kanji: Value(kanji),
    );
  }

  factory KanjiTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiTableData(
      id: serializer.fromJson<int>(json['id']),
      kanji: serializer.fromJson<String>(json['kanji']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanji': serializer.toJson<String>(kanji),
    };
  }

  KanjiTableData copyWith({int? id, String? kanji}) => KanjiTableData(
        id: id ?? this.id,
        kanji: kanji ?? this.kanji,
      );
  KanjiTableData copyWithCompanion(KanjiTableCompanion data) {
    return KanjiTableData(
      id: data.id.present ? data.id.value : this.id,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiTableData(')
          ..write('id: $id, ')
          ..write('kanji: $kanji')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanji);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiTableData &&
          other.id == this.id &&
          other.kanji == this.kanji);
}

class KanjiTableCompanion extends UpdateCompanion<KanjiTableData> {
  final Value<int> id;
  final Value<String> kanji;
  const KanjiTableCompanion({
    this.id = const Value.absent(),
    this.kanji = const Value.absent(),
  });
  KanjiTableCompanion.insert({
    this.id = const Value.absent(),
    required String kanji,
  }) : kanji = Value(kanji);
  static Insertable<KanjiTableData> custom({
    Expression<int>? id,
    Expression<String>? kanji,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanji != null) 'kanji': kanji,
    });
  }

  KanjiTableCompanion copyWith({Value<int>? id, Value<String>? kanji}) {
    return KanjiTableCompanion(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiTableCompanion(')
          ..write('id: $id, ')
          ..write('kanji: $kanji')
          ..write(')'))
        .toString();
  }
}

class $TermTableTable extends TermTable
    with TableInfo<$TermTableTable, TermTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, term];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_table';
  @override
  VerificationContext validateIntegrity(Insertable<TermTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      term: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term'])!,
    );
  }

  @override
  $TermTableTable createAlias(String alias) {
    return $TermTableTable(attachedDatabase, alias);
  }
}

class TermTableData extends DataClass implements Insertable<TermTableData> {
  /// id of this entry
  final int id;

  /// the term of this entry
  final String term;
  const TermTableData({required this.id, required this.term});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['term'] = Variable<String>(term);
    return map;
  }

  TermTableCompanion toCompanion(bool nullToAbsent) {
    return TermTableCompanion(
      id: Value(id),
      term: Value(term),
    );
  }

  factory TermTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermTableData(
      id: serializer.fromJson<int>(json['id']),
      term: serializer.fromJson<String>(json['term']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'term': serializer.toJson<String>(term),
    };
  }

  TermTableData copyWith({int? id, String? term}) => TermTableData(
        id: id ?? this.id,
        term: term ?? this.term,
      );
  TermTableData copyWithCompanion(TermTableCompanion data) {
    return TermTableData(
      id: data.id.present ? data.id.value : this.id,
      term: data.term.present ? data.term.value : this.term,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermTableData(')
          ..write('id: $id, ')
          ..write('term: $term')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, term);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermTableData &&
          other.id == this.id &&
          other.term == this.term);
}

class TermTableCompanion extends UpdateCompanion<TermTableData> {
  final Value<int> id;
  final Value<String> term;
  const TermTableCompanion({
    this.id = const Value.absent(),
    this.term = const Value.absent(),
  });
  TermTableCompanion.insert({
    this.id = const Value.absent(),
    required String term,
  }) : term = Value(term);
  static Insertable<TermTableData> custom({
    Expression<int>? id,
    Expression<String>? term,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (term != null) 'term': term,
    });
  }

  TermTableCompanion copyWith({Value<int>? id, Value<String>? term}) {
    return TermTableCompanion(
      id: id ?? this.id,
      term: term ?? this.term,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermTableCompanion(')
          ..write('id: $id, ')
          ..write('term: $term')
          ..write(')'))
        .toString();
  }
}

class $ReadingTableTable extends ReadingTable
    with TableInfo<$ReadingTableTable, ReadingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _readingMeta =
      const VerificationMeta('reading');
  @override
  late final GeneratedColumn<String> reading = GeneratedColumn<String>(
      'reading', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, reading];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_table';
  @override
  VerificationContext validateIntegrity(Insertable<ReadingTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reading')) {
      context.handle(_readingMeta,
          reading.isAcceptableOrUnknown(data['reading']!, _readingMeta));
    } else if (isInserting) {
      context.missing(_readingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reading: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading'])!,
    );
  }

  @override
  $ReadingTableTable createAlias(String alias) {
    return $ReadingTableTable(attachedDatabase, alias);
  }
}

class ReadingTableData extends DataClass
    implements Insertable<ReadingTableData> {
  /// id of this entry
  final int id;

  /// the reading of this entry
  final String reading;
  const ReadingTableData({required this.id, required this.reading});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reading'] = Variable<String>(reading);
    return map;
  }

  ReadingTableCompanion toCompanion(bool nullToAbsent) {
    return ReadingTableCompanion(
      id: Value(id),
      reading: Value(reading),
    );
  }

  factory ReadingTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingTableData(
      id: serializer.fromJson<int>(json['id']),
      reading: serializer.fromJson<String>(json['reading']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reading': serializer.toJson<String>(reading),
    };
  }

  ReadingTableData copyWith({int? id, String? reading}) => ReadingTableData(
        id: id ?? this.id,
        reading: reading ?? this.reading,
      );
  ReadingTableData copyWithCompanion(ReadingTableCompanion data) {
    return ReadingTableData(
      id: data.id.present ? data.id.value : this.id,
      reading: data.reading.present ? data.reading.value : this.reading,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingTableData(')
          ..write('id: $id, ')
          ..write('reading: $reading')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reading);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingTableData &&
          other.id == this.id &&
          other.reading == this.reading);
}

class ReadingTableCompanion extends UpdateCompanion<ReadingTableData> {
  final Value<int> id;
  final Value<String> reading;
  const ReadingTableCompanion({
    this.id = const Value.absent(),
    this.reading = const Value.absent(),
  });
  ReadingTableCompanion.insert({
    this.id = const Value.absent(),
    required String reading,
  }) : reading = Value(reading);
  static Insertable<ReadingTableData> custom({
    Expression<int>? id,
    Expression<String>? reading,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reading != null) 'reading': reading,
    });
  }

  ReadingTableCompanion copyWith({Value<int>? id, Value<String>? reading}) {
    return ReadingTableCompanion(
      id: id ?? this.id,
      reading: reading ?? this.reading,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingTableCompanion(')
          ..write('id: $id, ')
          ..write('reading: $reading')
          ..write(')'))
        .toString();
  }
}

class $RadicalsKanjiTableTable extends RadicalsKanjiTable
    with TableInfo<$RadicalsKanjiTableTable, RadicalsKanjiTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RadicalsKanjiTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES kanji_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'radicals_kanji_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<RadicalsKanjiTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RadicalsKanjiTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RadicalsKanjiTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $RadicalsKanjiTableTable createAlias(String alias) {
    return $RadicalsKanjiTableTable(attachedDatabase, alias);
  }
}

class RadicalsKanjiTableData extends DataClass
    implements Insertable<RadicalsKanjiTableData> {
  /// id of this entry
  final int id;

  /// ID of the kanji character this radical belongs to
  final int kanjiId;
  const RadicalsKanjiTableData({required this.id, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  RadicalsKanjiTableCompanion toCompanion(bool nullToAbsent) {
    return RadicalsKanjiTableCompanion(
      id: Value(id),
      kanjiId: Value(kanjiId),
    );
  }

  factory RadicalsKanjiTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RadicalsKanjiTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  RadicalsKanjiTableData copyWith({int? id, int? kanjiId}) =>
      RadicalsKanjiTableData(
        id: id ?? this.id,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  RadicalsKanjiTableData copyWithCompanion(RadicalsKanjiTableCompanion data) {
    return RadicalsKanjiTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RadicalsKanjiTableData(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RadicalsKanjiTableData &&
          other.id == this.id &&
          other.kanjiId == this.kanjiId);
}

class RadicalsKanjiTableCompanion
    extends UpdateCompanion<RadicalsKanjiTableData> {
  final Value<int> id;
  final Value<int> kanjiId;
  const RadicalsKanjiTableCompanion({
    this.id = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  RadicalsKanjiTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiId,
  }) : kanjiId = Value(kanjiId);
  static Insertable<RadicalsKanjiTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  RadicalsKanjiTableCompanion copyWith({Value<int>? id, Value<int>? kanjiId}) {
    return RadicalsKanjiTableCompanion(
      id: id ?? this.id,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RadicalsKanjiTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

class $RadicalsTableTable extends RadicalsTable
    with TableInfo<$RadicalsTableTable, RadicalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RadicalsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _radicalMeta =
      const VerificationMeta('radical');
  @override
  late final GeneratedColumn<String> radical =
      GeneratedColumn<String>('radical', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _strokeCountMeta =
      const VerificationMeta('strokeCount');
  @override
  late final GeneratedColumn<int> strokeCount = GeneratedColumn<int>(
      'stroke_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, radical, strokeCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'radicals_table';
  @override
  VerificationContext validateIntegrity(Insertable<RadicalsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('radical')) {
      context.handle(_radicalMeta,
          radical.isAcceptableOrUnknown(data['radical']!, _radicalMeta));
    } else if (isInserting) {
      context.missing(_radicalMeta);
    }
    if (data.containsKey('stroke_count')) {
      context.handle(
          _strokeCountMeta,
          strokeCount.isAcceptableOrUnknown(
              data['stroke_count']!, _strokeCountMeta));
    } else if (isInserting) {
      context.missing(_strokeCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RadicalsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RadicalsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      radical: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}radical'])!,
      strokeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stroke_count'])!,
    );
  }

  @override
  $RadicalsTableTable createAlias(String alias) {
    return $RadicalsTableTable(attachedDatabase, alias);
  }
}

class RadicalsTableData extends DataClass
    implements Insertable<RadicalsTableData> {
  /// id of this entry
  final int id;

  /// the radical character of this entry
  /// this column is indexed
  final String radical;

  /// Stroke count of this radical
  final int strokeCount;
  const RadicalsTableData(
      {required this.id, required this.radical, required this.strokeCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['radical'] = Variable<String>(radical);
    map['stroke_count'] = Variable<int>(strokeCount);
    return map;
  }

  RadicalsTableCompanion toCompanion(bool nullToAbsent) {
    return RadicalsTableCompanion(
      id: Value(id),
      radical: Value(radical),
      strokeCount: Value(strokeCount),
    );
  }

  factory RadicalsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RadicalsTableData(
      id: serializer.fromJson<int>(json['id']),
      radical: serializer.fromJson<String>(json['radical']),
      strokeCount: serializer.fromJson<int>(json['strokeCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'radical': serializer.toJson<String>(radical),
      'strokeCount': serializer.toJson<int>(strokeCount),
    };
  }

  RadicalsTableData copyWith({int? id, String? radical, int? strokeCount}) =>
      RadicalsTableData(
        id: id ?? this.id,
        radical: radical ?? this.radical,
        strokeCount: strokeCount ?? this.strokeCount,
      );
  RadicalsTableData copyWithCompanion(RadicalsTableCompanion data) {
    return RadicalsTableData(
      id: data.id.present ? data.id.value : this.id,
      radical: data.radical.present ? data.radical.value : this.radical,
      strokeCount:
          data.strokeCount.present ? data.strokeCount.value : this.strokeCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RadicalsTableData(')
          ..write('id: $id, ')
          ..write('radical: $radical, ')
          ..write('strokeCount: $strokeCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, radical, strokeCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RadicalsTableData &&
          other.id == this.id &&
          other.radical == this.radical &&
          other.strokeCount == this.strokeCount);
}

class RadicalsTableCompanion extends UpdateCompanion<RadicalsTableData> {
  final Value<int> id;
  final Value<String> radical;
  final Value<int> strokeCount;
  const RadicalsTableCompanion({
    this.id = const Value.absent(),
    this.radical = const Value.absent(),
    this.strokeCount = const Value.absent(),
  });
  RadicalsTableCompanion.insert({
    this.id = const Value.absent(),
    required String radical,
    required int strokeCount,
  })  : radical = Value(radical),
        strokeCount = Value(strokeCount);
  static Insertable<RadicalsTableData> custom({
    Expression<int>? id,
    Expression<String>? radical,
    Expression<int>? strokeCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (radical != null) 'radical': radical,
      if (strokeCount != null) 'stroke_count': strokeCount,
    });
  }

  RadicalsTableCompanion copyWith(
      {Value<int>? id, Value<String>? radical, Value<int>? strokeCount}) {
    return RadicalsTableCompanion(
      id: id ?? this.id,
      radical: radical ?? this.radical,
      strokeCount: strokeCount ?? this.strokeCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (radical.present) {
      map['radical'] = Variable<String>(radical.value);
    }
    if (strokeCount.present) {
      map['stroke_count'] = Variable<int>(strokeCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RadicalsTableCompanion(')
          ..write('id: $id, ')
          ..write('radical: $radical, ')
          ..write('strokeCount: $strokeCount')
          ..write(')'))
        .toString();
  }
}

class $RadicalKanjiRelationsTableTable extends RadicalKanjiRelationsTable
    with
        TableInfo<$RadicalKanjiRelationsTableTable,
            RadicalKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RadicalKanjiRelationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES radicals_kanji_table (id)'));
  static const VerificationMeta _radicalIdMeta =
      const VerificationMeta('radicalId');
  @override
  late final GeneratedColumn<int> radicalId = GeneratedColumn<int>(
      'radical_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES radicals_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, kanjiId, radicalId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'radical_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<RadicalKanjiRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    if (data.containsKey('radical_id')) {
      context.handle(_radicalIdMeta,
          radicalId.isAcceptableOrUnknown(data['radical_id']!, _radicalIdMeta));
    } else if (isInserting) {
      context.missing(_radicalIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RadicalKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RadicalKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
      radicalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}radical_id'])!,
    );
  }

  @override
  $RadicalKanjiRelationsTableTable createAlias(String alias) {
    return $RadicalKanjiRelationsTableTable(attachedDatabase, alias);
  }
}

class RadicalKanjiRelationsTableData extends DataClass
    implements Insertable<RadicalKanjiRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated kanji reading
  final int kanjiId;

  /// the id of the associated radical
  final int radicalId;
  const RadicalKanjiRelationsTableData(
      {required this.id, required this.kanjiId, required this.radicalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_id'] = Variable<int>(kanjiId);
    map['radical_id'] = Variable<int>(radicalId);
    return map;
  }

  RadicalKanjiRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return RadicalKanjiRelationsTableCompanion(
      id: Value(id),
      kanjiId: Value(kanjiId),
      radicalId: Value(radicalId),
    );
  }

  factory RadicalKanjiRelationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RadicalKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
      radicalId: serializer.fromJson<int>(json['radicalId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiId': serializer.toJson<int>(kanjiId),
      'radicalId': serializer.toJson<int>(radicalId),
    };
  }

  RadicalKanjiRelationsTableData copyWith(
          {int? id, int? kanjiId, int? radicalId}) =>
      RadicalKanjiRelationsTableData(
        id: id ?? this.id,
        kanjiId: kanjiId ?? this.kanjiId,
        radicalId: radicalId ?? this.radicalId,
      );
  RadicalKanjiRelationsTableData copyWithCompanion(
      RadicalKanjiRelationsTableCompanion data) {
    return RadicalKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
      radicalId: data.radicalId.present ? data.radicalId.value : this.radicalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RadicalKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('radicalId: $radicalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiId, radicalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RadicalKanjiRelationsTableData &&
          other.id == this.id &&
          other.kanjiId == this.kanjiId &&
          other.radicalId == this.radicalId);
}

class RadicalKanjiRelationsTableCompanion
    extends UpdateCompanion<RadicalKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> kanjiId;
  final Value<int> radicalId;
  const RadicalKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.kanjiId = const Value.absent(),
    this.radicalId = const Value.absent(),
  });
  RadicalKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiId,
    required int radicalId,
  })  : kanjiId = Value(kanjiId),
        radicalId = Value(radicalId);
  static Insertable<RadicalKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiId,
    Expression<int>? radicalId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiId != null) 'kanji_id': kanjiId,
      if (radicalId != null) 'radical_id': radicalId,
    });
  }

  RadicalKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiId, Value<int>? radicalId}) {
    return RadicalKanjiRelationsTableCompanion(
      id: id ?? this.id,
      kanjiId: kanjiId ?? this.kanjiId,
      radicalId: radicalId ?? this.radicalId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    if (radicalId.present) {
      map['radical_id'] = Variable<int>(radicalId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RadicalKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('radicalId: $radicalId')
          ..write(')'))
        .toString();
  }
}

class $KanjiVGTableTable extends KanjiVGTable
    with TableInfo<$KanjiVGTableTable, KanjiVGTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiVGTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES kanji_table (id)'));
  static const VerificationMeta _kanjiVGSVGMeta =
      const VerificationMeta('kanjiVGSVG');
  @override
  late final GeneratedColumnWithTypeConverter<String, Uint8List> kanjiVGSVG =
      GeneratedColumn<Uint8List>('kanji_v_g_s_v_g', aliasedName, false,
              type: DriftSqlType.blob, requiredDuringInsert: true)
          .withConverter<String>($KanjiVGTableTable.$converterkanjiVGSVG);
  @override
  List<GeneratedColumn> get $columns => [id, kanjiId, kanjiVGSVG];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_v_g_table';
  @override
  VerificationContext validateIntegrity(Insertable<KanjiVGTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    context.handle(_kanjiVGSVGMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiVGTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiVGTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
      kanjiVGSVG: $KanjiVGTableTable.$converterkanjiVGSVG.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.blob, data['${effectivePrefix}kanji_v_g_s_v_g'])!),
    );
  }

  @override
  $KanjiVGTableTable createAlias(String alias) {
    return $KanjiVGTableTable(attachedDatabase, alias);
  }

  static TypeConverter<String, Uint8List> $converterkanjiVGSVG =
      const ZlibStringConverter();
}

class KanjiVGTableData extends DataClass
    implements Insertable<KanjiVGTableData> {
  /// id of this entry
  final int id;

  /// The id of the kanji character in the `KanjiTable`
  final int kanjiId;

  /// The svg data of this kanji
  final String kanjiVGSVG;
  const KanjiVGTableData(
      {required this.id, required this.kanjiId, required this.kanjiVGSVG});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_id'] = Variable<int>(kanjiId);
    {
      map['kanji_v_g_s_v_g'] = Variable<Uint8List>(
          $KanjiVGTableTable.$converterkanjiVGSVG.toSql(kanjiVGSVG));
    }
    return map;
  }

  KanjiVGTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiVGTableCompanion(
      id: Value(id),
      kanjiId: Value(kanjiId),
      kanjiVGSVG: Value(kanjiVGSVG),
    );
  }

  factory KanjiVGTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiVGTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
      kanjiVGSVG: serializer.fromJson<String>(json['kanjiVGSVG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiId': serializer.toJson<int>(kanjiId),
      'kanjiVGSVG': serializer.toJson<String>(kanjiVGSVG),
    };
  }

  KanjiVGTableData copyWith({int? id, int? kanjiId, String? kanjiVGSVG}) =>
      KanjiVGTableData(
        id: id ?? this.id,
        kanjiId: kanjiId ?? this.kanjiId,
        kanjiVGSVG: kanjiVGSVG ?? this.kanjiVGSVG,
      );
  KanjiVGTableData copyWithCompanion(KanjiVGTableCompanion data) {
    return KanjiVGTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
      kanjiVGSVG:
          data.kanjiVGSVG.present ? data.kanjiVGSVG.value : this.kanjiVGSVG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiVGTableData(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('kanjiVGSVG: $kanjiVGSVG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiId, kanjiVGSVG);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiVGTableData &&
          other.id == this.id &&
          other.kanjiId == this.kanjiId &&
          other.kanjiVGSVG == this.kanjiVGSVG);
}

class KanjiVGTableCompanion extends UpdateCompanion<KanjiVGTableData> {
  final Value<int> id;
  final Value<int> kanjiId;
  final Value<String> kanjiVGSVG;
  const KanjiVGTableCompanion({
    this.id = const Value.absent(),
    this.kanjiId = const Value.absent(),
    this.kanjiVGSVG = const Value.absent(),
  });
  KanjiVGTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiId,
    required String kanjiVGSVG,
  })  : kanjiId = Value(kanjiId),
        kanjiVGSVG = Value(kanjiVGSVG);
  static Insertable<KanjiVGTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiId,
    Expression<Uint8List>? kanjiVGSVG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiId != null) 'kanji_id': kanjiId,
      if (kanjiVGSVG != null) 'kanji_v_g_s_v_g': kanjiVGSVG,
    });
  }

  KanjiVGTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiId, Value<String>? kanjiVGSVG}) {
    return KanjiVGTableCompanion(
      id: id ?? this.id,
      kanjiId: kanjiId ?? this.kanjiId,
      kanjiVGSVG: kanjiVGSVG ?? this.kanjiVGSVG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    if (kanjiVGSVG.present) {
      map['kanji_v_g_s_v_g'] = Variable<Uint8List>(
          $KanjiVGTableTable.$converterkanjiVGSVG.toSql(kanjiVGSVG.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiVGTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('kanjiVGSVG: $kanjiVGSVG')
          ..write(')'))
        .toString();
  }
}

class $IndexTableTable extends IndexTable
    with TableInfo<$IndexTableTable, IndexTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IndexTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _revisionMeta =
      const VerificationMeta('revision');
  @override
  late final GeneratedColumn<String> revision = GeneratedColumn<String>(
      'revision', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequencedMeta =
      const VerificationMeta('sequenced');
  @override
  late final GeneratedColumn<bool> sequenced = GeneratedColumn<bool>(
      'sequenced', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("sequenced" IN (0, 1))'));
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<int> format = GeneratedColumn<int>(
      'format', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatableMeta =
      const VerificationMeta('updatable');
  @override
  late final GeneratedColumn<bool> updatable = GeneratedColumn<bool>(
      'updatable', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("updatable" IN (0, 1))'));
  static const VerificationMeta _indexUrlMeta =
      const VerificationMeta('indexUrl');
  @override
  late final GeneratedColumn<String> indexUrl = GeneratedColumn<String>(
      'index_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _downloadUrlMeta =
      const VerificationMeta('downloadUrl');
  @override
  late final GeneratedColumn<String> downloadUrl = GeneratedColumn<String>(
      'download_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _attributionMeta =
      const VerificationMeta('attribution');
  @override
  late final GeneratedColumn<String> attribution = GeneratedColumn<String>(
      'attribution', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceLanguageMeta =
      const VerificationMeta('sourceLanguage');
  @override
  late final GeneratedColumn<String> sourceLanguage = GeneratedColumn<String>(
      'source_language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetLanguageMeta =
      const VerificationMeta('targetLanguage');
  @override
  late final GeneratedColumn<String> targetLanguage = GeneratedColumn<String>(
      'target_language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _frequencyModeMeta =
      const VerificationMeta('frequencyMode');
  @override
  late final GeneratedColumn<String> frequencyMode = GeneratedColumn<String>(
      'frequency_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        revision,
        sequenced,
        format,
        version,
        author,
        updatable,
        indexUrl,
        downloadUrl,
        url,
        description,
        attribution,
        sourceLanguage,
        targetLanguage,
        frequencyMode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'index_table';
  @override
  VerificationContext validateIntegrity(Insertable<IndexTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(_revisionMeta,
          revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta));
    } else if (isInserting) {
      context.missing(_revisionMeta);
    }
    if (data.containsKey('sequenced')) {
      context.handle(_sequencedMeta,
          sequenced.isAcceptableOrUnknown(data['sequenced']!, _sequencedMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('updatable')) {
      context.handle(_updatableMeta,
          updatable.isAcceptableOrUnknown(data['updatable']!, _updatableMeta));
    }
    if (data.containsKey('index_url')) {
      context.handle(_indexUrlMeta,
          indexUrl.isAcceptableOrUnknown(data['index_url']!, _indexUrlMeta));
    }
    if (data.containsKey('download_url')) {
      context.handle(
          _downloadUrlMeta,
          downloadUrl.isAcceptableOrUnknown(
              data['download_url']!, _downloadUrlMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('attribution')) {
      context.handle(
          _attributionMeta,
          attribution.isAcceptableOrUnknown(
              data['attribution']!, _attributionMeta));
    }
    if (data.containsKey('source_language')) {
      context.handle(
          _sourceLanguageMeta,
          sourceLanguage.isAcceptableOrUnknown(
              data['source_language']!, _sourceLanguageMeta));
    }
    if (data.containsKey('target_language')) {
      context.handle(
          _targetLanguageMeta,
          targetLanguage.isAcceptableOrUnknown(
              data['target_language']!, _targetLanguageMeta));
    }
    if (data.containsKey('frequency_mode')) {
      context.handle(
          _frequencyModeMeta,
          frequencyMode.isAcceptableOrUnknown(
              data['frequency_mode']!, _frequencyModeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IndexTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IndexTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      revision: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}revision'])!,
      sequenced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sequenced']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}format']),
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version']),
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      updatable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}updatable']),
      indexUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}index_url']),
      downloadUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}download_url']),
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      attribution: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attribution']),
      sourceLanguage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_language']),
      targetLanguage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_language']),
      frequencyMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency_mode']),
    );
  }

  @override
  $IndexTableTable createAlias(String alias) {
    return $IndexTableTable(attachedDatabase, alias);
  }
}

class IndexTableData extends DataClass implements Insertable<IndexTableData> {
  /// id of this entry
  final int id;

  /// Title of the dictionary.
  final String title;

  /// Revision of the dictionary. This value is displayed, and used to check for dictionary updates.
  final String revision;

  /// Whether or not this dictionary contains sequencing information for related terms.
  final bool? sequenced;

  /// Format of data found in the JSON data files.
  final int? format;

  /// Alias for format.
  final int? version;

  /// Creator of the dictionary.
  final String? author;

  /// Whether this dictionary contains links to its latest version.
  final bool? updatable;

  /// URL for the index file of the latest revision of the dictionary, used to check for updates.
  final String? indexUrl;

  /// URL for the download of the latest revision of the dictionary.
  final String? downloadUrl;

  /// URL for the source of the dictionary, displayed in the dictionary details.
  final String? url;

  /// Description of the dictionary data.
  final String? description;

  /// Attribution information for the dictionary data.
  final String? attribution;

  /// Language of the terms in the dictionary.
  final String? sourceLanguage;

  /// Main language of the definitions in the dictionary.
  final String? targetLanguage;

  /// The mode of the frequency in this dictionary, one of
  /// "occurrence-based", "rank-based"
  final String? frequencyMode;
  const IndexTableData(
      {required this.id,
      required this.title,
      required this.revision,
      this.sequenced,
      this.format,
      this.version,
      this.author,
      this.updatable,
      this.indexUrl,
      this.downloadUrl,
      this.url,
      this.description,
      this.attribution,
      this.sourceLanguage,
      this.targetLanguage,
      this.frequencyMode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['revision'] = Variable<String>(revision);
    if (!nullToAbsent || sequenced != null) {
      map['sequenced'] = Variable<bool>(sequenced);
    }
    if (!nullToAbsent || format != null) {
      map['format'] = Variable<int>(format);
    }
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<int>(version);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || updatable != null) {
      map['updatable'] = Variable<bool>(updatable);
    }
    if (!nullToAbsent || indexUrl != null) {
      map['index_url'] = Variable<String>(indexUrl);
    }
    if (!nullToAbsent || downloadUrl != null) {
      map['download_url'] = Variable<String>(downloadUrl);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || attribution != null) {
      map['attribution'] = Variable<String>(attribution);
    }
    if (!nullToAbsent || sourceLanguage != null) {
      map['source_language'] = Variable<String>(sourceLanguage);
    }
    if (!nullToAbsent || targetLanguage != null) {
      map['target_language'] = Variable<String>(targetLanguage);
    }
    if (!nullToAbsent || frequencyMode != null) {
      map['frequency_mode'] = Variable<String>(frequencyMode);
    }
    return map;
  }

  IndexTableCompanion toCompanion(bool nullToAbsent) {
    return IndexTableCompanion(
      id: Value(id),
      title: Value(title),
      revision: Value(revision),
      sequenced: sequenced == null && nullToAbsent
          ? const Value.absent()
          : Value(sequenced),
      format:
          format == null && nullToAbsent ? const Value.absent() : Value(format),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      updatable: updatable == null && nullToAbsent
          ? const Value.absent()
          : Value(updatable),
      indexUrl: indexUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(indexUrl),
      downloadUrl: downloadUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadUrl),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      attribution: attribution == null && nullToAbsent
          ? const Value.absent()
          : Value(attribution),
      sourceLanguage: sourceLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceLanguage),
      targetLanguage: targetLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(targetLanguage),
      frequencyMode: frequencyMode == null && nullToAbsent
          ? const Value.absent()
          : Value(frequencyMode),
    );
  }

  factory IndexTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IndexTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      revision: serializer.fromJson<String>(json['revision']),
      sequenced: serializer.fromJson<bool?>(json['sequenced']),
      format: serializer.fromJson<int?>(json['format']),
      version: serializer.fromJson<int?>(json['version']),
      author: serializer.fromJson<String?>(json['author']),
      updatable: serializer.fromJson<bool?>(json['updatable']),
      indexUrl: serializer.fromJson<String?>(json['indexUrl']),
      downloadUrl: serializer.fromJson<String?>(json['downloadUrl']),
      url: serializer.fromJson<String?>(json['url']),
      description: serializer.fromJson<String?>(json['description']),
      attribution: serializer.fromJson<String?>(json['attribution']),
      sourceLanguage: serializer.fromJson<String?>(json['sourceLanguage']),
      targetLanguage: serializer.fromJson<String?>(json['targetLanguage']),
      frequencyMode: serializer.fromJson<String?>(json['frequencyMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'revision': serializer.toJson<String>(revision),
      'sequenced': serializer.toJson<bool?>(sequenced),
      'format': serializer.toJson<int?>(format),
      'version': serializer.toJson<int?>(version),
      'author': serializer.toJson<String?>(author),
      'updatable': serializer.toJson<bool?>(updatable),
      'indexUrl': serializer.toJson<String?>(indexUrl),
      'downloadUrl': serializer.toJson<String?>(downloadUrl),
      'url': serializer.toJson<String?>(url),
      'description': serializer.toJson<String?>(description),
      'attribution': serializer.toJson<String?>(attribution),
      'sourceLanguage': serializer.toJson<String?>(sourceLanguage),
      'targetLanguage': serializer.toJson<String?>(targetLanguage),
      'frequencyMode': serializer.toJson<String?>(frequencyMode),
    };
  }

  IndexTableData copyWith(
          {int? id,
          String? title,
          String? revision,
          Value<bool?> sequenced = const Value.absent(),
          Value<int?> format = const Value.absent(),
          Value<int?> version = const Value.absent(),
          Value<String?> author = const Value.absent(),
          Value<bool?> updatable = const Value.absent(),
          Value<String?> indexUrl = const Value.absent(),
          Value<String?> downloadUrl = const Value.absent(),
          Value<String?> url = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> attribution = const Value.absent(),
          Value<String?> sourceLanguage = const Value.absent(),
          Value<String?> targetLanguage = const Value.absent(),
          Value<String?> frequencyMode = const Value.absent()}) =>
      IndexTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        revision: revision ?? this.revision,
        sequenced: sequenced.present ? sequenced.value : this.sequenced,
        format: format.present ? format.value : this.format,
        version: version.present ? version.value : this.version,
        author: author.present ? author.value : this.author,
        updatable: updatable.present ? updatable.value : this.updatable,
        indexUrl: indexUrl.present ? indexUrl.value : this.indexUrl,
        downloadUrl: downloadUrl.present ? downloadUrl.value : this.downloadUrl,
        url: url.present ? url.value : this.url,
        description: description.present ? description.value : this.description,
        attribution: attribution.present ? attribution.value : this.attribution,
        sourceLanguage:
            sourceLanguage.present ? sourceLanguage.value : this.sourceLanguage,
        targetLanguage:
            targetLanguage.present ? targetLanguage.value : this.targetLanguage,
        frequencyMode:
            frequencyMode.present ? frequencyMode.value : this.frequencyMode,
      );
  IndexTableData copyWithCompanion(IndexTableCompanion data) {
    return IndexTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      revision: data.revision.present ? data.revision.value : this.revision,
      sequenced: data.sequenced.present ? data.sequenced.value : this.sequenced,
      format: data.format.present ? data.format.value : this.format,
      version: data.version.present ? data.version.value : this.version,
      author: data.author.present ? data.author.value : this.author,
      updatable: data.updatable.present ? data.updatable.value : this.updatable,
      indexUrl: data.indexUrl.present ? data.indexUrl.value : this.indexUrl,
      downloadUrl:
          data.downloadUrl.present ? data.downloadUrl.value : this.downloadUrl,
      url: data.url.present ? data.url.value : this.url,
      description:
          data.description.present ? data.description.value : this.description,
      attribution:
          data.attribution.present ? data.attribution.value : this.attribution,
      sourceLanguage: data.sourceLanguage.present
          ? data.sourceLanguage.value
          : this.sourceLanguage,
      targetLanguage: data.targetLanguage.present
          ? data.targetLanguage.value
          : this.targetLanguage,
      frequencyMode: data.frequencyMode.present
          ? data.frequencyMode.value
          : this.frequencyMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IndexTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('revision: $revision, ')
          ..write('sequenced: $sequenced, ')
          ..write('format: $format, ')
          ..write('version: $version, ')
          ..write('author: $author, ')
          ..write('updatable: $updatable, ')
          ..write('indexUrl: $indexUrl, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('url: $url, ')
          ..write('description: $description, ')
          ..write('attribution: $attribution, ')
          ..write('sourceLanguage: $sourceLanguage, ')
          ..write('targetLanguage: $targetLanguage, ')
          ..write('frequencyMode: $frequencyMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      revision,
      sequenced,
      format,
      version,
      author,
      updatable,
      indexUrl,
      downloadUrl,
      url,
      description,
      attribution,
      sourceLanguage,
      targetLanguage,
      frequencyMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndexTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.revision == this.revision &&
          other.sequenced == this.sequenced &&
          other.format == this.format &&
          other.version == this.version &&
          other.author == this.author &&
          other.updatable == this.updatable &&
          other.indexUrl == this.indexUrl &&
          other.downloadUrl == this.downloadUrl &&
          other.url == this.url &&
          other.description == this.description &&
          other.attribution == this.attribution &&
          other.sourceLanguage == this.sourceLanguage &&
          other.targetLanguage == this.targetLanguage &&
          other.frequencyMode == this.frequencyMode);
}

class IndexTableCompanion extends UpdateCompanion<IndexTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> revision;
  final Value<bool?> sequenced;
  final Value<int?> format;
  final Value<int?> version;
  final Value<String?> author;
  final Value<bool?> updatable;
  final Value<String?> indexUrl;
  final Value<String?> downloadUrl;
  final Value<String?> url;
  final Value<String?> description;
  final Value<String?> attribution;
  final Value<String?> sourceLanguage;
  final Value<String?> targetLanguage;
  final Value<String?> frequencyMode;
  const IndexTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.revision = const Value.absent(),
    this.sequenced = const Value.absent(),
    this.format = const Value.absent(),
    this.version = const Value.absent(),
    this.author = const Value.absent(),
    this.updatable = const Value.absent(),
    this.indexUrl = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.url = const Value.absent(),
    this.description = const Value.absent(),
    this.attribution = const Value.absent(),
    this.sourceLanguage = const Value.absent(),
    this.targetLanguage = const Value.absent(),
    this.frequencyMode = const Value.absent(),
  });
  IndexTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String revision,
    this.sequenced = const Value.absent(),
    this.format = const Value.absent(),
    this.version = const Value.absent(),
    this.author = const Value.absent(),
    this.updatable = const Value.absent(),
    this.indexUrl = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.url = const Value.absent(),
    this.description = const Value.absent(),
    this.attribution = const Value.absent(),
    this.sourceLanguage = const Value.absent(),
    this.targetLanguage = const Value.absent(),
    this.frequencyMode = const Value.absent(),
  })  : title = Value(title),
        revision = Value(revision);
  static Insertable<IndexTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? revision,
    Expression<bool>? sequenced,
    Expression<int>? format,
    Expression<int>? version,
    Expression<String>? author,
    Expression<bool>? updatable,
    Expression<String>? indexUrl,
    Expression<String>? downloadUrl,
    Expression<String>? url,
    Expression<String>? description,
    Expression<String>? attribution,
    Expression<String>? sourceLanguage,
    Expression<String>? targetLanguage,
    Expression<String>? frequencyMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (revision != null) 'revision': revision,
      if (sequenced != null) 'sequenced': sequenced,
      if (format != null) 'format': format,
      if (version != null) 'version': version,
      if (author != null) 'author': author,
      if (updatable != null) 'updatable': updatable,
      if (indexUrl != null) 'index_url': indexUrl,
      if (downloadUrl != null) 'download_url': downloadUrl,
      if (url != null) 'url': url,
      if (description != null) 'description': description,
      if (attribution != null) 'attribution': attribution,
      if (sourceLanguage != null) 'source_language': sourceLanguage,
      if (targetLanguage != null) 'target_language': targetLanguage,
      if (frequencyMode != null) 'frequency_mode': frequencyMode,
    });
  }

  IndexTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? revision,
      Value<bool?>? sequenced,
      Value<int?>? format,
      Value<int?>? version,
      Value<String?>? author,
      Value<bool?>? updatable,
      Value<String?>? indexUrl,
      Value<String?>? downloadUrl,
      Value<String?>? url,
      Value<String?>? description,
      Value<String?>? attribution,
      Value<String?>? sourceLanguage,
      Value<String?>? targetLanguage,
      Value<String?>? frequencyMode}) {
    return IndexTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      revision: revision ?? this.revision,
      sequenced: sequenced ?? this.sequenced,
      format: format ?? this.format,
      version: version ?? this.version,
      author: author ?? this.author,
      updatable: updatable ?? this.updatable,
      indexUrl: indexUrl ?? this.indexUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      url: url ?? this.url,
      description: description ?? this.description,
      attribution: attribution ?? this.attribution,
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      frequencyMode: frequencyMode ?? this.frequencyMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (revision.present) {
      map['revision'] = Variable<String>(revision.value);
    }
    if (sequenced.present) {
      map['sequenced'] = Variable<bool>(sequenced.value);
    }
    if (format.present) {
      map['format'] = Variable<int>(format.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (updatable.present) {
      map['updatable'] = Variable<bool>(updatable.value);
    }
    if (indexUrl.present) {
      map['index_url'] = Variable<String>(indexUrl.value);
    }
    if (downloadUrl.present) {
      map['download_url'] = Variable<String>(downloadUrl.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (attribution.present) {
      map['attribution'] = Variable<String>(attribution.value);
    }
    if (sourceLanguage.present) {
      map['source_language'] = Variable<String>(sourceLanguage.value);
    }
    if (targetLanguage.present) {
      map['target_language'] = Variable<String>(targetLanguage.value);
    }
    if (frequencyMode.present) {
      map['frequency_mode'] = Variable<String>(frequencyMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IndexTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('revision: $revision, ')
          ..write('sequenced: $sequenced, ')
          ..write('format: $format, ')
          ..write('version: $version, ')
          ..write('author: $author, ')
          ..write('updatable: $updatable, ')
          ..write('indexUrl: $indexUrl, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('url: $url, ')
          ..write('description: $description, ')
          ..write('attribution: $attribution, ')
          ..write('sourceLanguage: $sourceLanguage, ')
          ..write('targetLanguage: $targetLanguage, ')
          ..write('frequencyMode: $frequencyMode')
          ..write(')'))
        .toString();
  }
}

class $TagBankV3TableTable extends TagBankV3Table
    with TableInfo<$TagBankV3TableTable, TagBankV3TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagBankV3TableTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _sortingOrderMeta =
      const VerificationMeta('sortingOrder');
  @override
  late final GeneratedColumn<int> sortingOrder = GeneratedColumn<int>(
      'sorting_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes =
      GeneratedColumn<String>('notes', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, sortingOrder, notes, score];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tag_bank_v3_table';
  @override
  VerificationContext validateIntegrity(Insertable<TagBankV3TableData> instance,
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
    if (data.containsKey('sorting_order')) {
      context.handle(
          _sortingOrderMeta,
          sortingOrder.isAcceptableOrUnknown(
              data['sorting_order']!, _sortingOrderMeta));
    } else if (isInserting) {
      context.missing(_sortingOrderMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagBankV3TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagBankV3TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sortingOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sorting_order'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
    );
  }

  @override
  $TagBankV3TableTable createAlias(String alias) {
    return $TagBankV3TableTable(attachedDatabase, alias);
  }
}

class TagBankV3TableData extends DataClass
    implements Insertable<TagBankV3TableData> {
  /// id of this entry
  final int id;

  /// Tag name.
  final String name;

  /// Sorting order for the tag.
  final int sortingOrder;

  /// Notes for the tag.
  final String notes;

  /// Score used to determine popularity. Negative values are more rare and
  /// positive values are more frequent. This score is also used to sort search
  /// results.
  final int score;
  const TagBankV3TableData(
      {required this.id,
      required this.name,
      required this.sortingOrder,
      required this.notes,
      required this.score});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sorting_order'] = Variable<int>(sortingOrder);
    map['notes'] = Variable<String>(notes);
    map['score'] = Variable<int>(score);
    return map;
  }

  TagBankV3TableCompanion toCompanion(bool nullToAbsent) {
    return TagBankV3TableCompanion(
      id: Value(id),
      name: Value(name),
      sortingOrder: Value(sortingOrder),
      notes: Value(notes),
      score: Value(score),
    );
  }

  factory TagBankV3TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagBankV3TableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortingOrder: serializer.fromJson<int>(json['sortingOrder']),
      notes: serializer.fromJson<String>(json['notes']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sortingOrder': serializer.toJson<int>(sortingOrder),
      'notes': serializer.toJson<String>(notes),
      'score': serializer.toJson<int>(score),
    };
  }

  TagBankV3TableData copyWith(
          {int? id,
          String? name,
          int? sortingOrder,
          String? notes,
          int? score}) =>
      TagBankV3TableData(
        id: id ?? this.id,
        name: name ?? this.name,
        sortingOrder: sortingOrder ?? this.sortingOrder,
        notes: notes ?? this.notes,
        score: score ?? this.score,
      );
  TagBankV3TableData copyWithCompanion(TagBankV3TableCompanion data) {
    return TagBankV3TableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortingOrder: data.sortingOrder.present
          ? data.sortingOrder.value
          : this.sortingOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagBankV3TableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortingOrder: $sortingOrder, ')
          ..write('notes: $notes, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortingOrder, notes, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagBankV3TableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortingOrder == this.sortingOrder &&
          other.notes == this.notes &&
          other.score == this.score);
}

class TagBankV3TableCompanion extends UpdateCompanion<TagBankV3TableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sortingOrder;
  final Value<String> notes;
  final Value<int> score;
  const TagBankV3TableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortingOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.score = const Value.absent(),
  });
  TagBankV3TableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int sortingOrder,
    required String notes,
    required int score,
  })  : name = Value(name),
        sortingOrder = Value(sortingOrder),
        notes = Value(notes),
        score = Value(score);
  static Insertable<TagBankV3TableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sortingOrder,
    Expression<String>? notes,
    Expression<int>? score,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortingOrder != null) 'sorting_order': sortingOrder,
      if (notes != null) 'notes': notes,
      if (score != null) 'score': score,
    });
  }

  TagBankV3TableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? sortingOrder,
      Value<String>? notes,
      Value<int>? score}) {
    return TagBankV3TableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortingOrder: sortingOrder ?? this.sortingOrder,
      notes: notes ?? this.notes,
      score: score ?? this.score,
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
    if (sortingOrder.present) {
      map['sorting_order'] = Variable<int>(sortingOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagBankV3TableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortingOrder: $sortingOrder, ')
          ..write('notes: $notes, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }
}

class $TagBankV3CategoryTableTable extends TagBankV3CategoryTable
    with TableInfo<$TagBankV3CategoryTableTable, TagBankV3CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagBankV3CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category =
      GeneratedColumn<String>('category', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tag_bank_v3_category_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TagBankV3CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagBankV3CategoryTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagBankV3CategoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
    );
  }

  @override
  $TagBankV3CategoryTableTable createAlias(String alias) {
    return $TagBankV3CategoryTableTable(attachedDatabase, alias);
  }
}

class TagBankV3CategoryTableData extends DataClass
    implements Insertable<TagBankV3CategoryTableData> {
  /// id of this entry
  final int id;

  /// Category for the tag.
  final String category;
  const TagBankV3CategoryTableData({required this.id, required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    return map;
  }

  TagBankV3CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return TagBankV3CategoryTableCompanion(
      id: Value(id),
      category: Value(category),
    );
  }

  factory TagBankV3CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagBankV3CategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
    };
  }

  TagBankV3CategoryTableData copyWith({int? id, String? category}) =>
      TagBankV3CategoryTableData(
        id: id ?? this.id,
        category: category ?? this.category,
      );
  TagBankV3CategoryTableData copyWithCompanion(
      TagBankV3CategoryTableCompanion data) {
    return TagBankV3CategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagBankV3CategoryTableData(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagBankV3CategoryTableData &&
          other.id == this.id &&
          other.category == this.category);
}

class TagBankV3CategoryTableCompanion
    extends UpdateCompanion<TagBankV3CategoryTableData> {
  final Value<int> id;
  final Value<String> category;
  const TagBankV3CategoryTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  TagBankV3CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String category,
  }) : category = Value(category);
  static Insertable<TagBankV3CategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
    });
  }

  TagBankV3CategoryTableCompanion copyWith(
      {Value<int>? id, Value<String>? category}) {
    return TagBankV3CategoryTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagBankV3CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $TagBankV3TagCategoryRelationsTableTable
    extends TagBankV3TagCategoryRelationsTable
    with
        TableInfo<$TagBankV3TagCategoryRelationsTableTable,
            TagBankV3TagCategoryRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagBankV3TagCategoryRelationsTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tag_bank_v3_table (id)'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tag_bank_v3_category_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, tagId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tag_bank_v3_tag_category_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TagBankV3TagCategoryRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagBankV3TagCategoryRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagBankV3TagCategoryRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
    );
  }

  @override
  $TagBankV3TagCategoryRelationsTableTable createAlias(String alias) {
    return $TagBankV3TagCategoryRelationsTableTable(attachedDatabase, alias);
  }
}

class TagBankV3TagCategoryRelationsTableData extends DataClass
    implements Insertable<TagBankV3TagCategoryRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated tag reading
  final int tagId;

  /// the id of the associated tag category
  final int categoryId;
  const TagBankV3TagCategoryRelationsTableData(
      {required this.id, required this.tagId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_id'] = Variable<int>(tagId);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  TagBankV3TagCategoryRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return TagBankV3TagCategoryRelationsTableCompanion(
      id: Value(id),
      tagId: Value(tagId),
      categoryId: Value(categoryId),
    );
  }

  factory TagBankV3TagCategoryRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagBankV3TagCategoryRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      tagId: serializer.fromJson<int>(json['tagId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagId': serializer.toJson<int>(tagId),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  TagBankV3TagCategoryRelationsTableData copyWith(
          {int? id, int? tagId, int? categoryId}) =>
      TagBankV3TagCategoryRelationsTableData(
        id: id ?? this.id,
        tagId: tagId ?? this.tagId,
        categoryId: categoryId ?? this.categoryId,
      );
  TagBankV3TagCategoryRelationsTableData copyWithCompanion(
      TagBankV3TagCategoryRelationsTableCompanion data) {
    return TagBankV3TagCategoryRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagBankV3TagCategoryRelationsTableData(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tagId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagBankV3TagCategoryRelationsTableData &&
          other.id == this.id &&
          other.tagId == this.tagId &&
          other.categoryId == this.categoryId);
}

class TagBankV3TagCategoryRelationsTableCompanion
    extends UpdateCompanion<TagBankV3TagCategoryRelationsTableData> {
  final Value<int> id;
  final Value<int> tagId;
  final Value<int> categoryId;
  const TagBankV3TagCategoryRelationsTableCompanion({
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  TagBankV3TagCategoryRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int tagId,
    required int categoryId,
  })  : tagId = Value(tagId),
        categoryId = Value(categoryId);
  static Insertable<TagBankV3TagCategoryRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? tagId,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagId != null) 'tag_id': tagId,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  TagBankV3TagCategoryRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? tagId, Value<int>? categoryId}) {
    return TagBankV3TagCategoryRelationsTableCompanion(
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagBankV3TagCategoryRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3TableTable extends KanjiBankV3Table
    with TableInfo<$KanjiBankV3TableTable, KanjiBankV3TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES kanji_table (id)'));
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES index_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, kanjiId, dictId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
    );
  }

  @override
  $KanjiBankV3TableTable createAlias(String alias) {
    return $KanjiBankV3TableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3TableData extends DataClass
    implements Insertable<KanjiBankV3TableData> {
  /// id of this entry
  final int id;

  /// id of the kanji character of this entry
  final int kanjiId;

  /// The id of the dictionary this entry belongs to
  final int dictId;
  const KanjiBankV3TableData(
      {required this.id, required this.kanjiId, required this.dictId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_id'] = Variable<int>(kanjiId);
    map['dict_id'] = Variable<int>(dictId);
    return map;
  }

  KanjiBankV3TableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TableCompanion(
      id: Value(id),
      kanjiId: Value(kanjiId),
      dictId: Value(dictId),
    );
  }

  factory KanjiBankV3TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
      dictId: serializer.fromJson<int>(json['dictId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiId': serializer.toJson<int>(kanjiId),
      'dictId': serializer.toJson<int>(dictId),
    };
  }

  KanjiBankV3TableData copyWith({int? id, int? kanjiId, int? dictId}) =>
      KanjiBankV3TableData(
        id: id ?? this.id,
        kanjiId: kanjiId ?? this.kanjiId,
        dictId: dictId ?? this.dictId,
      );
  KanjiBankV3TableData copyWithCompanion(KanjiBankV3TableCompanion data) {
    return KanjiBankV3TableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TableData(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('dictId: $dictId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiId, dictId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3TableData &&
          other.id == this.id &&
          other.kanjiId == this.kanjiId &&
          other.dictId == this.dictId);
}

class KanjiBankV3TableCompanion extends UpdateCompanion<KanjiBankV3TableData> {
  final Value<int> id;
  final Value<int> kanjiId;
  final Value<int> dictId;
  const KanjiBankV3TableCompanion({
    this.id = const Value.absent(),
    this.kanjiId = const Value.absent(),
    this.dictId = const Value.absent(),
  });
  KanjiBankV3TableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiId,
    required int dictId,
  })  : kanjiId = Value(kanjiId),
        dictId = Value(dictId);
  static Insertable<KanjiBankV3TableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiId,
    Expression<int>? dictId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiId != null) 'kanji_id': kanjiId,
      if (dictId != null) 'dict_id': dictId,
    });
  }

  KanjiBankV3TableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiId, Value<int>? dictId}) {
    return KanjiBankV3TableCompanion(
      id: id ?? this.id,
      kanjiId: kanjiId ?? this.kanjiId,
      dictId: dictId ?? this.dictId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('dictId: $dictId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3OnyomisTableTable extends KanjiBankV3OnyomisTable
    with TableInfo<$KanjiBankV3OnyomisTableTable, KanjiBankV3OnyomisTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3OnyomisTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _onyomiMeta = const VerificationMeta('onyomi');
  @override
  late final GeneratedColumn<String> onyomi = GeneratedColumn<String>(
      'onyomi', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, onyomi];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_onyomis_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3OnyomisTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onyomi')) {
      context.handle(_onyomiMeta,
          onyomi.isAcceptableOrUnknown(data['onyomi']!, _onyomiMeta));
    } else if (isInserting) {
      context.missing(_onyomiMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3OnyomisTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3OnyomisTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      onyomi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}onyomi'])!,
    );
  }

  @override
  $KanjiBankV3OnyomisTableTable createAlias(String alias) {
    return $KanjiBankV3OnyomisTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3OnyomisTableData extends DataClass
    implements Insertable<KanjiBankV3OnyomisTableData> {
  /// id of this meaning
  final int id;

  /// TODO link to reading table
  /// The onyomi reading of this entry
  final String onyomi;
  const KanjiBankV3OnyomisTableData({required this.id, required this.onyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onyomi'] = Variable<String>(onyomi);
    return map;
  }

  KanjiBankV3OnyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3OnyomisTableCompanion(
      id: Value(id),
      onyomi: Value(onyomi),
    );
  }

  factory KanjiBankV3OnyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3OnyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      onyomi: serializer.fromJson<String>(json['onyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onyomi': serializer.toJson<String>(onyomi),
    };
  }

  KanjiBankV3OnyomisTableData copyWith({int? id, String? onyomi}) =>
      KanjiBankV3OnyomisTableData(
        id: id ?? this.id,
        onyomi: onyomi ?? this.onyomi,
      );
  KanjiBankV3OnyomisTableData copyWithCompanion(
      KanjiBankV3OnyomisTableCompanion data) {
    return KanjiBankV3OnyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      onyomi: data.onyomi.present ? data.onyomi.value : this.onyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomisTableData(')
          ..write('id: $id, ')
          ..write('onyomi: $onyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, onyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3OnyomisTableData &&
          other.id == this.id &&
          other.onyomi == this.onyomi);
}

class KanjiBankV3OnyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3OnyomisTableData> {
  final Value<int> id;
  final Value<String> onyomi;
  const KanjiBankV3OnyomisTableCompanion({
    this.id = const Value.absent(),
    this.onyomi = const Value.absent(),
  });
  KanjiBankV3OnyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required String onyomi,
  }) : onyomi = Value(onyomi);
  static Insertable<KanjiBankV3OnyomisTableData> custom({
    Expression<int>? id,
    Expression<String>? onyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onyomi != null) 'onyomi': onyomi,
    });
  }

  KanjiBankV3OnyomisTableCompanion copyWith(
      {Value<int>? id, Value<String>? onyomi}) {
    return KanjiBankV3OnyomisTableCompanion(
      id: id ?? this.id,
      onyomi: onyomi ?? this.onyomi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onyomi.present) {
      map['onyomi'] = Variable<String>(onyomi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomisTableCompanion(')
          ..write('id: $id, ')
          ..write('onyomi: $onyomi')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3OnyomiKanjiRelationsTableTable
    extends KanjiBankV3OnyomiKanjiRelationsTable
    with
        TableInfo<$KanjiBankV3OnyomiKanjiRelationsTableTable,
            KanjiBankV3OnyomiKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3OnyomiKanjiRelationsTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _onyomiIdMeta =
      const VerificationMeta('onyomiId');
  @override
  late final GeneratedColumn<int> onyomiId = GeneratedColumn<int>(
      'onyomi_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_onyomis_table (id)'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, onyomiId, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_onyomi_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3OnyomiKanjiRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onyomi_id')) {
      context.handle(_onyomiIdMeta,
          onyomiId.isAcceptableOrUnknown(data['onyomi_id']!, _onyomiIdMeta));
    } else if (isInserting) {
      context.missing(_onyomiIdMeta);
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3OnyomiKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3OnyomiKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      onyomiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}onyomi_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $KanjiBankV3OnyomiKanjiRelationsTableTable createAlias(String alias) {
    return $KanjiBankV3OnyomiKanjiRelationsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3OnyomiKanjiRelationsTableData extends DataClass
    implements Insertable<KanjiBankV3OnyomiKanjiRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated onyomi reading
  final int onyomiId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3OnyomiKanjiRelationsTableData(
      {required this.id, required this.onyomiId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onyomi_id'] = Variable<int>(onyomiId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3OnyomiKanjiRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3OnyomiKanjiRelationsTableCompanion(
      id: Value(id),
      onyomiId: Value(onyomiId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3OnyomiKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3OnyomiKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      onyomiId: serializer.fromJson<int>(json['onyomiId']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onyomiId': serializer.toJson<int>(onyomiId),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  KanjiBankV3OnyomiKanjiRelationsTableData copyWith(
          {int? id, int? onyomiId, int? kanjiId}) =>
      KanjiBankV3OnyomiKanjiRelationsTableData(
        id: id ?? this.id,
        onyomiId: onyomiId ?? this.onyomiId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3OnyomiKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3OnyomiKanjiRelationsTableCompanion data) {
    return KanjiBankV3OnyomiKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      onyomiId: data.onyomiId.present ? data.onyomiId.value : this.onyomiId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomiKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('onyomiId: $onyomiId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, onyomiId, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3OnyomiKanjiRelationsTableData &&
          other.id == this.id &&
          other.onyomiId == this.onyomiId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3OnyomiKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3OnyomiKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> onyomiId;
  final Value<int> kanjiId;
  const KanjiBankV3OnyomiKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.onyomiId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3OnyomiKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int onyomiId,
    required int kanjiId,
  })  : onyomiId = Value(onyomiId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3OnyomiKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? onyomiId,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onyomiId != null) 'onyomi_id': onyomiId,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  KanjiBankV3OnyomiKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? onyomiId, Value<int>? kanjiId}) {
    return KanjiBankV3OnyomiKanjiRelationsTableCompanion(
      id: id ?? this.id,
      onyomiId: onyomiId ?? this.onyomiId,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onyomiId.present) {
      map['onyomi_id'] = Variable<int>(onyomiId.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomiKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('onyomiId: $onyomiId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3KunyomisTableTable extends KanjiBankV3KunyomisTable
    with
        TableInfo<$KanjiBankV3KunyomisTableTable,
            KanjiBankV3KunyomisTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3KunyomisTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kunyomiMeta =
      const VerificationMeta('kunyomi');
  @override
  late final GeneratedColumn<String> kunyomi = GeneratedColumn<String>(
      'kunyomi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kunyomi];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_kunyomis_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3KunyomisTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kunyomi')) {
      context.handle(_kunyomiMeta,
          kunyomi.isAcceptableOrUnknown(data['kunyomi']!, _kunyomiMeta));
    } else if (isInserting) {
      context.missing(_kunyomiMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3KunyomisTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3KunyomisTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kunyomi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kunyomi'])!,
    );
  }

  @override
  $KanjiBankV3KunyomisTableTable createAlias(String alias) {
    return $KanjiBankV3KunyomisTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3KunyomisTableData extends DataClass
    implements Insertable<KanjiBankV3KunyomisTableData> {
  /// id of this meaning
  final int id;

  /// TODO link to reading table
  /// The kunyomi reading of this entry
  final String kunyomi;
  const KanjiBankV3KunyomisTableData({required this.id, required this.kunyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kunyomi'] = Variable<String>(kunyomi);
    return map;
  }

  KanjiBankV3KunyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3KunyomisTableCompanion(
      id: Value(id),
      kunyomi: Value(kunyomi),
    );
  }

  factory KanjiBankV3KunyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3KunyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      kunyomi: serializer.fromJson<String>(json['kunyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kunyomi': serializer.toJson<String>(kunyomi),
    };
  }

  KanjiBankV3KunyomisTableData copyWith({int? id, String? kunyomi}) =>
      KanjiBankV3KunyomisTableData(
        id: id ?? this.id,
        kunyomi: kunyomi ?? this.kunyomi,
      );
  KanjiBankV3KunyomisTableData copyWithCompanion(
      KanjiBankV3KunyomisTableCompanion data) {
    return KanjiBankV3KunyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      kunyomi: data.kunyomi.present ? data.kunyomi.value : this.kunyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomisTableData(')
          ..write('id: $id, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kunyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3KunyomisTableData &&
          other.id == this.id &&
          other.kunyomi == this.kunyomi);
}

class KanjiBankV3KunyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3KunyomisTableData> {
  final Value<int> id;
  final Value<String> kunyomi;
  const KanjiBankV3KunyomisTableCompanion({
    this.id = const Value.absent(),
    this.kunyomi = const Value.absent(),
  });
  KanjiBankV3KunyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required String kunyomi,
  }) : kunyomi = Value(kunyomi);
  static Insertable<KanjiBankV3KunyomisTableData> custom({
    Expression<int>? id,
    Expression<String>? kunyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kunyomi != null) 'kunyomi': kunyomi,
    });
  }

  KanjiBankV3KunyomisTableCompanion copyWith(
      {Value<int>? id, Value<String>? kunyomi}) {
    return KanjiBankV3KunyomisTableCompanion(
      id: id ?? this.id,
      kunyomi: kunyomi ?? this.kunyomi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kunyomi.present) {
      map['kunyomi'] = Variable<String>(kunyomi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomisTableCompanion(')
          ..write('id: $id, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3KunyomiKanjiRelationsTableTable
    extends KanjiBankV3KunyomiKanjiRelationsTable
    with
        TableInfo<$KanjiBankV3KunyomiKanjiRelationsTableTable,
            KanjiBankV3KunyomiKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3KunyomiKanjiRelationsTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kunyomiIdMeta =
      const VerificationMeta('kunyomiId');
  @override
  late final GeneratedColumn<int> kunyomiId = GeneratedColumn<int>(
      'kunyomi_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_kunyomis_table (id)'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, kunyomiId, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_kunyomi_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3KunyomiKanjiRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kunyomi_id')) {
      context.handle(_kunyomiIdMeta,
          kunyomiId.isAcceptableOrUnknown(data['kunyomi_id']!, _kunyomiIdMeta));
    } else if (isInserting) {
      context.missing(_kunyomiIdMeta);
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3KunyomiKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3KunyomiKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kunyomiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kunyomi_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $KanjiBankV3KunyomiKanjiRelationsTableTable createAlias(String alias) {
    return $KanjiBankV3KunyomiKanjiRelationsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3KunyomiKanjiRelationsTableData extends DataClass
    implements Insertable<KanjiBankV3KunyomiKanjiRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated kunyomi reading
  final int kunyomiId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3KunyomiKanjiRelationsTableData(
      {required this.id, required this.kunyomiId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kunyomi_id'] = Variable<int>(kunyomiId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3KunyomiKanjiRelationsTableCompanion toCompanion(
      bool nullToAbsent) {
    return KanjiBankV3KunyomiKanjiRelationsTableCompanion(
      id: Value(id),
      kunyomiId: Value(kunyomiId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3KunyomiKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3KunyomiKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      kunyomiId: serializer.fromJson<int>(json['kunyomiId']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kunyomiId': serializer.toJson<int>(kunyomiId),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  KanjiBankV3KunyomiKanjiRelationsTableData copyWith(
          {int? id, int? kunyomiId, int? kanjiId}) =>
      KanjiBankV3KunyomiKanjiRelationsTableData(
        id: id ?? this.id,
        kunyomiId: kunyomiId ?? this.kunyomiId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3KunyomiKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3KunyomiKanjiRelationsTableCompanion data) {
    return KanjiBankV3KunyomiKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      kunyomiId: data.kunyomiId.present ? data.kunyomiId.value : this.kunyomiId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomiKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('kunyomiId: $kunyomiId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kunyomiId, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3KunyomiKanjiRelationsTableData &&
          other.id == this.id &&
          other.kunyomiId == this.kunyomiId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3KunyomiKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3KunyomiKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> kunyomiId;
  final Value<int> kanjiId;
  const KanjiBankV3KunyomiKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.kunyomiId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3KunyomiKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int kunyomiId,
    required int kanjiId,
  })  : kunyomiId = Value(kunyomiId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3KunyomiKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? kunyomiId,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kunyomiId != null) 'kunyomi_id': kunyomiId,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  KanjiBankV3KunyomiKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? kunyomiId, Value<int>? kanjiId}) {
    return KanjiBankV3KunyomiKanjiRelationsTableCompanion(
      id: id ?? this.id,
      kunyomiId: kunyomiId ?? this.kunyomiId,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kunyomiId.present) {
      map['kunyomi_id'] = Variable<int>(kunyomiId.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomiKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('kunyomiId: $kunyomiId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3TagsKanjiRelationsTableTable
    extends KanjiBankV3TagsKanjiRelationsTable
    with
        TableInfo<$KanjiBankV3TagsKanjiRelationsTableTable,
            KanjiBankV3TagsKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3TagsKanjiRelationsTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tag_bank_v3_table (id)'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, tagId, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_tags_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3TagsKanjiRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3TagsKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3TagsKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $KanjiBankV3TagsKanjiRelationsTableTable createAlias(String alias) {
    return $KanjiBankV3TagsKanjiRelationsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3TagsKanjiRelationsTableData extends DataClass
    implements Insertable<KanjiBankV3TagsKanjiRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated tag
  final int tagId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3TagsKanjiRelationsTableData(
      {required this.id, required this.tagId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_id'] = Variable<int>(tagId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3TagsKanjiRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TagsKanjiRelationsTableCompanion(
      id: Value(id),
      tagId: Value(tagId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3TagsKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TagsKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      tagId: serializer.fromJson<int>(json['tagId']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagId': serializer.toJson<int>(tagId),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  KanjiBankV3TagsKanjiRelationsTableData copyWith(
          {int? id, int? tagId, int? kanjiId}) =>
      KanjiBankV3TagsKanjiRelationsTableData(
        id: id ?? this.id,
        tagId: tagId ?? this.tagId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3TagsKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3TagsKanjiRelationsTableCompanion data) {
    return KanjiBankV3TagsKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TagsKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tagId, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3TagsKanjiRelationsTableData &&
          other.id == this.id &&
          other.tagId == this.tagId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3TagsKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3TagsKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> tagId;
  final Value<int> kanjiId;
  const KanjiBankV3TagsKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3TagsKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int tagId,
    required int kanjiId,
  })  : tagId = Value(tagId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3TagsKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? tagId,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagId != null) 'tag_id': tagId,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  KanjiBankV3TagsKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? tagId, Value<int>? kanjiId}) {
    return KanjiBankV3TagsKanjiRelationsTableCompanion(
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TagsKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3MeaningsTableTable extends KanjiBankV3MeaningsTable
    with
        TableInfo<$KanjiBankV3MeaningsTableTable,
            KanjiBankV3MeaningsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3MeaningsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _meaningMeta =
      const VerificationMeta('meaning');
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
      'meaning', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, meaning];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_meanings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3MeaningsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meaning')) {
      context.handle(_meaningMeta,
          meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta));
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3MeaningsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3MeaningsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      meaning: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning'])!,
    );
  }

  @override
  $KanjiBankV3MeaningsTableTable createAlias(String alias) {
    return $KanjiBankV3MeaningsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3MeaningsTableData extends DataClass
    implements Insertable<KanjiBankV3MeaningsTableData> {
  /// id of this meaning
  final int id;

  /// The meaning of this entry
  final String meaning;
  const KanjiBankV3MeaningsTableData({required this.id, required this.meaning});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meaning'] = Variable<String>(meaning);
    return map;
  }

  KanjiBankV3MeaningsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3MeaningsTableCompanion(
      id: Value(id),
      meaning: Value(meaning),
    );
  }

  factory KanjiBankV3MeaningsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3MeaningsTableData(
      id: serializer.fromJson<int>(json['id']),
      meaning: serializer.fromJson<String>(json['meaning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'meaning': serializer.toJson<String>(meaning),
    };
  }

  KanjiBankV3MeaningsTableData copyWith({int? id, String? meaning}) =>
      KanjiBankV3MeaningsTableData(
        id: id ?? this.id,
        meaning: meaning ?? this.meaning,
      );
  KanjiBankV3MeaningsTableData copyWithCompanion(
      KanjiBankV3MeaningsTableCompanion data) {
    return KanjiBankV3MeaningsTableData(
      id: data.id.present ? data.id.value : this.id,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3MeaningsTableData(')
          ..write('id: $id, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, meaning);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3MeaningsTableData &&
          other.id == this.id &&
          other.meaning == this.meaning);
}

class KanjiBankV3MeaningsTableCompanion
    extends UpdateCompanion<KanjiBankV3MeaningsTableData> {
  final Value<int> id;
  final Value<String> meaning;
  const KanjiBankV3MeaningsTableCompanion({
    this.id = const Value.absent(),
    this.meaning = const Value.absent(),
  });
  KanjiBankV3MeaningsTableCompanion.insert({
    this.id = const Value.absent(),
    required String meaning,
  }) : meaning = Value(meaning);
  static Insertable<KanjiBankV3MeaningsTableData> custom({
    Expression<int>? id,
    Expression<String>? meaning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meaning != null) 'meaning': meaning,
    });
  }

  KanjiBankV3MeaningsTableCompanion copyWith(
      {Value<int>? id, Value<String>? meaning}) {
    return KanjiBankV3MeaningsTableCompanion(
      id: id ?? this.id,
      meaning: meaning ?? this.meaning,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3MeaningsTableCompanion(')
          ..write('id: $id, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3MeaningsKanjiRelationsTableTable
    extends KanjiBankV3MeaningsKanjiRelationsTable
    with
        TableInfo<$KanjiBankV3MeaningsKanjiRelationsTableTable,
            KanjiBankV3MeaningsKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3MeaningsKanjiRelationsTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _meaningIdMeta =
      const VerificationMeta('meaningId');
  @override
  late final GeneratedColumn<int> meaningId = GeneratedColumn<int>(
      'meaning_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_meanings_table (id)'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, meaningId, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_meanings_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3MeaningsKanjiRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meaning_id')) {
      context.handle(_meaningIdMeta,
          meaningId.isAcceptableOrUnknown(data['meaning_id']!, _meaningIdMeta));
    } else if (isInserting) {
      context.missing(_meaningIdMeta);
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3MeaningsKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3MeaningsKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      meaningId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meaning_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $KanjiBankV3MeaningsKanjiRelationsTableTable createAlias(String alias) {
    return $KanjiBankV3MeaningsKanjiRelationsTableTable(
        attachedDatabase, alias);
  }
}

class KanjiBankV3MeaningsKanjiRelationsTableData extends DataClass
    implements Insertable<KanjiBankV3MeaningsKanjiRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated meaning
  final int meaningId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3MeaningsKanjiRelationsTableData(
      {required this.id, required this.meaningId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meaning_id'] = Variable<int>(meaningId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3MeaningsKanjiRelationsTableCompanion toCompanion(
      bool nullToAbsent) {
    return KanjiBankV3MeaningsKanjiRelationsTableCompanion(
      id: Value(id),
      meaningId: Value(meaningId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3MeaningsKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3MeaningsKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      meaningId: serializer.fromJson<int>(json['meaningId']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'meaningId': serializer.toJson<int>(meaningId),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  KanjiBankV3MeaningsKanjiRelationsTableData copyWith(
          {int? id, int? meaningId, int? kanjiId}) =>
      KanjiBankV3MeaningsKanjiRelationsTableData(
        id: id ?? this.id,
        meaningId: meaningId ?? this.meaningId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3MeaningsKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3MeaningsKanjiRelationsTableCompanion data) {
    return KanjiBankV3MeaningsKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      meaningId: data.meaningId.present ? data.meaningId.value : this.meaningId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3MeaningsKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('meaningId: $meaningId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, meaningId, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3MeaningsKanjiRelationsTableData &&
          other.id == this.id &&
          other.meaningId == this.meaningId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3MeaningsKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3MeaningsKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> meaningId;
  final Value<int> kanjiId;
  const KanjiBankV3MeaningsKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.meaningId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3MeaningsKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int meaningId,
    required int kanjiId,
  })  : meaningId = Value(meaningId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3MeaningsKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? meaningId,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meaningId != null) 'meaning_id': meaningId,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  KanjiBankV3MeaningsKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? meaningId, Value<int>? kanjiId}) {
    return KanjiBankV3MeaningsKanjiRelationsTableCompanion(
      id: id ?? this.id,
      meaningId: meaningId ?? this.meaningId,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (meaningId.present) {
      map['meaning_id'] = Variable<int>(meaningId.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3MeaningsKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('meaningId: $meaningId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3StatNamesTableTable extends KanjiBankV3StatNamesTable
    with
        TableInfo<$KanjiBankV3StatNamesTableTable,
            KanjiBankV3StatNamesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3StatNamesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statNameMeta =
      const VerificationMeta('statName');
  @override
  late final GeneratedColumn<String> statName = GeneratedColumn<String>(
      'stat_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, statName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_stat_names_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3StatNamesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stat_name')) {
      context.handle(_statNameMeta,
          statName.isAcceptableOrUnknown(data['stat_name']!, _statNameMeta));
    } else if (isInserting) {
      context.missing(_statNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3StatNamesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3StatNamesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stat_name'])!,
    );
  }

  @override
  $KanjiBankV3StatNamesTableTable createAlias(String alias) {
    return $KanjiBankV3StatNamesTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3StatNamesTableData extends DataClass
    implements Insertable<KanjiBankV3StatNamesTableData> {
  /// id of this stat name
  final int id;

  /// The name of this entrie's stat
  final String statName;
  const KanjiBankV3StatNamesTableData(
      {required this.id, required this.statName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stat_name'] = Variable<String>(statName);
    return map;
  }

  KanjiBankV3StatNamesTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatNamesTableCompanion(
      id: Value(id),
      statName: Value(statName),
    );
  }

  factory KanjiBankV3StatNamesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatNamesTableData(
      id: serializer.fromJson<int>(json['id']),
      statName: serializer.fromJson<String>(json['statName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'statName': serializer.toJson<String>(statName),
    };
  }

  KanjiBankV3StatNamesTableData copyWith({int? id, String? statName}) =>
      KanjiBankV3StatNamesTableData(
        id: id ?? this.id,
        statName: statName ?? this.statName,
      );
  KanjiBankV3StatNamesTableData copyWithCompanion(
      KanjiBankV3StatNamesTableCompanion data) {
    return KanjiBankV3StatNamesTableData(
      id: data.id.present ? data.id.value : this.id,
      statName: data.statName.present ? data.statName.value : this.statName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatNamesTableData(')
          ..write('id: $id, ')
          ..write('statName: $statName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, statName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatNamesTableData &&
          other.id == this.id &&
          other.statName == this.statName);
}

class KanjiBankV3StatNamesTableCompanion
    extends UpdateCompanion<KanjiBankV3StatNamesTableData> {
  final Value<int> id;
  final Value<String> statName;
  const KanjiBankV3StatNamesTableCompanion({
    this.id = const Value.absent(),
    this.statName = const Value.absent(),
  });
  KanjiBankV3StatNamesTableCompanion.insert({
    this.id = const Value.absent(),
    required String statName,
  }) : statName = Value(statName);
  static Insertable<KanjiBankV3StatNamesTableData> custom({
    Expression<int>? id,
    Expression<String>? statName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statName != null) 'stat_name': statName,
    });
  }

  KanjiBankV3StatNamesTableCompanion copyWith(
      {Value<int>? id, Value<String>? statName}) {
    return KanjiBankV3StatNamesTableCompanion(
      id: id ?? this.id,
      statName: statName ?? this.statName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statName.present) {
      map['stat_name'] = Variable<String>(statName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatNamesTableCompanion(')
          ..write('id: $id, ')
          ..write('statName: $statName')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3StatValuesTableTable extends KanjiBankV3StatValuesTable
    with
        TableInfo<$KanjiBankV3StatValuesTableTable,
            KanjiBankV3StatValuesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3StatValuesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statValueMeta =
      const VerificationMeta('statValue');
  @override
  late final GeneratedColumn<String> statValue = GeneratedColumn<String>(
      'stat_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, statValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_stat_values_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3StatValuesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stat_value')) {
      context.handle(_statValueMeta,
          statValue.isAcceptableOrUnknown(data['stat_value']!, _statValueMeta));
    } else if (isInserting) {
      context.missing(_statValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3StatValuesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3StatValuesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stat_value'])!,
    );
  }

  @override
  $KanjiBankV3StatValuesTableTable createAlias(String alias) {
    return $KanjiBankV3StatValuesTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3StatValuesTableData extends DataClass
    implements Insertable<KanjiBankV3StatValuesTableData> {
  /// id of this stat value
  final int id;

  /// The value of this entrie's stat
  final String statValue;
  const KanjiBankV3StatValuesTableData(
      {required this.id, required this.statValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stat_value'] = Variable<String>(statValue);
    return map;
  }

  KanjiBankV3StatValuesTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatValuesTableCompanion(
      id: Value(id),
      statValue: Value(statValue),
    );
  }

  factory KanjiBankV3StatValuesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatValuesTableData(
      id: serializer.fromJson<int>(json['id']),
      statValue: serializer.fromJson<String>(json['statValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'statValue': serializer.toJson<String>(statValue),
    };
  }

  KanjiBankV3StatValuesTableData copyWith({int? id, String? statValue}) =>
      KanjiBankV3StatValuesTableData(
        id: id ?? this.id,
        statValue: statValue ?? this.statValue,
      );
  KanjiBankV3StatValuesTableData copyWithCompanion(
      KanjiBankV3StatValuesTableCompanion data) {
    return KanjiBankV3StatValuesTableData(
      id: data.id.present ? data.id.value : this.id,
      statValue: data.statValue.present ? data.statValue.value : this.statValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatValuesTableData(')
          ..write('id: $id, ')
          ..write('statValue: $statValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, statValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatValuesTableData &&
          other.id == this.id &&
          other.statValue == this.statValue);
}

class KanjiBankV3StatValuesTableCompanion
    extends UpdateCompanion<KanjiBankV3StatValuesTableData> {
  final Value<int> id;
  final Value<String> statValue;
  const KanjiBankV3StatValuesTableCompanion({
    this.id = const Value.absent(),
    this.statValue = const Value.absent(),
  });
  KanjiBankV3StatValuesTableCompanion.insert({
    this.id = const Value.absent(),
    required String statValue,
  }) : statValue = Value(statValue);
  static Insertable<KanjiBankV3StatValuesTableData> custom({
    Expression<int>? id,
    Expression<String>? statValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statValue != null) 'stat_value': statValue,
    });
  }

  KanjiBankV3StatValuesTableCompanion copyWith(
      {Value<int>? id, Value<String>? statValue}) {
    return KanjiBankV3StatValuesTableCompanion(
      id: id ?? this.id,
      statValue: statValue ?? this.statValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statValue.present) {
      map['stat_value'] = Variable<String>(statValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatValuesTableCompanion(')
          ..write('id: $id, ')
          ..write('statValue: $statValue')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3StatsTableTable extends KanjiBankV3StatsTable
    with TableInfo<$KanjiBankV3StatsTableTable, KanjiBankV3StatsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3StatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statNameIdMeta =
      const VerificationMeta('statNameId');
  @override
  late final GeneratedColumn<int> statNameId = GeneratedColumn<int>(
      'stat_name_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_stat_names_table (id)'));
  static const VerificationMeta _statValueIdMeta =
      const VerificationMeta('statValueId');
  @override
  late final GeneratedColumn<int> statValueId = GeneratedColumn<int>(
      'stat_value_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_stat_values_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, statNameId, statValueId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_stats_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3StatsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stat_name_id')) {
      context.handle(
          _statNameIdMeta,
          statNameId.isAcceptableOrUnknown(
              data['stat_name_id']!, _statNameIdMeta));
    } else if (isInserting) {
      context.missing(_statNameIdMeta);
    }
    if (data.containsKey('stat_value_id')) {
      context.handle(
          _statValueIdMeta,
          statValueId.isAcceptableOrUnknown(
              data['stat_value_id']!, _statValueIdMeta));
    } else if (isInserting) {
      context.missing(_statValueIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3StatsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3StatsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statNameId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stat_name_id'])!,
      statValueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stat_value_id'])!,
    );
  }

  @override
  $KanjiBankV3StatsTableTable createAlias(String alias) {
    return $KanjiBankV3StatsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3StatsTableData extends DataClass
    implements Insertable<KanjiBankV3StatsTableData> {
  /// id of this meaning
  final int id;

  /// `KanjiBankV3StatsName` entry of this meaning
  final int statNameId;

  /// The value of this entrie's stat
  final int statValueId;
  const KanjiBankV3StatsTableData(
      {required this.id, required this.statNameId, required this.statValueId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stat_name_id'] = Variable<int>(statNameId);
    map['stat_value_id'] = Variable<int>(statValueId);
    return map;
  }

  KanjiBankV3StatsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatsTableCompanion(
      id: Value(id),
      statNameId: Value(statNameId),
      statValueId: Value(statValueId),
    );
  }

  factory KanjiBankV3StatsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatsTableData(
      id: serializer.fromJson<int>(json['id']),
      statNameId: serializer.fromJson<int>(json['statNameId']),
      statValueId: serializer.fromJson<int>(json['statValueId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'statNameId': serializer.toJson<int>(statNameId),
      'statValueId': serializer.toJson<int>(statValueId),
    };
  }

  KanjiBankV3StatsTableData copyWith(
          {int? id, int? statNameId, int? statValueId}) =>
      KanjiBankV3StatsTableData(
        id: id ?? this.id,
        statNameId: statNameId ?? this.statNameId,
        statValueId: statValueId ?? this.statValueId,
      );
  KanjiBankV3StatsTableData copyWithCompanion(
      KanjiBankV3StatsTableCompanion data) {
    return KanjiBankV3StatsTableData(
      id: data.id.present ? data.id.value : this.id,
      statNameId:
          data.statNameId.present ? data.statNameId.value : this.statNameId,
      statValueId:
          data.statValueId.present ? data.statValueId.value : this.statValueId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatsTableData(')
          ..write('id: $id, ')
          ..write('statNameId: $statNameId, ')
          ..write('statValueId: $statValueId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, statNameId, statValueId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatsTableData &&
          other.id == this.id &&
          other.statNameId == this.statNameId &&
          other.statValueId == this.statValueId);
}

class KanjiBankV3StatsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatsTableData> {
  final Value<int> id;
  final Value<int> statNameId;
  final Value<int> statValueId;
  const KanjiBankV3StatsTableCompanion({
    this.id = const Value.absent(),
    this.statNameId = const Value.absent(),
    this.statValueId = const Value.absent(),
  });
  KanjiBankV3StatsTableCompanion.insert({
    this.id = const Value.absent(),
    required int statNameId,
    required int statValueId,
  })  : statNameId = Value(statNameId),
        statValueId = Value(statValueId);
  static Insertable<KanjiBankV3StatsTableData> custom({
    Expression<int>? id,
    Expression<int>? statNameId,
    Expression<int>? statValueId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statNameId != null) 'stat_name_id': statNameId,
      if (statValueId != null) 'stat_value_id': statValueId,
    });
  }

  KanjiBankV3StatsTableCompanion copyWith(
      {Value<int>? id, Value<int>? statNameId, Value<int>? statValueId}) {
    return KanjiBankV3StatsTableCompanion(
      id: id ?? this.id,
      statNameId: statNameId ?? this.statNameId,
      statValueId: statValueId ?? this.statValueId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statNameId.present) {
      map['stat_name_id'] = Variable<int>(statNameId.value);
    }
    if (statValueId.present) {
      map['stat_value_id'] = Variable<int>(statValueId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatsTableCompanion(')
          ..write('id: $id, ')
          ..write('statNameId: $statNameId, ')
          ..write('statValueId: $statValueId')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3StatKanjiRelationsTableTable
    extends KanjiBankV3StatKanjiRelationsTable
    with
        TableInfo<$KanjiBankV3StatKanjiRelationsTableTable,
            KanjiBankV3StatKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3StatKanjiRelationsTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statIdMeta = const VerificationMeta('statId');
  @override
  late final GeneratedColumn<int> statId = GeneratedColumn<int>(
      'stat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_stats_table (id)'));
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, statId, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_stat_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3StatKanjiRelationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stat_id')) {
      context.handle(_statIdMeta,
          statId.isAcceptableOrUnknown(data['stat_id']!, _statIdMeta));
    } else if (isInserting) {
      context.missing(_statIdMeta);
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiBankV3StatKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3StatKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stat_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $KanjiBankV3StatKanjiRelationsTableTable createAlias(String alias) {
    return $KanjiBankV3StatKanjiRelationsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3StatKanjiRelationsTableData extends DataClass
    implements Insertable<KanjiBankV3StatKanjiRelationsTableData> {
  /// id of this relation
  final int id;

  /// the id of the associated stats element
  final int statId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3StatKanjiRelationsTableData(
      {required this.id, required this.statId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stat_id'] = Variable<int>(statId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3StatKanjiRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatKanjiRelationsTableCompanion(
      id: Value(id),
      statId: Value(statId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3StatKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      statId: serializer.fromJson<int>(json['statId']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'statId': serializer.toJson<int>(statId),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  KanjiBankV3StatKanjiRelationsTableData copyWith(
          {int? id, int? statId, int? kanjiId}) =>
      KanjiBankV3StatKanjiRelationsTableData(
        id: id ?? this.id,
        statId: statId ?? this.statId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3StatKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3StatKanjiRelationsTableCompanion data) {
    return KanjiBankV3StatKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      statId: data.statId.present ? data.statId.value : this.statId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('statId: $statId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, statId, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatKanjiRelationsTableData &&
          other.id == this.id &&
          other.statId == this.statId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3StatKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> statId;
  final Value<int> kanjiId;
  const KanjiBankV3StatKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.statId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3StatKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int statId,
    required int kanjiId,
  })  : statId = Value(statId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3StatKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? statId,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statId != null) 'stat_id': statId,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  KanjiBankV3StatKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? statId, Value<int>? kanjiId}) {
    return KanjiBankV3StatKanjiRelationsTableCompanion(
      id: id ?? this.id,
      statId: statId ?? this.statId,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statId.present) {
      map['stat_id'] = Variable<int>(statId.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<int>(kanjiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('statId: $statId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

class $KanjiMetaBankV3TypeTableTable extends KanjiMetaBankV3TypeTable
    with
        TableInfo<$KanjiMetaBankV3TypeTableTable,
            KanjiMetaBankV3TypeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiMetaBankV3TypeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type =
      GeneratedColumn<String>('type', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_meta_bank_v3_type_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiMetaBankV3TypeTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiMetaBankV3TypeTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiMetaBankV3TypeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $KanjiMetaBankV3TypeTableTable createAlias(String alias) {
    return $KanjiMetaBankV3TypeTableTable(attachedDatabase, alias);
  }
}

class KanjiMetaBankV3TypeTableData extends DataClass
    implements Insertable<KanjiMetaBankV3TypeTableData> {
  /// id of this entry
  final int id;

  /// the type of this meta information
  final String type;
  const KanjiMetaBankV3TypeTableData({required this.id, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    return map;
  }

  KanjiMetaBankV3TypeTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiMetaBankV3TypeTableCompanion(
      id: Value(id),
      type: Value(type),
    );
  }

  factory KanjiMetaBankV3TypeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiMetaBankV3TypeTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
    };
  }

  KanjiMetaBankV3TypeTableData copyWith({int? id, String? type}) =>
      KanjiMetaBankV3TypeTableData(
        id: id ?? this.id,
        type: type ?? this.type,
      );
  KanjiMetaBankV3TypeTableData copyWithCompanion(
      KanjiMetaBankV3TypeTableCompanion data) {
    return KanjiMetaBankV3TypeTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiMetaBankV3TypeTableData(')
          ..write('id: $id, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiMetaBankV3TypeTableData &&
          other.id == this.id &&
          other.type == this.type);
}

class KanjiMetaBankV3TypeTableCompanion
    extends UpdateCompanion<KanjiMetaBankV3TypeTableData> {
  final Value<int> id;
  final Value<String> type;
  const KanjiMetaBankV3TypeTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
  });
  KanjiMetaBankV3TypeTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
  }) : type = Value(type);
  static Insertable<KanjiMetaBankV3TypeTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
    });
  }

  KanjiMetaBankV3TypeTableCompanion copyWith(
      {Value<int>? id, Value<String>? type}) {
    return KanjiMetaBankV3TypeTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiMetaBankV3TypeTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $KanjiMetaBankV3TableTable extends KanjiMetaBankV3Table
    with TableInfo<$KanjiMetaBankV3TableTable, KanjiMetaBankV3TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiMetaBankV3TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<String> kanjiId =
      GeneratedColumn<String>('kanji_id', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
      'type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_meta_bank_v3_type_table (id)'));
  static const VerificationMeta _freqValueMeta =
      const VerificationMeta('freqValue');
  @override
  late final GeneratedColumn<int> freqValue = GeneratedColumn<int>(
      'freq_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _freqDisplayValueMeta =
      const VerificationMeta('freqDisplayValue');
  @override
  late final GeneratedColumn<String> freqDisplayValue = GeneratedColumn<String>(
      'freq_display_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, dictId, kanjiId, typeId, freqValue, freqDisplayValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_meta_bank_v3_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiMetaBankV3TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
    }
    if (data.containsKey('kanji_id')) {
      context.handle(_kanjiIdMeta,
          kanjiId.isAcceptableOrUnknown(data['kanji_id']!, _kanjiIdMeta));
    } else if (isInserting) {
      context.missing(_kanjiIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(_typeIdMeta,
          typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta));
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('freq_value')) {
      context.handle(_freqValueMeta,
          freqValue.isAcceptableOrUnknown(data['freq_value']!, _freqValueMeta));
    }
    if (data.containsKey('freq_display_value')) {
      context.handle(
          _freqDisplayValueMeta,
          freqDisplayValue.isAcceptableOrUnknown(
              data['freq_display_value']!, _freqDisplayValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KanjiMetaBankV3TableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiMetaBankV3TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kanji_id'])!,
      typeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_id'])!,
      freqValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}freq_value']),
      freqDisplayValue: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}freq_display_value']),
    );
  }

  @override
  $KanjiMetaBankV3TableTable createAlias(String alias) {
    return $KanjiMetaBankV3TableTable(attachedDatabase, alias);
  }
}

class KanjiMetaBankV3TableData extends DataClass
    implements Insertable<KanjiMetaBankV3TableData> {
  /// id of this entry
  final int id;

  /// id of the dictionary this entry belongs to
  final int dictId;

  /// the kanji this meta entry belongs to
  final String kanjiId;

  /// the id of this term's type entry
  final int typeId;

  /// this entry's numeric frequency value
  final int? freqValue;

  /// this entry's dispaly frequency value
  final String? freqDisplayValue;
  const KanjiMetaBankV3TableData(
      {required this.id,
      required this.dictId,
      required this.kanjiId,
      required this.typeId,
      this.freqValue,
      this.freqDisplayValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kanji_id'] = Variable<String>(kanjiId);
    map['type_id'] = Variable<int>(typeId);
    if (!nullToAbsent || freqValue != null) {
      map['freq_value'] = Variable<int>(freqValue);
    }
    if (!nullToAbsent || freqDisplayValue != null) {
      map['freq_display_value'] = Variable<String>(freqDisplayValue);
    }
    return map;
  }

  KanjiMetaBankV3TableCompanion toCompanion(bool nullToAbsent) {
    return KanjiMetaBankV3TableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      kanjiId: Value(kanjiId),
      typeId: Value(typeId),
      freqValue: freqValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqValue),
      freqDisplayValue: freqDisplayValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqDisplayValue),
    );
  }

  factory KanjiMetaBankV3TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiMetaBankV3TableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      kanjiId: serializer.fromJson<String>(json['kanjiId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      freqValue: serializer.fromJson<int?>(json['freqValue']),
      freqDisplayValue: serializer.fromJson<String?>(json['freqDisplayValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'kanjiId': serializer.toJson<String>(kanjiId),
      'typeId': serializer.toJson<int>(typeId),
      'freqValue': serializer.toJson<int?>(freqValue),
      'freqDisplayValue': serializer.toJson<String?>(freqDisplayValue),
    };
  }

  KanjiMetaBankV3TableData copyWith(
          {int? id,
          int? dictId,
          String? kanjiId,
          int? typeId,
          Value<int?> freqValue = const Value.absent(),
          Value<String?> freqDisplayValue = const Value.absent()}) =>
      KanjiMetaBankV3TableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kanjiId: kanjiId ?? this.kanjiId,
        typeId: typeId ?? this.typeId,
        freqValue: freqValue.present ? freqValue.value : this.freqValue,
        freqDisplayValue: freqDisplayValue.present
            ? freqDisplayValue.value
            : this.freqDisplayValue,
      );
  KanjiMetaBankV3TableData copyWithCompanion(
      KanjiMetaBankV3TableCompanion data) {
    return KanjiMetaBankV3TableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      freqValue: data.freqValue.present ? data.freqValue.value : this.freqValue,
      freqDisplayValue: data.freqDisplayValue.present
          ? data.freqDisplayValue.value
          : this.freqDisplayValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiMetaBankV3TableData(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('typeId: $typeId, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplayValue: $freqDisplayValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dictId, kanjiId, typeId, freqValue, freqDisplayValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiMetaBankV3TableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kanjiId == this.kanjiId &&
          other.typeId == this.typeId &&
          other.freqValue == this.freqValue &&
          other.freqDisplayValue == this.freqDisplayValue);
}

class KanjiMetaBankV3TableCompanion
    extends UpdateCompanion<KanjiMetaBankV3TableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<String> kanjiId;
  final Value<int> typeId;
  final Value<int?> freqValue;
  final Value<String?> freqDisplayValue;
  const KanjiMetaBankV3TableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kanjiId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.freqValue = const Value.absent(),
    this.freqDisplayValue = const Value.absent(),
  });
  KanjiMetaBankV3TableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required String kanjiId,
    required int typeId,
    this.freqValue = const Value.absent(),
    this.freqDisplayValue = const Value.absent(),
  })  : dictId = Value(dictId),
        kanjiId = Value(kanjiId),
        typeId = Value(typeId);
  static Insertable<KanjiMetaBankV3TableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<String>? kanjiId,
    Expression<int>? typeId,
    Expression<int>? freqValue,
    Expression<String>? freqDisplayValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kanjiId != null) 'kanji_id': kanjiId,
      if (typeId != null) 'type_id': typeId,
      if (freqValue != null) 'freq_value': freqValue,
      if (freqDisplayValue != null) 'freq_display_value': freqDisplayValue,
    });
  }

  KanjiMetaBankV3TableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<String>? kanjiId,
      Value<int>? typeId,
      Value<int?>? freqValue,
      Value<String?>? freqDisplayValue}) {
    return KanjiMetaBankV3TableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
      kanjiId: kanjiId ?? this.kanjiId,
      typeId: typeId ?? this.typeId,
      freqValue: freqValue ?? this.freqValue,
      freqDisplayValue: freqDisplayValue ?? this.freqDisplayValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
    }
    if (kanjiId.present) {
      map['kanji_id'] = Variable<String>(kanjiId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (freqValue.present) {
      map['freq_value'] = Variable<int>(freqValue.value);
    }
    if (freqDisplayValue.present) {
      map['freq_display_value'] = Variable<String>(freqDisplayValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiMetaBankV3TableCompanion(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('kanjiId: $kanjiId, ')
          ..write('typeId: $typeId, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplayValue: $freqDisplayValue')
          ..write(')'))
        .toString();
  }
}

class $TermMetaBankV3TypeTableTable extends TermMetaBankV3TypeTable
    with TableInfo<$TermMetaBankV3TypeTableTable, TermMetaBankV3TypeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaBankV3TypeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type =
      GeneratedColumn<String>('type', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_bank_v3_type_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TermMetaBankV3TypeTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermMetaBankV3TypeTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaBankV3TypeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $TermMetaBankV3TypeTableTable createAlias(String alias) {
    return $TermMetaBankV3TypeTableTable(attachedDatabase, alias);
  }
}

class TermMetaBankV3TypeTableData extends DataClass
    implements Insertable<TermMetaBankV3TypeTableData> {
  /// id of this entry
  final int id;

  /// the type of this meta information
  final String type;
  const TermMetaBankV3TypeTableData({required this.id, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    return map;
  }

  TermMetaBankV3TypeTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaBankV3TypeTableCompanion(
      id: Value(id),
      type: Value(type),
    );
  }

  factory TermMetaBankV3TypeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaBankV3TypeTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
    };
  }

  TermMetaBankV3TypeTableData copyWith({int? id, String? type}) =>
      TermMetaBankV3TypeTableData(
        id: id ?? this.id,
        type: type ?? this.type,
      );
  TermMetaBankV3TypeTableData copyWithCompanion(
      TermMetaBankV3TypeTableCompanion data) {
    return TermMetaBankV3TypeTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3TypeTableData(')
          ..write('id: $id, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaBankV3TypeTableData &&
          other.id == this.id &&
          other.type == this.type);
}

class TermMetaBankV3TypeTableCompanion
    extends UpdateCompanion<TermMetaBankV3TypeTableData> {
  final Value<int> id;
  final Value<String> type;
  const TermMetaBankV3TypeTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
  });
  TermMetaBankV3TypeTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
  }) : type = Value(type);
  static Insertable<TermMetaBankV3TypeTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
    });
  }

  TermMetaBankV3TypeTableCompanion copyWith(
      {Value<int>? id, Value<String>? type}) {
    return TermMetaBankV3TypeTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3TypeTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $TermMetaBankV3TableTable extends TermMetaBankV3Table
    with TableInfo<$TermMetaBankV3TableTable, TermMetaBankV3TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaBankV3TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'term_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _readingMeta =
      const VerificationMeta('reading');
  @override
  late final GeneratedColumn<String> reading =
      GeneratedColumn<String>('reading', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: false);
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
      'type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES term_meta_bank_v3_type_table (id)'));
  static const VerificationMeta _freqValueMeta =
      const VerificationMeta('freqValue');
  @override
  late final GeneratedColumn<int> freqValue = GeneratedColumn<int>(
      'freq_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _freqDisplayValueMeta =
      const VerificationMeta('freqDisplayValue');
  @override
  late final GeneratedColumn<String> freqDisplayValue = GeneratedColumn<String>(
      'freq_display_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, dictId, termId, reading, typeId, freqValue, freqDisplayValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_bank_v3_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TermMetaBankV3TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
    }
    if (data.containsKey('term_id')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['term_id']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(_readingMeta,
          reading.isAcceptableOrUnknown(data['reading']!, _readingMeta));
    }
    if (data.containsKey('type_id')) {
      context.handle(_typeIdMeta,
          typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta));
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('freq_value')) {
      context.handle(_freqValueMeta,
          freqValue.isAcceptableOrUnknown(data['freq_value']!, _freqValueMeta));
    }
    if (data.containsKey('freq_display_value')) {
      context.handle(
          _freqDisplayValueMeta,
          freqDisplayValue.isAcceptableOrUnknown(
              data['freq_display_value']!, _freqDisplayValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermMetaBankV3TableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaBankV3TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
      termId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}term_id'])!,
      reading: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading']),
      typeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_id'])!,
      freqValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}freq_value']),
      freqDisplayValue: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}freq_display_value']),
    );
  }

  @override
  $TermMetaBankV3TableTable createAlias(String alias) {
    return $TermMetaBankV3TableTable(attachedDatabase, alias);
  }
}

class TermMetaBankV3TableData extends DataClass
    implements Insertable<TermMetaBankV3TableData> {
  /// id of this entry
  final int id;

  /// id of the dictionary this entry belongs to
  final int dictId;

  /// TODO link to term table
  /// the term
  final int termId;

  /// the reading of this term
  final String? reading;

  /// the id of this term's type entry
  final int typeId;

  /// the value of this entry
  final int? freqValue;

  /// the display value of this entry
  final String? freqDisplayValue;
  const TermMetaBankV3TableData(
      {required this.id,
      required this.dictId,
      required this.termId,
      this.reading,
      required this.typeId,
      this.freqValue,
      this.freqDisplayValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['term_id'] = Variable<int>(termId);
    if (!nullToAbsent || reading != null) {
      map['reading'] = Variable<String>(reading);
    }
    map['type_id'] = Variable<int>(typeId);
    if (!nullToAbsent || freqValue != null) {
      map['freq_value'] = Variable<int>(freqValue);
    }
    if (!nullToAbsent || freqDisplayValue != null) {
      map['freq_display_value'] = Variable<String>(freqDisplayValue);
    }
    return map;
  }

  TermMetaBankV3TableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaBankV3TableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      termId: Value(termId),
      reading: reading == null && nullToAbsent
          ? const Value.absent()
          : Value(reading),
      typeId: Value(typeId),
      freqValue: freqValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqValue),
      freqDisplayValue: freqDisplayValue == null && nullToAbsent
          ? const Value.absent()
          : Value(freqDisplayValue),
    );
  }

  factory TermMetaBankV3TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaBankV3TableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      termId: serializer.fromJson<int>(json['termId']),
      reading: serializer.fromJson<String?>(json['reading']),
      typeId: serializer.fromJson<int>(json['typeId']),
      freqValue: serializer.fromJson<int?>(json['freqValue']),
      freqDisplayValue: serializer.fromJson<String?>(json['freqDisplayValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'termId': serializer.toJson<int>(termId),
      'reading': serializer.toJson<String?>(reading),
      'typeId': serializer.toJson<int>(typeId),
      'freqValue': serializer.toJson<int?>(freqValue),
      'freqDisplayValue': serializer.toJson<String?>(freqDisplayValue),
    };
  }

  TermMetaBankV3TableData copyWith(
          {int? id,
          int? dictId,
          int? termId,
          Value<String?> reading = const Value.absent(),
          int? typeId,
          Value<int?> freqValue = const Value.absent(),
          Value<String?> freqDisplayValue = const Value.absent()}) =>
      TermMetaBankV3TableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        termId: termId ?? this.termId,
        reading: reading.present ? reading.value : this.reading,
        typeId: typeId ?? this.typeId,
        freqValue: freqValue.present ? freqValue.value : this.freqValue,
        freqDisplayValue: freqDisplayValue.present
            ? freqDisplayValue.value
            : this.freqDisplayValue,
      );
  TermMetaBankV3TableData copyWithCompanion(TermMetaBankV3TableCompanion data) {
    return TermMetaBankV3TableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
      termId: data.termId.present ? data.termId.value : this.termId,
      reading: data.reading.present ? data.reading.value : this.reading,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      freqValue: data.freqValue.present ? data.freqValue.value : this.freqValue,
      freqDisplayValue: data.freqDisplayValue.present
          ? data.freqDisplayValue.value
          : this.freqDisplayValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3TableData(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('termId: $termId, ')
          ..write('reading: $reading, ')
          ..write('typeId: $typeId, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplayValue: $freqDisplayValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, dictId, termId, reading, typeId, freqValue, freqDisplayValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaBankV3TableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.termId == this.termId &&
          other.reading == this.reading &&
          other.typeId == this.typeId &&
          other.freqValue == this.freqValue &&
          other.freqDisplayValue == this.freqDisplayValue);
}

class TermMetaBankV3TableCompanion
    extends UpdateCompanion<TermMetaBankV3TableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> termId;
  final Value<String?> reading;
  final Value<int> typeId;
  final Value<int?> freqValue;
  final Value<String?> freqDisplayValue;
  const TermMetaBankV3TableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.termId = const Value.absent(),
    this.reading = const Value.absent(),
    this.typeId = const Value.absent(),
    this.freqValue = const Value.absent(),
    this.freqDisplayValue = const Value.absent(),
  });
  TermMetaBankV3TableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int termId,
    this.reading = const Value.absent(),
    required int typeId,
    this.freqValue = const Value.absent(),
    this.freqDisplayValue = const Value.absent(),
  })  : dictId = Value(dictId),
        termId = Value(termId),
        typeId = Value(typeId);
  static Insertable<TermMetaBankV3TableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? termId,
    Expression<String>? reading,
    Expression<int>? typeId,
    Expression<int>? freqValue,
    Expression<String>? freqDisplayValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (termId != null) 'term_id': termId,
      if (reading != null) 'reading': reading,
      if (typeId != null) 'type_id': typeId,
      if (freqValue != null) 'freq_value': freqValue,
      if (freqDisplayValue != null) 'freq_display_value': freqDisplayValue,
    });
  }

  TermMetaBankV3TableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? termId,
      Value<String?>? reading,
      Value<int>? typeId,
      Value<int?>? freqValue,
      Value<String?>? freqDisplayValue}) {
    return TermMetaBankV3TableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
      termId: termId ?? this.termId,
      reading: reading ?? this.reading,
      typeId: typeId ?? this.typeId,
      freqValue: freqValue ?? this.freqValue,
      freqDisplayValue: freqDisplayValue ?? this.freqDisplayValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
    }
    if (termId.present) {
      map['term_id'] = Variable<int>(termId.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (freqValue.present) {
      map['freq_value'] = Variable<int>(freqValue.value);
    }
    if (freqDisplayValue.present) {
      map['freq_display_value'] = Variable<String>(freqDisplayValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3TableCompanion(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('termId: $termId, ')
          ..write('reading: $reading, ')
          ..write('typeId: $typeId, ')
          ..write('freqValue: $freqValue, ')
          ..write('freqDisplayValue: $freqDisplayValue')
          ..write(')'))
        .toString();
  }
}

class $TermMetaBankV3PitchTableTable extends TermMetaBankV3PitchTable
    with
        TableInfo<$TermMetaBankV3PitchTableTable,
            TermMetaBankV3PitchTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaBankV3PitchTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nasalMeta = const VerificationMeta('nasal');
  @override
  late final GeneratedColumn<int> nasal = GeneratedColumn<int>(
      'nasal', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _devoiceMeta =
      const VerificationMeta('devoice');
  @override
  late final GeneratedColumn<int> devoice = GeneratedColumn<int>(
      'devoice', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, position, tagId, nasal, devoice];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_bank_v3_pitch_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TermMetaBankV3PitchTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    }
    if (data.containsKey('nasal')) {
      context.handle(
          _nasalMeta, nasal.isAcceptableOrUnknown(data['nasal']!, _nasalMeta));
    }
    if (data.containsKey('devoice')) {
      context.handle(_devoiceMeta,
          devoice.isAcceptableOrUnknown(data['devoice']!, _devoiceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermMetaBankV3PitchTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaBankV3PitchTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id']),
      nasal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nasal']),
      devoice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}devoice']),
    );
  }

  @override
  $TermMetaBankV3PitchTableTable createAlias(String alias) {
    return $TermMetaBankV3PitchTableTable(attachedDatabase, alias);
  }
}

class TermMetaBankV3PitchTableData extends DataClass
    implements Insertable<TermMetaBankV3PitchTableData> {
  /// id of this entry
  final int id;

  /// The position of the pitch accent
  final int position;

  /// TODO link to tag table
  /// the tag of this pitch entry
  final int? tagId;

  /// the nasal value of this pitch entry
  final int? nasal;

  /// the devoice value of this pitch entry
  final int? devoice;
  const TermMetaBankV3PitchTableData(
      {required this.id,
      required this.position,
      this.tagId,
      this.nasal,
      this.devoice});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int>(tagId);
    }
    if (!nullToAbsent || nasal != null) {
      map['nasal'] = Variable<int>(nasal);
    }
    if (!nullToAbsent || devoice != null) {
      map['devoice'] = Variable<int>(devoice);
    }
    return map;
  }

  TermMetaBankV3PitchTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaBankV3PitchTableCompanion(
      id: Value(id),
      position: Value(position),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      nasal:
          nasal == null && nullToAbsent ? const Value.absent() : Value(nasal),
      devoice: devoice == null && nullToAbsent
          ? const Value.absent()
          : Value(devoice),
    );
  }

  factory TermMetaBankV3PitchTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaBankV3PitchTableData(
      id: serializer.fromJson<int>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      tagId: serializer.fromJson<int?>(json['tagId']),
      nasal: serializer.fromJson<int?>(json['nasal']),
      devoice: serializer.fromJson<int?>(json['devoice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'position': serializer.toJson<int>(position),
      'tagId': serializer.toJson<int?>(tagId),
      'nasal': serializer.toJson<int?>(nasal),
      'devoice': serializer.toJson<int?>(devoice),
    };
  }

  TermMetaBankV3PitchTableData copyWith(
          {int? id,
          int? position,
          Value<int?> tagId = const Value.absent(),
          Value<int?> nasal = const Value.absent(),
          Value<int?> devoice = const Value.absent()}) =>
      TermMetaBankV3PitchTableData(
        id: id ?? this.id,
        position: position ?? this.position,
        tagId: tagId.present ? tagId.value : this.tagId,
        nasal: nasal.present ? nasal.value : this.nasal,
        devoice: devoice.present ? devoice.value : this.devoice,
      );
  TermMetaBankV3PitchTableData copyWithCompanion(
      TermMetaBankV3PitchTableCompanion data) {
    return TermMetaBankV3PitchTableData(
      id: data.id.present ? data.id.value : this.id,
      position: data.position.present ? data.position.value : this.position,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      nasal: data.nasal.present ? data.nasal.value : this.nasal,
      devoice: data.devoice.present ? data.devoice.value : this.devoice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3PitchTableData(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('tagId: $tagId, ')
          ..write('nasal: $nasal, ')
          ..write('devoice: $devoice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, position, tagId, nasal, devoice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaBankV3PitchTableData &&
          other.id == this.id &&
          other.position == this.position &&
          other.tagId == this.tagId &&
          other.nasal == this.nasal &&
          other.devoice == this.devoice);
}

class TermMetaBankV3PitchTableCompanion
    extends UpdateCompanion<TermMetaBankV3PitchTableData> {
  final Value<int> id;
  final Value<int> position;
  final Value<int?> tagId;
  final Value<int?> nasal;
  final Value<int?> devoice;
  const TermMetaBankV3PitchTableCompanion({
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.tagId = const Value.absent(),
    this.nasal = const Value.absent(),
    this.devoice = const Value.absent(),
  });
  TermMetaBankV3PitchTableCompanion.insert({
    this.id = const Value.absent(),
    required int position,
    this.tagId = const Value.absent(),
    this.nasal = const Value.absent(),
    this.devoice = const Value.absent(),
  }) : position = Value(position);
  static Insertable<TermMetaBankV3PitchTableData> custom({
    Expression<int>? id,
    Expression<int>? position,
    Expression<int>? tagId,
    Expression<int>? nasal,
    Expression<int>? devoice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (tagId != null) 'tag_id': tagId,
      if (nasal != null) 'nasal': nasal,
      if (devoice != null) 'devoice': devoice,
    });
  }

  TermMetaBankV3PitchTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? position,
      Value<int?>? tagId,
      Value<int?>? nasal,
      Value<int?>? devoice}) {
    return TermMetaBankV3PitchTableCompanion(
      id: id ?? this.id,
      position: position ?? this.position,
      tagId: tagId ?? this.tagId,
      nasal: nasal ?? this.nasal,
      devoice: devoice ?? this.devoice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (nasal.present) {
      map['nasal'] = Variable<int>(nasal.value);
    }
    if (devoice.present) {
      map['devoice'] = Variable<int>(devoice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3PitchTableCompanion(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('tagId: $tagId, ')
          ..write('nasal: $nasal, ')
          ..write('devoice: $devoice')
          ..write(')'))
        .toString();
  }
}

class $TermMetaBankV3IpaTableTable extends TermMetaBankV3IpaTable
    with TableInfo<$TermMetaBankV3IpaTableTable, TermMetaBankV3IpaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaBankV3IpaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ipaMeta = const VerificationMeta('ipa');
  @override
  late final GeneratedColumn<String> ipa =
      GeneratedColumn<String>('ipa', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ipa];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_bank_v3_ipa_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TermMetaBankV3IpaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ipa')) {
      context.handle(
          _ipaMeta, ipa.isAcceptableOrUnknown(data['ipa']!, _ipaMeta));
    } else if (isInserting) {
      context.missing(_ipaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermMetaBankV3IpaTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaBankV3IpaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ipa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ipa'])!,
    );
  }

  @override
  $TermMetaBankV3IpaTableTable createAlias(String alias) {
    return $TermMetaBankV3IpaTableTable(attachedDatabase, alias);
  }
}

class TermMetaBankV3IpaTableData extends DataClass
    implements Insertable<TermMetaBankV3IpaTableData> {
  /// id of this entry
  final int id;

  /// The ipa transcription
  final String ipa;
  const TermMetaBankV3IpaTableData({required this.id, required this.ipa});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ipa'] = Variable<String>(ipa);
    return map;
  }

  TermMetaBankV3IpaTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaBankV3IpaTableCompanion(
      id: Value(id),
      ipa: Value(ipa),
    );
  }

  factory TermMetaBankV3IpaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaBankV3IpaTableData(
      id: serializer.fromJson<int>(json['id']),
      ipa: serializer.fromJson<String>(json['ipa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ipa': serializer.toJson<String>(ipa),
    };
  }

  TermMetaBankV3IpaTableData copyWith({int? id, String? ipa}) =>
      TermMetaBankV3IpaTableData(
        id: id ?? this.id,
        ipa: ipa ?? this.ipa,
      );
  TermMetaBankV3IpaTableData copyWithCompanion(
      TermMetaBankV3IpaTableCompanion data) {
    return TermMetaBankV3IpaTableData(
      id: data.id.present ? data.id.value : this.id,
      ipa: data.ipa.present ? data.ipa.value : this.ipa,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3IpaTableData(')
          ..write('id: $id, ')
          ..write('ipa: $ipa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ipa);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaBankV3IpaTableData &&
          other.id == this.id &&
          other.ipa == this.ipa);
}

class TermMetaBankV3IpaTableCompanion
    extends UpdateCompanion<TermMetaBankV3IpaTableData> {
  final Value<int> id;
  final Value<String> ipa;
  const TermMetaBankV3IpaTableCompanion({
    this.id = const Value.absent(),
    this.ipa = const Value.absent(),
  });
  TermMetaBankV3IpaTableCompanion.insert({
    this.id = const Value.absent(),
    required String ipa,
  }) : ipa = Value(ipa);
  static Insertable<TermMetaBankV3IpaTableData> custom({
    Expression<int>? id,
    Expression<String>? ipa,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ipa != null) 'ipa': ipa,
    });
  }

  TermMetaBankV3IpaTableCompanion copyWith(
      {Value<int>? id, Value<String>? ipa}) {
    return TermMetaBankV3IpaTableCompanion(
      id: id ?? this.id,
      ipa: ipa ?? this.ipa,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ipa.present) {
      map['ipa'] = Variable<String>(ipa.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3IpaTableCompanion(')
          ..write('id: $id, ')
          ..write('ipa: $ipa')
          ..write(')'))
        .toString();
  }
}

class $TermMetaBankV3IpaTagTableTable extends TermMetaBankV3IpaTagTable
    with
        TableInfo<$TermMetaBankV3IpaTagTableTable,
            TermMetaBankV3IpaTagTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermMetaBankV3IpaTagTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag =
      GeneratedColumn<String>('tag', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'term_meta_bank_v3_ipa_tag_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TermMetaBankV3IpaTagTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermMetaBankV3IpaTagTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermMetaBankV3IpaTagTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $TermMetaBankV3IpaTagTableTable createAlias(String alias) {
    return $TermMetaBankV3IpaTagTableTable(attachedDatabase, alias);
  }
}

class TermMetaBankV3IpaTagTableData extends DataClass
    implements Insertable<TermMetaBankV3IpaTagTableData> {
  /// id of this entry
  final int id;

  /// The ipa tag
  final String tag;
  const TermMetaBankV3IpaTagTableData({required this.id, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  TermMetaBankV3IpaTagTableCompanion toCompanion(bool nullToAbsent) {
    return TermMetaBankV3IpaTagTableCompanion(
      id: Value(id),
      tag: Value(tag),
    );
  }

  factory TermMetaBankV3IpaTagTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermMetaBankV3IpaTagTableData(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String>(tag),
    };
  }

  TermMetaBankV3IpaTagTableData copyWith({int? id, String? tag}) =>
      TermMetaBankV3IpaTagTableData(
        id: id ?? this.id,
        tag: tag ?? this.tag,
      );
  TermMetaBankV3IpaTagTableData copyWithCompanion(
      TermMetaBankV3IpaTagTableCompanion data) {
    return TermMetaBankV3IpaTagTableData(
      id: data.id.present ? data.id.value : this.id,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3IpaTagTableData(')
          ..write('id: $id, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermMetaBankV3IpaTagTableData &&
          other.id == this.id &&
          other.tag == this.tag);
}

class TermMetaBankV3IpaTagTableCompanion
    extends UpdateCompanion<TermMetaBankV3IpaTagTableData> {
  final Value<int> id;
  final Value<String> tag;
  const TermMetaBankV3IpaTagTableCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
  });
  TermMetaBankV3IpaTagTableCompanion.insert({
    this.id = const Value.absent(),
    required String tag,
  }) : tag = Value(tag);
  static Insertable<TermMetaBankV3IpaTagTableData> custom({
    Expression<int>? id,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
    });
  }

  TermMetaBankV3IpaTagTableCompanion copyWith(
      {Value<int>? id, Value<String>? tag}) {
    return TermMetaBankV3IpaTagTableCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermMetaBankV3IpaTagTableCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

abstract class _$DaKanjiDB extends GeneratedDatabase {
  _$DaKanjiDB(QueryExecutor e) : super(e);
  $DaKanjiDBManager get managers => $DaKanjiDBManager(this);
  late final $KanjiTableTable kanjiTable = $KanjiTableTable(this);
  late final $TermTableTable termTable = $TermTableTable(this);
  late final $ReadingTableTable readingTable = $ReadingTableTable(this);
  late final $RadicalsKanjiTableTable radicalsKanjiTable =
      $RadicalsKanjiTableTable(this);
  late final $RadicalsTableTable radicalsTable = $RadicalsTableTable(this);
  late final $RadicalKanjiRelationsTableTable radicalKanjiRelationsTable =
      $RadicalKanjiRelationsTableTable(this);
  late final $KanjiVGTableTable kanjiVGTable = $KanjiVGTableTable(this);
  late final $IndexTableTable indexTable = $IndexTableTable(this);
  late final $TagBankV3TableTable tagBankV3Table = $TagBankV3TableTable(this);
  late final $TagBankV3CategoryTableTable tagBankV3CategoryTable =
      $TagBankV3CategoryTableTable(this);
  late final $TagBankV3TagCategoryRelationsTableTable
      tagBankV3TagCategoryRelationsTable =
      $TagBankV3TagCategoryRelationsTableTable(this);
  late final $KanjiBankV3TableTable kanjiBankV3Table =
      $KanjiBankV3TableTable(this);
  late final $KanjiBankV3OnyomisTableTable kanjiBankV3OnyomisTable =
      $KanjiBankV3OnyomisTableTable(this);
  late final $KanjiBankV3OnyomiKanjiRelationsTableTable
      kanjiBankV3OnyomiKanjiRelationsTable =
      $KanjiBankV3OnyomiKanjiRelationsTableTable(this);
  late final $KanjiBankV3KunyomisTableTable kanjiBankV3KunyomisTable =
      $KanjiBankV3KunyomisTableTable(this);
  late final $KanjiBankV3KunyomiKanjiRelationsTableTable
      kanjiBankV3KunyomiKanjiRelationsTable =
      $KanjiBankV3KunyomiKanjiRelationsTableTable(this);
  late final $KanjiBankV3TagsKanjiRelationsTableTable
      kanjiBankV3TagsKanjiRelationsTable =
      $KanjiBankV3TagsKanjiRelationsTableTable(this);
  late final $KanjiBankV3MeaningsTableTable kanjiBankV3MeaningsTable =
      $KanjiBankV3MeaningsTableTable(this);
  late final $KanjiBankV3MeaningsKanjiRelationsTableTable
      kanjiBankV3MeaningsKanjiRelationsTable =
      $KanjiBankV3MeaningsKanjiRelationsTableTable(this);
  late final $KanjiBankV3StatNamesTableTable kanjiBankV3StatNamesTable =
      $KanjiBankV3StatNamesTableTable(this);
  late final $KanjiBankV3StatValuesTableTable kanjiBankV3StatValuesTable =
      $KanjiBankV3StatValuesTableTable(this);
  late final $KanjiBankV3StatsTableTable kanjiBankV3StatsTable =
      $KanjiBankV3StatsTableTable(this);
  late final $KanjiBankV3StatKanjiRelationsTableTable
      kanjiBankV3StatKanjiRelationsTable =
      $KanjiBankV3StatKanjiRelationsTableTable(this);
  late final $KanjiMetaBankV3TypeTableTable kanjiMetaBankV3TypeTable =
      $KanjiMetaBankV3TypeTableTable(this);
  late final $KanjiMetaBankV3TableTable kanjiMetaBankV3Table =
      $KanjiMetaBankV3TableTable(this);
  late final $TermMetaBankV3TypeTableTable termMetaBankV3TypeTable =
      $TermMetaBankV3TypeTableTable(this);
  late final $TermMetaBankV3TableTable termMetaBankV3Table =
      $TermMetaBankV3TableTable(this);
  late final $TermMetaBankV3PitchTableTable termMetaBankV3PitchTable =
      $TermMetaBankV3PitchTableTable(this);
  late final $TermMetaBankV3IpaTableTable termMetaBankV3IpaTable =
      $TermMetaBankV3IpaTableTable(this);
  late final $TermMetaBankV3IpaTagTableTable termMetaBankV3IpaTagTable =
      $TermMetaBankV3IpaTagTableTable(this);
  late final Index kanji =
      Index('kanji', 'CREATE INDEX kanji ON kanji_table (kanji)');
  late final Index term =
      Index('term', 'CREATE INDEX term ON term_table (term)');
  late final Index reading =
      Index('reading', 'CREATE INDEX reading ON reading_table (reading)');
  late final Index radical =
      Index('radical', 'CREATE INDEX radical ON radicals_table (radical)');
  late final Index name =
      Index('name', 'CREATE INDEX name ON tag_bank_v3_table (name)');
  late final KanjiDao kanjiDao = KanjiDao(this as DaKanjiDB);
  late final TermDao termDao = TermDao(this as DaKanjiDB);
  late final ReadingDao readingDao = ReadingDao(this as DaKanjiDB);
  late final RadicalDao radicalDao = RadicalDao(this as DaKanjiDB);
  late final KanjiVGDao kanjiVGDao = KanjiVGDao(this as DaKanjiDB);
  late final IndexDao indexDao = IndexDao(this as DaKanjiDB);
  late final TagBankV3Dao tagBankV3Dao = TagBankV3Dao(this as DaKanjiDB);
  late final KanjiBankV3Dao kanjiBankV3Dao = KanjiBankV3Dao(this as DaKanjiDB);
  late final KanjiMetaBankV3Dao kanjiMetaBankV3Dao =
      KanjiMetaBankV3Dao(this as DaKanjiDB);
  late final TermMetaBankV3Dao termMetaBankV3Dao =
      TermMetaBankV3Dao(this as DaKanjiDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        kanjiTable,
        termTable,
        readingTable,
        radicalsKanjiTable,
        radicalsTable,
        radicalKanjiRelationsTable,
        kanjiVGTable,
        indexTable,
        tagBankV3Table,
        tagBankV3CategoryTable,
        tagBankV3TagCategoryRelationsTable,
        kanjiBankV3Table,
        kanjiBankV3OnyomisTable,
        kanjiBankV3OnyomiKanjiRelationsTable,
        kanjiBankV3KunyomisTable,
        kanjiBankV3KunyomiKanjiRelationsTable,
        kanjiBankV3TagsKanjiRelationsTable,
        kanjiBankV3MeaningsTable,
        kanjiBankV3MeaningsKanjiRelationsTable,
        kanjiBankV3StatNamesTable,
        kanjiBankV3StatValuesTable,
        kanjiBankV3StatsTable,
        kanjiBankV3StatKanjiRelationsTable,
        kanjiMetaBankV3TypeTable,
        kanjiMetaBankV3Table,
        termMetaBankV3TypeTable,
        termMetaBankV3Table,
        termMetaBankV3PitchTable,
        termMetaBankV3IpaTable,
        termMetaBankV3IpaTagTable,
        kanji,
        term,
        reading,
        radical,
        name
      ];
}

typedef $$KanjiTableTableCreateCompanionBuilder = KanjiTableCompanion Function({
  Value<int> id,
  required String kanji,
});
typedef $$KanjiTableTableUpdateCompanionBuilder = KanjiTableCompanion Function({
  Value<int> id,
  Value<String> kanji,
});

final class $$KanjiTableTableReferences
    extends BaseReferences<_$DaKanjiDB, $KanjiTableTable, KanjiTableData> {
  $$KanjiTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RadicalsKanjiTableTable,
      List<RadicalsKanjiTableData>> _radicalsKanjiTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.radicalsKanjiTable,
          aliasName: $_aliasNameGenerator(
              db.kanjiTable.id, db.radicalsKanjiTable.kanjiId));

  $$RadicalsKanjiTableTableProcessedTableManager get radicalsKanjiTableRefs {
    final manager =
        $$RadicalsKanjiTableTableTableManager($_db, $_db.radicalsKanjiTable)
            .filter((f) => f.kanjiId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_radicalsKanjiTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiVGTableTable, List<KanjiVGTableData>>
      _kanjiVGTableRefsTable(_$DaKanjiDB db) => MultiTypedResultKey.fromTable(
          db.kanjiVGTable,
          aliasName:
              $_aliasNameGenerator(db.kanjiTable.id, db.kanjiVGTable.kanjiId));

  $$KanjiVGTableTableProcessedTableManager get kanjiVGTableRefs {
    final manager = $$KanjiVGTableTableTableManager($_db, $_db.kanjiVGTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_kanjiVGTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3TableTable, List<KanjiBankV3TableData>>
      _kanjiBankV3TableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3Table,
              aliasName: $_aliasNameGenerator(
                  db.kanjiTable.id, db.kanjiBankV3Table.kanjiId));

  $$KanjiBankV3TableTableProcessedTableManager get kanjiBankV3TableRefs {
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.kanjiId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3TableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiTableTable> {
  $$KanjiTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kanji => $composableBuilder(
      column: $table.kanji, builder: (column) => ColumnFilters(column));

  Expression<bool> radicalsKanjiTableRefs(
      Expression<bool> Function($$RadicalsKanjiTableTableFilterComposer f) f) {
    final $$RadicalsKanjiTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.radicalsKanjiTable,
        getReferencedColumn: (t) => t.kanjiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RadicalsKanjiTableTableFilterComposer(
              $db: $db,
              $table: $db.radicalsKanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> kanjiVGTableRefs(
      Expression<bool> Function($$KanjiVGTableTableFilterComposer f) f) {
    final $$KanjiVGTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiVGTable,
        getReferencedColumn: (t) => t.kanjiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiVGTableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiVGTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3TableRefs(
      Expression<bool> Function($$KanjiBankV3TableTableFilterComposer f) f) {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.kanjiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KanjiTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiTableTable> {
  $$KanjiTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kanji => $composableBuilder(
      column: $table.kanji, builder: (column) => ColumnOrderings(column));
}

class $$KanjiTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiTableTable> {
  $$KanjiTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  Expression<T> radicalsKanjiTableRefs<T extends Object>(
      Expression<T> Function($$RadicalsKanjiTableTableAnnotationComposer a) f) {
    final $$RadicalsKanjiTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.radicalsKanjiTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RadicalsKanjiTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.radicalsKanjiTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiVGTableRefs<T extends Object>(
      Expression<T> Function($$KanjiVGTableTableAnnotationComposer a) f) {
    final $$KanjiVGTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiVGTable,
        getReferencedColumn: (t) => t.kanjiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiVGTableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiVGTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> kanjiBankV3TableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3TableTableAnnotationComposer a) f) {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.kanjiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KanjiTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiTableTable,
    KanjiTableData,
    $$KanjiTableTableFilterComposer,
    $$KanjiTableTableOrderingComposer,
    $$KanjiTableTableAnnotationComposer,
    $$KanjiTableTableCreateCompanionBuilder,
    $$KanjiTableTableUpdateCompanionBuilder,
    (KanjiTableData, $$KanjiTableTableReferences),
    KanjiTableData,
    PrefetchHooks Function(
        {bool radicalsKanjiTableRefs,
        bool kanjiVGTableRefs,
        bool kanjiBankV3TableRefs})> {
  $$KanjiTableTableTableManager(_$DaKanjiDB db, $KanjiTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> kanji = const Value.absent(),
          }) =>
              KanjiTableCompanion(
            id: id,
            kanji: kanji,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String kanji,
          }) =>
              KanjiTableCompanion.insert(
            id: id,
            kanji: kanji,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {radicalsKanjiTableRefs = false,
              kanjiVGTableRefs = false,
              kanjiBankV3TableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (radicalsKanjiTableRefs) db.radicalsKanjiTable,
                if (kanjiVGTableRefs) db.kanjiVGTable,
                if (kanjiBankV3TableRefs) db.kanjiBankV3Table
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (radicalsKanjiTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiTableTableReferences
                            ._radicalsKanjiTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiTableTableReferences(db, table, p0)
                                .radicalsKanjiTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items),
                  if (kanjiVGTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiTableTableReferences
                            ._kanjiVGTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiTableTableReferences(db, table, p0)
                                .kanjiVGTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items),
                  if (kanjiBankV3TableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiTableTableReferences
                            ._kanjiBankV3TableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiTableTableReferences(db, table, p0)
                                .kanjiBankV3TableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $KanjiTableTable,
    KanjiTableData,
    $$KanjiTableTableFilterComposer,
    $$KanjiTableTableOrderingComposer,
    $$KanjiTableTableAnnotationComposer,
    $$KanjiTableTableCreateCompanionBuilder,
    $$KanjiTableTableUpdateCompanionBuilder,
    (KanjiTableData, $$KanjiTableTableReferences),
    KanjiTableData,
    PrefetchHooks Function(
        {bool radicalsKanjiTableRefs,
        bool kanjiVGTableRefs,
        bool kanjiBankV3TableRefs})>;
typedef $$TermTableTableCreateCompanionBuilder = TermTableCompanion Function({
  Value<int> id,
  required String term,
});
typedef $$TermTableTableUpdateCompanionBuilder = TermTableCompanion Function({
  Value<int> id,
  Value<String> term,
});

class $$TermTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TermTableTable> {
  $$TermTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => ColumnFilters(column));
}

class $$TermTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TermTableTable> {
  $$TermTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => ColumnOrderings(column));
}

class $$TermTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TermTableTable> {
  $$TermTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);
}

class $$TermTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TermTableTable,
    TermTableData,
    $$TermTableTableFilterComposer,
    $$TermTableTableOrderingComposer,
    $$TermTableTableAnnotationComposer,
    $$TermTableTableCreateCompanionBuilder,
    $$TermTableTableUpdateCompanionBuilder,
    (
      TermTableData,
      BaseReferences<_$DaKanjiDB, $TermTableTable, TermTableData>
    ),
    TermTableData,
    PrefetchHooks Function()> {
  $$TermTableTableTableManager(_$DaKanjiDB db, $TermTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> term = const Value.absent(),
          }) =>
              TermTableCompanion(
            id: id,
            term: term,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String term,
          }) =>
              TermTableCompanion.insert(
            id: id,
            term: term,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TermTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $TermTableTable,
    TermTableData,
    $$TermTableTableFilterComposer,
    $$TermTableTableOrderingComposer,
    $$TermTableTableAnnotationComposer,
    $$TermTableTableCreateCompanionBuilder,
    $$TermTableTableUpdateCompanionBuilder,
    (
      TermTableData,
      BaseReferences<_$DaKanjiDB, $TermTableTable, TermTableData>
    ),
    TermTableData,
    PrefetchHooks Function()>;
typedef $$ReadingTableTableCreateCompanionBuilder = ReadingTableCompanion
    Function({
  Value<int> id,
  required String reading,
});
typedef $$ReadingTableTableUpdateCompanionBuilder = ReadingTableCompanion
    Function({
  Value<int> id,
  Value<String> reading,
});

class $$ReadingTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $ReadingTableTable> {
  $$ReadingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnFilters(column));
}

class $$ReadingTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $ReadingTableTable> {
  $$ReadingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnOrderings(column));
}

class $$ReadingTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $ReadingTableTable> {
  $$ReadingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);
}

class $$ReadingTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $ReadingTableTable,
    ReadingTableData,
    $$ReadingTableTableFilterComposer,
    $$ReadingTableTableOrderingComposer,
    $$ReadingTableTableAnnotationComposer,
    $$ReadingTableTableCreateCompanionBuilder,
    $$ReadingTableTableUpdateCompanionBuilder,
    (
      ReadingTableData,
      BaseReferences<_$DaKanjiDB, $ReadingTableTable, ReadingTableData>
    ),
    ReadingTableData,
    PrefetchHooks Function()> {
  $$ReadingTableTableTableManager(_$DaKanjiDB db, $ReadingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> reading = const Value.absent(),
          }) =>
              ReadingTableCompanion(
            id: id,
            reading: reading,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String reading,
          }) =>
              ReadingTableCompanion.insert(
            id: id,
            reading: reading,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReadingTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $ReadingTableTable,
    ReadingTableData,
    $$ReadingTableTableFilterComposer,
    $$ReadingTableTableOrderingComposer,
    $$ReadingTableTableAnnotationComposer,
    $$ReadingTableTableCreateCompanionBuilder,
    $$ReadingTableTableUpdateCompanionBuilder,
    (
      ReadingTableData,
      BaseReferences<_$DaKanjiDB, $ReadingTableTable, ReadingTableData>
    ),
    ReadingTableData,
    PrefetchHooks Function()>;
typedef $$RadicalsKanjiTableTableCreateCompanionBuilder
    = RadicalsKanjiTableCompanion Function({
  Value<int> id,
  required int kanjiId,
});
typedef $$RadicalsKanjiTableTableUpdateCompanionBuilder
    = RadicalsKanjiTableCompanion Function({
  Value<int> id,
  Value<int> kanjiId,
});

final class $$RadicalsKanjiTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $RadicalsKanjiTableTable, RadicalsKanjiTableData> {
  $$RadicalsKanjiTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiTableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiTable.createAlias($_aliasNameGenerator(
          db.radicalsKanjiTable.kanjiId, db.kanjiTable.id));

  $$KanjiTableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager = $$KanjiTableTableTableManager($_db, $_db.kanjiTable)
        .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RadicalKanjiRelationsTableTable,
          List<RadicalKanjiRelationsTableData>>
      _radicalKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.radicalKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.radicalsKanjiTable.id,
                  db.radicalKanjiRelationsTable.kanjiId));

  $$RadicalKanjiRelationsTableTableProcessedTableManager
      get radicalKanjiRelationsTableRefs {
    final manager = $$RadicalKanjiRelationsTableTableTableManager(
            $_db, $_db.radicalKanjiRelationsTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_radicalKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RadicalsKanjiTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $RadicalsKanjiTableTable> {
  $$RadicalsKanjiTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiTableTableFilterComposer get kanjiId {
    final $$KanjiTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> radicalKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$RadicalKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$RadicalKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.radicalKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RadicalKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.radicalKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RadicalsKanjiTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $RadicalsKanjiTableTable> {
  $$RadicalsKanjiTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiTableTableOrderingComposer get kanjiId {
    final $$KanjiTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RadicalsKanjiTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $RadicalsKanjiTableTable> {
  $$RadicalsKanjiTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiTableTableAnnotationComposer get kanjiId {
    final $$KanjiTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> radicalKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$RadicalKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$RadicalKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.radicalKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RadicalKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.radicalKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RadicalsKanjiTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $RadicalsKanjiTableTable,
    RadicalsKanjiTableData,
    $$RadicalsKanjiTableTableFilterComposer,
    $$RadicalsKanjiTableTableOrderingComposer,
    $$RadicalsKanjiTableTableAnnotationComposer,
    $$RadicalsKanjiTableTableCreateCompanionBuilder,
    $$RadicalsKanjiTableTableUpdateCompanionBuilder,
    (RadicalsKanjiTableData, $$RadicalsKanjiTableTableReferences),
    RadicalsKanjiTableData,
    PrefetchHooks Function(
        {bool kanjiId, bool radicalKanjiRelationsTableRefs})> {
  $$RadicalsKanjiTableTableTableManager(
      _$DaKanjiDB db, $RadicalsKanjiTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RadicalsKanjiTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RadicalsKanjiTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RadicalsKanjiTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              RadicalsKanjiTableCompanion(
            id: id,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiId,
          }) =>
              RadicalsKanjiTableCompanion.insert(
            id: id,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RadicalsKanjiTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {kanjiId = false, radicalKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (radicalKanjiRelationsTableRefs)
                  db.radicalKanjiRelationsTable
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$RadicalsKanjiTableTableReferences._kanjiIdTable(db),
                    referencedColumn: $$RadicalsKanjiTableTableReferences
                        ._kanjiIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (radicalKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RadicalsKanjiTableTableReferences
                            ._radicalKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RadicalsKanjiTableTableReferences(db, table, p0)
                                .radicalKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RadicalsKanjiTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $RadicalsKanjiTableTable,
    RadicalsKanjiTableData,
    $$RadicalsKanjiTableTableFilterComposer,
    $$RadicalsKanjiTableTableOrderingComposer,
    $$RadicalsKanjiTableTableAnnotationComposer,
    $$RadicalsKanjiTableTableCreateCompanionBuilder,
    $$RadicalsKanjiTableTableUpdateCompanionBuilder,
    (RadicalsKanjiTableData, $$RadicalsKanjiTableTableReferences),
    RadicalsKanjiTableData,
    PrefetchHooks Function(
        {bool kanjiId, bool radicalKanjiRelationsTableRefs})>;
typedef $$RadicalsTableTableCreateCompanionBuilder = RadicalsTableCompanion
    Function({
  Value<int> id,
  required String radical,
  required int strokeCount,
});
typedef $$RadicalsTableTableUpdateCompanionBuilder = RadicalsTableCompanion
    Function({
  Value<int> id,
  Value<String> radical,
  Value<int> strokeCount,
});

final class $$RadicalsTableTableReferences extends BaseReferences<_$DaKanjiDB,
    $RadicalsTableTable, RadicalsTableData> {
  $$RadicalsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RadicalKanjiRelationsTableTable,
          List<RadicalKanjiRelationsTableData>>
      _radicalKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.radicalKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.radicalsTable.id,
                  db.radicalKanjiRelationsTable.radicalId));

  $$RadicalKanjiRelationsTableTableProcessedTableManager
      get radicalKanjiRelationsTableRefs {
    final manager = $$RadicalKanjiRelationsTableTableTableManager(
            $_db, $_db.radicalKanjiRelationsTable)
        .filter((f) => f.radicalId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_radicalKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RadicalsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $RadicalsTableTable> {
  $$RadicalsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get radical => $composableBuilder(
      column: $table.radical, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get strokeCount => $composableBuilder(
      column: $table.strokeCount, builder: (column) => ColumnFilters(column));

  Expression<bool> radicalKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$RadicalKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$RadicalKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.radicalKanjiRelationsTable,
            getReferencedColumn: (t) => t.radicalId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RadicalKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.radicalKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RadicalsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $RadicalsTableTable> {
  $$RadicalsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get radical => $composableBuilder(
      column: $table.radical, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get strokeCount => $composableBuilder(
      column: $table.strokeCount, builder: (column) => ColumnOrderings(column));
}

class $$RadicalsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $RadicalsTableTable> {
  $$RadicalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get radical =>
      $composableBuilder(column: $table.radical, builder: (column) => column);

  GeneratedColumn<int> get strokeCount => $composableBuilder(
      column: $table.strokeCount, builder: (column) => column);

  Expression<T> radicalKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$RadicalKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$RadicalKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.radicalKanjiRelationsTable,
            getReferencedColumn: (t) => t.radicalId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RadicalKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.radicalKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RadicalsTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $RadicalsTableTable,
    RadicalsTableData,
    $$RadicalsTableTableFilterComposer,
    $$RadicalsTableTableOrderingComposer,
    $$RadicalsTableTableAnnotationComposer,
    $$RadicalsTableTableCreateCompanionBuilder,
    $$RadicalsTableTableUpdateCompanionBuilder,
    (RadicalsTableData, $$RadicalsTableTableReferences),
    RadicalsTableData,
    PrefetchHooks Function({bool radicalKanjiRelationsTableRefs})> {
  $$RadicalsTableTableTableManager(_$DaKanjiDB db, $RadicalsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RadicalsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RadicalsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RadicalsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> radical = const Value.absent(),
            Value<int> strokeCount = const Value.absent(),
          }) =>
              RadicalsTableCompanion(
            id: id,
            radical: radical,
            strokeCount: strokeCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String radical,
            required int strokeCount,
          }) =>
              RadicalsTableCompanion.insert(
            id: id,
            radical: radical,
            strokeCount: strokeCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RadicalsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({radicalKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (radicalKanjiRelationsTableRefs)
                  db.radicalKanjiRelationsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (radicalKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RadicalsTableTableReferences
                            ._radicalKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RadicalsTableTableReferences(db, table, p0)
                                .radicalKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.radicalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RadicalsTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $RadicalsTableTable,
    RadicalsTableData,
    $$RadicalsTableTableFilterComposer,
    $$RadicalsTableTableOrderingComposer,
    $$RadicalsTableTableAnnotationComposer,
    $$RadicalsTableTableCreateCompanionBuilder,
    $$RadicalsTableTableUpdateCompanionBuilder,
    (RadicalsTableData, $$RadicalsTableTableReferences),
    RadicalsTableData,
    PrefetchHooks Function({bool radicalKanjiRelationsTableRefs})>;
typedef $$RadicalKanjiRelationsTableTableCreateCompanionBuilder
    = RadicalKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int kanjiId,
  required int radicalId,
});
typedef $$RadicalKanjiRelationsTableTableUpdateCompanionBuilder
    = RadicalKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> kanjiId,
  Value<int> radicalId,
});

final class $$RadicalKanjiRelationsTableTableReferences extends BaseReferences<
    _$DaKanjiDB,
    $RadicalKanjiRelationsTableTable,
    RadicalKanjiRelationsTableData> {
  $$RadicalKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RadicalsKanjiTableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.radicalsKanjiTable.createAlias($_aliasNameGenerator(
          db.radicalKanjiRelationsTable.kanjiId, db.radicalsKanjiTable.id));

  $$RadicalsKanjiTableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager =
        $$RadicalsKanjiTableTableTableManager($_db, $_db.radicalsKanjiTable)
            .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RadicalsTableTable _radicalIdTable(_$DaKanjiDB db) =>
      db.radicalsTable.createAlias($_aliasNameGenerator(
          db.radicalKanjiRelationsTable.radicalId, db.radicalsTable.id));

  $$RadicalsTableTableProcessedTableManager? get radicalId {
    if ($_item.radicalId == null) return null;
    final manager = $$RadicalsTableTableTableManager($_db, $_db.radicalsTable)
        .filter((f) => f.id($_item.radicalId!));
    final item = $_typedResult.readTableOrNull(_radicalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RadicalKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $RadicalKanjiRelationsTableTable> {
  $$RadicalKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$RadicalsKanjiTableTableFilterComposer get kanjiId {
    final $$RadicalsKanjiTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.radicalsKanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RadicalsKanjiTableTableFilterComposer(
              $db: $db,
              $table: $db.radicalsKanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RadicalsTableTableFilterComposer get radicalId {
    final $$RadicalsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.radicalId,
        referencedTable: $db.radicalsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RadicalsTableTableFilterComposer(
              $db: $db,
              $table: $db.radicalsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RadicalKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $RadicalKanjiRelationsTableTable> {
  $$RadicalKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$RadicalsKanjiTableTableOrderingComposer get kanjiId {
    final $$RadicalsKanjiTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.radicalsKanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RadicalsKanjiTableTableOrderingComposer(
              $db: $db,
              $table: $db.radicalsKanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RadicalsTableTableOrderingComposer get radicalId {
    final $$RadicalsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.radicalId,
        referencedTable: $db.radicalsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RadicalsTableTableOrderingComposer(
              $db: $db,
              $table: $db.radicalsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RadicalKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $RadicalKanjiRelationsTableTable> {
  $$RadicalKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$RadicalsKanjiTableTableAnnotationComposer get kanjiId {
    final $$RadicalsKanjiTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.kanjiId,
            referencedTable: $db.radicalsKanjiTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RadicalsKanjiTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.radicalsKanjiTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$RadicalsTableTableAnnotationComposer get radicalId {
    final $$RadicalsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.radicalId,
        referencedTable: $db.radicalsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RadicalsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.radicalsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RadicalKanjiRelationsTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $RadicalKanjiRelationsTableTable,
    RadicalKanjiRelationsTableData,
    $$RadicalKanjiRelationsTableTableFilterComposer,
    $$RadicalKanjiRelationsTableTableOrderingComposer,
    $$RadicalKanjiRelationsTableTableAnnotationComposer,
    $$RadicalKanjiRelationsTableTableCreateCompanionBuilder,
    $$RadicalKanjiRelationsTableTableUpdateCompanionBuilder,
    (
      RadicalKanjiRelationsTableData,
      $$RadicalKanjiRelationsTableTableReferences
    ),
    RadicalKanjiRelationsTableData,
    PrefetchHooks Function({bool kanjiId, bool radicalId})> {
  $$RadicalKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $RadicalKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RadicalKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$RadicalKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RadicalKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
            Value<int> radicalId = const Value.absent(),
          }) =>
              RadicalKanjiRelationsTableCompanion(
            id: id,
            kanjiId: kanjiId,
            radicalId: radicalId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiId,
            required int radicalId,
          }) =>
              RadicalKanjiRelationsTableCompanion.insert(
            id: id,
            kanjiId: kanjiId,
            radicalId: radicalId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RadicalKanjiRelationsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiId = false, radicalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable: $$RadicalKanjiRelationsTableTableReferences
                        ._kanjiIdTable(db),
                    referencedColumn:
                        $$RadicalKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db)
                            .id,
                  ) as T;
                }
                if (radicalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.radicalId,
                    referencedTable: $$RadicalKanjiRelationsTableTableReferences
                        ._radicalIdTable(db),
                    referencedColumn:
                        $$RadicalKanjiRelationsTableTableReferences
                            ._radicalIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RadicalKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $RadicalKanjiRelationsTableTable,
        RadicalKanjiRelationsTableData,
        $$RadicalKanjiRelationsTableTableFilterComposer,
        $$RadicalKanjiRelationsTableTableOrderingComposer,
        $$RadicalKanjiRelationsTableTableAnnotationComposer,
        $$RadicalKanjiRelationsTableTableCreateCompanionBuilder,
        $$RadicalKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          RadicalKanjiRelationsTableData,
          $$RadicalKanjiRelationsTableTableReferences
        ),
        RadicalKanjiRelationsTableData,
        PrefetchHooks Function({bool kanjiId, bool radicalId})>;
typedef $$KanjiVGTableTableCreateCompanionBuilder = KanjiVGTableCompanion
    Function({
  Value<int> id,
  required int kanjiId,
  required String kanjiVGSVG,
});
typedef $$KanjiVGTableTableUpdateCompanionBuilder = KanjiVGTableCompanion
    Function({
  Value<int> id,
  Value<int> kanjiId,
  Value<String> kanjiVGSVG,
});

final class $$KanjiVGTableTableReferences
    extends BaseReferences<_$DaKanjiDB, $KanjiVGTableTable, KanjiVGTableData> {
  $$KanjiVGTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KanjiTableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiTable.createAlias(
          $_aliasNameGenerator(db.kanjiVGTable.kanjiId, db.kanjiTable.id));

  $$KanjiTableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager = $$KanjiTableTableTableManager($_db, $_db.kanjiTable)
        .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiVGTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiVGTableTable> {
  $$KanjiVGTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<String, String, Uint8List> get kanjiVGSVG =>
      $composableBuilder(
          column: $table.kanjiVGSVG,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$KanjiTableTableFilterComposer get kanjiId {
    final $$KanjiTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiVGTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiVGTableTable> {
  $$KanjiVGTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get kanjiVGSVG => $composableBuilder(
      column: $table.kanjiVGSVG, builder: (column) => ColumnOrderings(column));

  $$KanjiTableTableOrderingComposer get kanjiId {
    final $$KanjiTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiVGTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiVGTableTable> {
  $$KanjiVGTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<String, Uint8List> get kanjiVGSVG =>
      $composableBuilder(
          column: $table.kanjiVGSVG, builder: (column) => column);

  $$KanjiTableTableAnnotationComposer get kanjiId {
    final $$KanjiTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiVGTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiVGTableTable,
    KanjiVGTableData,
    $$KanjiVGTableTableFilterComposer,
    $$KanjiVGTableTableOrderingComposer,
    $$KanjiVGTableTableAnnotationComposer,
    $$KanjiVGTableTableCreateCompanionBuilder,
    $$KanjiVGTableTableUpdateCompanionBuilder,
    (KanjiVGTableData, $$KanjiVGTableTableReferences),
    KanjiVGTableData,
    PrefetchHooks Function({bool kanjiId})> {
  $$KanjiVGTableTableTableManager(_$DaKanjiDB db, $KanjiVGTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiVGTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiVGTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiVGTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
            Value<String> kanjiVGSVG = const Value.absent(),
          }) =>
              KanjiVGTableCompanion(
            id: id,
            kanjiId: kanjiId,
            kanjiVGSVG: kanjiVGSVG,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiId,
            required String kanjiVGSVG,
          }) =>
              KanjiVGTableCompanion.insert(
            id: id,
            kanjiId: kanjiId,
            kanjiVGSVG: kanjiVGSVG,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiVGTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiVGTableTableReferences._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiVGTableTableReferences._kanjiIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiVGTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $KanjiVGTableTable,
    KanjiVGTableData,
    $$KanjiVGTableTableFilterComposer,
    $$KanjiVGTableTableOrderingComposer,
    $$KanjiVGTableTableAnnotationComposer,
    $$KanjiVGTableTableCreateCompanionBuilder,
    $$KanjiVGTableTableUpdateCompanionBuilder,
    (KanjiVGTableData, $$KanjiVGTableTableReferences),
    KanjiVGTableData,
    PrefetchHooks Function({bool kanjiId})>;
typedef $$IndexTableTableCreateCompanionBuilder = IndexTableCompanion Function({
  Value<int> id,
  required String title,
  required String revision,
  Value<bool?> sequenced,
  Value<int?> format,
  Value<int?> version,
  Value<String?> author,
  Value<bool?> updatable,
  Value<String?> indexUrl,
  Value<String?> downloadUrl,
  Value<String?> url,
  Value<String?> description,
  Value<String?> attribution,
  Value<String?> sourceLanguage,
  Value<String?> targetLanguage,
  Value<String?> frequencyMode,
});
typedef $$IndexTableTableUpdateCompanionBuilder = IndexTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> revision,
  Value<bool?> sequenced,
  Value<int?> format,
  Value<int?> version,
  Value<String?> author,
  Value<bool?> updatable,
  Value<String?> indexUrl,
  Value<String?> downloadUrl,
  Value<String?> url,
  Value<String?> description,
  Value<String?> attribution,
  Value<String?> sourceLanguage,
  Value<String?> targetLanguage,
  Value<String?> frequencyMode,
});

final class $$IndexTableTableReferences
    extends BaseReferences<_$DaKanjiDB, $IndexTableTable, IndexTableData> {
  $$IndexTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3TableTable, List<KanjiBankV3TableData>>
      _kanjiBankV3TableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3Table,
              aliasName: $_aliasNameGenerator(
                  db.indexTable.id, db.kanjiBankV3Table.dictId));

  $$KanjiBankV3TableTableProcessedTableManager get kanjiBankV3TableRefs {
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.dictId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3TableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$IndexTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $IndexTableTable> {
  $$IndexTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get revision => $composableBuilder(
      column: $table.revision, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sequenced => $composableBuilder(
      column: $table.sequenced, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get updatable => $composableBuilder(
      column: $table.updatable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get indexUrl => $composableBuilder(
      column: $table.indexUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attribution => $composableBuilder(
      column: $table.attribution, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceLanguage => $composableBuilder(
      column: $table.sourceLanguage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetLanguage => $composableBuilder(
      column: $table.targetLanguage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequencyMode => $composableBuilder(
      column: $table.frequencyMode, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3TableRefs(
      Expression<bool> Function($$KanjiBankV3TableTableFilterComposer f) f) {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.dictId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$IndexTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $IndexTableTable> {
  $$IndexTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get revision => $composableBuilder(
      column: $table.revision, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sequenced => $composableBuilder(
      column: $table.sequenced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get updatable => $composableBuilder(
      column: $table.updatable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get indexUrl => $composableBuilder(
      column: $table.indexUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attribution => $composableBuilder(
      column: $table.attribution, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceLanguage => $composableBuilder(
      column: $table.sourceLanguage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetLanguage => $composableBuilder(
      column: $table.targetLanguage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequencyMode => $composableBuilder(
      column: $table.frequencyMode,
      builder: (column) => ColumnOrderings(column));
}

class $$IndexTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $IndexTableTable> {
  $$IndexTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<bool> get sequenced =>
      $composableBuilder(column: $table.sequenced, builder: (column) => column);

  GeneratedColumn<int> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<bool> get updatable =>
      $composableBuilder(column: $table.updatable, builder: (column) => column);

  GeneratedColumn<String> get indexUrl =>
      $composableBuilder(column: $table.indexUrl, builder: (column) => column);

  GeneratedColumn<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get attribution => $composableBuilder(
      column: $table.attribution, builder: (column) => column);

  GeneratedColumn<String> get sourceLanguage => $composableBuilder(
      column: $table.sourceLanguage, builder: (column) => column);

  GeneratedColumn<String> get targetLanguage => $composableBuilder(
      column: $table.targetLanguage, builder: (column) => column);

  GeneratedColumn<String> get frequencyMode => $composableBuilder(
      column: $table.frequencyMode, builder: (column) => column);

  Expression<T> kanjiBankV3TableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3TableTableAnnotationComposer a) f) {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.dictId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$IndexTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $IndexTableTable,
    IndexTableData,
    $$IndexTableTableFilterComposer,
    $$IndexTableTableOrderingComposer,
    $$IndexTableTableAnnotationComposer,
    $$IndexTableTableCreateCompanionBuilder,
    $$IndexTableTableUpdateCompanionBuilder,
    (IndexTableData, $$IndexTableTableReferences),
    IndexTableData,
    PrefetchHooks Function({bool kanjiBankV3TableRefs})> {
  $$IndexTableTableTableManager(_$DaKanjiDB db, $IndexTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IndexTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IndexTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IndexTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> revision = const Value.absent(),
            Value<bool?> sequenced = const Value.absent(),
            Value<int?> format = const Value.absent(),
            Value<int?> version = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<bool?> updatable = const Value.absent(),
            Value<String?> indexUrl = const Value.absent(),
            Value<String?> downloadUrl = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> attribution = const Value.absent(),
            Value<String?> sourceLanguage = const Value.absent(),
            Value<String?> targetLanguage = const Value.absent(),
            Value<String?> frequencyMode = const Value.absent(),
          }) =>
              IndexTableCompanion(
            id: id,
            title: title,
            revision: revision,
            sequenced: sequenced,
            format: format,
            version: version,
            author: author,
            updatable: updatable,
            indexUrl: indexUrl,
            downloadUrl: downloadUrl,
            url: url,
            description: description,
            attribution: attribution,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
            frequencyMode: frequencyMode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String revision,
            Value<bool?> sequenced = const Value.absent(),
            Value<int?> format = const Value.absent(),
            Value<int?> version = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<bool?> updatable = const Value.absent(),
            Value<String?> indexUrl = const Value.absent(),
            Value<String?> downloadUrl = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> attribution = const Value.absent(),
            Value<String?> sourceLanguage = const Value.absent(),
            Value<String?> targetLanguage = const Value.absent(),
            Value<String?> frequencyMode = const Value.absent(),
          }) =>
              IndexTableCompanion.insert(
            id: id,
            title: title,
            revision: revision,
            sequenced: sequenced,
            format: format,
            version: version,
            author: author,
            updatable: updatable,
            indexUrl: indexUrl,
            downloadUrl: downloadUrl,
            url: url,
            description: description,
            attribution: attribution,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
            frequencyMode: frequencyMode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IndexTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3TableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3TableRefs) db.kanjiBankV3Table
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3TableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$IndexTableTableReferences
                            ._kanjiBankV3TableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IndexTableTableReferences(db, table, p0)
                                .kanjiBankV3TableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dictId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$IndexTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $IndexTableTable,
    IndexTableData,
    $$IndexTableTableFilterComposer,
    $$IndexTableTableOrderingComposer,
    $$IndexTableTableAnnotationComposer,
    $$IndexTableTableCreateCompanionBuilder,
    $$IndexTableTableUpdateCompanionBuilder,
    (IndexTableData, $$IndexTableTableReferences),
    IndexTableData,
    PrefetchHooks Function({bool kanjiBankV3TableRefs})>;
typedef $$TagBankV3TableTableCreateCompanionBuilder = TagBankV3TableCompanion
    Function({
  Value<int> id,
  required String name,
  required int sortingOrder,
  required String notes,
  required int score,
});
typedef $$TagBankV3TableTableUpdateCompanionBuilder = TagBankV3TableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> sortingOrder,
  Value<String> notes,
  Value<int> score,
});

final class $$TagBankV3TableTableReferences extends BaseReferences<_$DaKanjiDB,
    $TagBankV3TableTable, TagBankV3TableData> {
  $$TagBankV3TableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TagBankV3TagCategoryRelationsTableTable,
          List<TagBankV3TagCategoryRelationsTableData>>
      _tagBankV3TagCategoryRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.tagBankV3TagCategoryRelationsTable,
              aliasName: $_aliasNameGenerator(db.tagBankV3Table.id,
                  db.tagBankV3TagCategoryRelationsTable.tagId));

  $$TagBankV3TagCategoryRelationsTableTableProcessedTableManager
      get tagBankV3TagCategoryRelationsTableRefs {
    final manager = $$TagBankV3TagCategoryRelationsTableTableTableManager(
            $_db, $_db.tagBankV3TagCategoryRelationsTable)
        .filter((f) => f.tagId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_tagBankV3TagCategoryRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3TagsKanjiRelationsTableTable,
          List<KanjiBankV3TagsKanjiRelationsTableData>>
      _kanjiBankV3TagsKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3TagsKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.tagBankV3Table.id,
                  db.kanjiBankV3TagsKanjiRelationsTable.tagId));

  $$KanjiBankV3TagsKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3TagsKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3TagsKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3TagsKanjiRelationsTable)
        .filter((f) => f.tagId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3TagsKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TagBankV3TableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TagBankV3TableTable> {
  $$TagBankV3TableTableFilterComposer({
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

  ColumnFilters<int> get sortingOrder => $composableBuilder(
      column: $table.sortingOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  Expression<bool> tagBankV3TagCategoryRelationsTableRefs(
      Expression<bool> Function(
              $$TagBankV3TagCategoryRelationsTableTableFilterComposer f)
          f) {
    final $$TagBankV3TagCategoryRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.tagBankV3TagCategoryRelationsTable,
            getReferencedColumn: (t) => t.tagId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3TagCategoryRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.tagBankV3TagCategoryRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3TagsKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3TagsKanjiRelationsTable,
            getReferencedColumn: (t) => t.tagId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TagBankV3TableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TagBankV3TableTable> {
  $$TagBankV3TableTableOrderingComposer({
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

  ColumnOrderings<int> get sortingOrder => $composableBuilder(
      column: $table.sortingOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));
}

class $$TagBankV3TableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TagBankV3TableTable> {
  $$TagBankV3TableTableAnnotationComposer({
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

  GeneratedColumn<int> get sortingOrder => $composableBuilder(
      column: $table.sortingOrder, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  Expression<T> tagBankV3TagCategoryRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer a)
          f) {
    final $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.tagBankV3TagCategoryRelationsTable,
            getReferencedColumn: (t) => t.tagId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.tagBankV3TagCategoryRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3TagsKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3TagsKanjiRelationsTable,
            getReferencedColumn: (t) => t.tagId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TagBankV3TableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TagBankV3TableTable,
    TagBankV3TableData,
    $$TagBankV3TableTableFilterComposer,
    $$TagBankV3TableTableOrderingComposer,
    $$TagBankV3TableTableAnnotationComposer,
    $$TagBankV3TableTableCreateCompanionBuilder,
    $$TagBankV3TableTableUpdateCompanionBuilder,
    (TagBankV3TableData, $$TagBankV3TableTableReferences),
    TagBankV3TableData,
    PrefetchHooks Function(
        {bool tagBankV3TagCategoryRelationsTableRefs,
        bool kanjiBankV3TagsKanjiRelationsTableRefs})> {
  $$TagBankV3TableTableTableManager(_$DaKanjiDB db, $TagBankV3TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagBankV3TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagBankV3TableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagBankV3TableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> sortingOrder = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> score = const Value.absent(),
          }) =>
              TagBankV3TableCompanion(
            id: id,
            name: name,
            sortingOrder: sortingOrder,
            notes: notes,
            score: score,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int sortingOrder,
            required String notes,
            required int score,
          }) =>
              TagBankV3TableCompanion.insert(
            id: id,
            name: name,
            sortingOrder: sortingOrder,
            notes: notes,
            score: score,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TagBankV3TableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {tagBankV3TagCategoryRelationsTableRefs = false,
              kanjiBankV3TagsKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tagBankV3TagCategoryRelationsTableRefs)
                  db.tagBankV3TagCategoryRelationsTable,
                if (kanjiBankV3TagsKanjiRelationsTableRefs)
                  db.kanjiBankV3TagsKanjiRelationsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tagBankV3TagCategoryRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TagBankV3TableTableReferences
                            ._tagBankV3TagCategoryRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagBankV3TableTableReferences(db, table, p0)
                                .tagBankV3TagCategoryRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tagId == item.id),
                        typedResults: items),
                  if (kanjiBankV3TagsKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TagBankV3TableTableReferences
                            ._kanjiBankV3TagsKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3TagsKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tagId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TagBankV3TableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $TagBankV3TableTable,
    TagBankV3TableData,
    $$TagBankV3TableTableFilterComposer,
    $$TagBankV3TableTableOrderingComposer,
    $$TagBankV3TableTableAnnotationComposer,
    $$TagBankV3TableTableCreateCompanionBuilder,
    $$TagBankV3TableTableUpdateCompanionBuilder,
    (TagBankV3TableData, $$TagBankV3TableTableReferences),
    TagBankV3TableData,
    PrefetchHooks Function(
        {bool tagBankV3TagCategoryRelationsTableRefs,
        bool kanjiBankV3TagsKanjiRelationsTableRefs})>;
typedef $$TagBankV3CategoryTableTableCreateCompanionBuilder
    = TagBankV3CategoryTableCompanion Function({
  Value<int> id,
  required String category,
});
typedef $$TagBankV3CategoryTableTableUpdateCompanionBuilder
    = TagBankV3CategoryTableCompanion Function({
  Value<int> id,
  Value<String> category,
});

final class $$TagBankV3CategoryTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $TagBankV3CategoryTableTable, TagBankV3CategoryTableData> {
  $$TagBankV3CategoryTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TagBankV3TagCategoryRelationsTableTable,
          List<TagBankV3TagCategoryRelationsTableData>>
      _tagBankV3TagCategoryRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.tagBankV3TagCategoryRelationsTable,
              aliasName: $_aliasNameGenerator(db.tagBankV3CategoryTable.id,
                  db.tagBankV3TagCategoryRelationsTable.categoryId));

  $$TagBankV3TagCategoryRelationsTableTableProcessedTableManager
      get tagBankV3TagCategoryRelationsTableRefs {
    final manager = $$TagBankV3TagCategoryRelationsTableTableTableManager(
            $_db, $_db.tagBankV3TagCategoryRelationsTable)
        .filter((f) => f.categoryId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_tagBankV3TagCategoryRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TagBankV3CategoryTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TagBankV3CategoryTableTable> {
  $$TagBankV3CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  Expression<bool> tagBankV3TagCategoryRelationsTableRefs(
      Expression<bool> Function(
              $$TagBankV3TagCategoryRelationsTableTableFilterComposer f)
          f) {
    final $$TagBankV3TagCategoryRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.tagBankV3TagCategoryRelationsTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3TagCategoryRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.tagBankV3TagCategoryRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TagBankV3CategoryTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TagBankV3CategoryTableTable> {
  $$TagBankV3CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));
}

class $$TagBankV3CategoryTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TagBankV3CategoryTableTable> {
  $$TagBankV3CategoryTableTableAnnotationComposer({
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

  Expression<T> tagBankV3TagCategoryRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer a)
          f) {
    final $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.tagBankV3TagCategoryRelationsTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.tagBankV3TagCategoryRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TagBankV3CategoryTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TagBankV3CategoryTableTable,
    TagBankV3CategoryTableData,
    $$TagBankV3CategoryTableTableFilterComposer,
    $$TagBankV3CategoryTableTableOrderingComposer,
    $$TagBankV3CategoryTableTableAnnotationComposer,
    $$TagBankV3CategoryTableTableCreateCompanionBuilder,
    $$TagBankV3CategoryTableTableUpdateCompanionBuilder,
    (TagBankV3CategoryTableData, $$TagBankV3CategoryTableTableReferences),
    TagBankV3CategoryTableData,
    PrefetchHooks Function({bool tagBankV3TagCategoryRelationsTableRefs})> {
  $$TagBankV3CategoryTableTableTableManager(
      _$DaKanjiDB db, $TagBankV3CategoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagBankV3CategoryTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TagBankV3CategoryTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagBankV3CategoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
          }) =>
              TagBankV3CategoryTableCompanion(
            id: id,
            category: category,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
          }) =>
              TagBankV3CategoryTableCompanion.insert(
            id: id,
            category: category,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TagBankV3CategoryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {tagBankV3TagCategoryRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tagBankV3TagCategoryRelationsTableRefs)
                  db.tagBankV3TagCategoryRelationsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tagBankV3TagCategoryRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TagBankV3CategoryTableTableReferences
                            ._tagBankV3TagCategoryRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagBankV3CategoryTableTableReferences(
                                    db, table, p0)
                                .tagBankV3TagCategoryRelationsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TagBankV3CategoryTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $TagBankV3CategoryTableTable,
        TagBankV3CategoryTableData,
        $$TagBankV3CategoryTableTableFilterComposer,
        $$TagBankV3CategoryTableTableOrderingComposer,
        $$TagBankV3CategoryTableTableAnnotationComposer,
        $$TagBankV3CategoryTableTableCreateCompanionBuilder,
        $$TagBankV3CategoryTableTableUpdateCompanionBuilder,
        (TagBankV3CategoryTableData, $$TagBankV3CategoryTableTableReferences),
        TagBankV3CategoryTableData,
        PrefetchHooks Function({bool tagBankV3TagCategoryRelationsTableRefs})>;
typedef $$TagBankV3TagCategoryRelationsTableTableCreateCompanionBuilder
    = TagBankV3TagCategoryRelationsTableCompanion Function({
  Value<int> id,
  required int tagId,
  required int categoryId,
});
typedef $$TagBankV3TagCategoryRelationsTableTableUpdateCompanionBuilder
    = TagBankV3TagCategoryRelationsTableCompanion Function({
  Value<int> id,
  Value<int> tagId,
  Value<int> categoryId,
});

final class $$TagBankV3TagCategoryRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $TagBankV3TagCategoryRelationsTableTable,
        TagBankV3TagCategoryRelationsTableData> {
  $$TagBankV3TagCategoryRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TagBankV3TableTable _tagIdTable(_$DaKanjiDB db) =>
      db.tagBankV3Table.createAlias($_aliasNameGenerator(
          db.tagBankV3TagCategoryRelationsTable.tagId, db.tagBankV3Table.id));

  $$TagBankV3TableTableProcessedTableManager? get tagId {
    if ($_item.tagId == null) return null;
    final manager = $$TagBankV3TableTableTableManager($_db, $_db.tagBankV3Table)
        .filter((f) => f.id($_item.tagId!));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TagBankV3CategoryTableTable _categoryIdTable(_$DaKanjiDB db) =>
      db.tagBankV3CategoryTable.createAlias($_aliasNameGenerator(
          db.tagBankV3TagCategoryRelationsTable.categoryId,
          db.tagBankV3CategoryTable.id));

  $$TagBankV3CategoryTableTableProcessedTableManager? get categoryId {
    if ($_item.categoryId == null) return null;
    final manager = $$TagBankV3CategoryTableTableTableManager(
            $_db, $_db.tagBankV3CategoryTable)
        .filter((f) => f.id($_item.categoryId!));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TagBankV3TagCategoryRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TagBankV3TagCategoryRelationsTableTable> {
  $$TagBankV3TagCategoryRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$TagBankV3TableTableFilterComposer get tagId {
    final $$TagBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tagBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.tagBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TagBankV3CategoryTableTableFilterComposer get categoryId {
    final $$TagBankV3CategoryTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.tagBankV3CategoryTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3CategoryTableTableFilterComposer(
                  $db: $db,
                  $table: $db.tagBankV3CategoryTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TagBankV3TagCategoryRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TagBankV3TagCategoryRelationsTableTable> {
  $$TagBankV3TagCategoryRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$TagBankV3TableTableOrderingComposer get tagId {
    final $$TagBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tagBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.tagBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TagBankV3CategoryTableTableOrderingComposer get categoryId {
    final $$TagBankV3CategoryTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.tagBankV3CategoryTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3CategoryTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.tagBankV3CategoryTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TagBankV3TagCategoryRelationsTableTable> {
  $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$TagBankV3TableTableAnnotationComposer get tagId {
    final $$TagBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tagBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.tagBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TagBankV3CategoryTableTableAnnotationComposer get categoryId {
    final $$TagBankV3CategoryTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.tagBankV3CategoryTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TagBankV3CategoryTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.tagBankV3CategoryTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TagBankV3TagCategoryRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $TagBankV3TagCategoryRelationsTableTable,
        TagBankV3TagCategoryRelationsTableData,
        $$TagBankV3TagCategoryRelationsTableTableFilterComposer,
        $$TagBankV3TagCategoryRelationsTableTableOrderingComposer,
        $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer,
        $$TagBankV3TagCategoryRelationsTableTableCreateCompanionBuilder,
        $$TagBankV3TagCategoryRelationsTableTableUpdateCompanionBuilder,
        (
          TagBankV3TagCategoryRelationsTableData,
          $$TagBankV3TagCategoryRelationsTableTableReferences
        ),
        TagBankV3TagCategoryRelationsTableData,
        PrefetchHooks Function({bool tagId, bool categoryId})> {
  $$TagBankV3TagCategoryRelationsTableTableTableManager(
      _$DaKanjiDB db, $TagBankV3TagCategoryRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagBankV3TagCategoryRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TagBankV3TagCategoryRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
          }) =>
              TagBankV3TagCategoryRelationsTableCompanion(
            id: id,
            tagId: tagId,
            categoryId: categoryId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tagId,
            required int categoryId,
          }) =>
              TagBankV3TagCategoryRelationsTableCompanion.insert(
            id: id,
            tagId: tagId,
            categoryId: categoryId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TagBankV3TagCategoryRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tagId = false, categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (tagId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable:
                        $$TagBankV3TagCategoryRelationsTableTableReferences
                            ._tagIdTable(db),
                    referencedColumn:
                        $$TagBankV3TagCategoryRelationsTableTableReferences
                            ._tagIdTable(db)
                            .id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$TagBankV3TagCategoryRelationsTableTableReferences
                            ._categoryIdTable(db),
                    referencedColumn:
                        $$TagBankV3TagCategoryRelationsTableTableReferences
                            ._categoryIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TagBankV3TagCategoryRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $TagBankV3TagCategoryRelationsTableTable,
        TagBankV3TagCategoryRelationsTableData,
        $$TagBankV3TagCategoryRelationsTableTableFilterComposer,
        $$TagBankV3TagCategoryRelationsTableTableOrderingComposer,
        $$TagBankV3TagCategoryRelationsTableTableAnnotationComposer,
        $$TagBankV3TagCategoryRelationsTableTableCreateCompanionBuilder,
        $$TagBankV3TagCategoryRelationsTableTableUpdateCompanionBuilder,
        (
          TagBankV3TagCategoryRelationsTableData,
          $$TagBankV3TagCategoryRelationsTableTableReferences
        ),
        TagBankV3TagCategoryRelationsTableData,
        PrefetchHooks Function({bool tagId, bool categoryId})>;
typedef $$KanjiBankV3TableTableCreateCompanionBuilder
    = KanjiBankV3TableCompanion Function({
  Value<int> id,
  required int kanjiId,
  required int dictId,
});
typedef $$KanjiBankV3TableTableUpdateCompanionBuilder
    = KanjiBankV3TableCompanion Function({
  Value<int> id,
  Value<int> kanjiId,
  Value<int> dictId,
});

final class $$KanjiBankV3TableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3TableTable, KanjiBankV3TableData> {
  $$KanjiBankV3TableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiTableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiTable.createAlias(
          $_aliasNameGenerator(db.kanjiBankV3Table.kanjiId, db.kanjiTable.id));

  $$KanjiTableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager = $$KanjiTableTableTableManager($_db, $_db.kanjiTable)
        .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $IndexTableTable _dictIdTable(_$DaKanjiDB db) =>
      db.indexTable.createAlias(
          $_aliasNameGenerator(db.kanjiBankV3Table.dictId, db.indexTable.id));

  $$IndexTableTableProcessedTableManager? get dictId {
    if ($_item.dictId == null) return null;
    final manager = $$IndexTableTableTableManager($_db, $_db.indexTable)
        .filter((f) => f.id($_item.dictId!));
    final item = $_typedResult.readTableOrNull(_dictIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$KanjiBankV3OnyomiKanjiRelationsTableTable,
          List<KanjiBankV3OnyomiKanjiRelationsTableData>>
      _kanjiBankV3OnyomiKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3OnyomiKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
                  db.kanjiBankV3OnyomiKanjiRelationsTable.kanjiId));

  $$KanjiBankV3OnyomiKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3OnyomiKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3OnyomiKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3OnyomiKanjiRelationsTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3OnyomiKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3KunyomiKanjiRelationsTableTable,
          List<KanjiBankV3KunyomiKanjiRelationsTableData>>
      _kanjiBankV3KunyomiKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(
              db.kanjiBankV3KunyomiKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
                  db.kanjiBankV3KunyomiKanjiRelationsTable.kanjiId));

  $$KanjiBankV3KunyomiKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3KunyomiKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3KunyomiKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3KunyomiKanjiRelationsTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3KunyomiKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3TagsKanjiRelationsTableTable,
          List<KanjiBankV3TagsKanjiRelationsTableData>>
      _kanjiBankV3TagsKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3TagsKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
                  db.kanjiBankV3TagsKanjiRelationsTable.kanjiId));

  $$KanjiBankV3TagsKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3TagsKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3TagsKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3TagsKanjiRelationsTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3TagsKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3MeaningsKanjiRelationsTableTable,
          List<KanjiBankV3MeaningsKanjiRelationsTableData>>
      _kanjiBankV3MeaningsKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(
              db.kanjiBankV3MeaningsKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
                  db.kanjiBankV3MeaningsKanjiRelationsTable.kanjiId));

  $$KanjiBankV3MeaningsKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3MeaningsKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3MeaningsKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3MeaningsKanjiRelationsTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(
        _kanjiBankV3MeaningsKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3StatKanjiRelationsTableTable,
          List<KanjiBankV3StatKanjiRelationsTableData>>
      _kanjiBankV3StatKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3StatKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
                  db.kanjiBankV3StatKanjiRelationsTable.kanjiId));

  $$KanjiBankV3StatKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3StatKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3StatKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatKanjiRelationsTable)
        .filter((f) => f.kanjiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3StatKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3TableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TableTable> {
  $$KanjiBankV3TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiTableTableFilterComposer get kanjiId {
    final $$KanjiTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IndexTableTableFilterComposer get dictId {
    final $$IndexTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dictId,
        referencedTable: $db.indexTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IndexTableTableFilterComposer(
              $db: $db,
              $table: $db.indexTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> kanjiBankV3OnyomiKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3KunyomiKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3TagsKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3TagsKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3MeaningsKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3MeaningsKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3StatKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3TableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TableTable> {
  $$KanjiBankV3TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiTableTableOrderingComposer get kanjiId {
    final $$KanjiTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IndexTableTableOrderingComposer get dictId {
    final $$IndexTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dictId,
        referencedTable: $db.indexTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IndexTableTableOrderingComposer(
              $db: $db,
              $table: $db.indexTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3TableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TableTable> {
  $$KanjiBankV3TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiTableTableAnnotationComposer get kanjiId {
    final $$KanjiTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiTableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IndexTableTableAnnotationComposer get dictId {
    final $$IndexTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dictId,
        referencedTable: $db.indexTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IndexTableTableAnnotationComposer(
              $db: $db,
              $table: $db.indexTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> kanjiBankV3OnyomiKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer
        composer = $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3KunyomiKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer
        composer = $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3TagsKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3TagsKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3MeaningsKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer
        composer = $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3MeaningsKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3StatKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatKanjiRelationsTable,
            getReferencedColumn: (t) => t.kanjiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3TableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3TableTable,
    KanjiBankV3TableData,
    $$KanjiBankV3TableTableFilterComposer,
    $$KanjiBankV3TableTableOrderingComposer,
    $$KanjiBankV3TableTableAnnotationComposer,
    $$KanjiBankV3TableTableCreateCompanionBuilder,
    $$KanjiBankV3TableTableUpdateCompanionBuilder,
    (KanjiBankV3TableData, $$KanjiBankV3TableTableReferences),
    KanjiBankV3TableData,
    PrefetchHooks Function(
        {bool kanjiId,
        bool dictId,
        bool kanjiBankV3OnyomiKanjiRelationsTableRefs,
        bool kanjiBankV3KunyomiKanjiRelationsTableRefs,
        bool kanjiBankV3TagsKanjiRelationsTableRefs,
        bool kanjiBankV3MeaningsKanjiRelationsTableRefs,
        bool kanjiBankV3StatKanjiRelationsTableRefs})> {
  $$KanjiBankV3TableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3TableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3TableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
            Value<int> dictId = const Value.absent(),
          }) =>
              KanjiBankV3TableCompanion(
            id: id,
            kanjiId: kanjiId,
            dictId: dictId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiId,
            required int dictId,
          }) =>
              KanjiBankV3TableCompanion.insert(
            id: id,
            kanjiId: kanjiId,
            dictId: dictId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3TableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {kanjiId = false,
              dictId = false,
              kanjiBankV3OnyomiKanjiRelationsTableRefs = false,
              kanjiBankV3KunyomiKanjiRelationsTableRefs = false,
              kanjiBankV3TagsKanjiRelationsTableRefs = false,
              kanjiBankV3MeaningsKanjiRelationsTableRefs = false,
              kanjiBankV3StatKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3OnyomiKanjiRelationsTableRefs)
                  db.kanjiBankV3OnyomiKanjiRelationsTable,
                if (kanjiBankV3KunyomiKanjiRelationsTableRefs)
                  db.kanjiBankV3KunyomiKanjiRelationsTable,
                if (kanjiBankV3TagsKanjiRelationsTableRefs)
                  db.kanjiBankV3TagsKanjiRelationsTable,
                if (kanjiBankV3MeaningsKanjiRelationsTableRefs)
                  db.kanjiBankV3MeaningsKanjiRelationsTable,
                if (kanjiBankV3StatKanjiRelationsTableRefs)
                  db.kanjiBankV3StatKanjiRelationsTable
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiBankV3TableTableReferences._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3TableTableReferences._kanjiIdTable(db).id,
                  ) as T;
                }
                if (dictId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dictId,
                    referencedTable:
                        $$KanjiBankV3TableTableReferences._dictIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3TableTableReferences._dictIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3OnyomiKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3OnyomiKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3OnyomiKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items),
                  if (kanjiBankV3KunyomiKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3KunyomiKanjiRelationsTableRefsTable(
                                db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3KunyomiKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items),
                  if (kanjiBankV3TagsKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3TagsKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3TagsKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items),
                  if (kanjiBankV3MeaningsKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3MeaningsKanjiRelationsTableRefsTable(
                                db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3MeaningsKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items),
                  if (kanjiBankV3StatKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3StatKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3StatKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kanjiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3TableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $KanjiBankV3TableTable,
    KanjiBankV3TableData,
    $$KanjiBankV3TableTableFilterComposer,
    $$KanjiBankV3TableTableOrderingComposer,
    $$KanjiBankV3TableTableAnnotationComposer,
    $$KanjiBankV3TableTableCreateCompanionBuilder,
    $$KanjiBankV3TableTableUpdateCompanionBuilder,
    (KanjiBankV3TableData, $$KanjiBankV3TableTableReferences),
    KanjiBankV3TableData,
    PrefetchHooks Function(
        {bool kanjiId,
        bool dictId,
        bool kanjiBankV3OnyomiKanjiRelationsTableRefs,
        bool kanjiBankV3KunyomiKanjiRelationsTableRefs,
        bool kanjiBankV3TagsKanjiRelationsTableRefs,
        bool kanjiBankV3MeaningsKanjiRelationsTableRefs,
        bool kanjiBankV3StatKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3OnyomisTableTableCreateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  required String onyomi,
});
typedef $$KanjiBankV3OnyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  Value<String> onyomi,
});

final class $$KanjiBankV3OnyomisTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3OnyomisTableTable, KanjiBankV3OnyomisTableData> {
  $$KanjiBankV3OnyomisTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3OnyomiKanjiRelationsTableTable,
          List<KanjiBankV3OnyomiKanjiRelationsTableData>>
      _kanjiBankV3OnyomiKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3OnyomiKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3OnyomisTable.id,
                  db.kanjiBankV3OnyomiKanjiRelationsTable.onyomiId));

  $$KanjiBankV3OnyomiKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3OnyomiKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3OnyomiKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3OnyomiKanjiRelationsTable)
        .filter((f) => f.onyomiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3OnyomiKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3OnyomisTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomisTableTable> {
  $$KanjiBankV3OnyomisTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get onyomi => $composableBuilder(
      column: $table.onyomi, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3OnyomiKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.onyomiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3OnyomisTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomisTableTable> {
  $$KanjiBankV3OnyomisTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get onyomi => $composableBuilder(
      column: $table.onyomi, builder: (column) => ColumnOrderings(column));
}

class $$KanjiBankV3OnyomisTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomisTableTable> {
  $$KanjiBankV3OnyomisTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get onyomi =>
      $composableBuilder(column: $table.onyomi, builder: (column) => column);

  Expression<T> kanjiBankV3OnyomiKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer
        composer = $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.onyomiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3OnyomisTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3OnyomisTableTable,
    KanjiBankV3OnyomisTableData,
    $$KanjiBankV3OnyomisTableTableFilterComposer,
    $$KanjiBankV3OnyomisTableTableOrderingComposer,
    $$KanjiBankV3OnyomisTableTableAnnotationComposer,
    $$KanjiBankV3OnyomisTableTableCreateCompanionBuilder,
    $$KanjiBankV3OnyomisTableTableUpdateCompanionBuilder,
    (KanjiBankV3OnyomisTableData, $$KanjiBankV3OnyomisTableTableReferences),
    KanjiBankV3OnyomisTableData,
    PrefetchHooks Function({bool kanjiBankV3OnyomiKanjiRelationsTableRefs})> {
  $$KanjiBankV3OnyomisTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3OnyomisTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3OnyomisTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3OnyomisTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3OnyomisTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> onyomi = const Value.absent(),
          }) =>
              KanjiBankV3OnyomisTableCompanion(
            id: id,
            onyomi: onyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String onyomi,
          }) =>
              KanjiBankV3OnyomisTableCompanion.insert(
            id: id,
            onyomi: onyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3OnyomisTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {kanjiBankV3OnyomiKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3OnyomiKanjiRelationsTableRefs)
                  db.kanjiBankV3OnyomiKanjiRelationsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3OnyomiKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$KanjiBankV3OnyomisTableTableReferences
                                ._kanjiBankV3OnyomiKanjiRelationsTableRefsTable(
                                    db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3OnyomisTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3OnyomiKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.onyomiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3OnyomisTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3OnyomisTableTable,
        KanjiBankV3OnyomisTableData,
        $$KanjiBankV3OnyomisTableTableFilterComposer,
        $$KanjiBankV3OnyomisTableTableOrderingComposer,
        $$KanjiBankV3OnyomisTableTableAnnotationComposer,
        $$KanjiBankV3OnyomisTableTableCreateCompanionBuilder,
        $$KanjiBankV3OnyomisTableTableUpdateCompanionBuilder,
        (KanjiBankV3OnyomisTableData, $$KanjiBankV3OnyomisTableTableReferences),
        KanjiBankV3OnyomisTableData,
        PrefetchHooks Function(
            {bool kanjiBankV3OnyomiKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3OnyomiKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3OnyomiKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int onyomiId,
  required int kanjiId,
});
typedef $$KanjiBankV3OnyomiKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3OnyomiKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> onyomiId,
  Value<int> kanjiId,
});

final class $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $KanjiBankV3OnyomiKanjiRelationsTableTable,
        KanjiBankV3OnyomiKanjiRelationsTableData> {
  $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3OnyomisTableTable _onyomiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3OnyomisTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3OnyomiKanjiRelationsTable.onyomiId,
          db.kanjiBankV3OnyomisTable.id));

  $$KanjiBankV3OnyomisTableTableProcessedTableManager? get onyomiId {
    if ($_item.onyomiId == null) return null;
    final manager = $$KanjiBankV3OnyomisTableTableTableManager(
            $_db, $_db.kanjiBankV3OnyomisTable)
        .filter((f) => f.id($_item.onyomiId!));
    final item = $_typedResult.readTableOrNull(_onyomiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KanjiBankV3TableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3OnyomiKanjiRelationsTable.kanjiId,
          db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomiKanjiRelationsTableTable> {
  $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiBankV3OnyomisTableTableFilterComposer get onyomiId {
    final $$KanjiBankV3OnyomisTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.onyomiId,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomisTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomisTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableFilterComposer get kanjiId {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3OnyomiKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomiKanjiRelationsTableTable> {
  $$KanjiBankV3OnyomiKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiBankV3OnyomisTableTableOrderingComposer get onyomiId {
    final $$KanjiBankV3OnyomisTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.onyomiId,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomisTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomisTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableOrderingComposer get kanjiId {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomiKanjiRelationsTableTable> {
  $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiBankV3OnyomisTableTableAnnotationComposer get onyomiId {
    final $$KanjiBankV3OnyomisTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.onyomiId,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomisTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomisTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableAnnotationComposer get kanjiId {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3OnyomiKanjiRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $KanjiBankV3OnyomiKanjiRelationsTableTable,
        KanjiBankV3OnyomiKanjiRelationsTableData,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3OnyomiKanjiRelationsTableData,
          $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
        ),
        KanjiBankV3OnyomiKanjiRelationsTableData,
        PrefetchHooks Function({bool onyomiId, bool kanjiId})> {
  $$KanjiBankV3OnyomiKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3OnyomiKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3OnyomiKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> onyomiId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3OnyomiKanjiRelationsTableCompanion(
            id: id,
            onyomiId: onyomiId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int onyomiId,
            required int kanjiId,
          }) =>
              KanjiBankV3OnyomiKanjiRelationsTableCompanion.insert(
            id: id,
            onyomiId: onyomiId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({onyomiId = false, kanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (onyomiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.onyomiId,
                    referencedTable:
                        $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
                            ._onyomiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
                            ._onyomiIdTable(db)
                            .id,
                  ) as T;
                }
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3OnyomiKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3OnyomiKanjiRelationsTableTable,
        KanjiBankV3OnyomiKanjiRelationsTableData,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3OnyomiKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3OnyomiKanjiRelationsTableData,
          $$KanjiBankV3OnyomiKanjiRelationsTableTableReferences
        ),
        KanjiBankV3OnyomiKanjiRelationsTableData,
        PrefetchHooks Function({bool onyomiId, bool kanjiId})>;
typedef $$KanjiBankV3KunyomisTableTableCreateCompanionBuilder
    = KanjiBankV3KunyomisTableCompanion Function({
  Value<int> id,
  required String kunyomi,
});
typedef $$KanjiBankV3KunyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3KunyomisTableCompanion Function({
  Value<int> id,
  Value<String> kunyomi,
});

final class $$KanjiBankV3KunyomisTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3KunyomisTableTable, KanjiBankV3KunyomisTableData> {
  $$KanjiBankV3KunyomisTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3KunyomiKanjiRelationsTableTable,
          List<KanjiBankV3KunyomiKanjiRelationsTableData>>
      _kanjiBankV3KunyomiKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(
              db.kanjiBankV3KunyomiKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3KunyomisTable.id,
                  db.kanjiBankV3KunyomiKanjiRelationsTable.kunyomiId));

  $$KanjiBankV3KunyomiKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3KunyomiKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3KunyomiKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3KunyomiKanjiRelationsTable)
        .filter((f) => f.kunyomiId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3KunyomiKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3KunyomisTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomisTableTable> {
  $$KanjiBankV3KunyomisTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kunyomi => $composableBuilder(
      column: $table.kunyomi, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3KunyomiKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.kunyomiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3KunyomisTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomisTableTable> {
  $$KanjiBankV3KunyomisTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kunyomi => $composableBuilder(
      column: $table.kunyomi, builder: (column) => ColumnOrderings(column));
}

class $$KanjiBankV3KunyomisTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomisTableTable> {
  $$KanjiBankV3KunyomisTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kunyomi =>
      $composableBuilder(column: $table.kunyomi, builder: (column) => column);

  Expression<T> kanjiBankV3KunyomiKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer
        composer = $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomiKanjiRelationsTable,
            getReferencedColumn: (t) => t.kunyomiId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomiKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3KunyomisTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3KunyomisTableTable,
    KanjiBankV3KunyomisTableData,
    $$KanjiBankV3KunyomisTableTableFilterComposer,
    $$KanjiBankV3KunyomisTableTableOrderingComposer,
    $$KanjiBankV3KunyomisTableTableAnnotationComposer,
    $$KanjiBankV3KunyomisTableTableCreateCompanionBuilder,
    $$KanjiBankV3KunyomisTableTableUpdateCompanionBuilder,
    (KanjiBankV3KunyomisTableData, $$KanjiBankV3KunyomisTableTableReferences),
    KanjiBankV3KunyomisTableData,
    PrefetchHooks Function({bool kanjiBankV3KunyomiKanjiRelationsTableRefs})> {
  $$KanjiBankV3KunyomisTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3KunyomisTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3KunyomisTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3KunyomisTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3KunyomisTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> kunyomi = const Value.absent(),
          }) =>
              KanjiBankV3KunyomisTableCompanion(
            id: id,
            kunyomi: kunyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String kunyomi,
          }) =>
              KanjiBankV3KunyomisTableCompanion.insert(
            id: id,
            kunyomi: kunyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3KunyomisTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {kanjiBankV3KunyomiKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3KunyomiKanjiRelationsTableRefs)
                  db.kanjiBankV3KunyomiKanjiRelationsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3KunyomiKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$KanjiBankV3KunyomisTableTableReferences
                                ._kanjiBankV3KunyomiKanjiRelationsTableRefsTable(
                                    db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3KunyomisTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3KunyomiKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kunyomiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3KunyomisTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3KunyomisTableTable,
        KanjiBankV3KunyomisTableData,
        $$KanjiBankV3KunyomisTableTableFilterComposer,
        $$KanjiBankV3KunyomisTableTableOrderingComposer,
        $$KanjiBankV3KunyomisTableTableAnnotationComposer,
        $$KanjiBankV3KunyomisTableTableCreateCompanionBuilder,
        $$KanjiBankV3KunyomisTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3KunyomisTableData,
          $$KanjiBankV3KunyomisTableTableReferences
        ),
        KanjiBankV3KunyomisTableData,
        PrefetchHooks Function(
            {bool kanjiBankV3KunyomiKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3KunyomiKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3KunyomiKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int kunyomiId,
  required int kanjiId,
});
typedef $$KanjiBankV3KunyomiKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3KunyomiKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> kunyomiId,
  Value<int> kanjiId,
});

final class $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $KanjiBankV3KunyomiKanjiRelationsTableTable,
        KanjiBankV3KunyomiKanjiRelationsTableData> {
  $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3KunyomisTableTable _kunyomiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3KunyomisTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3KunyomiKanjiRelationsTable.kunyomiId,
          db.kanjiBankV3KunyomisTable.id));

  $$KanjiBankV3KunyomisTableTableProcessedTableManager? get kunyomiId {
    if ($_item.kunyomiId == null) return null;
    final manager = $$KanjiBankV3KunyomisTableTableTableManager(
            $_db, $_db.kanjiBankV3KunyomisTable)
        .filter((f) => f.id($_item.kunyomiId!));
    final item = $_typedResult.readTableOrNull(_kunyomiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KanjiBankV3TableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3KunyomiKanjiRelationsTable.kanjiId,
          db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomiKanjiRelationsTableTable> {
  $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiBankV3KunyomisTableTableFilterComposer get kunyomiId {
    final $$KanjiBankV3KunyomisTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.kunyomiId,
            referencedTable: $db.kanjiBankV3KunyomisTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomisTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomisTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableFilterComposer get kanjiId {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3KunyomiKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomiKanjiRelationsTableTable> {
  $$KanjiBankV3KunyomiKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiBankV3KunyomisTableTableOrderingComposer get kunyomiId {
    final $$KanjiBankV3KunyomisTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.kunyomiId,
            referencedTable: $db.kanjiBankV3KunyomisTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomisTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomisTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableOrderingComposer get kanjiId {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomiKanjiRelationsTableTable> {
  $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiBankV3KunyomisTableTableAnnotationComposer get kunyomiId {
    final $$KanjiBankV3KunyomisTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.kunyomiId,
            referencedTable: $db.kanjiBankV3KunyomisTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomisTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomisTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableAnnotationComposer get kanjiId {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3KunyomiKanjiRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $KanjiBankV3KunyomiKanjiRelationsTableTable,
        KanjiBankV3KunyomiKanjiRelationsTableData,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3KunyomiKanjiRelationsTableData,
          $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
        ),
        KanjiBankV3KunyomiKanjiRelationsTableData,
        PrefetchHooks Function({bool kunyomiId, bool kanjiId})> {
  $$KanjiBankV3KunyomiKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3KunyomiKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3KunyomiKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kunyomiId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3KunyomiKanjiRelationsTableCompanion(
            id: id,
            kunyomiId: kunyomiId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kunyomiId,
            required int kanjiId,
          }) =>
              KanjiBankV3KunyomiKanjiRelationsTableCompanion.insert(
            id: id,
            kunyomiId: kunyomiId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kunyomiId = false, kanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (kunyomiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kunyomiId,
                    referencedTable:
                        $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
                            ._kunyomiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
                            ._kunyomiIdTable(db)
                            .id,
                  ) as T;
                }
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3KunyomiKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3KunyomiKanjiRelationsTableTable,
        KanjiBankV3KunyomiKanjiRelationsTableData,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3KunyomiKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3KunyomiKanjiRelationsTableData,
          $$KanjiBankV3KunyomiKanjiRelationsTableTableReferences
        ),
        KanjiBankV3KunyomiKanjiRelationsTableData,
        PrefetchHooks Function({bool kunyomiId, bool kanjiId})>;
typedef $$KanjiBankV3TagsKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3TagsKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int tagId,
  required int kanjiId,
});
typedef $$KanjiBankV3TagsKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3TagsKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> tagId,
  Value<int> kanjiId,
});

final class $$KanjiBankV3TagsKanjiRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $KanjiBankV3TagsKanjiRelationsTableTable,
        KanjiBankV3TagsKanjiRelationsTableData> {
  $$KanjiBankV3TagsKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TagBankV3TableTable _tagIdTable(_$DaKanjiDB db) =>
      db.tagBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3TagsKanjiRelationsTable.tagId, db.tagBankV3Table.id));

  $$TagBankV3TableTableProcessedTableManager? get tagId {
    if ($_item.tagId == null) return null;
    final manager = $$TagBankV3TableTableTableManager($_db, $_db.tagBankV3Table)
        .filter((f) => f.id($_item.tagId!));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KanjiBankV3TableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3TagsKanjiRelationsTable.kanjiId,
          db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagsKanjiRelationsTableTable> {
  $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$TagBankV3TableTableFilterComposer get tagId {
    final $$TagBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tagBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.tagBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KanjiBankV3TableTableFilterComposer get kanjiId {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3TagsKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagsKanjiRelationsTableTable> {
  $$KanjiBankV3TagsKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$TagBankV3TableTableOrderingComposer get tagId {
    final $$TagBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tagBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.tagBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KanjiBankV3TableTableOrderingComposer get kanjiId {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagsKanjiRelationsTableTable> {
  $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$TagBankV3TableTableAnnotationComposer get tagId {
    final $$TagBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tagBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.tagBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KanjiBankV3TableTableAnnotationComposer get kanjiId {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3TagsKanjiRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $KanjiBankV3TagsKanjiRelationsTableTable,
        KanjiBankV3TagsKanjiRelationsTableData,
        $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3TagsKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3TagsKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3TagsKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3TagsKanjiRelationsTableData,
          $$KanjiBankV3TagsKanjiRelationsTableTableReferences
        ),
        KanjiBankV3TagsKanjiRelationsTableData,
        PrefetchHooks Function({bool tagId, bool kanjiId})> {
  $$KanjiBankV3TagsKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3TagsKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3TagsKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3TagsKanjiRelationsTableCompanion(
            id: id,
            tagId: tagId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tagId,
            required int kanjiId,
          }) =>
              KanjiBankV3TagsKanjiRelationsTableCompanion.insert(
            id: id,
            tagId: tagId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3TagsKanjiRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tagId = false, kanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (tagId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable:
                        $$KanjiBankV3TagsKanjiRelationsTableTableReferences
                            ._tagIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3TagsKanjiRelationsTableTableReferences
                            ._tagIdTable(db)
                            .id,
                  ) as T;
                }
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiBankV3TagsKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3TagsKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3TagsKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3TagsKanjiRelationsTableTable,
        KanjiBankV3TagsKanjiRelationsTableData,
        $$KanjiBankV3TagsKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3TagsKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3TagsKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3TagsKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3TagsKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3TagsKanjiRelationsTableData,
          $$KanjiBankV3TagsKanjiRelationsTableTableReferences
        ),
        KanjiBankV3TagsKanjiRelationsTableData,
        PrefetchHooks Function({bool tagId, bool kanjiId})>;
typedef $$KanjiBankV3MeaningsTableTableCreateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  required String meaning,
});
typedef $$KanjiBankV3MeaningsTableTableUpdateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  Value<String> meaning,
});

final class $$KanjiBankV3MeaningsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3MeaningsTableTable, KanjiBankV3MeaningsTableData> {
  $$KanjiBankV3MeaningsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3MeaningsKanjiRelationsTableTable,
          List<KanjiBankV3MeaningsKanjiRelationsTableData>>
      _kanjiBankV3MeaningsKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(
              db.kanjiBankV3MeaningsKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3MeaningsTable.id,
                  db.kanjiBankV3MeaningsKanjiRelationsTable.meaningId));

  $$KanjiBankV3MeaningsKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3MeaningsKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3MeaningsKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3MeaningsKanjiRelationsTable)
        .filter((f) => f.meaningId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(
        _kanjiBankV3MeaningsKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3MeaningsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3MeaningsTableTable> {
  $$KanjiBankV3MeaningsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3MeaningsKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3MeaningsKanjiRelationsTable,
            getReferencedColumn: (t) => t.meaningId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3MeaningsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3MeaningsTableTable> {
  $$KanjiBankV3MeaningsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnOrderings(column));
}

class $$KanjiBankV3MeaningsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3MeaningsTableTable> {
  $$KanjiBankV3MeaningsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  Expression<T> kanjiBankV3MeaningsKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer
        composer = $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3MeaningsKanjiRelationsTable,
            getReferencedColumn: (t) => t.meaningId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3MeaningsTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3MeaningsTableTable,
    KanjiBankV3MeaningsTableData,
    $$KanjiBankV3MeaningsTableTableFilterComposer,
    $$KanjiBankV3MeaningsTableTableOrderingComposer,
    $$KanjiBankV3MeaningsTableTableAnnotationComposer,
    $$KanjiBankV3MeaningsTableTableCreateCompanionBuilder,
    $$KanjiBankV3MeaningsTableTableUpdateCompanionBuilder,
    (KanjiBankV3MeaningsTableData, $$KanjiBankV3MeaningsTableTableReferences),
    KanjiBankV3MeaningsTableData,
    PrefetchHooks Function({bool kanjiBankV3MeaningsKanjiRelationsTableRefs})> {
  $$KanjiBankV3MeaningsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3MeaningsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3MeaningsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3MeaningsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3MeaningsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> meaning = const Value.absent(),
          }) =>
              KanjiBankV3MeaningsTableCompanion(
            id: id,
            meaning: meaning,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String meaning,
          }) =>
              KanjiBankV3MeaningsTableCompanion.insert(
            id: id,
            meaning: meaning,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3MeaningsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {kanjiBankV3MeaningsKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3MeaningsKanjiRelationsTableRefs)
                  db.kanjiBankV3MeaningsKanjiRelationsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3MeaningsKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3MeaningsTableTableReferences
                            ._kanjiBankV3MeaningsKanjiRelationsTableRefsTable(
                                db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3MeaningsTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3MeaningsKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.meaningId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3MeaningsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3MeaningsTableTable,
        KanjiBankV3MeaningsTableData,
        $$KanjiBankV3MeaningsTableTableFilterComposer,
        $$KanjiBankV3MeaningsTableTableOrderingComposer,
        $$KanjiBankV3MeaningsTableTableAnnotationComposer,
        $$KanjiBankV3MeaningsTableTableCreateCompanionBuilder,
        $$KanjiBankV3MeaningsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3MeaningsTableData,
          $$KanjiBankV3MeaningsTableTableReferences
        ),
        KanjiBankV3MeaningsTableData,
        PrefetchHooks Function(
            {bool kanjiBankV3MeaningsKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3MeaningsKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3MeaningsKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int meaningId,
  required int kanjiId,
});
typedef $$KanjiBankV3MeaningsKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3MeaningsKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> meaningId,
  Value<int> kanjiId,
});

final class $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $KanjiBankV3MeaningsKanjiRelationsTableTable,
        KanjiBankV3MeaningsKanjiRelationsTableData> {
  $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3MeaningsTableTable _meaningIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3MeaningsTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3MeaningsKanjiRelationsTable.meaningId,
          db.kanjiBankV3MeaningsTable.id));

  $$KanjiBankV3MeaningsTableTableProcessedTableManager? get meaningId {
    if ($_item.meaningId == null) return null;
    final manager = $$KanjiBankV3MeaningsTableTableTableManager(
            $_db, $_db.kanjiBankV3MeaningsTable)
        .filter((f) => f.id($_item.meaningId!));
    final item = $_typedResult.readTableOrNull(_meaningIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KanjiBankV3TableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3MeaningsKanjiRelationsTable.kanjiId,
          db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB,
        $KanjiBankV3MeaningsKanjiRelationsTableTable> {
  $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiBankV3MeaningsTableTableFilterComposer get meaningId {
    final $$KanjiBankV3MeaningsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.meaningId,
            referencedTable: $db.kanjiBankV3MeaningsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableFilterComposer get kanjiId {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3MeaningsKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB,
        $KanjiBankV3MeaningsKanjiRelationsTableTable> {
  $$KanjiBankV3MeaningsKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiBankV3MeaningsTableTableOrderingComposer get meaningId {
    final $$KanjiBankV3MeaningsTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.meaningId,
            referencedTable: $db.kanjiBankV3MeaningsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableOrderingComposer get kanjiId {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB,
        $KanjiBankV3MeaningsKanjiRelationsTableTable> {
  $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiBankV3MeaningsTableTableAnnotationComposer get meaningId {
    final $$KanjiBankV3MeaningsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.meaningId,
            referencedTable: $db.kanjiBankV3MeaningsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3MeaningsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3MeaningsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableAnnotationComposer get kanjiId {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3MeaningsKanjiRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $KanjiBankV3MeaningsKanjiRelationsTableTable,
        KanjiBankV3MeaningsKanjiRelationsTableData,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3MeaningsKanjiRelationsTableData,
          $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
        ),
        KanjiBankV3MeaningsKanjiRelationsTableData,
        PrefetchHooks Function({bool meaningId, bool kanjiId})> {
  $$KanjiBankV3MeaningsKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3MeaningsKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3MeaningsKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> meaningId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3MeaningsKanjiRelationsTableCompanion(
            id: id,
            meaningId: meaningId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int meaningId,
            required int kanjiId,
          }) =>
              KanjiBankV3MeaningsKanjiRelationsTableCompanion.insert(
            id: id,
            meaningId: meaningId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({meaningId = false, kanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (meaningId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.meaningId,
                    referencedTable:
                        $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
                            ._meaningIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
                            ._meaningIdTable(db)
                            .id,
                  ) as T;
                }
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3MeaningsKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3MeaningsKanjiRelationsTableTable,
        KanjiBankV3MeaningsKanjiRelationsTableData,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3MeaningsKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3MeaningsKanjiRelationsTableData,
          $$KanjiBankV3MeaningsKanjiRelationsTableTableReferences
        ),
        KanjiBankV3MeaningsKanjiRelationsTableData,
        PrefetchHooks Function({bool meaningId, bool kanjiId})>;
typedef $$KanjiBankV3StatNamesTableTableCreateCompanionBuilder
    = KanjiBankV3StatNamesTableCompanion Function({
  Value<int> id,
  required String statName,
});
typedef $$KanjiBankV3StatNamesTableTableUpdateCompanionBuilder
    = KanjiBankV3StatNamesTableCompanion Function({
  Value<int> id,
  Value<String> statName,
});

final class $$KanjiBankV3StatNamesTableTableReferences extends BaseReferences<
    _$DaKanjiDB,
    $KanjiBankV3StatNamesTableTable,
    KanjiBankV3StatNamesTableData> {
  $$KanjiBankV3StatNamesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3StatsTableTable,
      List<KanjiBankV3StatsTableData>> _kanjiBankV3StatsTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3StatsTable,
          aliasName: $_aliasNameGenerator(db.kanjiBankV3StatNamesTable.id,
              db.kanjiBankV3StatsTable.statNameId));

  $$KanjiBankV3StatsTableTableProcessedTableManager
      get kanjiBankV3StatsTableRefs {
    final manager = $$KanjiBankV3StatsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatsTable)
        .filter((f) => f.statNameId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3StatsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3StatNamesTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatNamesTableTable> {
  $$KanjiBankV3StatNamesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statName => $composableBuilder(
      column: $table.statName, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3StatsTableRefs(
      Expression<bool> Function($$KanjiBankV3StatsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3StatsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.statNameId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3StatNamesTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatNamesTableTable> {
  $$KanjiBankV3StatNamesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statName => $composableBuilder(
      column: $table.statName, builder: (column) => ColumnOrderings(column));
}

class $$KanjiBankV3StatNamesTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatNamesTableTable> {
  $$KanjiBankV3StatNamesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get statName =>
      $composableBuilder(column: $table.statName, builder: (column) => column);

  Expression<T> kanjiBankV3StatsTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3StatsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3StatsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.statNameId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3StatNamesTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3StatNamesTableTable,
    KanjiBankV3StatNamesTableData,
    $$KanjiBankV3StatNamesTableTableFilterComposer,
    $$KanjiBankV3StatNamesTableTableOrderingComposer,
    $$KanjiBankV3StatNamesTableTableAnnotationComposer,
    $$KanjiBankV3StatNamesTableTableCreateCompanionBuilder,
    $$KanjiBankV3StatNamesTableTableUpdateCompanionBuilder,
    (KanjiBankV3StatNamesTableData, $$KanjiBankV3StatNamesTableTableReferences),
    KanjiBankV3StatNamesTableData,
    PrefetchHooks Function({bool kanjiBankV3StatsTableRefs})> {
  $$KanjiBankV3StatNamesTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3StatNamesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3StatNamesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3StatNamesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3StatNamesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> statName = const Value.absent(),
          }) =>
              KanjiBankV3StatNamesTableCompanion(
            id: id,
            statName: statName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String statName,
          }) =>
              KanjiBankV3StatNamesTableCompanion.insert(
            id: id,
            statName: statName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3StatNamesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3StatsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3StatsTableRefs) db.kanjiBankV3StatsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3StatsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$KanjiBankV3StatNamesTableTableReferences
                                ._kanjiBankV3StatsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3StatNamesTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3StatsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.statNameId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3StatNamesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatNamesTableTable,
        KanjiBankV3StatNamesTableData,
        $$KanjiBankV3StatNamesTableTableFilterComposer,
        $$KanjiBankV3StatNamesTableTableOrderingComposer,
        $$KanjiBankV3StatNamesTableTableAnnotationComposer,
        $$KanjiBankV3StatNamesTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatNamesTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3StatNamesTableData,
          $$KanjiBankV3StatNamesTableTableReferences
        ),
        KanjiBankV3StatNamesTableData,
        PrefetchHooks Function({bool kanjiBankV3StatsTableRefs})>;
typedef $$KanjiBankV3StatValuesTableTableCreateCompanionBuilder
    = KanjiBankV3StatValuesTableCompanion Function({
  Value<int> id,
  required String statValue,
});
typedef $$KanjiBankV3StatValuesTableTableUpdateCompanionBuilder
    = KanjiBankV3StatValuesTableCompanion Function({
  Value<int> id,
  Value<String> statValue,
});

final class $$KanjiBankV3StatValuesTableTableReferences extends BaseReferences<
    _$DaKanjiDB,
    $KanjiBankV3StatValuesTableTable,
    KanjiBankV3StatValuesTableData> {
  $$KanjiBankV3StatValuesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3StatsTableTable,
      List<KanjiBankV3StatsTableData>> _kanjiBankV3StatsTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3StatsTable,
          aliasName: $_aliasNameGenerator(db.kanjiBankV3StatValuesTable.id,
              db.kanjiBankV3StatsTable.statValueId));

  $$KanjiBankV3StatsTableTableProcessedTableManager
      get kanjiBankV3StatsTableRefs {
    final manager = $$KanjiBankV3StatsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatsTable)
        .filter((f) => f.statValueId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3StatsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3StatValuesTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatValuesTableTable> {
  $$KanjiBankV3StatValuesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statValue => $composableBuilder(
      column: $table.statValue, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3StatsTableRefs(
      Expression<bool> Function($$KanjiBankV3StatsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3StatsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.statValueId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3StatValuesTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatValuesTableTable> {
  $$KanjiBankV3StatValuesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statValue => $composableBuilder(
      column: $table.statValue, builder: (column) => ColumnOrderings(column));
}

class $$KanjiBankV3StatValuesTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatValuesTableTable> {
  $$KanjiBankV3StatValuesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get statValue =>
      $composableBuilder(column: $table.statValue, builder: (column) => column);

  Expression<T> kanjiBankV3StatsTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3StatsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3StatsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.statValueId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3StatValuesTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3StatValuesTableTable,
    KanjiBankV3StatValuesTableData,
    $$KanjiBankV3StatValuesTableTableFilterComposer,
    $$KanjiBankV3StatValuesTableTableOrderingComposer,
    $$KanjiBankV3StatValuesTableTableAnnotationComposer,
    $$KanjiBankV3StatValuesTableTableCreateCompanionBuilder,
    $$KanjiBankV3StatValuesTableTableUpdateCompanionBuilder,
    (
      KanjiBankV3StatValuesTableData,
      $$KanjiBankV3StatValuesTableTableReferences
    ),
    KanjiBankV3StatValuesTableData,
    PrefetchHooks Function({bool kanjiBankV3StatsTableRefs})> {
  $$KanjiBankV3StatValuesTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3StatValuesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3StatValuesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3StatValuesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3StatValuesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> statValue = const Value.absent(),
          }) =>
              KanjiBankV3StatValuesTableCompanion(
            id: id,
            statValue: statValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String statValue,
          }) =>
              KanjiBankV3StatValuesTableCompanion.insert(
            id: id,
            statValue: statValue,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3StatValuesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3StatsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3StatsTableRefs) db.kanjiBankV3StatsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3StatsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$KanjiBankV3StatValuesTableTableReferences
                                ._kanjiBankV3StatsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3StatValuesTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3StatsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.statValueId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3StatValuesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatValuesTableTable,
        KanjiBankV3StatValuesTableData,
        $$KanjiBankV3StatValuesTableTableFilterComposer,
        $$KanjiBankV3StatValuesTableTableOrderingComposer,
        $$KanjiBankV3StatValuesTableTableAnnotationComposer,
        $$KanjiBankV3StatValuesTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatValuesTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3StatValuesTableData,
          $$KanjiBankV3StatValuesTableTableReferences
        ),
        KanjiBankV3StatValuesTableData,
        PrefetchHooks Function({bool kanjiBankV3StatsTableRefs})>;
typedef $$KanjiBankV3StatsTableTableCreateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  required int statNameId,
  required int statValueId,
});
typedef $$KanjiBankV3StatsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  Value<int> statNameId,
  Value<int> statValueId,
});

final class $$KanjiBankV3StatsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3StatsTableTable, KanjiBankV3StatsTableData> {
  $$KanjiBankV3StatsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3StatNamesTableTable _statNameIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3StatNamesTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatsTable.statNameId,
          db.kanjiBankV3StatNamesTable.id));

  $$KanjiBankV3StatNamesTableTableProcessedTableManager? get statNameId {
    if ($_item.statNameId == null) return null;
    final manager = $$KanjiBankV3StatNamesTableTableTableManager(
            $_db, $_db.kanjiBankV3StatNamesTable)
        .filter((f) => f.id($_item.statNameId!));
    final item = $_typedResult.readTableOrNull(_statNameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KanjiBankV3StatValuesTableTable _statValueIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3StatValuesTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatsTable.statValueId,
          db.kanjiBankV3StatValuesTable.id));

  $$KanjiBankV3StatValuesTableTableProcessedTableManager? get statValueId {
    if ($_item.statValueId == null) return null;
    final manager = $$KanjiBankV3StatValuesTableTableTableManager(
            $_db, $_db.kanjiBankV3StatValuesTable)
        .filter((f) => f.id($_item.statValueId!));
    final item = $_typedResult.readTableOrNull(_statValueIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$KanjiBankV3StatKanjiRelationsTableTable,
          List<KanjiBankV3StatKanjiRelationsTableData>>
      _kanjiBankV3StatKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3StatKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3StatsTable.id,
                  db.kanjiBankV3StatKanjiRelationsTable.statId));

  $$KanjiBankV3StatKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3StatKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3StatKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatKanjiRelationsTable)
        .filter((f) => f.statId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3StatKanjiRelationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiBankV3StatsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatsTableTable> {
  $$KanjiBankV3StatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiBankV3StatNamesTableTableFilterComposer get statNameId {
    final $$KanjiBankV3StatNamesTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statNameId,
            referencedTable: $db.kanjiBankV3StatNamesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatNamesTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatNamesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3StatValuesTableTableFilterComposer get statValueId {
    final $$KanjiBankV3StatValuesTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statValueId,
            referencedTable: $db.kanjiBankV3StatValuesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatValuesTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatValuesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<bool> kanjiBankV3StatKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatKanjiRelationsTable,
            getReferencedColumn: (t) => t.statId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3StatsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatsTableTable> {
  $$KanjiBankV3StatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiBankV3StatNamesTableTableOrderingComposer get statNameId {
    final $$KanjiBankV3StatNamesTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statNameId,
            referencedTable: $db.kanjiBankV3StatNamesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatNamesTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatNamesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3StatValuesTableTableOrderingComposer get statValueId {
    final $$KanjiBankV3StatValuesTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statValueId,
            referencedTable: $db.kanjiBankV3StatValuesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatValuesTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatValuesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$KanjiBankV3StatsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatsTableTable> {
  $$KanjiBankV3StatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiBankV3StatNamesTableTableAnnotationComposer get statNameId {
    final $$KanjiBankV3StatNamesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statNameId,
            referencedTable: $db.kanjiBankV3StatNamesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatNamesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatNamesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3StatValuesTableTableAnnotationComposer get statValueId {
    final $$KanjiBankV3StatValuesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statValueId,
            referencedTable: $db.kanjiBankV3StatValuesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatValuesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatValuesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> kanjiBankV3StatKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatKanjiRelationsTable,
            getReferencedColumn: (t) => t.statId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatKanjiRelationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiBankV3StatsTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3StatsTableTable,
    KanjiBankV3StatsTableData,
    $$KanjiBankV3StatsTableTableFilterComposer,
    $$KanjiBankV3StatsTableTableOrderingComposer,
    $$KanjiBankV3StatsTableTableAnnotationComposer,
    $$KanjiBankV3StatsTableTableCreateCompanionBuilder,
    $$KanjiBankV3StatsTableTableUpdateCompanionBuilder,
    (KanjiBankV3StatsTableData, $$KanjiBankV3StatsTableTableReferences),
    KanjiBankV3StatsTableData,
    PrefetchHooks Function(
        {bool statNameId,
        bool statValueId,
        bool kanjiBankV3StatKanjiRelationsTableRefs})> {
  $$KanjiBankV3StatsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3StatsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3StatsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3StatsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3StatsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> statNameId = const Value.absent(),
            Value<int> statValueId = const Value.absent(),
          }) =>
              KanjiBankV3StatsTableCompanion(
            id: id,
            statNameId: statNameId,
            statValueId: statValueId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int statNameId,
            required int statValueId,
          }) =>
              KanjiBankV3StatsTableCompanion.insert(
            id: id,
            statNameId: statNameId,
            statValueId: statValueId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3StatsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {statNameId = false,
              statValueId = false,
              kanjiBankV3StatKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3StatKanjiRelationsTableRefs)
                  db.kanjiBankV3StatKanjiRelationsTable
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (statNameId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.statNameId,
                    referencedTable: $$KanjiBankV3StatsTableTableReferences
                        ._statNameIdTable(db),
                    referencedColumn: $$KanjiBankV3StatsTableTableReferences
                        ._statNameIdTable(db)
                        .id,
                  ) as T;
                }
                if (statValueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.statValueId,
                    referencedTable: $$KanjiBankV3StatsTableTableReferences
                        ._statValueIdTable(db),
                    referencedColumn: $$KanjiBankV3StatsTableTableReferences
                        ._statValueIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3StatKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3StatsTableTableReferences
                            ._kanjiBankV3StatKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3StatsTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3StatKanjiRelationsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.statId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3StatsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatsTableTable,
        KanjiBankV3StatsTableData,
        $$KanjiBankV3StatsTableTableFilterComposer,
        $$KanjiBankV3StatsTableTableOrderingComposer,
        $$KanjiBankV3StatsTableTableAnnotationComposer,
        $$KanjiBankV3StatsTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatsTableTableUpdateCompanionBuilder,
        (KanjiBankV3StatsTableData, $$KanjiBankV3StatsTableTableReferences),
        KanjiBankV3StatsTableData,
        PrefetchHooks Function(
            {bool statNameId,
            bool statValueId,
            bool kanjiBankV3StatKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3StatKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3StatKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int statId,
  required int kanjiId,
});
typedef $$KanjiBankV3StatKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> statId,
  Value<int> kanjiId,
});

final class $$KanjiBankV3StatKanjiRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $KanjiBankV3StatKanjiRelationsTableTable,
        KanjiBankV3StatKanjiRelationsTableData> {
  $$KanjiBankV3StatKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3StatsTableTable _statIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3StatsTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatKanjiRelationsTable.statId,
          db.kanjiBankV3StatsTable.id));

  $$KanjiBankV3StatsTableTableProcessedTableManager? get statId {
    if ($_item.statId == null) return null;
    final manager = $$KanjiBankV3StatsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatsTable)
        .filter((f) => f.id($_item.statId!));
    final item = $_typedResult.readTableOrNull(_statIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KanjiBankV3TableTable _kanjiIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatKanjiRelationsTable.kanjiId,
          db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiId {
    if ($_item.kanjiId == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiId!));
    final item = $_typedResult.readTableOrNull(_kanjiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatKanjiRelationsTableTable> {
  $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$KanjiBankV3StatsTableTableFilterComposer get statId {
    final $$KanjiBankV3StatsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statId,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableFilterComposer get kanjiId {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3StatKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatKanjiRelationsTableTable> {
  $$KanjiBankV3StatKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$KanjiBankV3StatsTableTableOrderingComposer get statId {
    final $$KanjiBankV3StatsTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statId,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableOrderingComposer get kanjiId {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableOrderingComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatKanjiRelationsTableTable> {
  $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$KanjiBankV3StatsTableTableAnnotationComposer get statId {
    final $$KanjiBankV3StatsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.statId,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3StatsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3StatsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$KanjiBankV3TableTableAnnotationComposer get kanjiId {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiId,
        referencedTable: $db.kanjiBankV3Table,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TableTableAnnotationComposer(
              $db: $db,
              $table: $db.kanjiBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KanjiBankV3StatKanjiRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatKanjiRelationsTableTable,
        KanjiBankV3StatKanjiRelationsTableData,
        $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3StatKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3StatKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3StatKanjiRelationsTableData,
          $$KanjiBankV3StatKanjiRelationsTableTableReferences
        ),
        KanjiBankV3StatKanjiRelationsTableData,
        PrefetchHooks Function({bool statId, bool kanjiId})> {
  $$KanjiBankV3StatKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3StatKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3StatKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> statId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3StatKanjiRelationsTableCompanion(
            id: id,
            statId: statId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int statId,
            required int kanjiId,
          }) =>
              KanjiBankV3StatKanjiRelationsTableCompanion.insert(
            id: id,
            statId: statId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3StatKanjiRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({statId = false, kanjiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (statId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.statId,
                    referencedTable:
                        $$KanjiBankV3StatKanjiRelationsTableTableReferences
                            ._statIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3StatKanjiRelationsTableTableReferences
                            ._statIdTable(db)
                            .id,
                  ) as T;
                }
                if (kanjiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiId,
                    referencedTable:
                        $$KanjiBankV3StatKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3StatKanjiRelationsTableTableReferences
                            ._kanjiIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiBankV3StatKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatKanjiRelationsTableTable,
        KanjiBankV3StatKanjiRelationsTableData,
        $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3StatKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3StatKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3StatKanjiRelationsTableData,
          $$KanjiBankV3StatKanjiRelationsTableTableReferences
        ),
        KanjiBankV3StatKanjiRelationsTableData,
        PrefetchHooks Function({bool statId, bool kanjiId})>;
typedef $$KanjiMetaBankV3TypeTableTableCreateCompanionBuilder
    = KanjiMetaBankV3TypeTableCompanion Function({
  Value<int> id,
  required String type,
});
typedef $$KanjiMetaBankV3TypeTableTableUpdateCompanionBuilder
    = KanjiMetaBankV3TypeTableCompanion Function({
  Value<int> id,
  Value<String> type,
});

final class $$KanjiMetaBankV3TypeTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiMetaBankV3TypeTableTable, KanjiMetaBankV3TypeTableData> {
  $$KanjiMetaBankV3TypeTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiMetaBankV3TableTable,
      List<KanjiMetaBankV3TableData>> _kanjiMetaBankV3TableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiMetaBankV3Table,
          aliasName: $_aliasNameGenerator(
              db.kanjiMetaBankV3TypeTable.id, db.kanjiMetaBankV3Table.typeId));

  $$KanjiMetaBankV3TableTableProcessedTableManager
      get kanjiMetaBankV3TableRefs {
    final manager =
        $$KanjiMetaBankV3TableTableTableManager($_db, $_db.kanjiMetaBankV3Table)
            .filter((f) => f.typeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiMetaBankV3TableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KanjiMetaBankV3TypeTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiMetaBankV3TypeTableTable> {
  $$KanjiMetaBankV3TypeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiMetaBankV3TableRefs(
      Expression<bool> Function($$KanjiMetaBankV3TableTableFilterComposer f)
          f) {
    final $$KanjiMetaBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiMetaBankV3Table,
        getReferencedColumn: (t) => t.typeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiMetaBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiMetaBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KanjiMetaBankV3TypeTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiMetaBankV3TypeTableTable> {
  $$KanjiMetaBankV3TypeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));
}

class $$KanjiMetaBankV3TypeTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiMetaBankV3TypeTableTable> {
  $$KanjiMetaBankV3TypeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  Expression<T> kanjiMetaBankV3TableRefs<T extends Object>(
      Expression<T> Function($$KanjiMetaBankV3TableTableAnnotationComposer a)
          f) {
    final $$KanjiMetaBankV3TableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiMetaBankV3Table,
            getReferencedColumn: (t) => t.typeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiMetaBankV3TableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiMetaBankV3Table,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$KanjiMetaBankV3TypeTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiMetaBankV3TypeTableTable,
    KanjiMetaBankV3TypeTableData,
    $$KanjiMetaBankV3TypeTableTableFilterComposer,
    $$KanjiMetaBankV3TypeTableTableOrderingComposer,
    $$KanjiMetaBankV3TypeTableTableAnnotationComposer,
    $$KanjiMetaBankV3TypeTableTableCreateCompanionBuilder,
    $$KanjiMetaBankV3TypeTableTableUpdateCompanionBuilder,
    (KanjiMetaBankV3TypeTableData, $$KanjiMetaBankV3TypeTableTableReferences),
    KanjiMetaBankV3TypeTableData,
    PrefetchHooks Function({bool kanjiMetaBankV3TableRefs})> {
  $$KanjiMetaBankV3TypeTableTableTableManager(
      _$DaKanjiDB db, $KanjiMetaBankV3TypeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiMetaBankV3TypeTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiMetaBankV3TypeTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiMetaBankV3TypeTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
          }) =>
              KanjiMetaBankV3TypeTableCompanion(
            id: id,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String type,
          }) =>
              KanjiMetaBankV3TypeTableCompanion.insert(
            id: id,
            type: type,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiMetaBankV3TypeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiMetaBankV3TableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiMetaBankV3TableRefs) db.kanjiMetaBankV3Table
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiMetaBankV3TableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$KanjiMetaBankV3TypeTableTableReferences
                                ._kanjiMetaBankV3TableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiMetaBankV3TypeTableTableReferences(
                                    db, table, p0)
                                .kanjiMetaBankV3TableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.typeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KanjiMetaBankV3TypeTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiMetaBankV3TypeTableTable,
        KanjiMetaBankV3TypeTableData,
        $$KanjiMetaBankV3TypeTableTableFilterComposer,
        $$KanjiMetaBankV3TypeTableTableOrderingComposer,
        $$KanjiMetaBankV3TypeTableTableAnnotationComposer,
        $$KanjiMetaBankV3TypeTableTableCreateCompanionBuilder,
        $$KanjiMetaBankV3TypeTableTableUpdateCompanionBuilder,
        (
          KanjiMetaBankV3TypeTableData,
          $$KanjiMetaBankV3TypeTableTableReferences
        ),
        KanjiMetaBankV3TypeTableData,
        PrefetchHooks Function({bool kanjiMetaBankV3TableRefs})>;
typedef $$KanjiMetaBankV3TableTableCreateCompanionBuilder
    = KanjiMetaBankV3TableCompanion Function({
  Value<int> id,
  required int dictId,
  required String kanjiId,
  required int typeId,
  Value<int?> freqValue,
  Value<String?> freqDisplayValue,
});
typedef $$KanjiMetaBankV3TableTableUpdateCompanionBuilder
    = KanjiMetaBankV3TableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<String> kanjiId,
  Value<int> typeId,
  Value<int?> freqValue,
  Value<String?> freqDisplayValue,
});

final class $$KanjiMetaBankV3TableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiMetaBankV3TableTable, KanjiMetaBankV3TableData> {
  $$KanjiMetaBankV3TableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiMetaBankV3TypeTableTable _typeIdTable(_$DaKanjiDB db) =>
      db.kanjiMetaBankV3TypeTable.createAlias($_aliasNameGenerator(
          db.kanjiMetaBankV3Table.typeId, db.kanjiMetaBankV3TypeTable.id));

  $$KanjiMetaBankV3TypeTableTableProcessedTableManager? get typeId {
    if ($_item.typeId == null) return null;
    final manager = $$KanjiMetaBankV3TypeTableTableTableManager(
            $_db, $_db.kanjiMetaBankV3TypeTable)
        .filter((f) => f.id($_item.typeId!));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiMetaBankV3TableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiMetaBankV3TableTable> {
  $$KanjiMetaBankV3TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get freqValue => $composableBuilder(
      column: $table.freqValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get freqDisplayValue => $composableBuilder(
      column: $table.freqDisplayValue,
      builder: (column) => ColumnFilters(column));

  $$KanjiMetaBankV3TypeTableTableFilterComposer get typeId {
    final $$KanjiMetaBankV3TypeTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.typeId,
            referencedTable: $db.kanjiMetaBankV3TypeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiMetaBankV3TypeTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiMetaBankV3TypeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$KanjiMetaBankV3TableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiMetaBankV3TableTable> {
  $$KanjiMetaBankV3TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get freqValue => $composableBuilder(
      column: $table.freqValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get freqDisplayValue => $composableBuilder(
      column: $table.freqDisplayValue,
      builder: (column) => ColumnOrderings(column));

  $$KanjiMetaBankV3TypeTableTableOrderingComposer get typeId {
    final $$KanjiMetaBankV3TypeTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.typeId,
            referencedTable: $db.kanjiMetaBankV3TypeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiMetaBankV3TypeTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiMetaBankV3TypeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$KanjiMetaBankV3TableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiMetaBankV3TableTable> {
  $$KanjiMetaBankV3TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

  GeneratedColumn<String> get kanjiId =>
      $composableBuilder(column: $table.kanjiId, builder: (column) => column);

  GeneratedColumn<int> get freqValue =>
      $composableBuilder(column: $table.freqValue, builder: (column) => column);

  GeneratedColumn<String> get freqDisplayValue => $composableBuilder(
      column: $table.freqDisplayValue, builder: (column) => column);

  $$KanjiMetaBankV3TypeTableTableAnnotationComposer get typeId {
    final $$KanjiMetaBankV3TypeTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.typeId,
            referencedTable: $db.kanjiMetaBankV3TypeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiMetaBankV3TypeTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiMetaBankV3TypeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$KanjiMetaBankV3TableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiMetaBankV3TableTable,
    KanjiMetaBankV3TableData,
    $$KanjiMetaBankV3TableTableFilterComposer,
    $$KanjiMetaBankV3TableTableOrderingComposer,
    $$KanjiMetaBankV3TableTableAnnotationComposer,
    $$KanjiMetaBankV3TableTableCreateCompanionBuilder,
    $$KanjiMetaBankV3TableTableUpdateCompanionBuilder,
    (KanjiMetaBankV3TableData, $$KanjiMetaBankV3TableTableReferences),
    KanjiMetaBankV3TableData,
    PrefetchHooks Function({bool typeId})> {
  $$KanjiMetaBankV3TableTableTableManager(
      _$DaKanjiDB db, $KanjiMetaBankV3TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiMetaBankV3TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiMetaBankV3TableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiMetaBankV3TableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dictId = const Value.absent(),
            Value<String> kanjiId = const Value.absent(),
            Value<int> typeId = const Value.absent(),
            Value<int?> freqValue = const Value.absent(),
            Value<String?> freqDisplayValue = const Value.absent(),
          }) =>
              KanjiMetaBankV3TableCompanion(
            id: id,
            dictId: dictId,
            kanjiId: kanjiId,
            typeId: typeId,
            freqValue: freqValue,
            freqDisplayValue: freqDisplayValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required String kanjiId,
            required int typeId,
            Value<int?> freqValue = const Value.absent(),
            Value<String?> freqDisplayValue = const Value.absent(),
          }) =>
              KanjiMetaBankV3TableCompanion.insert(
            id: id,
            dictId: dictId,
            kanjiId: kanjiId,
            typeId: typeId,
            freqValue: freqValue,
            freqDisplayValue: freqDisplayValue,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiMetaBankV3TableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (typeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.typeId,
                    referencedTable:
                        $$KanjiMetaBankV3TableTableReferences._typeIdTable(db),
                    referencedColumn: $$KanjiMetaBankV3TableTableReferences
                        ._typeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KanjiMetaBankV3TableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiMetaBankV3TableTable,
        KanjiMetaBankV3TableData,
        $$KanjiMetaBankV3TableTableFilterComposer,
        $$KanjiMetaBankV3TableTableOrderingComposer,
        $$KanjiMetaBankV3TableTableAnnotationComposer,
        $$KanjiMetaBankV3TableTableCreateCompanionBuilder,
        $$KanjiMetaBankV3TableTableUpdateCompanionBuilder,
        (KanjiMetaBankV3TableData, $$KanjiMetaBankV3TableTableReferences),
        KanjiMetaBankV3TableData,
        PrefetchHooks Function({bool typeId})>;
typedef $$TermMetaBankV3TypeTableTableCreateCompanionBuilder
    = TermMetaBankV3TypeTableCompanion Function({
  Value<int> id,
  required String type,
});
typedef $$TermMetaBankV3TypeTableTableUpdateCompanionBuilder
    = TermMetaBankV3TypeTableCompanion Function({
  Value<int> id,
  Value<String> type,
});

final class $$TermMetaBankV3TypeTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $TermMetaBankV3TypeTableTable, TermMetaBankV3TypeTableData> {
  $$TermMetaBankV3TypeTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TermMetaBankV3TableTable,
      List<TermMetaBankV3TableData>> _termMetaBankV3TableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.termMetaBankV3Table,
          aliasName: $_aliasNameGenerator(
              db.termMetaBankV3TypeTable.id, db.termMetaBankV3Table.typeId));

  $$TermMetaBankV3TableTableProcessedTableManager get termMetaBankV3TableRefs {
    final manager =
        $$TermMetaBankV3TableTableTableManager($_db, $_db.termMetaBankV3Table)
            .filter((f) => f.typeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_termMetaBankV3TableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TermMetaBankV3TypeTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3TypeTableTable> {
  $$TermMetaBankV3TypeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  Expression<bool> termMetaBankV3TableRefs(
      Expression<bool> Function($$TermMetaBankV3TableTableFilterComposer f) f) {
    final $$TermMetaBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.termMetaBankV3Table,
        getReferencedColumn: (t) => t.typeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TermMetaBankV3TableTableFilterComposer(
              $db: $db,
              $table: $db.termMetaBankV3Table,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TermMetaBankV3TypeTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3TypeTableTable> {
  $$TermMetaBankV3TypeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));
}

class $$TermMetaBankV3TypeTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3TypeTableTable> {
  $$TermMetaBankV3TypeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  Expression<T> termMetaBankV3TableRefs<T extends Object>(
      Expression<T> Function($$TermMetaBankV3TableTableAnnotationComposer a)
          f) {
    final $$TermMetaBankV3TableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.termMetaBankV3Table,
            getReferencedColumn: (t) => t.typeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TermMetaBankV3TableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.termMetaBankV3Table,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TermMetaBankV3TypeTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TermMetaBankV3TypeTableTable,
    TermMetaBankV3TypeTableData,
    $$TermMetaBankV3TypeTableTableFilterComposer,
    $$TermMetaBankV3TypeTableTableOrderingComposer,
    $$TermMetaBankV3TypeTableTableAnnotationComposer,
    $$TermMetaBankV3TypeTableTableCreateCompanionBuilder,
    $$TermMetaBankV3TypeTableTableUpdateCompanionBuilder,
    (TermMetaBankV3TypeTableData, $$TermMetaBankV3TypeTableTableReferences),
    TermMetaBankV3TypeTableData,
    PrefetchHooks Function({bool termMetaBankV3TableRefs})> {
  $$TermMetaBankV3TypeTableTableTableManager(
      _$DaKanjiDB db, $TermMetaBankV3TypeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaBankV3TypeTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TermMetaBankV3TypeTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermMetaBankV3TypeTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
          }) =>
              TermMetaBankV3TypeTableCompanion(
            id: id,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String type,
          }) =>
              TermMetaBankV3TypeTableCompanion.insert(
            id: id,
            type: type,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TermMetaBankV3TypeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({termMetaBankV3TableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (termMetaBankV3TableRefs) db.termMetaBankV3Table
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (termMetaBankV3TableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TermMetaBankV3TypeTableTableReferences
                                ._termMetaBankV3TableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TermMetaBankV3TypeTableTableReferences(
                                    db, table, p0)
                                .termMetaBankV3TableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.typeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TermMetaBankV3TypeTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $TermMetaBankV3TypeTableTable,
        TermMetaBankV3TypeTableData,
        $$TermMetaBankV3TypeTableTableFilterComposer,
        $$TermMetaBankV3TypeTableTableOrderingComposer,
        $$TermMetaBankV3TypeTableTableAnnotationComposer,
        $$TermMetaBankV3TypeTableTableCreateCompanionBuilder,
        $$TermMetaBankV3TypeTableTableUpdateCompanionBuilder,
        (TermMetaBankV3TypeTableData, $$TermMetaBankV3TypeTableTableReferences),
        TermMetaBankV3TypeTableData,
        PrefetchHooks Function({bool termMetaBankV3TableRefs})>;
typedef $$TermMetaBankV3TableTableCreateCompanionBuilder
    = TermMetaBankV3TableCompanion Function({
  Value<int> id,
  required int dictId,
  required int termId,
  Value<String?> reading,
  required int typeId,
  Value<int?> freqValue,
  Value<String?> freqDisplayValue,
});
typedef $$TermMetaBankV3TableTableUpdateCompanionBuilder
    = TermMetaBankV3TableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<int> termId,
  Value<String?> reading,
  Value<int> typeId,
  Value<int?> freqValue,
  Value<String?> freqDisplayValue,
});

final class $$TermMetaBankV3TableTableReferences extends BaseReferences<
    _$DaKanjiDB, $TermMetaBankV3TableTable, TermMetaBankV3TableData> {
  $$TermMetaBankV3TableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TermMetaBankV3TypeTableTable _typeIdTable(_$DaKanjiDB db) =>
      db.termMetaBankV3TypeTable.createAlias($_aliasNameGenerator(
          db.termMetaBankV3Table.typeId, db.termMetaBankV3TypeTable.id));

  $$TermMetaBankV3TypeTableTableProcessedTableManager? get typeId {
    if ($_item.typeId == null) return null;
    final manager = $$TermMetaBankV3TypeTableTableTableManager(
            $_db, $_db.termMetaBankV3TypeTable)
        .filter((f) => f.id($_item.typeId!));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TermMetaBankV3TableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3TableTable> {
  $$TermMetaBankV3TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get termId => $composableBuilder(
      column: $table.termId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get freqValue => $composableBuilder(
      column: $table.freqValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get freqDisplayValue => $composableBuilder(
      column: $table.freqDisplayValue,
      builder: (column) => ColumnFilters(column));

  $$TermMetaBankV3TypeTableTableFilterComposer get typeId {
    final $$TermMetaBankV3TypeTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.typeId,
            referencedTable: $db.termMetaBankV3TypeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TermMetaBankV3TypeTableTableFilterComposer(
                  $db: $db,
                  $table: $db.termMetaBankV3TypeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TermMetaBankV3TableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3TableTable> {
  $$TermMetaBankV3TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get termId => $composableBuilder(
      column: $table.termId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get freqValue => $composableBuilder(
      column: $table.freqValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get freqDisplayValue => $composableBuilder(
      column: $table.freqDisplayValue,
      builder: (column) => ColumnOrderings(column));

  $$TermMetaBankV3TypeTableTableOrderingComposer get typeId {
    final $$TermMetaBankV3TypeTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.typeId,
            referencedTable: $db.termMetaBankV3TypeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TermMetaBankV3TypeTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.termMetaBankV3TypeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TermMetaBankV3TableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3TableTable> {
  $$TermMetaBankV3TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

  GeneratedColumn<int> get termId =>
      $composableBuilder(column: $table.termId, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<int> get freqValue =>
      $composableBuilder(column: $table.freqValue, builder: (column) => column);

  GeneratedColumn<String> get freqDisplayValue => $composableBuilder(
      column: $table.freqDisplayValue, builder: (column) => column);

  $$TermMetaBankV3TypeTableTableAnnotationComposer get typeId {
    final $$TermMetaBankV3TypeTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.typeId,
            referencedTable: $db.termMetaBankV3TypeTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TermMetaBankV3TypeTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.termMetaBankV3TypeTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TermMetaBankV3TableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TermMetaBankV3TableTable,
    TermMetaBankV3TableData,
    $$TermMetaBankV3TableTableFilterComposer,
    $$TermMetaBankV3TableTableOrderingComposer,
    $$TermMetaBankV3TableTableAnnotationComposer,
    $$TermMetaBankV3TableTableCreateCompanionBuilder,
    $$TermMetaBankV3TableTableUpdateCompanionBuilder,
    (TermMetaBankV3TableData, $$TermMetaBankV3TableTableReferences),
    TermMetaBankV3TableData,
    PrefetchHooks Function({bool typeId})> {
  $$TermMetaBankV3TableTableTableManager(
      _$DaKanjiDB db, $TermMetaBankV3TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaBankV3TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermMetaBankV3TableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermMetaBankV3TableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dictId = const Value.absent(),
            Value<int> termId = const Value.absent(),
            Value<String?> reading = const Value.absent(),
            Value<int> typeId = const Value.absent(),
            Value<int?> freqValue = const Value.absent(),
            Value<String?> freqDisplayValue = const Value.absent(),
          }) =>
              TermMetaBankV3TableCompanion(
            id: id,
            dictId: dictId,
            termId: termId,
            reading: reading,
            typeId: typeId,
            freqValue: freqValue,
            freqDisplayValue: freqDisplayValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int termId,
            Value<String?> reading = const Value.absent(),
            required int typeId,
            Value<int?> freqValue = const Value.absent(),
            Value<String?> freqDisplayValue = const Value.absent(),
          }) =>
              TermMetaBankV3TableCompanion.insert(
            id: id,
            dictId: dictId,
            termId: termId,
            reading: reading,
            typeId: typeId,
            freqValue: freqValue,
            freqDisplayValue: freqDisplayValue,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TermMetaBankV3TableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (typeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.typeId,
                    referencedTable:
                        $$TermMetaBankV3TableTableReferences._typeIdTable(db),
                    referencedColumn: $$TermMetaBankV3TableTableReferences
                        ._typeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TermMetaBankV3TableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $TermMetaBankV3TableTable,
    TermMetaBankV3TableData,
    $$TermMetaBankV3TableTableFilterComposer,
    $$TermMetaBankV3TableTableOrderingComposer,
    $$TermMetaBankV3TableTableAnnotationComposer,
    $$TermMetaBankV3TableTableCreateCompanionBuilder,
    $$TermMetaBankV3TableTableUpdateCompanionBuilder,
    (TermMetaBankV3TableData, $$TermMetaBankV3TableTableReferences),
    TermMetaBankV3TableData,
    PrefetchHooks Function({bool typeId})>;
typedef $$TermMetaBankV3PitchTableTableCreateCompanionBuilder
    = TermMetaBankV3PitchTableCompanion Function({
  Value<int> id,
  required int position,
  Value<int?> tagId,
  Value<int?> nasal,
  Value<int?> devoice,
});
typedef $$TermMetaBankV3PitchTableTableUpdateCompanionBuilder
    = TermMetaBankV3PitchTableCompanion Function({
  Value<int> id,
  Value<int> position,
  Value<int?> tagId,
  Value<int?> nasal,
  Value<int?> devoice,
});

class $$TermMetaBankV3PitchTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3PitchTableTable> {
  $$TermMetaBankV3PitchTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nasal => $composableBuilder(
      column: $table.nasal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get devoice => $composableBuilder(
      column: $table.devoice, builder: (column) => ColumnFilters(column));
}

class $$TermMetaBankV3PitchTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3PitchTableTable> {
  $$TermMetaBankV3PitchTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nasal => $composableBuilder(
      column: $table.nasal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get devoice => $composableBuilder(
      column: $table.devoice, builder: (column) => ColumnOrderings(column));
}

class $$TermMetaBankV3PitchTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3PitchTableTable> {
  $$TermMetaBankV3PitchTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<int> get nasal =>
      $composableBuilder(column: $table.nasal, builder: (column) => column);

  GeneratedColumn<int> get devoice =>
      $composableBuilder(column: $table.devoice, builder: (column) => column);
}

class $$TermMetaBankV3PitchTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TermMetaBankV3PitchTableTable,
    TermMetaBankV3PitchTableData,
    $$TermMetaBankV3PitchTableTableFilterComposer,
    $$TermMetaBankV3PitchTableTableOrderingComposer,
    $$TermMetaBankV3PitchTableTableAnnotationComposer,
    $$TermMetaBankV3PitchTableTableCreateCompanionBuilder,
    $$TermMetaBankV3PitchTableTableUpdateCompanionBuilder,
    (
      TermMetaBankV3PitchTableData,
      BaseReferences<_$DaKanjiDB, $TermMetaBankV3PitchTableTable,
          TermMetaBankV3PitchTableData>
    ),
    TermMetaBankV3PitchTableData,
    PrefetchHooks Function()> {
  $$TermMetaBankV3PitchTableTableTableManager(
      _$DaKanjiDB db, $TermMetaBankV3PitchTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaBankV3PitchTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TermMetaBankV3PitchTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermMetaBankV3PitchTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int?> tagId = const Value.absent(),
            Value<int?> nasal = const Value.absent(),
            Value<int?> devoice = const Value.absent(),
          }) =>
              TermMetaBankV3PitchTableCompanion(
            id: id,
            position: position,
            tagId: tagId,
            nasal: nasal,
            devoice: devoice,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int position,
            Value<int?> tagId = const Value.absent(),
            Value<int?> nasal = const Value.absent(),
            Value<int?> devoice = const Value.absent(),
          }) =>
              TermMetaBankV3PitchTableCompanion.insert(
            id: id,
            position: position,
            tagId: tagId,
            nasal: nasal,
            devoice: devoice,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TermMetaBankV3PitchTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $TermMetaBankV3PitchTableTable,
        TermMetaBankV3PitchTableData,
        $$TermMetaBankV3PitchTableTableFilterComposer,
        $$TermMetaBankV3PitchTableTableOrderingComposer,
        $$TermMetaBankV3PitchTableTableAnnotationComposer,
        $$TermMetaBankV3PitchTableTableCreateCompanionBuilder,
        $$TermMetaBankV3PitchTableTableUpdateCompanionBuilder,
        (
          TermMetaBankV3PitchTableData,
          BaseReferences<_$DaKanjiDB, $TermMetaBankV3PitchTableTable,
              TermMetaBankV3PitchTableData>
        ),
        TermMetaBankV3PitchTableData,
        PrefetchHooks Function()>;
typedef $$TermMetaBankV3IpaTableTableCreateCompanionBuilder
    = TermMetaBankV3IpaTableCompanion Function({
  Value<int> id,
  required String ipa,
});
typedef $$TermMetaBankV3IpaTableTableUpdateCompanionBuilder
    = TermMetaBankV3IpaTableCompanion Function({
  Value<int> id,
  Value<String> ipa,
});

class $$TermMetaBankV3IpaTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3IpaTableTable> {
  $$TermMetaBankV3IpaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ipa => $composableBuilder(
      column: $table.ipa, builder: (column) => ColumnFilters(column));
}

class $$TermMetaBankV3IpaTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3IpaTableTable> {
  $$TermMetaBankV3IpaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ipa => $composableBuilder(
      column: $table.ipa, builder: (column) => ColumnOrderings(column));
}

class $$TermMetaBankV3IpaTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3IpaTableTable> {
  $$TermMetaBankV3IpaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ipa =>
      $composableBuilder(column: $table.ipa, builder: (column) => column);
}

class $$TermMetaBankV3IpaTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TermMetaBankV3IpaTableTable,
    TermMetaBankV3IpaTableData,
    $$TermMetaBankV3IpaTableTableFilterComposer,
    $$TermMetaBankV3IpaTableTableOrderingComposer,
    $$TermMetaBankV3IpaTableTableAnnotationComposer,
    $$TermMetaBankV3IpaTableTableCreateCompanionBuilder,
    $$TermMetaBankV3IpaTableTableUpdateCompanionBuilder,
    (
      TermMetaBankV3IpaTableData,
      BaseReferences<_$DaKanjiDB, $TermMetaBankV3IpaTableTable,
          TermMetaBankV3IpaTableData>
    ),
    TermMetaBankV3IpaTableData,
    PrefetchHooks Function()> {
  $$TermMetaBankV3IpaTableTableTableManager(
      _$DaKanjiDB db, $TermMetaBankV3IpaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaBankV3IpaTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TermMetaBankV3IpaTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermMetaBankV3IpaTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> ipa = const Value.absent(),
          }) =>
              TermMetaBankV3IpaTableCompanion(
            id: id,
            ipa: ipa,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String ipa,
          }) =>
              TermMetaBankV3IpaTableCompanion.insert(
            id: id,
            ipa: ipa,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TermMetaBankV3IpaTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $TermMetaBankV3IpaTableTable,
        TermMetaBankV3IpaTableData,
        $$TermMetaBankV3IpaTableTableFilterComposer,
        $$TermMetaBankV3IpaTableTableOrderingComposer,
        $$TermMetaBankV3IpaTableTableAnnotationComposer,
        $$TermMetaBankV3IpaTableTableCreateCompanionBuilder,
        $$TermMetaBankV3IpaTableTableUpdateCompanionBuilder,
        (
          TermMetaBankV3IpaTableData,
          BaseReferences<_$DaKanjiDB, $TermMetaBankV3IpaTableTable,
              TermMetaBankV3IpaTableData>
        ),
        TermMetaBankV3IpaTableData,
        PrefetchHooks Function()>;
typedef $$TermMetaBankV3IpaTagTableTableCreateCompanionBuilder
    = TermMetaBankV3IpaTagTableCompanion Function({
  Value<int> id,
  required String tag,
});
typedef $$TermMetaBankV3IpaTagTableTableUpdateCompanionBuilder
    = TermMetaBankV3IpaTagTableCompanion Function({
  Value<int> id,
  Value<String> tag,
});

class $$TermMetaBankV3IpaTagTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3IpaTagTableTable> {
  $$TermMetaBankV3IpaTagTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));
}

class $$TermMetaBankV3IpaTagTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3IpaTagTableTable> {
  $$TermMetaBankV3IpaTagTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));
}

class $$TermMetaBankV3IpaTagTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $TermMetaBankV3IpaTagTableTable> {
  $$TermMetaBankV3IpaTagTableTableAnnotationComposer({
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
}

class $$TermMetaBankV3IpaTagTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $TermMetaBankV3IpaTagTableTable,
    TermMetaBankV3IpaTagTableData,
    $$TermMetaBankV3IpaTagTableTableFilterComposer,
    $$TermMetaBankV3IpaTagTableTableOrderingComposer,
    $$TermMetaBankV3IpaTagTableTableAnnotationComposer,
    $$TermMetaBankV3IpaTagTableTableCreateCompanionBuilder,
    $$TermMetaBankV3IpaTagTableTableUpdateCompanionBuilder,
    (
      TermMetaBankV3IpaTagTableData,
      BaseReferences<_$DaKanjiDB, $TermMetaBankV3IpaTagTableTable,
          TermMetaBankV3IpaTagTableData>
    ),
    TermMetaBankV3IpaTagTableData,
    PrefetchHooks Function()> {
  $$TermMetaBankV3IpaTagTableTableTableManager(
      _$DaKanjiDB db, $TermMetaBankV3IpaTagTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermMetaBankV3IpaTagTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TermMetaBankV3IpaTagTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermMetaBankV3IpaTagTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tag = const Value.absent(),
          }) =>
              TermMetaBankV3IpaTagTableCompanion(
            id: id,
            tag: tag,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tag,
          }) =>
              TermMetaBankV3IpaTagTableCompanion.insert(
            id: id,
            tag: tag,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TermMetaBankV3IpaTagTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $TermMetaBankV3IpaTagTableTable,
        TermMetaBankV3IpaTagTableData,
        $$TermMetaBankV3IpaTagTableTableFilterComposer,
        $$TermMetaBankV3IpaTagTableTableOrderingComposer,
        $$TermMetaBankV3IpaTagTableTableAnnotationComposer,
        $$TermMetaBankV3IpaTagTableTableCreateCompanionBuilder,
        $$TermMetaBankV3IpaTagTableTableUpdateCompanionBuilder,
        (
          TermMetaBankV3IpaTagTableData,
          BaseReferences<_$DaKanjiDB, $TermMetaBankV3IpaTagTableTable,
              TermMetaBankV3IpaTagTableData>
        ),
        TermMetaBankV3IpaTagTableData,
        PrefetchHooks Function()>;

class $DaKanjiDBManager {
  final _$DaKanjiDB _db;
  $DaKanjiDBManager(this._db);
  $$KanjiTableTableTableManager get kanjiTable =>
      $$KanjiTableTableTableManager(_db, _db.kanjiTable);
  $$TermTableTableTableManager get termTable =>
      $$TermTableTableTableManager(_db, _db.termTable);
  $$ReadingTableTableTableManager get readingTable =>
      $$ReadingTableTableTableManager(_db, _db.readingTable);
  $$RadicalsKanjiTableTableTableManager get radicalsKanjiTable =>
      $$RadicalsKanjiTableTableTableManager(_db, _db.radicalsKanjiTable);
  $$RadicalsTableTableTableManager get radicalsTable =>
      $$RadicalsTableTableTableManager(_db, _db.radicalsTable);
  $$RadicalKanjiRelationsTableTableTableManager
      get radicalKanjiRelationsTable =>
          $$RadicalKanjiRelationsTableTableTableManager(
              _db, _db.radicalKanjiRelationsTable);
  $$KanjiVGTableTableTableManager get kanjiVGTable =>
      $$KanjiVGTableTableTableManager(_db, _db.kanjiVGTable);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db, _db.indexTable);
  $$TagBankV3TableTableTableManager get tagBankV3Table =>
      $$TagBankV3TableTableTableManager(_db, _db.tagBankV3Table);
  $$TagBankV3CategoryTableTableTableManager get tagBankV3CategoryTable =>
      $$TagBankV3CategoryTableTableTableManager(
          _db, _db.tagBankV3CategoryTable);
  $$TagBankV3TagCategoryRelationsTableTableTableManager
      get tagBankV3TagCategoryRelationsTable =>
          $$TagBankV3TagCategoryRelationsTableTableTableManager(
              _db, _db.tagBankV3TagCategoryRelationsTable);
  $$KanjiBankV3TableTableTableManager get kanjiBankV3Table =>
      $$KanjiBankV3TableTableTableManager(_db, _db.kanjiBankV3Table);
  $$KanjiBankV3OnyomisTableTableTableManager get kanjiBankV3OnyomisTable =>
      $$KanjiBankV3OnyomisTableTableTableManager(
          _db, _db.kanjiBankV3OnyomisTable);
  $$KanjiBankV3OnyomiKanjiRelationsTableTableTableManager
      get kanjiBankV3OnyomiKanjiRelationsTable =>
          $$KanjiBankV3OnyomiKanjiRelationsTableTableTableManager(
              _db, _db.kanjiBankV3OnyomiKanjiRelationsTable);
  $$KanjiBankV3KunyomisTableTableTableManager get kanjiBankV3KunyomisTable =>
      $$KanjiBankV3KunyomisTableTableTableManager(
          _db, _db.kanjiBankV3KunyomisTable);
  $$KanjiBankV3KunyomiKanjiRelationsTableTableTableManager
      get kanjiBankV3KunyomiKanjiRelationsTable =>
          $$KanjiBankV3KunyomiKanjiRelationsTableTableTableManager(
              _db, _db.kanjiBankV3KunyomiKanjiRelationsTable);
  $$KanjiBankV3TagsKanjiRelationsTableTableTableManager
      get kanjiBankV3TagsKanjiRelationsTable =>
          $$KanjiBankV3TagsKanjiRelationsTableTableTableManager(
              _db, _db.kanjiBankV3TagsKanjiRelationsTable);
  $$KanjiBankV3MeaningsTableTableTableManager get kanjiBankV3MeaningsTable =>
      $$KanjiBankV3MeaningsTableTableTableManager(
          _db, _db.kanjiBankV3MeaningsTable);
  $$KanjiBankV3MeaningsKanjiRelationsTableTableTableManager
      get kanjiBankV3MeaningsKanjiRelationsTable =>
          $$KanjiBankV3MeaningsKanjiRelationsTableTableTableManager(
              _db, _db.kanjiBankV3MeaningsKanjiRelationsTable);
  $$KanjiBankV3StatNamesTableTableTableManager get kanjiBankV3StatNamesTable =>
      $$KanjiBankV3StatNamesTableTableTableManager(
          _db, _db.kanjiBankV3StatNamesTable);
  $$KanjiBankV3StatValuesTableTableTableManager
      get kanjiBankV3StatValuesTable =>
          $$KanjiBankV3StatValuesTableTableTableManager(
              _db, _db.kanjiBankV3StatValuesTable);
  $$KanjiBankV3StatsTableTableTableManager get kanjiBankV3StatsTable =>
      $$KanjiBankV3StatsTableTableTableManager(_db, _db.kanjiBankV3StatsTable);
  $$KanjiBankV3StatKanjiRelationsTableTableTableManager
      get kanjiBankV3StatKanjiRelationsTable =>
          $$KanjiBankV3StatKanjiRelationsTableTableTableManager(
              _db, _db.kanjiBankV3StatKanjiRelationsTable);
  $$KanjiMetaBankV3TypeTableTableTableManager get kanjiMetaBankV3TypeTable =>
      $$KanjiMetaBankV3TypeTableTableTableManager(
          _db, _db.kanjiMetaBankV3TypeTable);
  $$KanjiMetaBankV3TableTableTableManager get kanjiMetaBankV3Table =>
      $$KanjiMetaBankV3TableTableTableManager(_db, _db.kanjiMetaBankV3Table);
  $$TermMetaBankV3TypeTableTableTableManager get termMetaBankV3TypeTable =>
      $$TermMetaBankV3TypeTableTableTableManager(
          _db, _db.termMetaBankV3TypeTable);
  $$TermMetaBankV3TableTableTableManager get termMetaBankV3Table =>
      $$TermMetaBankV3TableTableTableManager(_db, _db.termMetaBankV3Table);
  $$TermMetaBankV3PitchTableTableTableManager get termMetaBankV3PitchTable =>
      $$TermMetaBankV3PitchTableTableTableManager(
          _db, _db.termMetaBankV3PitchTable);
  $$TermMetaBankV3IpaTableTableTableManager get termMetaBankV3IpaTable =>
      $$TermMetaBankV3IpaTableTableTableManager(
          _db, _db.termMetaBankV3IpaTable);
  $$TermMetaBankV3IpaTagTableTableTableManager get termMetaBankV3IpaTagTable =>
      $$TermMetaBankV3IpaTagTableTableTableManager(
          _db, _db.termMetaBankV3IpaTagTable);
}
