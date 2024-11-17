// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dakanji_db.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [id, dictId, kanjiBankV3ID, onyomi];
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
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
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
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
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

  /// The id of the dictionary this entry belongs to
  final int dictId;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The onyomi reading of this entry
  final String onyomi;
  const KanjiBankV3OnyomisTableData(
      {required this.id,
      required this.dictId,
      required this.kanjiBankV3ID,
      required this.onyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['onyomi'] = Variable<String>(onyomi);
    return map;
  }

  KanjiBankV3OnyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3OnyomisTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      onyomi: Value(onyomi),
    );
  }

  factory KanjiBankV3OnyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3OnyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      onyomi: serializer.fromJson<String>(json['onyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'onyomi': serializer.toJson<String>(onyomi),
    };
  }

  KanjiBankV3OnyomisTableData copyWith(
          {int? id, int? dictId, int? kanjiBankV3ID, String? onyomi}) =>
      KanjiBankV3OnyomisTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        onyomi: onyomi ?? this.onyomi,
      );
  KanjiBankV3OnyomisTableData copyWithCompanion(
      KanjiBankV3OnyomisTableCompanion data) {
    return KanjiBankV3OnyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('onyomi: $onyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, kanjiBankV3ID, onyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3OnyomisTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.onyomi == this.onyomi);
}

class KanjiBankV3OnyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3OnyomisTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> kanjiBankV3ID;
  final Value<String> onyomi;
  const KanjiBankV3OnyomisTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.onyomi = const Value.absent(),
  });
  KanjiBankV3OnyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int kanjiBankV3ID,
    required String onyomi,
  })  : dictId = Value(dictId),
        kanjiBankV3ID = Value(kanjiBankV3ID),
        onyomi = Value(onyomi);
  static Insertable<KanjiBankV3OnyomisTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? onyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (onyomi != null) 'onyomi': onyomi,
    });
  }

  KanjiBankV3OnyomisTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? kanjiBankV3ID,
      Value<String>? onyomi}) {
    return KanjiBankV3OnyomisTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
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
          ..write('dictId: $dictId, ')
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [id, dictId, kanjiBankV3ID, kunyomi];
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
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
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
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
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

  /// The id of the dictionary this entry belongs to
  final int dictId;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The kunyomi reading of this entry
  final String kunyomi;
  const KanjiBankV3KunyomisTableData(
      {required this.id,
      required this.dictId,
      required this.kanjiBankV3ID,
      required this.kunyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['kunyomi'] = Variable<String>(kunyomi);
    return map;
  }

  KanjiBankV3KunyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3KunyomisTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      kunyomi: Value(kunyomi),
    );
  }

  factory KanjiBankV3KunyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3KunyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      kunyomi: serializer.fromJson<String>(json['kunyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'kunyomi': serializer.toJson<String>(kunyomi),
    };
  }

  KanjiBankV3KunyomisTableData copyWith(
          {int? id, int? dictId, int? kanjiBankV3ID, String? kunyomi}) =>
      KanjiBankV3KunyomisTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        kunyomi: kunyomi ?? this.kunyomi,
      );
  KanjiBankV3KunyomisTableData copyWithCompanion(
      KanjiBankV3KunyomisTableCompanion data) {
    return KanjiBankV3KunyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, kanjiBankV3ID, kunyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3KunyomisTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.kunyomi == this.kunyomi);
}

