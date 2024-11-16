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
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
      'kanji', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
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

class $KanjiBankV3OnyomiTableTable extends KanjiBankV3OnyomiTable
    with TableInfo<$KanjiBankV3OnyomiTableTable, KanjiBankV3OnyomiTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3OnyomiTableTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kanjiBankV3ID, onyomi];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_onyomi_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3OnyomiTableData> instance,
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
  KanjiBankV3OnyomiTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3OnyomiTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
      onyomi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}onyomi'])!,
    );
  }

  @override
  $KanjiBankV3OnyomiTableTable createAlias(String alias) {
    return $KanjiBankV3OnyomiTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3OnyomiTableData extends DataClass
    implements Insertable<KanjiBankV3OnyomiTableData> {
  /// id of this meaning
  final int id;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The onyomi reading of this entry
  final String onyomi;
  const KanjiBankV3OnyomiTableData(
      {required this.id, required this.kanjiBankV3ID, required this.onyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['onyomi'] = Variable<String>(onyomi);
    return map;
  }

  KanjiBankV3OnyomiTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3OnyomiTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      onyomi: Value(onyomi),
    );
  }

  factory KanjiBankV3OnyomiTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3OnyomiTableData(
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

  KanjiBankV3OnyomiTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? onyomi}) =>
      KanjiBankV3OnyomiTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        onyomi: onyomi ?? this.onyomi,
      );
  KanjiBankV3OnyomiTableData copyWithCompanion(
      KanjiBankV3OnyomiTableCompanion data) {
    return KanjiBankV3OnyomiTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      onyomi: data.onyomi.present ? data.onyomi.value : this.onyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomiTableData(')
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
      (other is KanjiBankV3OnyomiTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.onyomi == this.onyomi);
}

class KanjiBankV3OnyomiTableCompanion
    extends UpdateCompanion<KanjiBankV3OnyomiTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> onyomi;
  const KanjiBankV3OnyomiTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.onyomi = const Value.absent(),
  });
  KanjiBankV3OnyomiTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String onyomi,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        onyomi = Value(onyomi);
  static Insertable<KanjiBankV3OnyomiTableData> custom({
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

  KanjiBankV3OnyomiTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? onyomi}) {
    return KanjiBankV3OnyomiTableCompanion(
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
    return (StringBuffer('KanjiBankV3OnyomiTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('onyomi: $onyomi')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3KunyomiTableTable extends KanjiBankV3KunyomiTable
    with TableInfo<$KanjiBankV3KunyomiTableTable, KanjiBankV3KunyomiTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3KunyomiTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'kanji_bank_v3_kunyomi_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3KunyomiTableData> instance,
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
  KanjiBankV3KunyomiTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3KunyomiTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
      kunyomi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kunyomi'])!,
    );
  }

  @override
  $KanjiBankV3KunyomiTableTable createAlias(String alias) {
    return $KanjiBankV3KunyomiTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3KunyomiTableData extends DataClass
    implements Insertable<KanjiBankV3KunyomiTableData> {
  /// id of this meaning
  final int id;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The kunyomi reading of this entry
  final String kunyomi;
  const KanjiBankV3KunyomiTableData(
      {required this.id, required this.kanjiBankV3ID, required this.kunyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['kunyomi'] = Variable<String>(kunyomi);
    return map;
  }

  KanjiBankV3KunyomiTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3KunyomiTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      kunyomi: Value(kunyomi),
    );
  }

  factory KanjiBankV3KunyomiTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3KunyomiTableData(
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

  KanjiBankV3KunyomiTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? kunyomi}) =>
      KanjiBankV3KunyomiTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        kunyomi: kunyomi ?? this.kunyomi,
      );
  KanjiBankV3KunyomiTableData copyWithCompanion(
      KanjiBankV3KunyomiTableCompanion data) {
    return KanjiBankV3KunyomiTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      kunyomi: data.kunyomi.present ? data.kunyomi.value : this.kunyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomiTableData(')
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
      (other is KanjiBankV3KunyomiTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.kunyomi == this.kunyomi);
}

class KanjiBankV3KunyomiTableCompanion
    extends UpdateCompanion<KanjiBankV3KunyomiTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> kunyomi;
  const KanjiBankV3KunyomiTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.kunyomi = const Value.absent(),
  });
  KanjiBankV3KunyomiTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String kunyomi,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        kunyomi = Value(kunyomi);
  static Insertable<KanjiBankV3KunyomiTableData> custom({
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

  KanjiBankV3KunyomiTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? kunyomi}) {
    return KanjiBankV3KunyomiTableCompanion(
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
    return (StringBuffer('KanjiBankV3KunyomiTableCompanion(')
          ..write('id: $id, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3TagTableTable extends KanjiBankV3TagTable
    with TableInfo<$KanjiBankV3TagTableTable, KanjiBankV3TagTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3TagTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'kanji_bank_v3_tag_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3TagTableData> instance,
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
  KanjiBankV3TagTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3TagTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kanjiBankV3ID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_bank_v3_i_d'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $KanjiBankV3TagTableTable createAlias(String alias) {
    return $KanjiBankV3TagTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3TagTableData extends DataClass
    implements Insertable<KanjiBankV3TagTableData> {
  /// id of this meaning
  final int id;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The kunyomi reading of this entry
  final String tag;
  const KanjiBankV3TagTableData(
      {required this.id, required this.kanjiBankV3ID, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  KanjiBankV3TagTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TagTableCompanion(
      id: Value(id),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      tag: Value(tag),
    );
  }

  factory KanjiBankV3TagTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TagTableData(
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

  KanjiBankV3TagTableData copyWith(
          {int? id, int? kanjiBankV3ID, String? tag}) =>
      KanjiBankV3TagTableData(
        id: id ?? this.id,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        tag: tag ?? this.tag,
      );
  KanjiBankV3TagTableData copyWithCompanion(KanjiBankV3TagTableCompanion data) {
    return KanjiBankV3TagTableData(
      id: data.id.present ? data.id.value : this.id,
      kanjiBankV3ID: data.kanjiBankV3ID.present
          ? data.kanjiBankV3ID.value
          : this.kanjiBankV3ID,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TagTableData(')
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
      (other is KanjiBankV3TagTableData &&
          other.id == this.id &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.tag == this.tag);
}

class KanjiBankV3TagTableCompanion
    extends UpdateCompanion<KanjiBankV3TagTableData> {
  final Value<int> id;
  final Value<int> kanjiBankV3ID;
  final Value<String> tag;
  const KanjiBankV3TagTableCompanion({
    this.id = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.tag = const Value.absent(),
  });
  KanjiBankV3TagTableCompanion.insert({
    this.id = const Value.absent(),
    required int kanjiBankV3ID,
    required String tag,
  })  : kanjiBankV3ID = Value(kanjiBankV3ID),
        tag = Value(tag);
  static Insertable<KanjiBankV3TagTableData> custom({
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

  KanjiBankV3TagTableCompanion copyWith(
      {Value<int>? id, Value<int>? kanjiBankV3ID, Value<String>? tag}) {
    return KanjiBankV3TagTableCompanion(
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
    return (StringBuffer('KanjiBankV3TagTableCompanion(')
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
  late final $KanjiBankV3OnyomiTableTable kanjiBankV3OnyomiTable =
      $KanjiBankV3OnyomiTableTable(this);
  late final $KanjiBankV3KunyomiTableTable kanjiBankV3KunyomiTable =
      $KanjiBankV3KunyomiTableTable(this);
  late final $KanjiBankV3TagTableTable kanjiBankV3TagTable =
      $KanjiBankV3TagTableTable(this);
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
        kanjiBankV3OnyomiTable,
        kanjiBankV3KunyomiTable,
        kanjiBankV3TagTable,
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

  static MultiTypedResultKey<$KanjiBankV3OnyomiTableTable,
      List<KanjiBankV3OnyomiTableData>> _kanjiBankV3OnyomiTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3OnyomiTable,
          aliasName: $_aliasNameGenerator(
              db.kanjiBankV3Table.id, db.kanjiBankV3OnyomiTable.kanjiBankV3ID));

  $$KanjiBankV3OnyomiTableTableProcessedTableManager
      get kanjiBankV3OnyomiTableRefs {
    final manager = $$KanjiBankV3OnyomiTableTableTableManager(
            $_db, $_db.kanjiBankV3OnyomiTable)
        .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3OnyomiTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3KunyomiTableTable,
      List<KanjiBankV3KunyomiTableData>> _kanjiBankV3KunyomiTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3KunyomiTable,
          aliasName: $_aliasNameGenerator(db.kanjiBankV3Table.id,
              db.kanjiBankV3KunyomiTable.kanjiBankV3ID));

  $$KanjiBankV3KunyomiTableTableProcessedTableManager
      get kanjiBankV3KunyomiTableRefs {
    final manager = $$KanjiBankV3KunyomiTableTableTableManager(
            $_db, $_db.kanjiBankV3KunyomiTable)
        .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3KunyomiTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3TagTableTable,
      List<KanjiBankV3TagTableData>> _kanjiBankV3TagTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3TagTable,
          aliasName: $_aliasNameGenerator(
              db.kanjiBankV3Table.id, db.kanjiBankV3TagTable.kanjiBankV3ID));

  $$KanjiBankV3TagTableTableProcessedTableManager get kanjiBankV3TagTableRefs {
    final manager =
        $$KanjiBankV3TagTableTableTableManager($_db, $_db.kanjiBankV3TagTable)
            .filter((f) => f.kanjiBankV3ID.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3TagTableRefsTable($_db));
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

  Expression<bool> kanjiBankV3OnyomiTableRefs(
      Expression<bool> Function($$KanjiBankV3OnyomiTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3OnyomiTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomiTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomiTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomiTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3KunyomiTableRefs(
      Expression<bool> Function($$KanjiBankV3KunyomiTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3KunyomiTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomiTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomiTableTableFilterComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomiTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> kanjiBankV3TagTableRefs(
      Expression<bool> Function($$KanjiBankV3TagTableTableFilterComposer f) f) {
    final $$KanjiBankV3TagTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kanjiBankV3TagTable,
        getReferencedColumn: (t) => t.kanjiBankV3ID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KanjiBankV3TagTableTableFilterComposer(
              $db: $db,
              $table: $db.kanjiBankV3TagTable,
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

  Expression<T> kanjiBankV3OnyomiTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3OnyomiTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3OnyomiTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomiTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3OnyomiTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3OnyomiTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3KunyomiTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3KunyomiTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3KunyomiTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3KunyomiTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3KunyomiTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3KunyomiTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> kanjiBankV3TagTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3TagTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3TagTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3TagTable,
            getReferencedColumn: (t) => t.kanjiBankV3ID,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagTable,
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
        {bool kanjiBankV3OnyomiTableRefs,
        bool kanjiBankV3KunyomiTableRefs,
        bool kanjiBankV3TagTableRefs,
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
              {kanjiBankV3OnyomiTableRefs = false,
              kanjiBankV3KunyomiTableRefs = false,
              kanjiBankV3TagTableRefs = false,
              kanjiBankV3MeaningsTableRefs = false,
              kanjiBankV3StatsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3OnyomiTableRefs) db.kanjiBankV3OnyomiTable,
                if (kanjiBankV3KunyomiTableRefs) db.kanjiBankV3KunyomiTable,
                if (kanjiBankV3TagTableRefs) db.kanjiBankV3TagTable,
                if (kanjiBankV3MeaningsTableRefs) db.kanjiBankV3MeaningsTable,
                if (kanjiBankV3StatsTableRefs) db.kanjiBankV3StatsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3OnyomiTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3OnyomiTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3OnyomiTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
                        typedResults: items),
                  if (kanjiBankV3KunyomiTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3KunyomiTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3KunyomiTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.kanjiBankV3ID == item.id),
                        typedResults: items),
                  if (kanjiBankV3TagTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TableTableReferences
                            ._kanjiBankV3TagTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TableTableReferences(db, table, p0)
                                .kanjiBankV3TagTableRefs,
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
        {bool kanjiBankV3OnyomiTableRefs,
        bool kanjiBankV3KunyomiTableRefs,
        bool kanjiBankV3TagTableRefs,
        bool kanjiBankV3MeaningsTableRefs,
        bool kanjiBankV3StatsTableRefs})>;
typedef $$KanjiBankV3OnyomiTableTableCreateCompanionBuilder
    = KanjiBankV3OnyomiTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String onyomi,
});
typedef $$KanjiBankV3OnyomiTableTableUpdateCompanionBuilder
    = KanjiBankV3OnyomiTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> onyomi,
});

final class $$KanjiBankV3OnyomiTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3OnyomiTableTable, KanjiBankV3OnyomiTableData> {
  $$KanjiBankV3OnyomiTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3OnyomiTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

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

class $$KanjiBankV3OnyomiTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomiTableTable> {
  $$KanjiBankV3OnyomiTableTableFilterComposer({
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

class $$KanjiBankV3OnyomiTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomiTableTable> {
  $$KanjiBankV3OnyomiTableTableOrderingComposer({
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

class $$KanjiBankV3OnyomiTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3OnyomiTableTable> {
  $$KanjiBankV3OnyomiTableTableAnnotationComposer({
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

class $$KanjiBankV3OnyomiTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3OnyomiTableTable,
    KanjiBankV3OnyomiTableData,
    $$KanjiBankV3OnyomiTableTableFilterComposer,
    $$KanjiBankV3OnyomiTableTableOrderingComposer,
    $$KanjiBankV3OnyomiTableTableAnnotationComposer,
    $$KanjiBankV3OnyomiTableTableCreateCompanionBuilder,
    $$KanjiBankV3OnyomiTableTableUpdateCompanionBuilder,
    (KanjiBankV3OnyomiTableData, $$KanjiBankV3OnyomiTableTableReferences),
    KanjiBankV3OnyomiTableData,
    PrefetchHooks Function({bool kanjiBankV3ID})> {
  $$KanjiBankV3OnyomiTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3OnyomiTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3OnyomiTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3OnyomiTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3OnyomiTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> onyomi = const Value.absent(),
          }) =>
              KanjiBankV3OnyomiTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            onyomi: onyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String onyomi,
          }) =>
              KanjiBankV3OnyomiTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            onyomi: onyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3OnyomiTableTableReferences(db, table, e)
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
                    referencedTable: $$KanjiBankV3OnyomiTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3OnyomiTableTableReferences
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

typedef $$KanjiBankV3OnyomiTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3OnyomiTableTable,
        KanjiBankV3OnyomiTableData,
        $$KanjiBankV3OnyomiTableTableFilterComposer,
        $$KanjiBankV3OnyomiTableTableOrderingComposer,
        $$KanjiBankV3OnyomiTableTableAnnotationComposer,
        $$KanjiBankV3OnyomiTableTableCreateCompanionBuilder,
        $$KanjiBankV3OnyomiTableTableUpdateCompanionBuilder,
        (KanjiBankV3OnyomiTableData, $$KanjiBankV3OnyomiTableTableReferences),
        KanjiBankV3OnyomiTableData,
        PrefetchHooks Function({bool kanjiBankV3ID})>;
typedef $$KanjiBankV3KunyomiTableTableCreateCompanionBuilder
    = KanjiBankV3KunyomiTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String kunyomi,
});
typedef $$KanjiBankV3KunyomiTableTableUpdateCompanionBuilder
    = KanjiBankV3KunyomiTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> kunyomi,
});

final class $$KanjiBankV3KunyomiTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3KunyomiTableTable, KanjiBankV3KunyomiTableData> {
  $$KanjiBankV3KunyomiTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3KunyomiTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

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

class $$KanjiBankV3KunyomiTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomiTableTable> {
  $$KanjiBankV3KunyomiTableTableFilterComposer({
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

class $$KanjiBankV3KunyomiTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomiTableTable> {
  $$KanjiBankV3KunyomiTableTableOrderingComposer({
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

class $$KanjiBankV3KunyomiTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3KunyomiTableTable> {
  $$KanjiBankV3KunyomiTableTableAnnotationComposer({
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

class $$KanjiBankV3KunyomiTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3KunyomiTableTable,
    KanjiBankV3KunyomiTableData,
    $$KanjiBankV3KunyomiTableTableFilterComposer,
    $$KanjiBankV3KunyomiTableTableOrderingComposer,
    $$KanjiBankV3KunyomiTableTableAnnotationComposer,
    $$KanjiBankV3KunyomiTableTableCreateCompanionBuilder,
    $$KanjiBankV3KunyomiTableTableUpdateCompanionBuilder,
    (KanjiBankV3KunyomiTableData, $$KanjiBankV3KunyomiTableTableReferences),
    KanjiBankV3KunyomiTableData,
    PrefetchHooks Function({bool kanjiBankV3ID})> {
  $$KanjiBankV3KunyomiTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3KunyomiTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3KunyomiTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3KunyomiTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3KunyomiTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> kunyomi = const Value.absent(),
          }) =>
              KanjiBankV3KunyomiTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            kunyomi: kunyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String kunyomi,
          }) =>
              KanjiBankV3KunyomiTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            kunyomi: kunyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3KunyomiTableTableReferences(db, table, e)
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
                    referencedTable: $$KanjiBankV3KunyomiTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3KunyomiTableTableReferences
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

typedef $$KanjiBankV3KunyomiTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3KunyomiTableTable,
        KanjiBankV3KunyomiTableData,
        $$KanjiBankV3KunyomiTableTableFilterComposer,
        $$KanjiBankV3KunyomiTableTableOrderingComposer,
        $$KanjiBankV3KunyomiTableTableAnnotationComposer,
        $$KanjiBankV3KunyomiTableTableCreateCompanionBuilder,
        $$KanjiBankV3KunyomiTableTableUpdateCompanionBuilder,
        (KanjiBankV3KunyomiTableData, $$KanjiBankV3KunyomiTableTableReferences),
        KanjiBankV3KunyomiTableData,
        PrefetchHooks Function({bool kanjiBankV3ID})>;
typedef $$KanjiBankV3TagTableTableCreateCompanionBuilder
    = KanjiBankV3TagTableCompanion Function({
  Value<int> id,
  required int kanjiBankV3ID,
  required String tag,
});
typedef $$KanjiBankV3TagTableTableUpdateCompanionBuilder
    = KanjiBankV3TagTableCompanion Function({
  Value<int> id,
  Value<int> kanjiBankV3ID,
  Value<String> tag,
});

final class $$KanjiBankV3TagTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3TagTableTable, KanjiBankV3TagTableData> {
  $$KanjiBankV3TagTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3TableTable _kanjiBankV3IDTable(_$DaKanjiDB db) =>
      db.kanjiBankV3Table.createAlias($_aliasNameGenerator(
          db.kanjiBankV3TagTable.kanjiBankV3ID, db.kanjiBankV3Table.id));

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

class $$KanjiBankV3TagTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagTableTable> {
  $$KanjiBankV3TagTableTableFilterComposer({
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

class $$KanjiBankV3TagTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagTableTable> {
  $$KanjiBankV3TagTableTableOrderingComposer({
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

class $$KanjiBankV3TagTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3TagTableTable> {
  $$KanjiBankV3TagTableTableAnnotationComposer({
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

class $$KanjiBankV3TagTableTableTableManager extends RootTableManager<
    _$DaKanjiDB,
    $KanjiBankV3TagTableTable,
    KanjiBankV3TagTableData,
    $$KanjiBankV3TagTableTableFilterComposer,
    $$KanjiBankV3TagTableTableOrderingComposer,
    $$KanjiBankV3TagTableTableAnnotationComposer,
    $$KanjiBankV3TagTableTableCreateCompanionBuilder,
    $$KanjiBankV3TagTableTableUpdateCompanionBuilder,
    (KanjiBankV3TagTableData, $$KanjiBankV3TagTableTableReferences),
    KanjiBankV3TagTableData,
    PrefetchHooks Function({bool kanjiBankV3ID})> {
  $$KanjiBankV3TagTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3TagTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3TagTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3TagTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3TagTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> tag = const Value.absent(),
          }) =>
              KanjiBankV3TagTableCompanion(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            tag: tag,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int kanjiBankV3ID,
            required String tag,
          }) =>
              KanjiBankV3TagTableCompanion.insert(
            id: id,
            kanjiBankV3ID: kanjiBankV3ID,
            tag: tag,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3TagTableTableReferences(db, table, e)
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
                    referencedTable: $$KanjiBankV3TagTableTableReferences
                        ._kanjiBankV3IDTable(db),
                    referencedColumn: $$KanjiBankV3TagTableTableReferences
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

typedef $$KanjiBankV3TagTableTableProcessedTableManager = ProcessedTableManager<
    _$DaKanjiDB,
    $KanjiBankV3TagTableTable,
    KanjiBankV3TagTableData,
    $$KanjiBankV3TagTableTableFilterComposer,
    $$KanjiBankV3TagTableTableOrderingComposer,
    $$KanjiBankV3TagTableTableAnnotationComposer,
    $$KanjiBankV3TagTableTableCreateCompanionBuilder,
    $$KanjiBankV3TagTableTableUpdateCompanionBuilder,
    (KanjiBankV3TagTableData, $$KanjiBankV3TagTableTableReferences),
    KanjiBankV3TagTableData,
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
  $$KanjiBankV3OnyomiTableTableTableManager get kanjiBankV3OnyomiTable =>
      $$KanjiBankV3OnyomiTableTableTableManager(
          _db, _db.kanjiBankV3OnyomiTable);
  $$KanjiBankV3KunyomiTableTableTableManager get kanjiBankV3KunyomiTable =>
      $$KanjiBankV3KunyomiTableTableTableManager(
          _db, _db.kanjiBankV3KunyomiTable);
  $$KanjiBankV3TagTableTableTableManager get kanjiBankV3TagTable =>
      $$KanjiBankV3TagTableTableTableManager(_db, _db.kanjiBankV3TagTable);
  $$KanjiBankV3MeaningsTableTableTableManager get kanjiBankV3MeaningsTable =>
      $$KanjiBankV3MeaningsTableTableTableManager(
          _db, _db.kanjiBankV3MeaningsTable);
  $$KanjiBankV3StatsTableTableTableManager get kanjiBankV3StatsTable =>
      $$KanjiBankV3StatsTableTableTableManager(_db, _db.kanjiBankV3StatsTable);
}
