// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dakanji_db.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji =
      GeneratedColumn<String>('kanji', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kanji];
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
  KanjiBankV3TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kanji'])!,
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

  /// the kanji character of this entry
  /// this column is indexed
  final String kanji;
  const KanjiBankV3TableData({required this.id, required this.kanji});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji'] = Variable<String>(kanji);
    return map;
  }

  KanjiBankV3TableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TableCompanion(
      id: Value(id),
      kanji: Value(kanji),
    );
  }

  factory KanjiBankV3TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TableData(
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

  KanjiBankV3TableData copyWith({int? id, String? kanji}) =>
      KanjiBankV3TableData(
        id: id ?? this.id,
        kanji: kanji ?? this.kanji,
      );
  KanjiBankV3TableData copyWithCompanion(KanjiBankV3TableCompanion data) {
    return KanjiBankV3TableData(
      id: data.id.present ? data.id.value : this.id,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TableData(')
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
      (other is KanjiBankV3TableData &&
          other.id == this.id &&
          other.kanji == this.kanji);
}

class KanjiBankV3TableCompanion extends UpdateCompanion<KanjiBankV3TableData> {
  final Value<int> id;
  final Value<String> kanji;
  const KanjiBankV3TableCompanion({
    this.id = const Value.absent(),
    this.kanji = const Value.absent(),
  });
  KanjiBankV3TableCompanion.insert({
    this.id = const Value.absent(),
    required String kanji,
  }) : kanji = Value(kanji);
  static Insertable<KanjiBankV3TableData> custom({
    Expression<int>? id,
    Expression<String>? kanji,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanji != null) 'kanji': kanji,
    });
  }

  KanjiBankV3TableCompanion copyWith({Value<int>? id, Value<String>? kanji}) {
    return KanjiBankV3TableCompanion(
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
    return (StringBuffer('KanjiBankV3TableCompanion(')
          ..write('id: $id, ')
          ..write('kanji: $kanji')
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
  static const VerificationMeta _kanjiBankV3IDMeta =
      const VerificationMeta('kanjiBankV3ID');
  @override
  late final GeneratedColumn<int> kanjiBankV3ID = GeneratedColumn<int>(
      'kanji_bank_v3_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  static const VerificationMeta _onyomiMeta = const VerificationMeta('onyomi');
  @override
  late final GeneratedColumn<String> onyomi = GeneratedColumn<String>(
      'onyomi', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, kanjiBankV3ID, onyomi];
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
    if (data.containsKey('kanji_bank_v3_i_d')) {
      context.handle(
          _kanjiBankV3IDMeta,
          kanjiBankV3ID.isAcceptableOrUnknown(
              data['kanji_bank_v3_i_d']!, _kanjiBankV3IDMeta));
    } else if (isInserting) {
      context.missing(_kanjiBankV3IDMeta);
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
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
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

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The onyomi reading of this entry
  final String onyomi;
  const KanjiBankV3OnyomisTableData(
      {required this.id, required this.kanjiBankV3ID, required this.onyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['onyomi'] = Variable<String>(onyomi);
    return map;
  }

  KanjiBankV3OnyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3OnyomisTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      onyomi: Value(onyomi),
    );
  }

  factory KanjiBankV3OnyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3OnyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      onyomi: serializer.fromJson<String>(json['onyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'onyomi': serializer.toJson<String>(onyomi),
    };
  }

  KanjiBankV3OnyomisTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? onyomi}) =>
      KanjiBankV3OnyomisTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        onyomi: onyomi ?? this.onyomi,
      );
  KanjiBankV3OnyomisTableData copyWithCompanion(
      KanjiBankV3OnyomisTableCompanion data) {
    return KanjiBankV3OnyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      onyomi: data.onyomi.present ? data.onyomi.value : this.onyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomisTableData(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('onyomi: $onyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiBankV3ID, onyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3OnyomisTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.onyomi == this.onyomi);
}

class KanjiBankV3OnyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3OnyomisTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> onyomi;
  const KanjiBankV3OnyomisTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.onyomi = const Value.absent(),
  });
  KanjiBankV3OnyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String onyomi,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        onyomi = Value(onyomi);
  static Insertable<KanjiBankV3OnyomisTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? onyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (onyomi != null) 'onyomi': onyomi,
    });
  }

  KanjiBankV3OnyomisTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? onyomi}) {
    return KanjiBankV3OnyomisTableCompanion(
      id: id ?? this.id,
      kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
      onyomi: onyomi ?? this.onyomi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiBankV3ID.present) {
      map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID.value);
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
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  /// id of this realtion
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
  static const VerificationMeta _kanjiBankV3IDMeta =
      const VerificationMeta('kanjiBankV3ID');
  @override
  late final GeneratedColumn<int> kanjiBankV3ID = GeneratedColumn<int>(
      'kanji_bank_v3_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  static const VerificationMeta _kunyomiMeta =
      const VerificationMeta('kunyomi');
  @override
  late final GeneratedColumn<String> kunyomi = GeneratedColumn<String>(
      'kunyomi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kanjiBankV3ID, kunyomi];
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
    if (data.containsKey('kanji_bank_v3_i_d')) {
      context.handle(
          _kanjiBankV3IDMeta,
          kanjiBankV3ID.isAcceptableOrUnknown(
              data['kanji_bank_v3_i_d']!, _kanjiBankV3IDMeta));
    } else if (isInserting) {
      context.missing(_kanjiBankV3IDMeta);
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
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
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

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The kunyomi reading of this entry
  final String kunyomi;
  const KanjiBankV3KunyomisTableData(
      {required this.id, required this.kanjiBankV3ID, required this.kunyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['kunyomi'] = Variable<String>(kunyomi);
    return map;
  }

  KanjiBankV3KunyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3KunyomisTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      kunyomi: Value(kunyomi),
    );
  }

  factory KanjiBankV3KunyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3KunyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      kunyomi: serializer.fromJson<String>(json['kunyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'kunyomi': serializer.toJson<String>(kunyomi),
    };
  }

  KanjiBankV3KunyomisTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? kunyomi}) =>
      KanjiBankV3KunyomisTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        kunyomi: kunyomi ?? this.kunyomi,
      );
  KanjiBankV3KunyomisTableData copyWithCompanion(
      KanjiBankV3KunyomisTableCompanion data) {
    return KanjiBankV3KunyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      kunyomi: data.kunyomi.present ? data.kunyomi.value : this.kunyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomisTableData(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiBankV3ID, kunyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3KunyomisTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.kunyomi == this.kunyomi);
}