class KanjiBankV3KunyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3KunyomisTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> kanjiBankV3ID;
  final Value<String> kunyomi;
  const KanjiBankV3KunyomisTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.kunyomi = const Value.absent(),
  });
  KanjiBankV3KunyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int kanjiBankV3ID,
    required String kunyomi,
  })  : dictId = Value(dictId),
        kanjiBankV3ID = Value(kanjiBankV3ID),
        kunyomi = Value(kunyomi);
  static Insertable<KanjiBankV3KunyomisTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? kunyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (kunyomi != null) 'kunyomi': kunyomi,
    });
  }

  KanjiBankV3KunyomisTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? kanjiBankV3ID,
      Value<String>? kunyomi}) {
    return KanjiBankV3KunyomisTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  /// id of this realtion
  final int id;

  /// the id of the associated onyomi reading
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [id, dictId, kanjiBankV3ID, tag];
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
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
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
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
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

  /// The id of the dictionary this entry belongs to
  final int dictId;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The kunyomi reading of this entry
  final String tag;
  const KanjiBankV3TagsTableData(
      {required this.id,
      required this.dictId,
      required this.kanjiBankV3ID,
      required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  KanjiBankV3TagsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TagsTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      tag: Value(tag),
    );
  }

  factory KanjiBankV3TagsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TagsTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'tag': serializer.toJson<String>(tag),
    };
  }

  KanjiBankV3TagsTableData copyWith(
          {int? id, int? dictId, int? kanjiBankV3ID, String? tag}) =>
      KanjiBankV3TagsTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        tag: tag ?? this.tag,
      );
  KanjiBankV3TagsTableData copyWithCompanion(
      KanjiBankV3TagsTableCompanion data) {
    return KanjiBankV3TagsTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, kanjiBankV3ID, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3TagsTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.tag == this.tag);
}

class KanjiBankV3TagsTableCompanion
    extends UpdateCompanion<KanjiBankV3TagsTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> kanjiBankV3ID;
  final Value<String> tag;
  const KanjiBankV3TagsTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.tag = const Value.absent(),
  });
  KanjiBankV3TagsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int kanjiBankV3ID,
    required String tag,
  })  : dictId = Value(dictId),
        kanjiBankV3ID = Value(kanjiBankV3ID),
        tag = Value(tag);
  static Insertable<KanjiBankV3TagsTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (tag != null) 'tag': tag,
    });
  }

  KanjiBankV3TagsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? kanjiBankV3ID,
      Value<String>? tag}) {
    return KanjiBankV3TagsTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('tag: $tag')
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  /// id of this realtion
  final int id;

  /// the id of the associated onyomi reading
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [id, dictId, kanjiBankV3ID, meaning];
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
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
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
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
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

  /// The id of the dictionary this entry belongs to
  final int dictId;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The meaning of this entry
  final String meaning;
  const KanjiBankV3MeaningsTableData(
      {required this.id,
      required this.dictId,
      required this.kanjiBankV3ID,
      required this.meaning});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['meaning'] = Variable<String>(meaning);
    return map;
  }

  KanjiBankV3MeaningsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3MeaningsTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      kanjiBankV3ID: Value(kanjiBankV3ID),
      meaning: Value(meaning),
    );
  }

  factory KanjiBankV3MeaningsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3MeaningsTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      kanjiBankV3ID: serializer.fromJson<int>(json['kanjiBankV3ID']),
      meaning: serializer.fromJson<String>(json['meaning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'meaning': serializer.toJson<String>(meaning),
    };
  }

  KanjiBankV3MeaningsTableData copyWith(
          {int? id, int? dictId, int? kanjiBankV3ID, String? meaning}) =>
      KanjiBankV3MeaningsTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        meaning: meaning ?? this.meaning,
      );
  KanjiBankV3MeaningsTableData copyWithCompanion(
      KanjiBankV3MeaningsTableCompanion data) {
    return KanjiBankV3MeaningsTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, kanjiBankV3ID, meaning);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3MeaningsTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.meaning == this.meaning);
}

