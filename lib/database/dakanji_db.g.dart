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
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES index_table (id)'));
  static const VerificationMeta _onyomiMeta = const VerificationMeta('onyomi');
  @override
  late final GeneratedColumn<String> onyomi = GeneratedColumn<String>(
      'onyomi', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, dictId, onyomi];
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

  /// The onyomi reading of this entry
  final String onyomi;
  const KanjiBankV3OnyomisTableData(
      {required this.id, required this.dictId, required this.onyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['onyomi'] = Variable<String>(onyomi);
    return map;
  }

  KanjiBankV3OnyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3OnyomisTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      onyomi: Value(onyomi),
    );
  }

  factory KanjiBankV3OnyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3OnyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      onyomi: serializer.fromJson<String>(json['onyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'onyomi': serializer.toJson<String>(onyomi),
    };
  }

  KanjiBankV3OnyomisTableData copyWith(
          {int? id, int? dictId, String? onyomi}) =>
      KanjiBankV3OnyomisTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        onyomi: onyomi ?? this.onyomi,
      );
  KanjiBankV3OnyomisTableData copyWithCompanion(
      KanjiBankV3OnyomisTableCompanion data) {
    return KanjiBankV3OnyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
      onyomi: data.onyomi.present ? data.onyomi.value : this.onyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3OnyomisTableData(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('onyomi: $onyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, onyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3OnyomisTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.onyomi == this.onyomi);
}

class KanjiBankV3OnyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3OnyomisTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<String> onyomi;
  const KanjiBankV3OnyomisTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.onyomi = const Value.absent(),
  });
  KanjiBankV3OnyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required String onyomi,
  })  : dictId = Value(dictId),
        onyomi = Value(onyomi);
  static Insertable<KanjiBankV3OnyomisTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<String>? onyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (onyomi != null) 'onyomi': onyomi,
    });
  }

  KanjiBankV3OnyomisTableCompanion copyWith(
      {Value<int>? id, Value<int>? dictId, Value<String>? onyomi}) {
    return KanjiBankV3OnyomisTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES index_table (id)'));
  static const VerificationMeta _kunyomiMeta =
      const VerificationMeta('kunyomi');
  @override
  late final GeneratedColumn<String> kunyomi = GeneratedColumn<String>(
      'kunyomi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dictId, kunyomi];
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

  /// The kunyomi reading of this entry
  final String kunyomi;
  const KanjiBankV3KunyomisTableData(
      {required this.id, required this.dictId, required this.kunyomi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['kunyomi'] = Variable<String>(kunyomi);
    return map;
  }

  KanjiBankV3KunyomisTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3KunyomisTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      kunyomi: Value(kunyomi),
    );
  }

  factory KanjiBankV3KunyomisTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3KunyomisTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      kunyomi: serializer.fromJson<String>(json['kunyomi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'kunyomi': serializer.toJson<String>(kunyomi),
    };
  }

  KanjiBankV3KunyomisTableData copyWith(
          {int? id, int? dictId, String? kunyomi}) =>
      KanjiBankV3KunyomisTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        kunyomi: kunyomi ?? this.kunyomi,
      );
  KanjiBankV3KunyomisTableData copyWithCompanion(
      KanjiBankV3KunyomisTableCompanion data) {
    return KanjiBankV3KunyomisTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
      kunyomi: data.kunyomi.present ? data.kunyomi.value : this.kunyomi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3KunyomisTableData(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('kunyomi: $kunyomi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, kunyomi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3KunyomisTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.kunyomi == this.kunyomi);
}

class KanjiBankV3KunyomisTableCompanion
    extends UpdateCompanion<KanjiBankV3KunyomisTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<String> kunyomi;
  const KanjiBankV3KunyomisTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.kunyomi = const Value.absent(),
  });
  KanjiBankV3KunyomisTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required String kunyomi,
  })  : dictId = Value(dictId),
        kunyomi = Value(kunyomi);
  static Insertable<KanjiBankV3KunyomisTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<String>? kunyomi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (kunyomi != null) 'kunyomi': kunyomi,
    });
  }

  KanjiBankV3KunyomisTableCompanion copyWith(
      {Value<int>? id, Value<int>? dictId, Value<String>? kunyomi}) {
    return KanjiBankV3KunyomisTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES index_table (id)'));
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dictId, tag];
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

  /// The kunyomi reading of this entry
  final String tag;
  const KanjiBankV3TagsTableData(
      {required this.id, required this.dictId, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  KanjiBankV3TagsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3TagsTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      tag: Value(tag),
    );
  }

  factory KanjiBankV3TagsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3TagsTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'tag': serializer.toJson<String>(tag),
    };
  }

  KanjiBankV3TagsTableData copyWith({int? id, int? dictId, String? tag}) =>
      KanjiBankV3TagsTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        tag: tag ?? this.tag,
      );
  KanjiBankV3TagsTableData copyWithCompanion(
      KanjiBankV3TagsTableCompanion data) {
    return KanjiBankV3TagsTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3TagsTableData(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3TagsTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.tag == this.tag);
}