class KanjiBankV3KunyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3KunyomisTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> kunyomi;
  const KanjiBankV3KunyomisTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.kunyomi = const Value.absent(),
  });
  KanjiBankV3KunyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String kunyomi,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        kunyomi = Value(kunyomi);
  static Insertable<KanjiBankV3KunyomisTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? kunyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (kunyomi != null) 'kunyomi': kunyomi,
    });
  }

  KanjiBankV3KunyomisTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? kunyomi}) {
    return KanjiBankV3KunyomisTableCompanion(
      id: id ?? this.id,
      kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
      kunyomi: kunyomi ?? this.kunyomi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiBankV3ID.present) {
      map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID.value);
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
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3TagsTableTable extends KanjiBankV3TagsTable
    with TableInfo<$KanjiBankV3TagsTableTable, KanjiBankV3TagsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3TagsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kanjiBankV3IDMeta =
      const VerificationMeta('kanjiBankV3ID');
  @override
  late final GeneratedColumn<int> kanjiBankV3ID = GeneratedColumn<int>(
      'kanji_bank_v3_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kanjiBankV3ID, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_tags_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3TagsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji_bank_v3_i_d')) {
      context.handle(
          _kanjiBankV3IDMeta,
          kanjiBankV3ID.isAcceptableOrUnknown(
              data['kanji_bank_v3_i_d']!, _kanjiBankV3IDMeta));
    } else if (isInserting) {
      context.missing(_kanjiBankV3IDMeta);
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
  KanjiBankV3TagsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3TagsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $KanjiBankV3TagsTableTable createAlias(String alias) {
    return $KanjiBankV3TagsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3TagsTableData extends DataClass
    implements Insertable<KanjiBankV3TagsTableData> {
  /// id of this meaning
  final int id;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The kunyomi reading of this entry
  final String tag;
  const KanjiBankV3TagsTableData(
      {required this.id, required this.kanjiBankV3ID, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  KanjiBankV3TagsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TagsTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      tag: Value(tag),
    );
  }

  factory KanjiBankV3TagsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TagsTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'tag': serializer.toJson<String>(tag),
    };
  }

  KanjiBankV3TagsTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? tag}) =>
      KanjiBankV3TagsTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        tag: tag ?? this.tag,
      );
  KanjiBankV3TagsTableData copyWithCompanion(
      KanjiBankV3TagsTableCompanion data) {
    return KanjiBankV3TagsTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TagsTableData(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiBankV3ID, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3TagsTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.tag == this.tag);
}