class KanjiBankV3MeaningsTableCompanion
    extends UpdateCompanion<KanjiBankV3MeaningsTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> kanjiBankV3ID;
  final Value<String> meaning;
  const KanjiBankV3MeaningsTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.meaning = const Value.absent(),
  });
  KanjiBankV3MeaningsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int kanjiBankV3ID,
    required String meaning,
  })  : dictId = Value(dictId),
        kanjiBankV3ID = Value(kanjiBankV3ID),
        meaning = Value(meaning);
  static Insertable<KanjiBankV3MeaningsTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? meaning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (meaning != null) 'meaning': meaning,
    });
  }

  KanjiBankV3MeaningsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? kanjiBankV3ID,
      Value<String>? meaning}) {
    return KanjiBankV3MeaningsTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  /// id of this realtion
  final int id;

  /// the id of the associated onyomi reading
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
      [id, dictId, kanjiBankV3ID, statName, statValue];
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
    if (data.containsKey('dict_id')) {
      context.handle(_dictIdMeta,
          dictId.isAcceptableOrUnknown(data['dict_id']!, _dictIdMeta));
    } else if (isInserting) {
      context.missing(_dictIdMeta);
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
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
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

  /// The id of the dictionary this entry belongs to
  final int dictId;

  /// `KanjiBankV3` entry this meaning belongs to
  final int kanjiBankV3ID;

  /// The name of this entrie's stat
  final String statName;

  /// The value of this entrie's stat
  final String statValue;
  const KanjiBankV3StatsTableData(
      {required this.id,
      required this.dictId,
      required this.kanjiBankV3ID,
      required this.statName,
      required this.statValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kanji_bank_v3_i_d'] = Variable<int>(kanjiBankV3ID);
    map['stat_name'] = Variable<String>(statName);
    map['stat_value'] = Variable<String>(statValue);
    return map;
  }

  KanjiBankV3StatsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatsTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
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
      dictId: serializer.fromJson<int>(json['dictId']),
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
      'dictId': serializer.toJson<int>(dictId),
      'kanjiBankV3ID': serializer.toJson<int>(kanjiBankV3ID),
      'statName': serializer.toJson<String>(statName),
      'statValue': serializer.toJson<String>(statValue),
    };
  }

  KanjiBankV3StatsTableData copyWith(
          {int? id,
          int? dictId,
          int? kanjiBankV3ID,
          String? statName,
          String? statValue}) =>
      KanjiBankV3StatsTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kanjiBankV3ID: kanjiBankV3ID ?? this.kanjiBankV3ID,
        statName: statName ?? this.statName,
        statValue: statValue ?? this.statValue,
      );
  KanjiBankV3StatsTableData copyWithCompanion(
      KanjiBankV3StatsTableCompanion data) {
    return KanjiBankV3StatsTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('statName: $statName, ')
          ..write('statValue: $statValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dictId, kanjiBankV3ID, statName, statValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatsTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kanjiBankV3ID == this.kanjiBankV3ID &&
          other.statName == this.statName &&
          other.statValue == this.statValue);
}

class KanjiBankV3StatsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatsTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> kanjiBankV3ID;
  final Value<String> statName;
  final Value<String> statValue;
  const KanjiBankV3StatsTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kanjiBankV3ID = const Value.absent(),
    this.statName = const Value.absent(),
    this.statValue = const Value.absent(),
  });
  KanjiBankV3StatsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int kanjiBankV3ID,
    required String statName,
    required String statValue,
  })  : dictId = Value(dictId),
        kanjiBankV3ID = Value(kanjiBankV3ID),
        statName = Value(statName),
        statValue = Value(statValue);
  static Insertable<KanjiBankV3StatsTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? kanjiBankV3ID,
    Expression<String>? statName,
    Expression<String>? statValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kanjiBankV3ID != null) 'kanji_bank_v3_i_d': kanjiBankV3ID,
      if (statName != null) 'stat_name': statName,
      if (statValue != null) 'stat_value': statValue,
    });
  }

  KanjiBankV3StatsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? kanjiBankV3ID,
      Value<String>? statName,
      Value<String>? statValue}) {
    return KanjiBankV3StatsTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
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
          ..write('dictId: $dictId, ')
          ..write('kanjiBankV3ID: $kanjiBankV3ID, ')
          ..write('statName: $statName, ')
          ..write('statValue: $statValue')
          ..write(')'))
        .toString();
  }
}

