import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/extensions/json1.dart';
import 'package:flutter/foundation.dart';

import '../utils/json.dart';
import 'connection/connection.dart' as impl;

part 'database.g.dart';

const dbName = 'firestore.sqlite';

// TODO: Relation triggers
@DriftDatabase(include: {
  'sql/firestore.drift',
  'sql/search.drift',
})
class Database extends _$Database {
  Database({
    required DatabaseConnection connection,
    String dbName = dbName,
    bool useWebWorker = false,
    bool logStatements = false,
  }) : super.connect(connection);

  factory Database.defaults({
    bool useWebWorker = false,
    bool logStatements = false,
  }) {
    return Database(
      dbName: dbName,
      useWebWorker: kIsWeb,
      logStatements: kDebugMode,
      connection: impl.connect(
        dbName,
        useWebWorker: useWebWorker,
        logStatements: logStatements,
      ),
    );
  }

  @override
  int get schemaVersion => 1;

  Future<void> insertOrReplaceDocument(Map<String, Object?> data) async {
    final id = data['id'] as String?;
    if (id == null || id.isEmpty) {
      throw ArgumentError('Document missing id: $data');
    }
    final collection = data['collection'] as String?;
    if (collection == null || collection.isEmpty) {
      throw ArgumentError('Document missing collection: $data');
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

  Future<void> deleteDocument(String id, String collection) async {
    await (delete(documents)
          ..where((t) => t.documentId.equals(id))
          ..where((t) => t.collection.equals(collection)))
        .go();
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

  Future<void> removeDeletedDocuments() async {
    await (delete(documents)
          ..where((t) => t.data.jsonExtract('deleted').equals(true)))
        .go();
  }
}

extension DocUtils on Document {
  Map<String, Object?> toMap() => {
        ...jsonDecode(data),
        'id': documentId,
      };
}