class KanjiBankV3TagsTableCompanion
    extends UpdateCompanion<KanjiBankV3TagsTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> tag;
  const KanjiBankV3TagsTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.tag = const Value.absent(),
  });
  KanjiBankV3TagsTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String tag,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        tag = Value(tag);
  static Insertable<KanjiBankV3TagsTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (tag != null) 'tag': tag,
    });
  }

  KanjiBankV3TagsTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? tag}) {
    return KanjiBankV3TagsTableCompanion(
      id: id ?? this.id,
      kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiBankV3ID.present) {
      map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TagsTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('tag: $tag')
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
  static const VerificationMeta _kanjiBankV3IDMeta =
      const VerificationMeta('kanjiBankV3ID');
  @override
  late final GeneratedColumn<int> kanjiBankV3ID = GeneratedColumn<int>(
      'kanji_bank_v3_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  static const VerificationMeta _meaningMeta =
      const VerificationMeta('meaning');
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
      'meaning', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kanjiBankV3ID, meaning];
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
    if (data.containsKey('kanji_bank_v3_i_d')) {
      context.handle(
          _kanjiBankV3IDMeta,
          kanjiBankV3ID.isAcceptableOrUnknown(
              data['kanji_bank_v3_i_d']!, _kanjiBankV3IDMeta));
    } else if (isInserting) {
      context.missing(_kanjiBankV3IDMeta);
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
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
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

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The meaning of this entry
  final String meaning;
  const KanjiBankV3MeaningsTableData(
      {required this.id, required this.kanjiBankV3ID, required this.meaning});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['meaning'] = Variable<String>(meaning);
    return map;
  }

  KanjiBankV3MeaningsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3MeaningsTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      meaning: Value(meaning),
    );
  }

  factory KanjiBankV3MeaningsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3MeaningsTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      meaning: serializer.fromJson<String>(json['meaning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'meaning': serializer.toJson<String>(meaning),
    };
  }

  KanjiBankV3MeaningsTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? meaning}) =>
      KanjiBankV3MeaningsTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        meaning: meaning ?? this.meaning,
      );
  KanjiBankV3MeaningsTableData copyWithCompanion(
      KanjiBankV3MeaningsTableCompanion data) {
    return KanjiBankV3MeaningsTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3MeaningsTableData(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiBankV3ID, meaning);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3MeaningsTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.meaning == this.meaning);
}

