import 'package:cloud_firestore/cloud_firestore.dart';

import '../generators/json.dart';
import '../utils/json.dart';
import 'collection.dart';
import 'doc.dart';
import 'field.dart';

typedef Snapshots = List<QueryDocumentSnapshot<Json?>>;

extension CollectionUtils on Collection {
  static final db = FirebaseFirestore.instance;

  CollectionReference<Json> get reference => db.collection(name);

  DocumentReference<Json> get schema => db.collection('schema').doc(name);

  Future<Collection> checkForUpdate() async {
    final snapshot = await schema.get();
    return Collection.fromJson(snapshot.toJson());
  }

  Future<List<Doc>> parseDocs(Snapshots docs) async {
    final results = <Doc>[];
    for (final doc in docs) {
      final item = await Doc.fromSnapshot(this, doc);
      results.add(item);
    }
    return results;
  }

  Future<List<Doc>> getDocuments([GetOptions? options]) {
    return reference
        .get(options)
        .then((snapshot) => snapshot.docs)
        .then((docs) => parseDocs(docs));
  }

  Stream<List<Doc>> watchDocuments({bool includeMetadataChanges = false}) {
    return reference
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .map((snapshot) => snapshot.docs)
        .asyncMap((docs) => parseDocs(docs));
  }

  Future<Doc> getDocument(String id, [GetOptions? options]) async {
    final reference = this.reference.doc(id);
    final snapshot = await reference.get(options);
    return Doc.fromSnapshot(this, snapshot);
  }

  Future<void> save() async {
    final data = copyWith(updated: DateTime.now(), fields: allFields).toJson();
    await schema.set(copyJson(data) as Map<String, Object?>);
  }

  Future<String> add(Doc base) async {
    final doc = await reference.add(base.toJson());
    return doc.id;
  }

  Future<void> set(Doc base, [SetOptions? options]) async {
    final ref = reference.doc(base.id);
    await ref.set(base.toJson(), options);
  }
}

extension FieldUtils on Field {
  Object? getValue(Doc doc) {
    final data = doc.data();
    if (data.containsKey(name)) {
      return data[name];
    }
    for (final key in previous ?? []) {
      if (data.containsKey(key)) {
        return data[name];
      }
    }
    return null;
  }

  String? getString(Doc doc) {
    final value = getValue(doc);
    if (value is String) return value;
    if (defaultValue is String) {
      return defaultValue as String;
    }
    return null;
  }

  int? getInt(Doc doc) {
    final value = getValue(doc);
    if (value is int) return value;
    if (defaultValue is int) {
      return defaultValue as int;
    }
    return null;
  }

  double? getDouble(Doc doc) {
    final value = getValue(doc);
    if (value is double) return value;
    if (defaultValue is double) {
      return defaultValue as double;
    }
    return null;
  }

  num? getNum(Doc doc) {
    final value = getValue(doc);
    if (value is num) return value;
    if (defaultValue is num) {
      return defaultValue as num;
    }
    return null;
  }

  bool? getBool(Doc doc) {
    final value = getValue(doc);
    if (value is bool) return value;
    if (defaultValue is bool) {
      return defaultValue as bool;
    }
    return null;
  }

  DateTime? getDate(Doc doc) {
    final value = getValue(doc);
    if (value is DateTime) return value;
    if (value != null) {
      final date = DateTime.tryParse(value.toString());
      if (date != null) return date;
    }
    if (defaultValue is DateTime) {
      return defaultValue as DateTime;
    }
    return null;
  }
}

extension SnapshotUtils on DocumentSnapshot<Json?> {
  Json toJson() => {...data() ?? {}, 'id': id};
}
