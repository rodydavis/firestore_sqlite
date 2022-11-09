import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/foundation.dart';

class FirestoreClient {
  final database = Database();
  final firestore = FirebaseFirestore.instance;
  late final schemas = firestore.collection('schema');

  Future<void> _add(Doc doc) async {
    final source = doc.reference.id;
    final jsonString = jsonEncode(doc.toJson());
    // Insert node into nodes
    await database.insertNode(jsonString);
    // Insert edges on relationships
    final fields = doc.collection.allFields;
    final relationFields = fields.whereType<DocumentField>().toList();
    for (final field in relationFields) {
      final target = (field as Field).getString(doc);
      if (target != null) {
        await database.insertEdge(source, target, '{}');
      }
    }
  }

  Future<void> _update(Doc doc) async {
    final source = doc.id;
    final jsonString = jsonEncode(doc.toJson());
    // Insert node into nodes
    await database.updateNode(jsonString, source);
    // Insert edges on relationships
    final fields = doc.collection.allFields;
    final relationFields = fields.whereType<DocumentField>().toList();
    for (final field in relationFields) {
      final target = (field as Field).getString(doc);
      if (target != null) {
        await database.insertEdge(source, target, '{}');
      }
    }
  }

  Future<void> _delete(Doc doc) async {
    final source = doc.id;
    // Delete nodes
    await database.deleteNode(source);
    // Delete edges
    final fields = doc.collection.allFields;
    final relationFields = fields.whereType<DocumentField>().toList();
    for (final field in relationFields) {
      final target = (field as Field).getString(doc);
      if (target != null) {
        await database.deleteEdge(source, target);
      }
    }
  }

  Future<void> addDoc(Doc doc) async {
    await doc.collection.add(doc);
    return _add(doc);
  }

  Future<void> updateDoc(Doc doc) async {
    await doc.collection.set(doc);
    return _update(doc);
  }

  Future<void> deleteDoc(Doc doc) async {
    await doc.delete();
    return _delete(doc);
  }
}

class FirestoreClientCollection<T extends Doc> {
  FirestoreClientCollection(this.client, this.collection);
  final FirestoreClient client;
  final Collection collection;

  static bool _needsUpdate(GetOptions? options) {
    if (options == null) return false;
    final source = options.source;
    return source == Source.server || source == Source.serverAndCache;
  }

  Future<Doc?> _getDoc(
    Collection collection,
    String id, {
    GetOptions options = const GetOptions(),
  }) async {
    await collection.checkForUpdate();
    final doc = Doc(collection: collection, id: id);
    final snapshot = await doc.reference.get(options);
    if (snapshot.exists) {
      await doc.loadSnapshot(snapshot);
      final local = await client.database.getDocument(collection.name, id);
      if (local == null) {
        await client._add(doc);
      } else {
        await client._update(doc);
      }
      return doc;
    } else {
      return null;
    }
  }

  Stream<Doc?> _watchDoc(
    Collection collection,
    String id, {
    GetOptions options = const GetOptions(),
  }) async* {
    final local = await client.database.getDocument(collection.name, id);
    yield local != null ? Doc.fromJson(collection, local.toJson()) : null;
    if (_needsUpdate(options)) {
      await collection.checkForUpdate();
      final doc = Doc(collection: collection, id: id);
      final stream = doc.reference.snapshots();
      await for (final snapshot in stream) {
        if (snapshot.exists) {
          yield Doc.fromDocumentSnapshot(collection, snapshot);
        } else {
          yield null;
        }
      }
    } else {
      yield* client.database
          .watchDocument(collection.name, id)
          .map((e) => e != null ? Doc.fromJson(collection, e.toJson()) : null);
    }
  }

  Future<List<Doc>> _getDocs(
    Collection collection,
    bool deleted, {
    GetOptions options = const GetOptions(),
  }) async {
    if (_needsUpdate(options)) {
      await collection.checkForUpdate();
      final snapshot = await collection.reference.get(options);
      final docs = snapshot.docs
          .map((e) => Doc.fromDocumentSnapshot(collection, e))
          .toList();
      for (final doc in docs) {
        final local =
            await client.database.getDocument(collection.name, doc.id);
        if (local == null) {
          await client._add(doc);
        } else {
          await client._update(doc);
        }
      }
      return docs;
    } else {
      final nodes = await client.database.getDocuments(collection.name);
      return nodes
          .map((e) => Doc.fromJson(collection, e.toJson()))
          .where((e) => deleted ? e.deleted == true : true)
          .toList();
    }
  }

  Stream<List<Doc>> _watchDocs(
    Collection collection,
    bool deleted, {
    GetOptions options = const GetOptions(),
  }) async* {
    final docs = await client.database.getDocuments(collection.name).then((e) =>
        e
            .map((e) => Doc.fromJson(collection, e.toJson()))
            .where((e) => deleted ? e.deleted == true : true)
            .toList());
    yield docs;

    if (_needsUpdate(options)) {
      await collection.checkForUpdate();
      final stream = collection.reference.snapshots();
      await for (final snapshot in stream) {
        final docs = snapshot.docs
            .map((e) => Doc.fromDocumentSnapshot(collection, e))
            .toList();
        yield docs;

        for (final doc in docs) {
          final local =
              await client.database.getDocument(collection.name, doc.id);
          if (local == null) {
            await client._add(doc);
          } else {
            await client._update(doc);
          }
        }
      }
    }
  }

  Future<List<Doc>> get({
    bool deleted = false,
    GetOptions options = const GetOptions(),
  }) =>
      _getDocs(collection, deleted, options: options);

  Stream<List<Doc>> watch({
    bool deleted = false,
    GetOptions options = const GetOptions(),
  }) =>
      _watchDocs(collection, deleted, options: options);

  Future<Doc?> getSingle(
    String id, {
    GetOptions options = const GetOptions(),
  }) =>
      _getDoc(collection, id, options: options);

  Stream<Doc?> watchSingle(
    String id, {
    GetOptions options = const GetOptions(),
  }) =>
      _watchDoc(collection, id, options: options);

  Future<void> checkForUpdates() async {
    await collection.checkForUpdate();
    final local = await client.database.getDocuments(collection.name);
    final newestItems = local
        .map((e) => Doc.fromJson(collection, e.toJson()))
        .map((e) => e.updated)
        .toList();
    final newest = newestItems.isEmpty
        ? DateTime(0)
        : newestItems.reduce((a, b) => a.isAfter(b) ? a : b);
    final latest = await collection.reference
        .where('updated', isGreaterThan: newest.toIso8601String())
        .get()
        .then((snap) => snap.docs)
        .then((docs) =>
            docs.map((e) => Doc.fromDocumentSnapshot(collection, e)).toList());
    await client.database.insertAllNodes(
      latest.map((e) => e.toJson()).toList(),
    );
  }
}