class KanjiBankV3TagsTableCompanion
    extends UpdateCompanion<KanjiBankV3TagsTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<String> tag;
  const KanjiBankV3TagsTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.tag = const Value.absent(),
  });
  KanjiBankV3TagsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required String tag,
  })  : dictId = Value(dictId),
        tag = Value(tag);
  static Insertable<KanjiBankV3TagsTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (tag != null) 'tag': tag,
    });
  }

  KanjiBankV3TagsTableCompanion copyWith(
      {Value<int>? id, Value<int>? dictId, Value<String>? tag}) {
    return KanjiBankV3TagsTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_tags_table (id)'));
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES index_table (id)'));
  static const VerificationMeta _meaningMeta =
      const VerificationMeta('meaning');
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
      'meaning', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dictId, meaning];
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

  /// The meaning of this entry
  final String meaning;
  const KanjiBankV3MeaningsTableData(
      {required this.id, required this.dictId, required this.meaning});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['meaning'] = Variable<String>(meaning);
    return map;
  }

  KanjiBankV3MeaningsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3MeaningsTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      meaning: Value(meaning),
    );
  }

  factory KanjiBankV3MeaningsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3MeaningsTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      meaning: serializer.fromJson<String>(json['meaning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'meaning': serializer.toJson<String>(meaning),
    };
  }

  KanjiBankV3MeaningsTableData copyWith(
          {int? id, int? dictId, String? meaning}) =>
      KanjiBankV3MeaningsTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        meaning: meaning ?? this.meaning,
      );
  KanjiBankV3MeaningsTableData copyWithCompanion(
      KanjiBankV3MeaningsTableCompanion data) {
    return KanjiBankV3MeaningsTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3MeaningsTableData(')
          ..write('id: $id, ')
          ..write('dictId: $dictId, ')
          ..write('meaning: $meaning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, meaning);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3MeaningsTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.meaning == this.meaning);
}

class KanjiBankV3MeaningsTableCompanion
    extends UpdateCompanion<KanjiBankV3MeaningsTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<String> meaning;
  const KanjiBankV3MeaningsTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.meaning = const Value.absent(),
  });
  KanjiBankV3MeaningsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required String meaning,
  })  : dictId = Value(dictId),
        meaning = Value(meaning);
  static Insertable<KanjiBankV3MeaningsTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<String>? meaning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (meaning != null) 'meaning': meaning,
    });
  }

  KanjiBankV3MeaningsTableCompanion copyWith(
      {Value<int>? id, Value<int>? dictId, Value<String>? meaning}) {
    return KanjiBankV3MeaningsTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
  static const VerificationMeta _dictIdMeta = const VerificationMeta('dictId');
  @override
  late final GeneratedColumn<int> dictId = GeneratedColumn<int>(
      'dict_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES index_table (id)'));
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
  List<GeneratedColumn> get $columns => [id, dictId, statNameId, statValueId];
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
      dictId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dict_id'])!,
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

  /// The id of the dictionary this entry belongs to
  final int dictId;

  /// `KanjiBankV3StatsName` entry of this meaning
  final int statNameId;

  /// The value of this entrie's stat
  final int statValueId;
  const KanjiBankV3StatsTableData(
      {required this.id,
      required this.dictId,
      required this.statNameId,
      required this.statValueId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dict_id'] = Variable<int>(dictId);
    map['stat_name_id'] = Variable<int>(statNameId);
    map['stat_value_id'] = Variable<int>(statValueId);
    return map;
  }

  KanjiBankV3StatsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatsTableCompanion(
      id: Value(id),
      dictId: Value(dictId),
      statNameId: Value(statNameId),
      statValueId: Value(statValueId),
    );
  }

  factory KanjiBankV3StatsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatsTableData(
      id: serializer.fromJson<int>(json['id']),
      dictId: serializer.fromJson<int>(json['dictId']),
      statNameId: serializer.fromJson<int>(json['statNameId']),
      statValueId: serializer.fromJson<int>(json['statValueId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictId': serializer.toJson<int>(dictId),
      'statNameId': serializer.toJson<int>(statNameId),
      'statValueId': serializer.toJson<int>(statValueId),
    };
  }

  KanjiBankV3StatsTableData copyWith(
          {int? id, int? dictId, int? statNameId, int? statValueId}) =>
      KanjiBankV3StatsTableData(
        id: id ?? this.id,
        dictId: dictId ?? this.dictId,
        statNameId: statNameId ?? this.statNameId,
        statValueId: statValueId ?? this.statValueId,
      );
  KanjiBankV3StatsTableData copyWithCompanion(
      KanjiBankV3StatsTableCompanion data) {
    return KanjiBankV3StatsTableData(
      id: data.id.present ? data.id.value : this.id,
      dictId: data.dictId.present ? data.dictId.value : this.dictId,
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
          ..write('dictId: $dictId, ')
          ..write('statNameId: $statNameId, ')
          ..write('statValueId: $statValueId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictId, statNameId, statValueId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatsTableData &&
          other.id == this.id &&
          other.dictId == this.dictId &&
          other.statNameId == this.statNameId &&
          other.statValueId == this.statValueId);
}

class KanjiBankV3StatsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatsTableData> {
  final Value<int> id;
  final Value<int> dictId;
  final Value<int> statNameId;
  final Value<int> statValueId;
  const KanjiBankV3StatsTableCompanion({
    this.id = const Value.absent(),
    this.dictId = const Value.absent(),
    this.statNameId = const Value.absent(),
    this.statValueId = const Value.absent(),
  });
  KanjiBankV3StatsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dictId,
    required int statNameId,
    required int statValueId,
  })  : dictId = Value(dictId),
        statNameId = Value(statNameId),
        statValueId = Value(statValueId);
  static Insertable<KanjiBankV3StatsTableData> custom({
    Expression<int>? id,
    Expression<int>? dictId,
    Expression<int>? statNameId,
    Expression<int>? statValueId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictId != null) 'dict_id': dictId,
      if (statNameId != null) 'stat_name_id': statNameId,
      if (statValueId != null) 'stat_value_id': statValueId,
    });
  }

  KanjiBankV3StatsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dictId,
      Value<int>? statNameId,
      Value<int>? statValueId}) {
    return KanjiBankV3StatsTableCompanion(
      id: id ?? this.id,
      dictId: dictId ?? this.dictId,
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
    if (dictId.present) {
      map['dict_id'] = Variable<int>(dictId.value);
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
          ..write('dictId: $dictId, ')
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
  static const VerificationMeta _statValueIdMeta =
      const VerificationMeta('statValueId');
  @override
  late final GeneratedColumn<int> statValueId = GeneratedColumn<int>(
      'stat_value_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES kanji_bank_v3_stat_values_table (id)'));
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
  List<GeneratedColumn> get $columns => [id, statValueId, kanjiId];
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
    if (data.containsKey('stat_value_id')) {
      context.handle(
          _statValueIdMeta,
          statValueId.isAcceptableOrUnknown(
              data['stat_value_id']!, _statValueIdMeta));
    } else if (isInserting) {
      context.missing(_statValueIdMeta);
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
      statValueId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stat_value_id'])!,
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

  /// the id of the associated stats value
  final int statValueId;

  /// the id of the associated kanji
  final int kanjiId;
  const KanjiBankV3StatKanjiRelationsTableData(
      {required this.id, required this.statValueId, required this.kanjiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stat_value_id'] = Variable<int>(statValueId);
    map['kanji_id'] = Variable<int>(kanjiId);
    return map;
  }

  KanjiBankV3StatKanjiRelationsTableCompanion toCompanion(bool nullToAbsent) {
    return KanjiBankV3StatKanjiRelationsTableCompanion(
      id: Value(id),
      statValueId: Value(statValueId),
      kanjiId: Value(kanjiId),
    );
  }

  factory KanjiBankV3StatKanjiRelationsTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KanjiBankV3StatKanjiRelationsTableData(
      id: serializer.fromJson<int>(json['id']),
      statValueId: serializer.fromJson<int>(json['statValueId']),
      kanjiId: serializer.fromJson<int>(json['kanjiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'statValueId': serializer.toJson<int>(statValueId),
      'kanjiId': serializer.toJson<int>(kanjiId),
    };
  }

  KanjiBankV3StatKanjiRelationsTableData copyWith(
          {int? id, int? statValueId, int? kanjiId}) =>
      KanjiBankV3StatKanjiRelationsTableData(
        id: id ?? this.id,
        statValueId: statValueId ?? this.statValueId,
        kanjiId: kanjiId ?? this.kanjiId,
      );
  KanjiBankV3StatKanjiRelationsTableData copyWithCompanion(
      KanjiBankV3StatKanjiRelationsTableCompanion data) {
    return KanjiBankV3StatKanjiRelationsTableData(
      id: data.id.present ? data.id.value : this.id,
      statValueId:
          data.statValueId.present ? data.statValueId.value : this.statValueId,
      kanjiId: data.kanjiId.present ? data.kanjiId.value : this.kanjiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KanjiBankV3StatKanjiRelationsTableData(')
          ..write('id: $id, ')
          ..write('statValueId: $statValueId, ')
          ..write('kanjiId: $kanjiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, statValueId, kanjiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KanjiBankV3StatKanjiRelationsTableData &&
          other.id == this.id &&
          other.statValueId == this.statValueId &&
          other.kanjiId == this.kanjiId);
}

class KanjiBankV3StatKanjiRelationsTableCompanion
    extends UpdateCompanion<KanjiBankV3StatKanjiRelationsTableData> {
  final Value<int> id;
  final Value<int> statValueId;
  final Value<int> kanjiId;
  const KanjiBankV3StatKanjiRelationsTableCompanion({
    this.id = const Value.absent(),
    this.statValueId = const Value.absent(),
    this.kanjiId = const Value.absent(),
  });
  KanjiBankV3StatKanjiRelationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int statValueId,
    required int kanjiId,
  })  : statValueId = Value(statValueId),
        kanjiId = Value(kanjiId);
  static Insertable<KanjiBankV3StatKanjiRelationsTableData> custom({
    Expression<int>? id,
    Expression<int>? statValueId,
    Expression<int>? kanjiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statValueId != null) 'stat_value_id': statValueId,
      if (kanjiId != null) 'kanji_id': kanjiId,
    });
  }

  KanjiBankV3StatKanjiRelationsTableCompanion copyWith(
      {Value<int>? id, Value<int>? statValueId, Value<int>? kanjiId}) {
    return KanjiBankV3StatKanjiRelationsTableCompanion(
      id: id ?? this.id,
      statValueId: statValueId ?? this.statValueId,
      kanjiId: kanjiId ?? this.kanjiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statValueId.present) {
      map['stat_value_id'] = Variable<int>(statValueId.value);
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
          ..write('statValueId: $statValueId, ')
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
  late final $KanjiBankV3StatNamesTableTable kanjiBankV3StatNamesTable =
      $KanjiBankV3StatNamesTableTable(this);
  late final $KanjiBankV3StatValuesTableTable kanjiBankV3StatValuesTable =
      $KanjiBankV3StatValuesTableTable(this);
  late final $KanjiBankV3StatsTableTable kanjiBankV3StatsTable =
      $KanjiBankV3StatsTableTable(this);
  late final $KanjiBankV3StatKanjiRelationsTableTable
      kanjiBankV3StatKanjiRelationsTable =
      $KanjiBankV3StatKanjiRelationsTableTable(this);
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
        kanjiBankV3StatNamesTable,
        kanjiBankV3StatValuesTable,
        kanjiBankV3StatsTable,
        kanjiBankV3StatKanjiRelationsTable,
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

final class $$IndexTableTableReferences
    extends BaseReferences<_$DaKanjiDB, $IndexTableTable, IndexTableData> {
  $$IndexTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KanjiBankV3OnyomisTableTable,
      List<KanjiBankV3OnyomisTableData>> _kanjiBankV3OnyomisTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3OnyomisTable,
          aliasName: $_aliasNameGenerator(
              db.indexTable.id, db.kanjiBankV3OnyomisTable.dictId));

  $$KanjiBankV3OnyomisTableTableProcessedTableManager
      get kanjiBankV3OnyomisTableRefs {
    final manager = $$KanjiBankV3OnyomisTableTableTableManager(
            $_db, $_db.kanjiBankV3OnyomisTable)
        .filter((f) => f.dictId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3OnyomisTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3KunyomisTableTable,
      List<KanjiBankV3KunyomisTableData>> _kanjiBankV3KunyomisTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3KunyomisTable,
          aliasName: $_aliasNameGenerator(
              db.indexTable.id, db.kanjiBankV3KunyomisTable.dictId));

  $$KanjiBankV3KunyomisTableTableProcessedTableManager
      get kanjiBankV3KunyomisTableRefs {
    final manager = $$KanjiBankV3KunyomisTableTableTableManager(
            $_db, $_db.kanjiBankV3KunyomisTable)
        .filter((f) => f.dictId.id($_item.id));

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
              db.indexTable.id, db.kanjiBankV3TagsTable.dictId));

  $$KanjiBankV3TagsTableTableProcessedTableManager
      get kanjiBankV3TagsTableRefs {
    final manager =
        $$KanjiBankV3TagsTableTableTableManager($_db, $_db.kanjiBankV3TagsTable)
            .filter((f) => f.dictId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3TagsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KanjiBankV3MeaningsTableTable,
      List<KanjiBankV3MeaningsTableData>> _kanjiBankV3MeaningsTableRefsTable(
          _$DaKanjiDB db) =>
      MultiTypedResultKey.fromTable(db.kanjiBankV3MeaningsTable,
          aliasName: $_aliasNameGenerator(
              db.indexTable.id, db.kanjiBankV3MeaningsTable.dictId));

  $$KanjiBankV3MeaningsTableTableProcessedTableManager
      get kanjiBankV3MeaningsTableRefs {
    final manager = $$KanjiBankV3MeaningsTableTableTableManager(
            $_db, $_db.kanjiBankV3MeaningsTable)
        .filter((f) => f.dictId.id($_item.id));

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
              db.indexTable.id, db.kanjiBankV3StatsTable.dictId));

  $$KanjiBankV3StatsTableTableProcessedTableManager
      get kanjiBankV3StatsTableRefs {
    final manager = $$KanjiBankV3StatsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatsTable)
        .filter((f) => f.dictId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_kanjiBankV3StatsTableRefsTable($_db));
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

  Expression<bool> kanjiBankV3OnyomisTableRefs(
      Expression<bool> Function($$KanjiBankV3OnyomisTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3OnyomisTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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
        getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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

  Expression<T> kanjiBankV3OnyomisTableRefs<T extends Object>(
      Expression<T> Function($$KanjiBankV3OnyomisTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3OnyomisTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3OnyomisTable,
            getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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
            getReferencedColumn: (t) => t.dictId,
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
    PrefetchHooks Function(
        {bool kanjiBankV3OnyomisTableRefs,
        bool kanjiBankV3KunyomisTableRefs,
        bool kanjiBankV3TagsTableRefs,
        bool kanjiBankV3MeaningsTableRefs,
        bool kanjiBankV3StatsTableRefs})> {
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
                        referencedTable: $$IndexTableTableReferences
                            ._kanjiBankV3OnyomisTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IndexTableTableReferences(db, table, p0)
                                .kanjiBankV3OnyomisTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dictId == item.id),
                        typedResults: items),
                  if (kanjiBankV3KunyomisTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$IndexTableTableReferences
                            ._kanjiBankV3KunyomisTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IndexTableTableReferences(db, table, p0)
                                .kanjiBankV3KunyomisTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dictId == item.id),
                        typedResults: items),
                  if (kanjiBankV3TagsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$IndexTableTableReferences
                            ._kanjiBankV3TagsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IndexTableTableReferences(db, table, p0)
                                .kanjiBankV3TagsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dictId == item.id),
                        typedResults: items),
                  if (kanjiBankV3MeaningsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$IndexTableTableReferences
                            ._kanjiBankV3MeaningsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IndexTableTableReferences(db, table, p0)
                                .kanjiBankV3MeaningsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dictId == item.id),
                        typedResults: items),
                  if (kanjiBankV3StatsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$IndexTableTableReferences
                            ._kanjiBankV3StatsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IndexTableTableReferences(db, table, p0)
                                .kanjiBankV3StatsTableRefs,
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
    PrefetchHooks Function(
        {bool kanjiBankV3OnyomisTableRefs,
        bool kanjiBankV3KunyomisTableRefs,
        bool kanjiBankV3TagsTableRefs,
        bool kanjiBankV3MeaningsTableRefs,
        bool kanjiBankV3StatsTableRefs})>;
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

  ColumnFilters<String> get kanji => $composableBuilder(
      column: $table.kanji, builder: (column) => ColumnFilters(column));

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
        {bool kanjiBankV3OnyomiKanjiRelationsTableRefs,
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
              {kanjiBankV3OnyomiKanjiRelationsTableRefs = false,
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
              addJoins: null,
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
        {bool kanjiBankV3OnyomiKanjiRelationsTableRefs,
        bool kanjiBankV3KunyomiKanjiRelationsTableRefs,
        bool kanjiBankV3TagsKanjiRelationsTableRefs,
        bool kanjiBankV3MeaningsKanjiRelationsTableRefs,
        bool kanjiBankV3StatKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3OnyomisTableTableCreateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  required int dictId,
  required String onyomi,
});
typedef $$KanjiBankV3OnyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3OnyomisTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<String> onyomi,
});

final class $$KanjiBankV3OnyomisTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3OnyomisTableTable, KanjiBankV3OnyomisTableData> {
  $$KanjiBankV3OnyomisTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $IndexTableTable _dictIdTable(_$DaKanjiDB db) =>
      db.indexTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3OnyomisTable.dictId, db.indexTable.id));

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
    PrefetchHooks Function(
        {bool dictId, bool kanjiBankV3OnyomiKanjiRelationsTableRefs})> {
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
            Value<String> onyomi = const Value.absent(),
          }) =>
              KanjiBankV3OnyomisTableCompanion(
            id: id,
            dictId: dictId,
            onyomi: onyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required String onyomi,
          }) =>
              KanjiBankV3OnyomisTableCompanion.insert(
            id: id,
            dictId: dictId,
            onyomi: onyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3OnyomisTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dictId = false,
              kanjiBankV3OnyomiKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3OnyomiKanjiRelationsTableRefs)
                  db.kanjiBankV3OnyomiKanjiRelationsTable
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
                if (dictId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dictId,
                    referencedTable: $$KanjiBankV3OnyomisTableTableReferences
                        ._dictIdTable(db),
                    referencedColumn: $$KanjiBankV3OnyomisTableTableReferences
                        ._dictIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
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
            {bool dictId, bool kanjiBankV3OnyomiKanjiRelationsTableRefs})>;
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
  required int dictId,
  required String kunyomi,
});
typedef $$KanjiBankV3KunyomisTableTableUpdateCompanionBuilder
    = KanjiBankV3KunyomisTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<String> kunyomi,
});

