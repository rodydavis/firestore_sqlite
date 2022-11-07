import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'collection.dart';

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
  StreamSubscription<DocumentSnapshot<Object?>>? _subscription;

  Map<String, Object?> metadata() => {
        "id": reference.id,
        "created": DateTime.now().toIso8601String(),
        "updated": DateTime.now().toIso8601String(),
      };

  bool get isDeleted => getBool('deleted') == true;
  DateTime get created => getDate('created', DateTime.now())!;
  DateTime get updated => getDate('updated', DateTime.now())!;

  Map<String, Object?> toJson() => {...metadata(), ..._data};

  Future<void> save() => reference.set(toJson());

  Future<void> update(Map<String, dynamic> data, [SetOptions? options]) async {
    final newData = {...metadata()};
    final merge = options?.merge ?? false;
    if (merge) {
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

  Future<void> setValue(String key, Object? value) => update({key: value});

  Object? getValue(String key, [Object? fallback]) {
    if (_data[key] != null) return _data[key];
    return fallback;
  }

  String? getString(String key, [String? fallback]) {
    final value = getValue(key);
    if (value is String) return value;
    return fallback;
  }

  int? getInt(String key, [int? fallback]) {
    final value = getValue(key);
    if (value is int) return value;
    return fallback;
  }

  double? getDouble(String key, [double? fallback]) {
    final value = getValue(key);
    if (value is double) return value;
    return fallback;
  }

  num? getNum(String key, [num? fallback]) {
    final value = getValue(key);
    if (value is num) return value;
    return fallback;
  }

  bool? getBool(String key, [bool? fallback]) {
    final value = getValue(key);
    if (value is bool) return value;
    return fallback;
  }

  DateTime? getDate(String key, [DateTime? fallback]) {
    final value = getValue(key);
    if (value is DateTime) return value;
    if (value != null) {
      final date = DateTime.tryParse(value.toString());
      if (date != null) return date;
    }
    return fallback;
  }
}