class KanjiBankV3MeaningsTableCompanion
    extends UpdateCompanion<KanjiBankV3MeaningsTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> meaning;
  const KanjiBankV3MeaningsTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.meaning = const Value.absent(),
  });
  KanjiBankV3MeaningsTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String meaning,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        meaning = Value(meaning);
  static Insertable<KanjiBankV3MeaningsTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? meaning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (meaning != null) 'meaning': meaning,
    });
  }

  KanjiBankV3MeaningsTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? meaning}) {
    return KanjiBankV3MeaningsTableCompanion(
      id: id ?? this.id,
      kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
      meaning: meaning ?? this.meaning,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiBankV3ID.present) {
      map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID.value);
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
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('meaning: $meaning')
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
  static const VerificationMeta _kanjiBankV3IDMeta =
      const VerificationMeta('kanjiBankV3ID');
  @override
  late final GeneratedColumn<int> kanjiBankV3ID = GeneratedColumn<int>(
      'kanji_bank_v3_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_table (id)'));
  static const VerificationMeta _statNameMeta =
      const VerificationMeta('statName');
  @override
  late final GeneratedColumn<String> statName = GeneratedColumn<String>(
      'stat_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statValueMeta =
      const VerificationMeta('statValue');
  @override
  late final GeneratedColumn<String> statValue = GeneratedColumn<String>(
      'stat_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, kanjiBankV3ID, statName, statValue];
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
    if (data.containsKey('kanji_bank_v3_i_d')) {
      context.handle(
          _kanjiBankV3IDMeta,
          kanjiBankV3ID.isAcceptableOrUnknown(
              data['kanji_bank_v3_i_d']!, _kanjiBankV3IDMeta));
    } else if (isInserting) {
      context.missing(_kanjiBankV3IDMeta);
    }
    if (data.containsKey('stat_name')) {
      context.handle(_statNameMeta,
          statName.isAcceptableOrUnknown(data['stat_name']!, _statNameMeta));
    } else if (isInserting) {
      context.missing(_statNameMeta);
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
  KanjiBankV3StatsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3StatsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
      statName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stat_name'])!,
      statValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stat_value'])!,
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

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The name of this entrie's stat
  final String statName;

  /// The value of this entrie's stat
  final String statValue;
  const KanjiBankV3StatsTableData(
      {required this.id,
      required this.kanjiBankV3ID,
      required this.statName,
      required this.statValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['stat_name'] = Variable<String>(statName);
    map['stat_value'] = Variable<String>(statValue);
    return map;
  }

  KanjiBankV3StatsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatsTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      statName: Value(statName),
      statValue: Value(statValue),
    );
  }

  factory KanjiBankV3StatsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatsTableData(
      id: serializer.fromJson<int>(json['id']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      statName: serializer.fromJson<String>(json['statName']),
      statValue: serializer.fromJson<String>(json['statValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'statName': serializer.toJson<String>(statName),
      'statValue': serializer.toJson<String>(statValue),
    };
  }

  KanjiBankV3StatsTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? statName, String? statValue}) =>
      KanjiBankV3StatsTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        statName: statName ?? this.statName,
        statValue: statValue ?? this.statValue,
      );
  KanjiBankV3StatsTableData copyWithCompanion(
      KanjiBankV3StatsTableCompanion data) {
    return KanjiBankV3StatsTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      statName: data.statName.present ? data.statName.value : this.statName,
      statValue: data.statValue.present ? data.statValue.value : this.statValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatsTableData(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('statName: $statName, ')
          ..write('statValue: $statValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanjiBankV3ID, statName, statValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatsTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.statName == this.statName &&
          other.statValue == this.statValue);
}

class KanjiBankV3StatsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatsTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> statName;
  final Value<String> statValue;
  const KanjiBankV3StatsTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.statName = const Value.absent(),
    this.statValue = const Value.absent(),
  });
  KanjiBankV3StatsTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String statName,
    required String statValue,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        statName = Value(statName),
        statValue = Value(statValue);
  static Insertable<KanjiBankV3StatsTableData> custom({
    Expression<int>? id,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? statName,
    Expression<String>? statValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (statName != null) 'stat_name': statName,
      if (statValue != null) 'stat_value': statValue,
    });
  }

  KanjiBankV3StatsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? kanjiBankV3ID,
      Value<String>? statName,
      Value<String>? statValue}) {
    return KanjiBankV3StatsTableCompanion(
      id: id ?? this.id,
      kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
      statName: statName ?? this.statName,
      statValue: statValue ?? this.statValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanjiBankV3ID.present) {
      map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID.value);
    }
    if (statName.present) {
      map['stat_name'] = Variable<String>(statName.value);
    }
    if (statValue.present) {
      map['stat_value'] = Variable<String>(statValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatsTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('statName: $statName, ')
          ..write('statValue: $statValue')
          ..write(')'))
        .toString();
  }
}

abstract class _$DaKanjiDB extends GeneratedDatabase {
  _$DaKanjiDB(QueryExecutor e) : super(e);
  $DaKanjiDBManager get managers => $DaKanjiDBManager(this);
  late final $KanjiBankV3TableTable kanjiBankV3Table =
      $KanjiBankV3TableTable(this);
  late final $KanjiBankV3OnyomisTableTable kanjiBankV3OnyomisTable =
      $KanjiBankV3OnyomisTableTable(this);
  late final $KanjiBankV3OnyomiKanjiRelationsTableTable
      kanjiBankV3OnyomiKanjiRelationsTable =
      $KanjiBankV3OnyomiKanjiRelationsTableTable(this);
  late final $KanjiBankV3KunyomisTableTable kanjiBankV3KunyomisTable =
      $KanjiBankV3KunyomisTableTable(this);
  late final $KanjiBankV3TagsTableTable kanjiBankV3TagsTable =
      $KanjiBankV3TagsTableTable(this);
  late final $KanjiBankV3MeaningsTableTable kanjiBankV3MeaningsTable =
      $KanjiBankV3MeaningsTableTable(this);
  late final $KanjiBankV3StatsTableTable kanjiBankV3StatsTable =
      $KanjiBankV3StatsTableTable(this);
  late final Index kanji =
      Index('kanji', 'CREATE INDEX kanji ON kanji_bank_v3_table (kanji)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        kanjiBankV3Table,
        kanjiBankV3OnyomisTable,
        kanjiBankV3OnyomiKanjiRelationsTable,
        kanjiBankV3KunyomisTable,
        kanjiBankV3TagsTable,
        kanjiBankV3MeaningsTable,
        kanjiBankV3StatsTable,
        kanji
      ];
}

