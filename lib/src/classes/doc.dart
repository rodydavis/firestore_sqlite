import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../client.dart';
import 'extensions.dart';
import 'collection.dart';

typedef Snapshot = DocumentSnapshot<Object?>;

/// Base for all items in a collection
class Doc {
  Doc({
    required this.id,
    required this.collection,
    required this.client,
  });

  factory Doc.modify(
    Collection collection,
    FirestoreClient client, [
    String? id,
  ]) {
    final ref = client.firebase.firestore.collection(collection.name);
    final docId = id ?? ref.doc().id;
    return Doc(
      id: docId,
      collection: collection,
      client: client,
    );
  }

  factory Doc.fromJson(
    FirestoreClient client,
    Collection collection,
    Json data,
  ) {
    final id = data['document_id'] ?? data['id'] ?? '';
    final base = Doc(
      id: id,
      collection: collection,
      client: client,
    );
    data['id'] = id;
    base.setJson(data);
    return base;
  }

  factory Doc.fromDocumentSnapshot(
    FirestoreClient client,
    Collection collection,
    DocumentSnapshot<Json?> snapshot,
  ) =>
      Doc.fromJson(client, collection, {
        ...snapshot.data() ?? {},
        'id': snapshot.id,
      });

  static Future<Doc> fromSnapshot(
    FirestoreClient client,
    Collection collection,
    DocumentSnapshot<Object?> snapshot,
  ) async {
    final base = Doc(
      client: client,
      id: snapshot.id,
      collection: collection,
    );
    await base.loadSnapshot(snapshot);
    return base;
  }

  notifyListeners() {}

  StreamSubscription<Snapshot>? _subscription;
  Json _data = {};
  WriteBatch? _batch;
  bool get hasPendingChanges => _batch != null;

  /// Collection the document belongs to
  Collection collection;

  void setSchema(Json value) {
    collection = Collection.fromJson(value);
    notifyListeners();
  }

  /// Document id
  final String id;
  final FirestoreClient client;

  /// Firestore collection reference
  late final ref =
      client.firebase.firestore.collection(collection.name).doc(id);

  Object? operator [](String key) {
    for (final field in collection.allFields) {
      // Check for current key
      if (field.name == key && _data.containsKey(key)) {
        return _data[key];
      }
      // Check previous keys
      if (field.previous != null) {
        if (_data.keys.any((e) => field.previous!.contains(e))) {
          final match = _data.keys.firstWhere(
            (e) => field.previous!.contains(e),
          );
          return _data[match];
        }
      }
    }
    return null;
  }

  operator []=(String key, Object? value) => setValue(key, value);

  DateTime get created => getDate(this['created']);

  DateTime get updated => getDate(this['updated']);

  bool? get deleted => this['deleted'] as bool?;

  Future<void> applySchemaChanges() async {
    for (final field in collection.allFields) {
      if (field.previous != null) {
        final keys = _data.keys.toList();
        final idx = field.previous!.indexWhere((e) => keys.contains(e));
        if (idx != -1) {
          final key = keys[idx];
          final value = _data.remove(key);
          await setValue(field.name, value);
        }
      }
    }
  }

  void setJson(Json value) {
    _data = value;
    notifyListeners();
  }

  Json toJson() {
    final meta = <String, Object?>{};
    for (final field in collection.allFields) {
      final value = field.getValue(this);
      meta[field.name] = value;
    }
    final now = DateTime.now();
    meta['created'] ??= now.toIso8601String();
    meta['updated'] = now.toIso8601String();
    meta['collection'] = collection.name;
    meta['id'] = ref.id;
    return meta;
  }

  Json data() => _data;
  Object? get(String key) => data()[key];
  void set(String key, Object? value) => _data[key] = value;

  Future<void> save([DocumentReference<Json>? ref]) async {
    if (_batch != null) {
      await _batch!.commit();
      endBatch();
    } else {
      await (ref ?? this.ref).set(toJson());
    }
  }

  Future<void> update(Json data) async {
    if (_batch != null) {
      _data.addAll(data);
      _batch!.set(ref, data);
    } else {
      final newData = {..._data};
      newData.addAll(data);
      newData['updated'] = DateTime.now().toIso8601String();
      _data = newData;
      await save();
    }
    notifyListeners();
  }

  Future<void> loadSnapshot(Snapshot snapshot) async {
    final data = snapshot.data();
    if (snapshot.exists) {
      _data = jsonDecode(jsonEncode(data ?? {}));
      notifyListeners();
    } else if (!snapshot.exists) {
      if (deleted != true) await delete();
    }
  }

  void subscribe({bool includeMetadataChanges = false}) {
    _subscription = ref
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .listen(loadSnapshot);
  }

  void unsubscribe() {
    _subscription?.cancel();
  }

  Future<DocumentSnapshot<Json>> reload([GetOptions? options]) async {
    final snapshot = await ref.get(options);
    await loadSnapshot(snapshot);
    return snapshot;
  }

  Future<void> delete({bool soft = true}) async {
    if (soft) {
      await update({'deleted': true});
    } else {
      await ref.delete();
    }
  }

  void startBatch() {
    _batch = client.firebase.firestore.batch();
  }

  void endBatch() {
    _batch = null;
  }

  Future<void> setValue(String key, Object? value) => update({key: value});
}

DateTime getDate(Object? object) {
  if (object is DateTime) {
    return object;
  } else if (object is String) {
    return DateTime.parse(object);
  } else {
    throw Exception('Invalid date type');
  }
}
