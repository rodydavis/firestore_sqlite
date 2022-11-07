import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'collection.dart';
import 'field.dart';

typedef Snapshot = DocumentSnapshot<Object?>;

/// Base for all items in a collection
class Doc extends ChangeNotifier {
  Doc({
    required this.collection,
    required this.id,
  }) : reference = collection.reference.doc(id);

  static Future<Doc> fromSnapshot(
    Collection collection,
    DocumentSnapshot<Object?> snapshot,
  ) async {
    final base = Doc(
      id: snapshot.id,
      collection: collection,
    );
    await base.loadSnapshot(snapshot);
    return base;
  }

  /// Collection the document belongs to
  final Collection collection;

  /// Document id
  final String id;

  /// Firestore collection reference
  final DocumentReference reference;

  Map<String, Object?> _data = {};
  StreamSubscription<Snapshot>? _subscription;

  bool get isDeleted {
    return collection.deletedField.getBool(this) == true;
  }

  DateTime get created {
    return collection.createdField.getDate(this) ?? DateTime.now();
  }

  DateTime get updated {
    return collection.updatedField.getDate(this) ?? DateTime.now();
  }

  Map<String, Object?> toJson() {
    final meta = <String, Object?>{};
    for (final field in collection.allFields) {
      final value = field.getValue(this);
      meta[field.name] = value;
    }
    return meta;
  }

  Future<void> save() => reference.set(toJson());

  Future<void> update(Map<String, dynamic> data) async {
    final newData = {..._data};
    newData.addAll(data);
    newData['updated'] = DateTime.now().toIso8601String();
    _data = newData;
    await save();
    notifyListeners();
  }

  Future<void> loadSnapshot(Snapshot snapshot) async {
    final data = snapshot.data();
    if (snapshot.exists) {
      _data = jsonDecode(jsonEncode(data ?? {}));
      notifyListeners();
    } else if (!snapshot.exists) {
      if (!isDeleted) await delete();
    }
  }

  void subscribe({bool includeMetadataChanges = false}) {
    _subscription = reference
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .listen(loadSnapshot);
  }

  void unsubscribe() {
    _subscription?.cancel();
  }

  Future<void> reload([GetOptions? options]) async {
    final snapshot = await reference.get(options);
    await loadSnapshot(snapshot);
  }

  // TODO: Setup deletion trigger on cron with deleted == true and updated > TTL
  Future<void> delete() => update({'deleted': true});

  Future<void> setValue(String key, Object? value) => update({key: value});
}