typedef $$KanjiBankV3TableTableCreateCompanionBuilder
    = KanjiBankV3TableCompanion Function({
  Value<int> id,
  required String kanji,
});
typedef $$KanjiBankV3TableTableUpdateCompanionBuilder
    = KanjiBankV3TableCompanion Function({
  Value<int> id,
  Value<String> kanji,
});

final class $$KanjiBankV3TableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3TableTable, KanjiBankV3TableData> {
  $$KanjiBankV3TableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3OnyomisTableTable,
      List<KanjiBankV3OnyomisTableData>> _kanjiBankV3OnyomisTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3OnyomisTable,
          aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
              db.kanjiBankV3OnyomisTable.kanjiBankV3ID));

  $$KanjiBankV3OnyomisTableTableProcessedTableManager
      get kanjiBankV3OnyomisTableRefs {
    final manager = $$KanjiBankV3OnyomisTableTableTableManager(
            $_db, $_db.kanjiBankV3OnyomisTable)
        .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3OnyomisTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3KunyomisTableTable,
      List<KanjiBankV3KunyomisTableData>> _kanjiBankV3KunyomisTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3KunyomisTable,
          aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
              db.kanjiBankV3KunyomisTable.kanjiBankV3ID));

  $$KanjiBankV3KunyomisTableTableProcessedTableManager
      get kanjiBankV3KunyomisTableRefs {
    final manager = $$KanjiBankV3KunyomisTableTableTableManager(
            $_db, $_db.kanjiBankV3KunyomisTable)
        .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3KunyomisTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3TagsTableTable,
      List<KanjiBankV3TagsTableData>> _kanjiBankV3TagsTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3TagsTable,
          aliasName: $_aliasNameGenerator(
              db.kanjiBankV3Table.id, db.kanjiBankV3TagsTable.kanjiBankV3ID));

  $$KanjiBankV3TagsTableTableProcessedTableManager
      get kanjiBankV3TagsTableRefs {
    final manager =
        $$KanjiBankV3TagsTableTableTableManager($_db, $_db.kanjiBankV3TagsTable)
            .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3TagsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3MeaningsTableTable,
      List<KanjiBankV3MeaningsTableData>> _kanjiBankV3MeaningsTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3MeaningsTable,
          aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
              db.kanjiBankV3MeaningsTable.kanjiBankV3ID));

  $$KanjiBankV3MeaningsTableTableProcessedTableManager
      get kanjiBankV3MeaningsTableRefs {
    final manager = $$KanjiBankV3MeaningsTableTableTableManager(
            $_db, $_db.kanjiBankV3MeaningsTable)
        .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3MeaningsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3StatsTableTable,
      List<KanjiBankV3StatsTableData>> _kanjiBankV3StatsTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3StatsTable,
          aliasName: $_aliasNameGenerator(
              db.kanjiBankV3Table.id, db.kanjiBankV3StatsTable.kanjiBankV3ID));

  $$KanjiBankV3StatsTableTableProcessedTableManager
      get kanjiBankV3StatsTableRefs {
    final manager = $$KanjiBankV3StatsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatsTable)
        .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3StatsTableRefsTable($_db));
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

  ColumnFilters<String> get kanji => $composableBuilder(
      column: $table.kanji, builder: (column) => ColumnFilters(column));

  Expression<bool> kanjiBankV3OnyomisTableRefs(
      Expression<bool> Function($$KanjiBankV3OnyomisTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3OnyomisTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
    return f(composer);
  }

  Expression<bool> kanjiBankV3KunyomisTableRefs(
      Expression<bool> Function($$KanjiBankV3KunyomisTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3KunyomisTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomisTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
    return f(composer);
  }

  Expression<bool> kanjiBankV3TagsTableRefs(
      Expression<bool> Function($$KanjiBankV3TagsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3TagsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiBankV3TagsTable,
        getReferencedColumn: (t) => t.kanjiBankV3ID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TagsTableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3TagsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3MeaningsTableRefs(
      Expression<bool> Function($$KanjiBankV3MeaningsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3MeaningsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3MeaningsTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
    return f(composer);
  }

  Expression<bool> kanjiBankV3StatsTableRefs(
      Expression<bool> Function($$KanjiBankV3StatsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3StatsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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

  ColumnOrderings<String> get kanji => $composableBuilder(
      column: $table.kanji, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  Expression<T> kanjiBankV3OnyomisTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3OnyomisTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3OnyomisTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
    return f(composer);
  }

  Expression<T> kanjiBankV3KunyomisTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3KunyomisTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3KunyomisTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomisTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
    return f(composer);
  }

  Expression<T> kanjiBankV3TagsTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3TagsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3TagsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3TagsTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3MeaningsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3MeaningsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3MeaningsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3MeaningsTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
    return f(composer);
  }

  Expression<T> kanjiBankV3StatsTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3StatsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3StatsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatsTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
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
        {bool kanjiBankV3OnyomisTableRefs,
        bool kanjiBankV3KunyomisTableRefs,
        bool kanjiBankV3TagsTableRefs,
        bool kanjiBankV3MeaningsTableRefs,
        bool kanjiBankV3StatsTableRefs})> {
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
            Value<String> kanji = const Value.absent(),
          }) =>
              KanjiBankV3TableCompanion(
            id: id,
            kanji: kanji,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String kanji,
          }) =>
              KanjiBankV3TableCompanion.insert(
            id: id,
            kanji: kanji,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3TableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {kanjiBankV3OnyomisTableRefs = false,
              kanjiBankV3KunyomisTableRefs = false,
              kanjiBankV3TagsTableRefs = false,
              kanjiBankV3MeaningsTableRefs = false,
              kanjiBankV3StatsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3OnyomisTableRefs) db.kanjiBankV3OnyomisTable,
                if (kanjiBankV3KunyomisTableRefs) db.kanjiBankV3KunyomisTable,
                if (kanjiBankV3TagsTableRefs) db.kanjiBankV3TagsTable,
                if (kanjiBankV3MeaningsTableRefs) db.kanjiBankV3MeaningsTable,
                if (kanjiBankV3StatsTableRefs) db.kanjiBankV3StatsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3OnyomisTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3OnyomisTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3OnyomisTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
                        typedResults: items),
                  if (kanjiBankV3KunyomisTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3KunyomisTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3KunyomisTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
                        typedResults: items),
                  if (kanjiBankV3TagsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3TagsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3TagsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
                        typedResults: items),
                  if (kanjiBankV3MeaningsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3MeaningsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3MeaningsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
                        typedResults: items),
                  if (kanjiBankV3StatsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3StatsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3StatsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
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
        {bool kanjiBankV3OnyomisTableRefs,
        bool kanjiBankV3KunyomisTableRefs,
        bool kanjiBankV3TagsTableRefs,
        bool kanjiBankV3MeaningsTableRefs,
        bool kanjiBankV3StatsTableRefs})>;
typedef $$KanjiBankV3OnyomisTableTableCreateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String onyomi,
});
typedef $$KanjiBankV3OnyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> onyomi,
});

