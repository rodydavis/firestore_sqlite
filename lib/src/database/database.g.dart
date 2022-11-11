// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Document extends DataClass implements Insertable<Document> {
  final int id;
  final String data;
  final String documentId;
  final String collection;
  final String created;
  final String updated;
  const Document(
      {required this.id,
      required this.data,
      required this.documentId,
      required this.collection,
      required this.created,
      required this.updated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data'] = Variable<String>(data);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      data: Value(data),
    );
  }

  factory Document.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
      documentId: serializer.fromJson<String>(json['document_id']),
      collection: serializer.fromJson<String>(json['collection']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
      'document_id': serializer.toJson<String>(documentId),
      'collection': serializer.toJson<String>(collection),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
    };
  }

  Document copyWith(
          {int? id,
          String? data,
          String? documentId,
          String? collection,
          String? created,
          String? updated}) =>
      Document(
        id: id ?? this.id,
        data: data ?? this.data,
        documentId: documentId ?? this.documentId,
        collection: collection ?? this.collection,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );
  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('documentId: $documentId, ')
          ..write('collection: $collection, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, data, documentId, collection, created, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.data == this.data &&
          other.documentId == this.documentId &&
          other.collection == this.collection &&
          other.created == this.created &&
          other.updated == this.updated);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<String> data;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String data,
  }) : data = Value(data);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
    });
  }

  DocumentsCompanion copyWith({Value<int>? id, Value<String>? data}) {
    return DocumentsCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class Documents extends Table with TableInfo<Documents, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Documents(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
      'document_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'GENERATED ALWAYS AS (json_extract(data, \'\$.id\')) VIRTUAL NOT NULL UNIQUE');
  final VerificationMeta _collectionMeta = const VerificationMeta('collection');
  late final GeneratedColumn<String> collection = GeneratedColumn<String>(
      'collection', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'GENERATED ALWAYS AS (json_extract(data, \'\$.collection\')) VIRTUAL NOT NULL');
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'GENERATED ALWAYS AS (json_extract(data, \'\$.created\')) VIRTUAL NOT NULL');
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  late final GeneratedColumn<String> updated = GeneratedColumn<String>(
      'updated', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'GENERATED ALWAYS AS (json_extract(data, \'\$.updated\')) VIRTUAL NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, data, documentId, collection, created, updated];
  @override
  String get aliasedName => _alias ?? 'documents';
  @override
  String get actualTableName => 'documents';
  @override
  VerificationContext validateIntegrity(Insertable<Document> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    }
    if (data.containsKey('collection')) {
      context.handle(
          _collectionMeta,
          collection.isAcceptableOrUnknown(
              data['collection']!, _collectionMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      documentId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}document_id'])!,
      collection: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}collection'])!,
      created: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}created'])!,
      updated: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}updated'])!,
    );
  }

  @override
  Documents createAlias(String alias) {
    return Documents(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DocumentEntrie extends DataClass implements Insertable<DocumentEntrie> {
  final String data;
  const DocumentEntrie({required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['data'] = Variable<String>(data);
    return map;
  }

  DocumentEntriesCompanion toCompanion(bool nullToAbsent) {
    return DocumentEntriesCompanion(
      data: Value(data),
    );
  }

  factory DocumentEntrie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentEntrie(
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'data': serializer.toJson<String>(data),
    };
  }

  DocumentEntrie copyWith({String? data}) => DocumentEntrie(
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('DocumentEntrie(')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => data.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentEntrie && other.data == this.data);
}

class DocumentEntriesCompanion extends UpdateCompanion<DocumentEntrie> {
  final Value<String> data;
  const DocumentEntriesCompanion({
    this.data = const Value.absent(),
  });
  DocumentEntriesCompanion.insert({
    required String data,
  }) : data = Value(data);
  static Insertable<DocumentEntrie> custom({
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (data != null) 'data': data,
    });
  }

  DocumentEntriesCompanion copyWith({Value<String>? data}) {
    return DocumentEntriesCompanion(
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentEntriesCompanion(')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class DocumentEntries extends Table
    with
        TableInfo<DocumentEntries, DocumentEntrie>,
        VirtualTableInfo<DocumentEntries, DocumentEntrie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DocumentEntries(this.attachedDatabase, [this._alias]);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [data];
  @override
  String get aliasedName => _alias ?? 'document_entries';
  @override
  String get actualTableName => 'document_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DocumentEntrie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DocumentEntrie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentEntrie(
      data: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
    );
  }

  @override
  DocumentEntries createAlias(String alias) {
    return DocumentEntries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs => 'fts5(data, content=documents, content_rowid=id)';
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  _$Database.connect(DatabaseConnection c) : super.connect(c);
  late final Documents documents = Documents(this);
  late final DocumentEntries documentEntries = DocumentEntries(this);
  late final Trigger documentsInsert = Trigger(
      'CREATE TRIGGER documents_insert AFTER INSERT ON documents BEGIN INSERT INTO document_entries ("rowid", data) VALUES (new.id, new.data);END',
      'documents_insert');
  late final Trigger documentsDelete = Trigger(
      'CREATE TRIGGER documents_delete AFTER DELETE ON documents BEGIN INSERT INTO document_entries (document_entries, "rowid", data) VALUES (\'delete\', old.id, old.data);END',
      'documents_delete');
  late final Trigger documentsUpdate = Trigger(
      'CREATE TRIGGER documents_update AFTER UPDATE ON documents BEGIN INSERT INTO document_entries (document_entries, "rowid", data) VALUES (\'delete\', new.id, new.data);INSERT INTO document_entries ("rowid", data) VALUES (new.id, new.data);END',
      'documents_update');
  late final Index documentIdIdx = Index('document_id_idx',
      'CREATE INDEX IF NOT EXISTS document_id_idx ON documents (document_id)');
  late final Index collectionIdx = Index('collection_idx',
      'CREATE INDEX IF NOT EXISTS collection_idx ON documents (collection)');
  late final Index createdIdx = Index('created_idx',
      'CREATE INDEX IF NOT EXISTS created_idx ON documents (created)');
  late final Index updatedIdx = Index('updated_idx',
      'CREATE INDEX IF NOT EXISTS updated_idx ON documents (updated)');
  Selectable<SearchDocumentsResult> searchDocuments(String query) {
    return customSelect(
        'SELECT"r"."id" AS "nested_0.id", "r"."data" AS "nested_0.data", "r"."document_id" AS "nested_0.document_id", "r"."collection" AS "nested_0.collection", "r"."created" AS "nested_0.created", "r"."updated" AS "nested_0.updated" FROM document_entries INNER JOIN documents AS r ON r.id = document_entries."rowid" WHERE document_entries MATCH ?1 ORDER BY rank',
        variables: [
          Variable<String>(query)
        ],
        readsFrom: {
          documentEntries,
          documents,
        }).asyncMap((QueryRow row) async {
      return SearchDocumentsResult(
        r: await documents.mapFromRow(row, tablePrefix: 'nested_0'),
      );
    });
  }

  Future<int> createDocument(String data) {
    return customInsert(
      'INSERT INTO documents (data) VALUES (json(?1))',
      variables: [Variable<String>(data)],
      updates: {documents},
    );
  }

  Future<int> updateDocument(String text) {
    return customUpdate(
      'UPDATE documents SET data = json(?1) WHERE document_id = json_extract(?1, \'\$.id\')',
      variables: [Variable<String>(text)],
      updates: {documents},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<Document> getAllDocuments() {
    return customSelect('SELECT * FROM documents', variables: [], readsFrom: {
      documents,
    }).asyncMap(documents.mapFromRow);
  }

  Selectable<Document> getDocumentById(String id) {
    return customSelect('SELECT * FROM documents WHERE document_id = ?1',
        variables: [
          Variable<String>(id)
        ],
        readsFrom: {
          documents,
        }).asyncMap(documents.mapFromRow);
  }

  Selectable<Document> getDocumentsByCollection(String collection) {
    return customSelect('SELECT * FROM documents WHERE collection = ?1',
        variables: [
          Variable<String>(collection)
        ],
        readsFrom: {
          documents,
        }).asyncMap(documents.mapFromRow);
  }

  Selectable<Document> getDocumentByIdAndCollection(
      String id, String collection) {
    return customSelect(
        'SELECT * FROM documents WHERE document_id = ?1 AND collection = ?2',
        variables: [
          Variable<String>(id),
          Variable<String>(collection)
        ],
        readsFrom: {
          documents,
        }).asyncMap(documents.mapFromRow);
  }

  Selectable<Document> getLatestDocumentInCollection(String collection) {
    return customSelect(
        'SELECT * FROM documents WHERE collection = ?1 ORDER BY updated DESC LIMIT 1',
        variables: [
          Variable<String>(collection)
        ],
        readsFrom: {
          documents,
        }).asyncMap(documents.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        documents,
        documentEntries,
        documentsInsert,
        documentsDelete,
        documentsUpdate,
        documentIdIdx,
        collectionIdx,
        createdIdx,
        updatedIdx
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('documents',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('document_entries', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('documents',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('document_entries', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('documents',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('document_entries', kind: UpdateKind.insert),
            ],
          ),
        ],
      );
}

class SearchDocumentsResult {
  final Document r;
  SearchDocumentsResult({
    required this.r,
  });
}