class $KanjiBankV3StatsKanjiRelationsTableTable
    extends KanjiBankV3StatsKanjiRelationsTable
    with
        TableInfo<$KanjiBankV3StatsKanjiRelationsTableTable,
            KanjiBankV3StatsKanjiRelationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KanjiBankV3StatsKanjiRelationsTableTable(this.attachedDatabase,
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kanjiIdMeta =
      const VerificationMeta('kanjiId');
  @override
  late final GeneratedColumn<int> kanjiId = GeneratedColumn<int>(
      'kanji_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, statId, kanjiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kanji_bank_v3_stats_kanji_relations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KanjiBankV3StatsKanjiRelationsTableData> instance,
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
  KanjiBankV3StatsKanjiRelationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KanjiBankV3StatsKanjiRelationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stat_id'])!,
      kanjiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kanji_id'])!,
    );
  }

  @override
  $KanjiBankV3StatsKanjiRelationsTableTable createAlias(String alias) {
    return $KanjiBankV3StatsKanjiRelationsTableTable(attachedDatabase, alias);
  }
}

class KanjiBankV3StatsKanjiRelationsTableData extends DataClass
    implements Insertable<KanjiBankV3StatsKanjiRelationsTableData> {
  /// id of this realtion
  final int id;

  /// the id of the associated onyomi reading
  final int statId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3StatsKanjiRelationsTableData(
      {required this.id, required this.statId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stat_id'] = Variable<int>(statId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3StatsKanjiRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatsKanjiRelationsTableCompanion(
      id: Value(id),
      statId: Value(statId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3StatsKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatsKanjiRelationsTableData(
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

  KanjiBankV3StatsKanjiRelationsTableData copyWith(
          {int? id, int? statId, int? kanjiId}) =>
      KanjiBankV3StatsKanjiRelationsTableData(
        id: id ?? this.id,
        statId: statId ?? this.statId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3StatsKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3StatsKanjiRelationsTableCompanion data) {
    return KanjiBankV3StatsKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      statId: data.statId.present ? data.statId.value : this.statId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatsKanjiRelationsTableData(')
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
      (other is KanjiBankV3StatsKanjiRelationsTableData &&
          other.id == this.id &&
          other.statId == this.statId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3StatsKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatsKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> statId;
  final Value<int> kanjiId;
  const KanjiBankV3StatsKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.statId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3StatsKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int statId,
    required int kanjiId,
  })  : statId = Value(statId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3StatsKanjiRelationsTableData> custom({
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

  KanjiBankV3StatsKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? statId, Value<int>? kanjiId}) {
    return KanjiBankV3StatsKanjiRelationsTableCompanion(
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
    return (StringBuffer('KanjiBankV3StatsKanjiRelationsTableCompanion(')
          ..write('id: $id, ')
          ..write('statId: $statId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }
}

abstract class _$DaKanjiDB extends GeneratedDatabase {
  _$DaKanjiDB(QueryExecutor e) : super(e);
  $DaKanjiDBManager get managers => $DaKanjiDBManager(this);
  late final $IndexTableTable indexTable = $IndexTableTable(this);
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
  late final $KanjiBankV3TagsTableTable kanjiBankV3TagsTable =
      $KanjiBankV3TagsTableTable(this);
  late final $KanjiBankV3TagsKanjiRelationsTableTable
      kanjiBankV3TagsKanjiRelationsTable =
      $KanjiBankV3TagsKanjiRelationsTableTable(this);
  late final $KanjiBankV3MeaningsTableTable kanjiBankV3MeaningsTable =
      $KanjiBankV3MeaningsTableTable(this);
  late final $KanjiBankV3MeaningsKanjiRelationsTableTable
      kanjiBankV3MeaningsKanjiRelationsTable =
      $KanjiBankV3MeaningsKanjiRelationsTableTable(this);
  late final $KanjiBankV3StatsTableTable kanjiBankV3StatsTable =
      $KanjiBankV3StatsTableTable(this);
  late final $KanjiBankV3StatsKanjiRelationsTableTable
      kanjiBankV3StatsKanjiRelationsTable =
      $KanjiBankV3StatsKanjiRelationsTableTable(this);
  late final Index kanji =
      Index('kanji', 'CREATE INDEX kanji ON kanji_bank_v3_table (kanji)');
  late final KanjiBankV3Dao kanjiBankV3Dao = KanjiBankV3Dao(this as DaKanjiDB);
  late final IndexDao indexDao = IndexDao(this as DaKanjiDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        indexTable,
        kanjiBankV3Table,
        kanjiBankV3OnyomisTable,
        kanjiBankV3OnyomiKanjiRelationsTable,
        kanjiBankV3KunyomisTable,
        kanjiBankV3KunyomiKanjiRelationsTable,
        kanjiBankV3TagsTable,
        kanjiBankV3TagsKanjiRelationsTable,
        kanjiBankV3MeaningsTable,
        kanjiBankV3MeaningsKanjiRelationsTable,
        kanjiBankV3StatsTable,
        kanjiBankV3StatsKanjiRelationsTable,
        kanji
      ];
}

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
    (
      IndexTableData,
      BaseReferences<_$DaKanjiDB, $IndexTableTable, IndexTableData>
    ),
    IndexTableData,
    PrefetchHooks Function()> {
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      IndexTableData,
      BaseReferences<_$DaKanjiDB, $IndexTableTable, IndexTableData>
    ),
    IndexTableData,
    PrefetchHooks Function()>;
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
  required int dictId,
  required int kanjiBankV3ID,
  required String onyomi,
});
typedef $$KanjiBankV3OnyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
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

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

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
            Value<int> dictId = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> onyomi = const Value.absent(),
          }) =>
              KanjiBankV3OnyomisTableCompanion(
            id: id,
            dictId: dictId,
            kanjiBankV3ID: kanjiBankV3ID,
            onyomi: onyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int kanjiBankV3ID,
            required String onyomi,
          }) =>
              KanjiBankV3OnyomisTableCompanion.insert(
            id: id,
            dictId: dictId,
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
  required int dictId,
  required int kanjiBankV3ID,
  required String kunyomi,
});
typedef $$KanjiBankV3KunyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3KunyomisTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
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

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

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
            Value<int> dictId = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> kunyomi = const Value.absent(),
          }) =>
              KanjiBankV3KunyomisTableCompanion(
            id: id,
            dictId: dictId,
            kanjiBankV3ID: kanjiBankV3ID,
            kunyomi: kunyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int kanjiBankV3ID,
            required String kunyomi,
          }) =>
              KanjiBankV3KunyomisTableCompanion.insert(
            id: id,
            dictId: dictId,
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

  ColumnFilters<int> get kunyomiId => $composableBuilder(
      column: $table.kunyomiId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get kunyomiId => $composableBuilder(
      column: $table.kunyomiId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get kunyomiId =>
      $composableBuilder(column: $table.kunyomiId, builder: (column) => column);

  GeneratedColumn<int> get kanjiId =>
      $composableBuilder(column: $table.kanjiId, builder: (column) => column);
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
          BaseReferences<
              _$DaKanjiDB,
              $KanjiBankV3KunyomiKanjiRelationsTableTable,
              KanjiBankV3KunyomiKanjiRelationsTableData>
        ),
        KanjiBankV3KunyomiKanjiRelationsTableData,
        PrefetchHooks Function()> {
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
          BaseReferences<
              _$DaKanjiDB,
              $KanjiBankV3KunyomiKanjiRelationsTableTable,
              KanjiBankV3KunyomiKanjiRelationsTableData>
        ),
        KanjiBankV3KunyomiKanjiRelationsTableData,
        PrefetchHooks Function()>;
typedef $$KanjiBankV3TagsTableTableCreateCompanionBuilder
    = KanjiBankV3TagsTableCompanion Function({
  Value<int> id,
  required int dictId,
  required int kanjiBankV3ID,
  required String tag,
});
typedef $$KanjiBankV3TagsTableTableUpdateCompanionBuilder
    = KanjiBankV3TagsTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
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

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

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
            Value<int> dictId = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> tag = const Value.absent(),
          }) =>
              KanjiBankV3TagsTableCompanion(
            id: id,
            dictId: dictId,
            kanjiBankV3ID: kanjiBankV3ID,
            tag: tag,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int kanjiBankV3ID,
            required String tag,
          }) =>
              KanjiBankV3TagsTableCompanion.insert(
            id: id,
            dictId: dictId,
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

  ColumnFilters<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<int> get kanjiId =>
      $composableBuilder(column: $table.kanjiId, builder: (column) => column);
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
          BaseReferences<_$DaKanjiDB, $KanjiBankV3TagsKanjiRelationsTableTable,
              KanjiBankV3TagsKanjiRelationsTableData>
        ),
        KanjiBankV3TagsKanjiRelationsTableData,
        PrefetchHooks Function()> {
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
          BaseReferences<_$DaKanjiDB, $KanjiBankV3TagsKanjiRelationsTableTable,
              KanjiBankV3TagsKanjiRelationsTableData>
        ),
        KanjiBankV3TagsKanjiRelationsTableData,
        PrefetchHooks Function()>;