final class $$KanjiBankV3OnyomisTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3OnyomisTableTable, KanjiBankV3OnyomisTableData> {
  $$KanjiBankV3OnyomisTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3OnyomisTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiBankV3ID {
    if ($_item.kanjiBankV3ID == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiBankV3ID!));
    final item = $_typedResult.readTableOrNull(_kanjiBankV3IDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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

  $$KanjiBankV3TableTableFilterComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  $$KanjiBankV3TableTableOrderingComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  $$KanjiBankV3TableTableAnnotationComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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
    PrefetchHooks Function({bool kanjiBankV3ID})> {
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
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> onyomi = const Value.absent(),
          }) =>
              KanjiBankV3OnyomisTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            onyomi: onyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String onyomi,
          }) =>
              KanjiBankV3OnyomisTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            onyomi: onyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3OnyomisTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3ID = false}) {
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
                if (kanjiBankV3ID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiBankV3ID,
                    referencedTable: $$KanjiBankV3OnyomisTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3OnyomisTableTableReferences
                        ._kanjiBankV3IDTable(db)
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
        PrefetchHooks Function({bool kanjiBankV3ID})>;
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

  ColumnFilters<int> get onyomiId => $composableBuilder(
      column: $table.onyomiId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get onyomiId => $composableBuilder(
      column: $table.onyomiId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get onyomiId =>
      $composableBuilder(column: $table.onyomiId, builder: (column) => column);

  GeneratedColumn<int> get kanjiId =>
      $composableBuilder(column: $table.kanjiId, builder: (column) => column);
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
          BaseReferences<
              _$DaKanjiDB,
              $KanjiBankV3OnyomiKanjiRelationsTableTable,
              KanjiBankV3OnyomiKanjiRelationsTableData>
        ),
        KanjiBankV3OnyomiKanjiRelationsTableData,
        PrefetchHooks Function()> {
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
          BaseReferences<
              _$DaKanjiDB,
              $KanjiBankV3OnyomiKanjiRelationsTableTable,
              KanjiBankV3OnyomiKanjiRelationsTableData>
        ),
        KanjiBankV3OnyomiKanjiRelationsTableData,
        PrefetchHooks Function()>;
typedef $$KanjiBankV3KunyomisTableTableCreateCompanionBuilder
    = KanjiBankV3KunyomisTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String kunyomi,
});
typedef $$KanjiBankV3KunyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3KunyomisTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> kunyomi,
});

