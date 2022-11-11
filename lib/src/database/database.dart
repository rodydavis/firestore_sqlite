import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../utils/json.dart';
import 'connection/connection.dart' as impl;

part 'database.g.dart';

// TODO: Document CRUD queries
// TODO: Relation triggers
// TODO: Full text search
@DriftDatabase(include: {
  'sql/firestore.drift',
  'sql/search.drift',
})
class Database extends _$Database {
  Database({
    String dbName = 'graph_db.db',
    DatabaseConnection? connection,
    bool useWebWorker = false,
    bool logStatements = false,
  }) : super.connect(
          connection ??
              impl.connect(
                dbName,
                useWebWorker: useWebWorker,
                logStatements: logStatements,
              ),
        );

  @override
  int get schemaVersion => 1;

  Future<void> insertOrReplaceDocument(Map<String, Object?> data) async {
    final id = data['id'] as String?;
    if (id == null || id.isEmpty) {
      throw ArgumentError('Node missing id: $data');
    }
    final body = jsonToString(data);
    final current = await getDocumentById(id).getSingleOrNull();
    try {
      if (current == null) {
        await createDocument(body);
      } else {
        await updateDocument(body);
      }
    } catch (e) {
      debugPrint('Error inserting node: $e $body');
    }
  }

  Future<void> deleteDocument(String id) async {
    await (delete(documents)..where((t) => t.documentId.equals(id))).go();
  }

  Future<List<Document>> getDocuments(String collection) {
    return getDocumentsByCollection(collection).get();
  }

  Stream<List<Document>> watchDocuments(String collection) {
    return getDocumentsByCollection(collection).watch();
  }

  Future<Document?> getDocument(String collection, String id) {
    return getDocumentByIdAndCollection(id, collection).getSingleOrNull();
  }

  Stream<Document?> watchDocument(String collection, String id) {
    return getDocumentByIdAndCollection(id, collection).watchSingleOrNull();
  }

  Future<List<Document>> searchAllDocuments(
    String query, {
    bool Function(Map<String, Object?>)? filter,
  }) =>
      super
          .searchDocuments(query)
          .get()
          .then((value) => value.map((e) => e.r).where((d) {
                if (filter != null) {
                  return filter(d.toMap());
                } else {
                  return true;
                }
              }).toList());
}

extension DocUtils on Document {
  Map<String, Object?> toMap() => {
        ...jsonDecode(data),
        'id': documentId,
      };
}