typedef $$KanjiBankV3MeaningsTableTableCreateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  required int dictId,
  required int kanjiBankV3ID,
  required String meaning,
});
typedef $$KanjiBankV3MeaningsTableTableUpdateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
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

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

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
            Value<int> dictId = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> meaning = const Value.absent(),
          }) =>
              KanjiBankV3MeaningsTableCompanion(
            id: id,
            dictId: dictId,
            kanjiBankV3ID: kanjiBankV3ID,
            meaning: meaning,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int kanjiBankV3ID,
            required String meaning,
          }) =>
              KanjiBankV3MeaningsTableCompanion.insert(
            id: id,
            dictId: dictId,
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

  ColumnFilters<int> get meaningId => $composableBuilder(
      column: $table.meaningId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get meaningId => $composableBuilder(
      column: $table.meaningId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get meaningId =>
      $composableBuilder(column: $table.meaningId, builder: (column) => column);

  GeneratedColumn<int> get kanjiId =>
      $composableBuilder(column: $table.kanjiId, builder: (column) => column);
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
          BaseReferences<
              _$DaKanjiDB,
              $KanjiBankV3MeaningsKanjiRelationsTableTable,
              KanjiBankV3MeaningsKanjiRelationsTableData>
        ),
        KanjiBankV3MeaningsKanjiRelationsTableData,
        PrefetchHooks Function()> {
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
          BaseReferences<
              _$DaKanjiDB,
              $KanjiBankV3MeaningsKanjiRelationsTableTable,
              KanjiBankV3MeaningsKanjiRelationsTableData>
        ),
        KanjiBankV3MeaningsKanjiRelationsTableData,
        PrefetchHooks Function()>;
typedef $$KanjiBankV3StatsTableTableCreateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  required int dictId,
  required int kanjiBankV3ID,
  required String statName,
  required String statValue,
});
typedef $$KanjiBankV3StatsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
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

  ColumnFilters<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<int> get dictId => $composableBuilder(
      column: $table.dictId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get dictId =>
      $composableBuilder(column: $table.dictId, builder: (column) => column);

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
            Value<int> dictId = const Value.absent(),
            Value<int> kanjiBankV3ID = const Value.absent(),
            Value<String> statName = const Value.absent(),
            Value<String> statValue = const Value.absent(),
          }) =>
              KanjiBankV3StatsTableCompanion(
            id: id,
            dictId: dictId,
            kanjiBankV3ID: kanjiBankV3ID,
            statName: statName,
            statValue: statValue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int kanjiBankV3ID,
            required String statName,
            required String statValue,
          }) =>
              KanjiBankV3StatsTableCompanion.insert(
            id: id,
            dictId: dictId,
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
typedef $$KanjiBankV3StatsKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3StatsKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int statId,
  required int kanjiId,
});
typedef $$KanjiBankV3StatsKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatsKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> statId,
  Value<int> kanjiId,
});