final class $$KanjiBankV3KunyomisTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3KunyomisTableTable, KanjiBankV3KunyomisTableData> {
  $$KanjiBankV3KunyomisTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3KunyomisTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiBankV3ID {
    if ($_item.kanjiBankV3ID == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiBankV3ID!));
    final item = $_typedResult.readTableOrNull(_kanjiBankV3IDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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

  $$KanjiBankV3TableTableFilterComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  $$KanjiBankV3TableTableOrderingComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  $$KanjiBankV3TableTableAnnotationComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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
    PrefetchHooks Function({bool kanjiBankV3ID})> {
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
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> kunyomi = const Value.absent(),
          }) =>
              KanjiBankV3KunyomisTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            kunyomi: kunyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String kunyomi,
          }) =>
              KanjiBankV3KunyomisTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            kunyomi: kunyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3KunyomisTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3ID = false}) {
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
                if (kanjiBankV3ID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiBankV3ID,
                    referencedTable: $$KanjiBankV3KunyomisTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3KunyomisTableTableReferences
                        ._kanjiBankV3IDTable(db)
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
        PrefetchHooks Function({bool kanjiBankV3ID})>;
typedef $$KanjiBankV3TagsTableTableCreateCompanionBuilder
    = KanjiBankV3TagsTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String tag,
});
typedef $$KanjiBankV3TagsTableTableUpdateCompanionBuilder
    = KanjiBankV3TagsTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> tag,
});

final class $$KanjiBankV3TagsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3TagsTableTable, KanjiBankV3TagsTableData> {
  $$KanjiBankV3TagsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3TagsTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiBankV3ID {
    if ($_item.kanjiBankV3ID == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiBankV3ID!));
    final item = $_typedResult.readTableOrNull(_kanjiBankV3IDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KanjiBankV3TagsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagsTableTable> {
  $$KanjiBankV3TagsTableTableFilterComposer({
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

  $$KanjiBankV3TableTableFilterComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

class $$KanjiBankV3TagsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagsTableTable> {
  $$KanjiBankV3TagsTableTableOrderingComposer({
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

  $$KanjiBankV3TableTableOrderingComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

class $$KanjiBankV3TagsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagsTableTable> {
  $$KanjiBankV3TagsTableTableAnnotationComposer({
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

  $$KanjiBankV3TableTableAnnotationComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

class $$KanjiBankV3TagsTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3TagsTableTable,
    KanjiBankV3TagsTableData,
    $$KanjiBankV3TagsTableTableFilterComposer,
    $$KanjiBankV3TagsTableTableOrderingComposer,
    $$KanjiBankV3TagsTableTableAnnotationComposer,
    $$KanjiBankV3TagsTableTableCreateCompanionBuilder,
    $$KanjiBankV3TagsTableTableUpdateCompanionBuilder,
    (KanjiBankV3TagsTableData, $$KanjiBankV3TagsTableTableReferences),
    KanjiBankV3TagsTableData,
    PrefetchHooks Function({bool kanjiBankV3ID})> {
  $$KanjiBankV3TagsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3TagsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3TagsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3TagsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3TagsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> tag = const Value.absent(),
          }) =>
              KanjiBankV3TagsTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            tag: tag,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String tag,
          }) =>
              KanjiBankV3TagsTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            tag: tag,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3TagsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3ID = false}) {
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
                if (kanjiBankV3ID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiBankV3ID,
                    referencedTable: $$KanjiBankV3TagsTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3TagsTableTableReferences
                        ._kanjiBankV3IDTable(db)
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

typedef $$KanjiBankV3TagsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3TagsTableTable,
        KanjiBankV3TagsTableData,
        $$KanjiBankV3TagsTableTableFilterComposer,
        $$KanjiBankV3TagsTableTableOrderingComposer,
        $$KanjiBankV3TagsTableTableAnnotationComposer,
        $$KanjiBankV3TagsTableTableCreateCompanionBuilder,
        $$KanjiBankV3TagsTableTableUpdateCompanionBuilder,
        (KanjiBankV3TagsTableData, $$KanjiBankV3TagsTableTableReferences),
        KanjiBankV3TagsTableData,
        PrefetchHooks Function({bool kanjiBankV3ID})>;
typedef $$KanjiBankV3MeaningsTableTableCreateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String meaning,
});
typedef $$KanjiBankV3MeaningsTableTableUpdateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> meaning,
});

final class $$KanjiBankV3MeaningsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3MeaningsTableTable, KanjiBankV3MeaningsTableData> {
  $$KanjiBankV3MeaningsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3MeaningsTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiBankV3ID {
    if ($_item.kanjiBankV3ID == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiBankV3ID!));
    final item = $_typedResult.readTableOrNull(_kanjiBankV3IDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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

  $$KanjiBankV3TableTableFilterComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  $$KanjiBankV3TableTableOrderingComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  $$KanjiBankV3TableTableAnnotationComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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
    PrefetchHooks Function({bool kanjiBankV3ID})> {
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
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> meaning = const Value.absent(),
          }) =>
              KanjiBankV3MeaningsTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            meaning: meaning,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String meaning,
          }) =>
              KanjiBankV3MeaningsTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            meaning: meaning,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3MeaningsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3ID = false}) {
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
                if (kanjiBankV3ID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiBankV3ID,
                    referencedTable: $$KanjiBankV3MeaningsTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3MeaningsTableTableReferences
                        ._kanjiBankV3IDTable(db)
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
        PrefetchHooks Function({bool kanjiBankV3ID})>;
typedef $$KanjiBankV3StatsTableTableCreateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String statName,
  required String statValue,
});
typedef $$KanjiBankV3StatsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> statName,
  Value<String> statValue,
});

