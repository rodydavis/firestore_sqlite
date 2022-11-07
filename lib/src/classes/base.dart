import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'collection.dart';

/// Base for all items in a collection
class CollectionBase extends ChangeNotifier {
  CollectionBase({
    required this.collection,
    required this.id,
  }) : reference = collection.reference.doc(id);

  static Future<CollectionBase> fromSnapshot(
    Collection collection,
    DocumentSnapshot<Object?> snapshot,
  ) async {
    final base = CollectionBase(
      id: snapshot.id,
      collection: collection,
    );
    await base.loadSnapshot(snapshot);
    return base;
  }

  final Collection collection;
  final String id;
  final db = FirebaseFirestore.instance;

  /// Firestore collection reference
  final DocumentReference reference;

  Map<String, Object?> _data = {};
  StreamSubscription<DocumentSnapshot<Object?>>? _subscription;

  Map<String, Object?> metadata() {
    return {
      "id": reference.id,
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
    };
  }

  /// Convert to JSON
  Map<String, Object?> toJson() => {...metadata(), ..._data};

  bool get isDeleted => _value('deleted') == true;
  DateTime get created => _date('created');
  DateTime get updated => _date('updated');

  Future<void> save() => reference.set(toJson());

  Future<void> update(Map<String, dynamic> data, [SetOptions? options]) async {
    final newData = {...metadata()};
    if (options?.merge == true) {
      newData.addAll(_data);
      newData.addAll(data);
    } else {
      newData.addAll(data);
    }
    newData['updated'] = DateTime.now().toIso8601String();
    _data = newData;
    await save();
    notifyListeners();
  }

  Future<void> loadSnapshot(DocumentSnapshot<Object?> snapshot) async {
    final data = snapshot.data();
    if (data != null && snapshot.exists) {
      _data = jsonDecode(jsonEncode(data));
      notifyListeners();
    } else if (!isDeleted) {
      await delete();
    }
  }

  void subscribe({
    bool includeMetadataChanges = false,
  }) {
    _subscription = reference
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .listen(loadSnapshot);
  }

  void unsubscribe() {
    _subscription?.cancel();
  }

  Future<void> reload([
    GetOptions? options,
  ]) async {
    final snapshot = await reference.get(options);
    await loadSnapshot(snapshot);
  }

  Future<void> delete() => update({'deleted': true});

  Object? _value(String key) {
    if (_data[key] != null) return _data[key];
    return null;
  }

  DateTime _date(String key) {
    final value = _value(key);
    if (value is DateTime) return value;
    if (value != null) {
      final date = DateTime.tryParse(value.toString());
      if (date != null) return date;
    }
    return DateTime.now();
  }
}
