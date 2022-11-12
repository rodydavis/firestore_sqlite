import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:collection/collection.dart';
import 'package:firestore_sqlite/src/utils/json.dart';
import 'package:flutter/foundation.dart';

import 'package:firestore_sqlite/firestore_sqlite.dart';

abstract class FirestoreClient {
  late final schemas = firebase.firestore.collection('schema');
  Database get database;
  Firebase get firebase;
  List<Collection> get collections;

  Future<void> _add(Doc doc) async {
    final source = doc.id;
    try {
      // Insert node into documents
      debugPrint('Inserting node into documents: $source');
      await database.insertOrReplaceDocument(doc.toJson());
    } catch (e) {
      debugPrint('Error adding node: $e');
    }
  }

  Future<void> _update(Doc doc) async {
    final source = doc.id;
    try {
      // Insert node into documents
      debugPrint('Updating node into documents: $source');
      await database.insertOrReplaceDocument(doc.toJson());
    } catch (e) {
      debugPrint('Error updating node: $e');
    }
  }

  Future<void> _delete(Doc doc) async {
    final source = doc.id;
    // Delete nodes
    await database.deleteDocument(source, doc.collection.name);
  }

  Future<void> deleteDoc(Doc doc) async {
    await doc.delete();
    return _delete(doc);
  }

  Stream<BundleState> downloadBundle() async* {
    final hasBundles = collections.any((e) => e.bundle == true);
    if (!hasBundles) {
      yield BundleState.success;
      return;
    }
    final bucket = firebase.storage.ref();
    final bundle = await bucket.child('collections-bundle').getData();
    if (bundle == null) {
      yield BundleState.error;
      return;
    }
    yield* loadBundle(bundle);
  }

  Stream<BundleState> loadBundle(Uint8List bundle) async* {
    final task = firebase.firestore.loadBundle(bundle);
    await for (final event in task.stream) {
      final idx = event.taskState.index;
      yield BundleState.values[idx];
    }
  }
}

enum BundleState { running, success, error }

class FirestoreClientCollection<T extends Doc> {
  FirestoreClientCollection(this.client, this.collection);
  final FirestoreClient client;
  final Collection collection;
  late CollectionReference<Json> collectionRef =
      client.firebase.firestore.collection(collection.name);
  late Query<Json> query = collectionRef;

  void setFilter(String key, Object value) {
    query = collectionRef.where(key, isEqualTo: value);
  }

  Future<void> addDoc(Doc doc) async {
    await add(client, doc);
    return client._add(doc);
  }

  Future<void> updateDoc(Doc doc) async {
    await set(client, doc);
    return client._update(doc);
  }

  Future<List<Doc>> getDocuments(FirestoreClient client,
      [GetOptions? options]) {
    return query
        .get(options)
        .then((snapshot) => snapshot.docs)
        .then((docs) => collection.parseDocs(client, docs));
  }

  Stream<List<Doc>> watchDocuments(FirestoreClient client,
      {bool includeMetadataChanges = false}) {
    return query
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .map((snapshot) => snapshot.docs)
        .asyncMap((docs) => collection.parseDocs(client, docs));
  }

  Future<Doc> getDocument(FirestoreClient client, String id,
      [GetOptions? options]) async {
    final reference = collectionRef.doc(id);
    final snapshot = await reference.get(options);
    return Doc.fromSnapshot(client, collection, snapshot);
  }

  Future<String> add(FirestoreClient client, Doc base) async {
    final doc = await collectionRef.add(base.toJson());
    return doc.id;
  }