final class $$KanjiBankV3KunyomisTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3KunyomisTableTable, KanjiBankV3KunyomisTableData> {
  $$KanjiBankV3KunyomisTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $IndexTableTable _dictIdTable(_$DaKanjiDB db) =>
      db.indexTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3KunyomisTable.dictId, db.indexTable.id));

  $$IndexTableTableProcessedTableManager? get dictId {
    if ($_item.dictId == null) return null;
    final manager = $$IndexTableTableTableManager($_db, $_db.indexTable)
        .filter((f) => f.id($_item.dictId!));
    final item = $_typedResult.readTableOrNull(_dictIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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
    PrefetchHooks Function(
        {bool dictId, bool kanjiBankV3KunyomiKanjiRelationsTableRefs})> {
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
            Value<String> kunyomi = const Value.absent(),
          }) =>
              KanjiBankV3KunyomisTableCompanion(
            id: id,
            dictId: dictId,
            kunyomi: kunyomi,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required String kunyomi,
          }) =>
              KanjiBankV3KunyomisTableCompanion.insert(
            id: id,
            dictId: dictId,
            kunyomi: kunyomi,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3KunyomisTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dictId = false,
              kanjiBankV3KunyomiKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3KunyomiKanjiRelationsTableRefs)
                  db.kanjiBankV3KunyomiKanjiRelationsTable
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
                if (dictId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dictId,
                    referencedTable: $$KanjiBankV3KunyomisTableTableReferences
                        ._dictIdTable(db),
                    referencedColumn: $$KanjiBankV3KunyomisTableTableReferences
                        ._dictIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
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
            {bool dictId, bool kanjiBankV3KunyomiKanjiRelationsTableRefs})>;
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
typedef $$KanjiBankV3TagsTableTableCreateCompanionBuilder
    = KanjiBankV3TagsTableCompanion Function({
  Value<int> id,
  required int dictId,
  required String tag,
});
typedef $$KanjiBankV3TagsTableTableUpdateCompanionBuilder
    = KanjiBankV3TagsTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<String> tag,
});

