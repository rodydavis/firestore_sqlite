import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';

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

  Future<Doc?> getDoc(Collection collection, String id) async {
    await collection.checkForUpdate();
    final doc = Doc(collection: collection, id: id);
    final snapshot = await doc.reference.get();
    if (snapshot.exists) {
      await doc.loadSnapshot(snapshot);
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
    await collection.checkForUpdate();
    final doc = Doc(collection: collection, id: id);
    final stream = doc.reference.snapshots();
    await for (final event in stream) {
      if (event.exists) {
        await doc.loadSnapshot(event);
        final local = await database.getDocument(collection.name, id);
        if (local == null) {
          await _add(doc);
        } else {
          await _update(doc);
        }
        yield doc;
      } else {
        yield null;
      }
    }
  }

  Future<List<Doc>> getDocs(Collection collection) async {
    await collection.checkForUpdate();
    // TODO: Load from firestore
    final nodes = await database.getDocuments(collection.name);
    return nodes
        .map((e) => Doc.fromJson(collection, jsonDecode(e.body!)))
        .toList();
  }

  Stream<List<Doc>> watchDocs(Collection collection) async* {
    await collection.checkForUpdate();
    // TODO: Load from firestore
    final stream = database.watchDocuments(collection.name);
    await for (final event in stream) {
      final results = event
          .map((e) => Doc.fromJson(collection, jsonDecode(e.body!)))
          .toList();
      yield results;
    }
  }
}