class $$KanjiBankV3StatsKanjiRelationsTableTableFilterComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatsKanjiRelationsTableTable> {
  $$KanjiBankV3StatsKanjiRelationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get statId => $composableBuilder(
      column: $table.statId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnFilters(column));
}

class $$KanjiBankV3StatsKanjiRelationsTableTableOrderingComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatsKanjiRelationsTableTable> {
  $$KanjiBankV3StatsKanjiRelationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get statId => $composableBuilder(
      column: $table.statId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kanjiId => $composableBuilder(
      column: $table.kanjiId, builder: (column) => ColumnOrderings(column));
}

class $$KanjiBankV3StatsKanjiRelationsTableTableAnnotationComposer
    extends Composer<_$DaKanjiDB, $KanjiBankV3StatsKanjiRelationsTableTable> {
  $$KanjiBankV3StatsKanjiRelationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get statId =>
      $composableBuilder(column: $table.statId, builder: (column) => column);

  GeneratedColumn<int> get kanjiId =>
      $composableBuilder(column: $table.kanjiId, builder: (column) => column);
}

class $$KanjiBankV3StatsKanjiRelationsTableTableTableManager
    extends RootTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatsKanjiRelationsTableTable,
        KanjiBankV3StatsKanjiRelationsTableData,
        $$KanjiBankV3StatsKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3StatsKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3StatsKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3StatsKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatsKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3StatsKanjiRelationsTableData,
          BaseReferences<_$DaKanjiDB, $KanjiBankV3StatsKanjiRelationsTableTable,
              KanjiBankV3StatsKanjiRelationsTableData>
        ),
        KanjiBankV3StatsKanjiRelationsTableData,
        PrefetchHooks Function()> {
  $$KanjiBankV3StatsKanjiRelationsTableTableTableManager(
      _$DaKanjiDB db, $KanjiBankV3StatsKanjiRelationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KanjiBankV3StatsKanjiRelationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$KanjiBankV3StatsKanjiRelationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KanjiBankV3StatsKanjiRelationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> statId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3StatsKanjiRelationsTableCompanion(
            id: id,
            statId: statId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int statId,
            required int kanjiId,
          }) =>
              KanjiBankV3StatsKanjiRelationsTableCompanion.insert(
            id: id,
            statId: statId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KanjiBankV3StatsKanjiRelationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$DaKanjiDB,
        $KanjiBankV3StatsKanjiRelationsTableTable,
        KanjiBankV3StatsKanjiRelationsTableData,
        $$KanjiBankV3StatsKanjiRelationsTableTableFilterComposer,
        $$KanjiBankV3StatsKanjiRelationsTableTableOrderingComposer,
        $$KanjiBankV3StatsKanjiRelationsTableTableAnnotationComposer,
        $$KanjiBankV3StatsKanjiRelationsTableTableCreateCompanionBuilder,
        $$KanjiBankV3StatsKanjiRelationsTableTableUpdateCompanionBuilder,
        (
          KanjiBankV3StatsKanjiRelationsTableData,
          BaseReferences<_$DaKanjiDB, $KanjiBankV3StatsKanjiRelationsTableTable,
              KanjiBankV3StatsKanjiRelationsTableData>
        ),
        KanjiBankV3StatsKanjiRelationsTableData,
        PrefetchHooks Function()>;

class $DaKanjiDBManager {
  final _$DaKanjiDB _db;
  $DaKanjiDBManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db, _db.indexTable);
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
  $$KanjiBankV3TagsTableTableTableManager get kanjiBankV3TagsTable =>
      $$KanjiBankV3TagsTableTableTableManager(_db, _db.kanjiBankV3TagsTable);
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
  $$KanjiBankV3StatsTableTableTableManager get kanjiBankV3StatsTable =>
      $$KanjiBankV3StatsTableTableTableManager(_db, _db.kanjiBankV3StatsTable);
  $$KanjiBankV3StatsKanjiRelationsTableTableTableManager
      get kanjiBankV3StatsKanjiRelationsTable =>
          $$KanjiBankV3StatsKanjiRelationsTableTableTableManager(
              _db, _db.kanjiBankV3StatsKanjiRelationsTable);
}