final class $$KanjiBankV3TagsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3TagsTableTable, KanjiBankV3TagsTableData> {
  $$KanjiBankV3TagsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $IndexTableTable _dictIdTable(_$DaKanjiDB db) =>
      db.indexTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3TagsTable.dictId, db.indexTable.id));

  $$IndexTableTableProcessedTableManager? get dictId {
    if ($_item.dictId == null) return null;
    final manager = $$IndexTableTableTableManager($_db, $_db.indexTable)
        .filter((f) => f.id($_item.dictId!));
    final item = $_typedResult.readTableOrNull(_dictIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$KanjiBankV3TagsKanjiRelationsTableTable,
          List<KanjiBankV3TagsKanjiRelationsTableData>>
      _kanjiBankV3TagsKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3TagsKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3TagsTable.id,
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
    PrefetchHooks Function(
        {bool dictId, bool kanjiBankV3TagsKanjiRelationsTableRefs})> {
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
            Value<String> tag = const Value.absent(),
          }) =>
              KanjiBankV3TagsTableCompanion(
            id: id,
            dictId: dictId,
            tag: tag,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required String tag,
          }) =>
              KanjiBankV3TagsTableCompanion.insert(
            id: id,
            dictId: dictId,
            tag: tag,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3TagsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dictId = false,
              kanjiBankV3TagsKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3TagsKanjiRelationsTableRefs)
                  db.kanjiBankV3TagsKanjiRelationsTable
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
                if (dictId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dictId,
                    referencedTable:
                        $$KanjiBankV3TagsTableTableReferences._dictIdTable(db),
                    referencedColumn: $$KanjiBankV3TagsTableTableReferences
                        ._dictIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kanjiBankV3TagsKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$KanjiBankV3TagsTableTableReferences
                            ._kanjiBankV3TagsKanjiRelationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3TagsTableTableReferences(db, table, p0)
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
        PrefetchHooks Function(
            {bool dictId, bool kanjiBankV3TagsKanjiRelationsTableRefs})>;
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

  static $KanjiBankV3TagsTableTable _tagIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3TagsTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3TagsKanjiRelationsTable.tagId,
          db.kanjiBankV3TagsTable.id));

  $$KanjiBankV3TagsTableTableProcessedTableManager? get tagId {
    if ($_item.tagId == null) return null;
    final manager =
        $$KanjiBankV3TagsTableTableTableManager($_db, $_db.kanjiBankV3TagsTable)
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

  $$KanjiBankV3TagsTableTableFilterComposer get tagId {
    final $$KanjiBankV3TagsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.kanjiBankV3TagsTable,
        getReferencedColumn: (t) => t.id,
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

  $$KanjiBankV3TagsTableTableOrderingComposer get tagId {
    final $$KanjiBankV3TagsTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tagId,
            referencedTable: $db.kanjiBankV3TagsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KanjiBankV3TagsTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.kanjiBankV3TagsTable,
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

  $$KanjiBankV3TagsTableTableAnnotationComposer get tagId {
    final $$KanjiBankV3TagsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tagId,
            referencedTable: $db.kanjiBankV3TagsTable,
            getReferencedColumn: (t) => t.id,
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
  required int dictId,
  required String meaning,
});
typedef $$KanjiBankV3MeaningsTableTableUpdateCompanionBuilder
    = KanjiBankV3MeaningsTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<String> meaning,
});