final class $$KanjiBankV3StatsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3StatsTableTable, KanjiBankV3StatsTableData> {
  $$KanjiBankV3StatsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatsTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

  $$KanjiBankV3TableTableProcessedTableManager? get kanjiBankV3ID {
    if ($_item.kanjiBankV3ID == null) return null;
    final manager =
        $$KanjiBankV3TableTableTableManager($_db, $_db.kanjiBankV3Table)
            .filter((f) => f.id($_item.kanjiBankV3ID!));
    final item = $_typedResult.readTableOrNull(_kanjiBankV3IDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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

  ColumnFilters<String> get statName => $composableBuilder(
      column: $table.statName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statValue => $composableBuilder(
      column: $table.statValue, builder: (column) => ColumnFilters(column));

  $$KanjiBankV3TableTableFilterComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  ColumnOrderings<String> get statName => $composableBuilder(
      column: $table.statName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statValue => $composableBuilder(
      column: $table.statValue, builder: (column) => ColumnOrderings(column));

  $$KanjiBankV3TableTableOrderingComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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

  GeneratedColumn<String> get statName =>
      $composableBuilder(column: $table.statName, builder: (column) => column);

  GeneratedColumn<String> get statValue =>
      $composableBuilder(column: $table.statValue, builder: (column) => column);

  $$KanjiBankV3TableTableAnnotationComposer get kanjiBankV3ID {
    final $$KanjiBankV3TableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kanjiBankV3ID,
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
    PrefetchHooks Function({bool kanjiBankV3ID})> {
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
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> statName = const Value.absent(),
            Value<String> statValue = const Value.absent(),
          }) =>
              KanjiBankV3StatsTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            statName: statName,
            statValue: statValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String statName,
            required String statValue,
          }) =>
              KanjiBankV3StatsTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            statName: statName,
            statValue: statValue,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3StatsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({kanjiBankV3ID = false}) {
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
                if (kanjiBankV3ID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kanjiBankV3ID,
                    referencedTable: $$KanjiBankV3StatsTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3StatsTableTableReferences
                        ._kanjiBankV3IDTable(db)
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
        PrefetchHooks Function({bool kanjiBankV3ID})>;

class $DaKanjiDBManager {
  final _$DaKanjiDB _db;
  $DaKanjiDBManager(this._db);
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
  $$KanjiBankV3TagsTableTableTableManager get kanjiBankV3TagsTable =>
      $$KanjiBankV3TagsTableTableTableManager(_db, _db.kanjiBankV3TagsTable);
  $$KanjiBankV3MeaningsTableTableTableManager get kanjiBankV3MeaningsTable =>
      $$KanjiBankV3MeaningsTableTableTableManager(
          _db, _db.kanjiBankV3MeaningsTable);
  $$KanjiBankV3StatsTableTableTableManager get kanjiBankV3StatsTable =>
      $$KanjiBankV3StatsTableTableTableManager(_db, _db.kanjiBankV3StatsTable);
}