  Future<void> set(FirestoreClient client, Doc base,
      [SetOptions? options]) async {
    final ref = collectionRef.doc(base.id);
    await ref.set(base.toJson(), options);
  }

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
    if (_needsUpdate(options)) {
      await collection.checkForUpdate(client);
    }
    final local = await client.database.getDocument(collection.name, id);
    if (options.source == Source.cache && local != null) {
      return Doc.fromJson(client, collection, local.toJson());
    }
    if (options.source == Source.serverAndCache) {
      final doc = Doc(client: client, collection: collection, id: id);
      final snapshot = await doc.reference.get(options);
      if (!snapshot.exists) return null;
      final local = await client.database.getDocument(collection.name, id);
      if (local == null) {
        await client._add(doc);
      } else {
        await client._update(doc);
      }
      return Doc.fromDocumentSnapshot(client, collection, snapshot);
    }
    if (options.source == Source.server) {
      final doc = Doc(client: client, collection: collection, id: id);
      final snapshot = await doc.reference.get(options);
      if (!snapshot.exists) return null;
      return Doc.fromDocumentSnapshot(client, collection, snapshot);
    }
    return null;
  }

  Stream<Doc?> _watchDoc(
    Collection collection,
    String id, {
    GetOptions options = const GetOptions(),
  }) async* {
    final local = await client.database.getDocument(collection.name, id);
    yield local != null
        ? Doc.fromJson(client, collection, local.toMap())
        : null;
    if (_needsUpdate(options)) {
      await collection.checkForUpdate(client);
      final doc = Doc(client: client, collection: collection, id: id);
      final stream = doc.reference.snapshots();
      await for (final snapshot in stream) {
        if (snapshot.exists) {
          yield Doc.fromDocumentSnapshot(client, collection, snapshot);
        } else {
          yield null;
        }
      }
    } else {
      yield* client.database.watchDocument(collection.name, id).map((e) =>
          e != null ? Doc.fromJson(client, collection, e.toMap()) : null);
    }
  }

  Future<List<Doc>> _getDocs(
    Collection collection,
    bool deleted, {
    GetOptions options = const GetOptions(),
  }) async {
    if (_needsUpdate(options)) {
      await collection.checkForUpdate(client);
      final snapshot = await query.get(options);
      final docs = snapshot.docs
          .map((e) => Doc.fromDocumentSnapshot(client, collection, e))
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
          .map((e) => Doc.fromJson(client, collection, e.toMap()))
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
            .map((e) => Doc.fromJson(client, collection, e.toMap()))
            .where((e) => deleted ? e.deleted == true : true)
            .toList());
    yield docs;

    if (_needsUpdate(options)) {
      await collection.checkForUpdate(client);
      final stream = query.snapshots();
      await for (final snapshot in stream) {
        final docs = snapshot.docs
            .map((e) => Doc.fromDocumentSnapshot(client, collection, e))
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

    yield* client.database.watchDocuments(collection.name).map((e) => e
        .map((e) => Doc.fromJson(client, collection, e.toMap()))
        .where((e) => deleted ? e.deleted == true : true)
        .toList());
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
    await collection.checkForUpdate(client);
    final local = await client.database.getDocuments(collection.name);
    final newestItems = local
        .map((e) => Doc.fromJson(client, collection, e.toMap()))
        .map((e) => e.updated)
        .toList();
    final newest = newestItems.isEmpty
        ? DateTime(0)
        : newestItems.reduce((a, b) => a.isAfter(b) ? a : b);
    final latest = await collectionRef
        .where('updated', isGreaterThan: newest.toIso8601String())
        .get()
        .then((snap) => snap.docs)
        .then((docs) => docs
            .map((e) => Doc.fromDocumentSnapshot(client, collection, e))
            .toList());
    for (final node in latest) {
      await client.database.insertOrReplaceDocument(node.toJson());
    }
  }

  Future<List<Doc>> search(String query) async {
    final results = await client.database.searchAllDocuments(query);
    return results
        .where((e) => e.collection == collection.name)
        .map((e) => Doc.fromJson(client, collection, e.toMap()))
        .where((e) => e.deleted != true)
        .toList();
  }

  Future<void> sync({
    CollectionReference<Json>? reference,
    GetOptions? options,
  }) async {
    final ref = reference ?? collectionRef;
    final local = await client.database.getDocuments(collection.name);
    final newest = await getNewestItem();
    final remote = await getNewestRemote(
      options: options,
      reference: reference,
      date: newest?.updated,
    );

    // Add missing items
    for (final item in remote) {
      final local = await client.database.getDocument(collection.name, item.id);
      if (local == null) {
        await client.database.insertOrReplaceDocument(item.toJson());
      }
    }

    // Check for missing remote items
    for (final item in local) {
      final remoteItem = remote.firstWhereOrNull(
        (e) => e.id == item.documentId,
      );
      if (remoteItem == null) {
        await ref.doc(item.documentId).set(jsonToMap(item.toMap()));
      }
    }
  }

  Future<Doc?> getNewestItem() async {
    final local = await client.database.getDocuments(collection.name);
    if (local.isNotEmpty) {
      final newestItem = local
          .map((e) => Doc.fromJson(client, collection, e.toMap()))
          .reduce((a, b) => a.updated.isAfter(b.updated) ? a : b);
      return newestItem;
    }
    return null;
  }

  Future<List<DocumentSnapshot<Json?>>> getNewestRemote({
    DateTime? date,
    CollectionReference<Json>? reference,
    GetOptions? options,
  }) async {
    final ref = collectionRef;
    Query<Json?> query = (reference ?? ref);
    if (date != null) {
      query = query.where(
        'updated',
        isGreaterThan: date.toIso8601String(),
      );
    }
    final remote = await query.get(options);
    return remote.docs;
  }
}

class Firebase {
  Firebase({
    required this.firestore,
    required this.storage,
  });

  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
}