final class $$KanjiBankV3MeaningsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3MeaningsTableTable, KanjiBankV3MeaningsTableData> {
  $$KanjiBankV3MeaningsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $IndexTableTable _dictIdTable(_$DaKanjiDB db) =>
      db.indexTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3MeaningsTable.dictId, db.indexTable.id));

  $$IndexTableTableProcessedTableManager? get dictId {
    if ($_item.dictId == null) return null;
    final manager = $$IndexTableTableTableManager($_db, $_db.indexTable)
        .filter((f) => f.id($_item.dictId!));
    final item = $_typedResult.readTableOrNull(_dictIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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
    PrefetchHooks Function(
        {bool dictId, bool kanjiBankV3MeaningsKanjiRelationsTableRefs})> {
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
            Value<String> meaning = const Value.absent(),
          }) =>
              KanjiBankV3MeaningsTableCompanion(
            id: id,
            dictId: dictId,
            meaning: meaning,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required String meaning,
          }) =>
              KanjiBankV3MeaningsTableCompanion.insert(
            id: id,
            dictId: dictId,
            meaning: meaning,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3MeaningsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dictId = false,
              kanjiBankV3MeaningsKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3MeaningsKanjiRelationsTableRefs)
                  db.kanjiBankV3MeaningsKanjiRelationsTable
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
                if (dictId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dictId,
                    referencedTable: $$KanjiBankV3MeaningsTableTableReferences
                        ._dictIdTable(db),
                    referencedColumn: $$KanjiBankV3MeaningsTableTableReferences
                        ._dictIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
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
            {bool dictId, bool kanjiBankV3MeaningsKanjiRelationsTableRefs})>;
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

  static MultiTypedResultKey<$KanjiBankV3StatKanjiRelationsTableTable,
          List<KanjiBankV3StatKanjiRelationsTableData>>
      _kanjiBankV3StatKanjiRelationsTableRefsTable(_$DaKanjiDB db) =>
          MultiTypedResultKey.fromTable(db.kanjiBankV3StatKanjiRelationsTable,
              aliasName: $_aliasNameGenerator(db.kanjiBankV3StatValuesTable.id,
                  db.kanjiBankV3StatKanjiRelationsTable.statValueId));

  $$KanjiBankV3StatKanjiRelationsTableTableProcessedTableManager
      get kanjiBankV3StatKanjiRelationsTableRefs {
    final manager = $$KanjiBankV3StatKanjiRelationsTableTableTableManager(
            $_db, $_db.kanjiBankV3StatKanjiRelationsTable)
        .filter((f) => f.statValueId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_kanjiBankV3StatKanjiRelationsTableRefsTable($_db));
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

  Expression<bool> kanjiBankV3StatKanjiRelationsTableRefs(
      Expression<bool> Function(
              $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer f)
          f) {
    final $$KanjiBankV3StatKanjiRelationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatKanjiRelationsTable,
            getReferencedColumn: (t) => t.statValueId,
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

  Expression<T> kanjiBankV3StatKanjiRelationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer a)
          f) {
    final $$KanjiBankV3StatKanjiRelationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.kanjiBankV3StatKanjiRelationsTable,
            getReferencedColumn: (t) => t.statValueId,
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
    PrefetchHooks Function(
        {bool kanjiBankV3StatsTableRefs,
        bool kanjiBankV3StatKanjiRelationsTableRefs})> {
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
          prefetchHooksCallback: (
              {kanjiBankV3StatsTableRefs = false,
              kanjiBankV3StatKanjiRelationsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (kanjiBankV3StatsTableRefs) db.kanjiBankV3StatsTable,
                if (kanjiBankV3StatKanjiRelationsTableRefs)
                  db.kanjiBankV3StatKanjiRelationsTable
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
                        typedResults: items),
                  if (kanjiBankV3StatKanjiRelationsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$KanjiBankV3StatValuesTableTableReferences
                                ._kanjiBankV3StatKanjiRelationsTableRefsTable(
                                    db),
                        managerFromTypedResult: (p0) =>
                            $$KanjiBankV3StatValuesTableTableReferences(
                                    db, table, p0)
                                .kanjiBankV3StatKanjiRelationsTableRefs,
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
        PrefetchHooks Function(
            {bool kanjiBankV3StatsTableRefs,
            bool kanjiBankV3StatKanjiRelationsTableRefs})>;
typedef $$KanjiBankV3StatsTableTableCreateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  required int dictId,
  required int statNameId,
  required int statValueId,
});
typedef $$KanjiBankV3StatsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatsTableCompanion Function({
  Value<int> id,
  Value<int> dictId,
  Value<int> statNameId,
  Value<int> statValueId,
});

final class $$KanjiBankV3StatsTableTableReferences extends BaseReferences<
    _$DaKanjiDB, $KanjiBankV3StatsTableTable, KanjiBankV3StatsTableData> {
  $$KanjiBankV3StatsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $IndexTableTable _dictIdTable(_$DaKanjiDB db) =>
      db.indexTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatsTable.dictId, db.indexTable.id));

  $$IndexTableTableProcessedTableManager? get dictId {
    if ($_item.dictId == null) return null;
    final manager = $$IndexTableTableTableManager($_db, $_db.indexTable)
        .filter((f) => f.id($_item.dictId!));
    final item = $_typedResult.readTableOrNull(_dictIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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
    PrefetchHooks Function({bool dictId, bool statNameId, bool statValueId})> {
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
            Value<int> statNameId = const Value.absent(),
            Value<int> statValueId = const Value.absent(),
          }) =>
              KanjiBankV3StatsTableCompanion(
            id: id,
            dictId: dictId,
            statNameId: statNameId,
            statValueId: statValueId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dictId,
            required int statNameId,
            required int statValueId,
          }) =>
              KanjiBankV3StatsTableCompanion.insert(
            id: id,
            dictId: dictId,
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
              {dictId = false, statNameId = false, statValueId = false}) {
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
                if (dictId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dictId,
                    referencedTable:
                        $$KanjiBankV3StatsTableTableReferences._dictIdTable(db),
                    referencedColumn: $$KanjiBankV3StatsTableTableReferences
                        ._dictIdTable(db)
                        .id,
                  ) as T;
                }
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
        PrefetchHooks Function(
            {bool dictId, bool statNameId, bool statValueId})>;
typedef $$KanjiBankV3StatKanjiRelationsTableTableCreateCompanionBuilder
    = KanjiBankV3StatKanjiRelationsTableCompanion Function({
  Value<int> id,
  required int statValueId,
  required int kanjiId,
});
typedef $$KanjiBankV3StatKanjiRelationsTableTableUpdateCompanionBuilder
    = KanjiBankV3StatKanjiRelationsTableCompanion Function({
  Value<int> id,
  Value<int> statValueId,
  Value<int> kanjiId,
});

final class $$KanjiBankV3StatKanjiRelationsTableTableReferences
    extends BaseReferences<
        _$DaKanjiDB,
        $KanjiBankV3StatKanjiRelationsTableTable,
        KanjiBankV3StatKanjiRelationsTableData> {
  $$KanjiBankV3StatKanjiRelationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KanjiBankV3StatValuesTableTable _statValueIdTable(_$DaKanjiDB db) =>
      db.kanjiBankV3StatValuesTable.createAlias($_aliasNameGenerator(
          db.kanjiBankV3StatKanjiRelationsTable.statValueId,
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
        PrefetchHooks Function({bool statValueId, bool kanjiId})> {
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
            Value<int> statValueId = const Value.absent(),
            Value<int> kanjiId = const Value.absent(),
          }) =>
              KanjiBankV3StatKanjiRelationsTableCompanion(
            id: id,
            statValueId: statValueId,
            kanjiId: kanjiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int statValueId,
            required int kanjiId,
          }) =>
              KanjiBankV3StatKanjiRelationsTableCompanion.insert(
            id: id,
            statValueId: statValueId,
            kanjiId: kanjiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KanjiBankV3StatKanjiRelationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({statValueId = false, kanjiId = false}) {
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
                if (statValueId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.statValueId,
                    referencedTable:
                        $$KanjiBankV3StatKanjiRelationsTableTableReferences
                            ._statValueIdTable(db),
                    referencedColumn:
                        $$KanjiBankV3StatKanjiRelationsTableTableReferences
                            ._statValueIdTable(db)
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
        PrefetchHooks Function({bool statValueId, bool kanjiId})>;

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
}
