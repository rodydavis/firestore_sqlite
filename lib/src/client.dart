import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/foundation.dart';

class FirestoreClient extends ChangeNotifier {
  final database = Database();
  final collections = ValueNotifier<List<Collection>>([]);
  final firestore = FirebaseFirestore.instance;
  late final schemas = firestore.collection('schema');

  Future<void> checkForUpdates({
    Future<String> Function()? loadFromAssets,
  }) async {
    final snapshot = await schemas.get();
    final results = <Collection>[];
    for (final doc in snapshot.docs) {
      final data = {...doc.data(), "id": doc.id};
      results.add(Collection.fromJson(data));
    }
    if (results.isEmpty && loadFromAssets != null) {
      final assetString = await loadFromAssets();
      final jsonItems = jsonDecode(assetString) as List<dynamic>;
      for (final data in jsonItems) {
        results.add(Collection.fromJson(data));
      }
    }
    collections.value = results;
  }

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

  Future<void> addDoc(Doc doc) async {
    await doc.collection.add(doc);
    return _add(doc);
  }

  Future<void> updateDoc(Doc doc) async {
    await doc.collection.set(doc);
    return _update(doc);
  }

  Future<void> deleteDoc(Doc doc) async {
    final source = doc.id;
    await doc.delete();
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

  Future<Doc?> getDoc(Collection collection, String id) async {
    final doc = Doc(collection: collection, id: id);
    final snapshot = await doc.reload();
    if (snapshot.exists) {
      final local = await database.getDocument(collection.name, id);
      if (local == null) {
        await _add(doc);
      } else {
        await _update(doc);
      }
      return doc;
    } else {
      return null;
    }
  }

  Stream<Doc?> watchDoc(Collection collection, String id) async* {
    final doc = Doc(collection: collection, id: id);
    final stream = doc.reference.snapshots();
    await for (final event in stream) {
      if (event.exists) {
        final data = {...event.data() ?? {}, 'id': event.id};
        yield Doc.fromJson(collection, data);
      } else {
        yield null;
      }
    }
  }

  Future<List<Doc>> getDocs(Collection collection) async {
    final docs = await database.getDocuments(collection.name);
    return docs
        .map((e) => Doc.fromJson(collection, jsonDecode(e.body!)))
        .toList();
  }

  Stream<List<Doc>> watchDocs(Collection collection) async* {
    final stream = database.watchDocuments(collection.name);

    await for (final event in stream) {
      final results = event
          .map((e) => Doc.fromJson(collection, jsonDecode(e.body!)))
          .toList();
      yield results;
    }
  }
}
