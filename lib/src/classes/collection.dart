import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recase/recase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'base.dart';
import 'field.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

typedef Json = Map<String, dynamic>;

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String name,
    required DateTime created,
    required DateTime updated,
    required String? description,
    required List<Field> fields,
  }) = _Collection;

  factory Collection.fromJson(Map<String, Object?> json) =>
      _$CollectionFromJson(json);
}

extension CollectionUtils on Collection {
  static final db = FirebaseFirestore.instance;
  CollectionReference<Json> get reference => db.collection(name);
  DocumentReference<Json> get schema =>
      db.collection('schema').doc(name.snakeCase);

  Future<List<CollectionBase>> parseDocs(
    List<QueryDocumentSnapshot<Object?>> docs,
  ) async {
    final results = <CollectionBase>[];
    for (final doc in docs) {
      final item = await CollectionBase.fromSnapshot(this, doc);
      results.add(item);
    }
    return results;
  }

  Future<List<CollectionBase>> getDocuments([
    GetOptions? options,
  ]) {
    return reference
        .get(options)
        .then((snapshot) => snapshot.docs)
        .then((docs) => parseDocs(docs));
  }

  Stream<List<CollectionBase>> watchDocuments({
    bool includeMetadataChanges = false,
  }) {
    return reference
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .map((snapshot) => snapshot.docs)
        .asyncMap((docs) => parseDocs(docs));
  }

  Future<CollectionBase> getDocument(
    String id, [
    GetOptions? options,
  ]) async {
    final reference = this.reference.doc(id);
    final snapshot = await reference.get(options);
    return CollectionBase.fromSnapshot(this, snapshot);
  }

  Future<void> save() async {
    final data = copyWith(updated: DateTime.now()).toJson();
    await schema.set(data);
  }

  Future<CollectionBase> add(CollectionBase base) async {
    final doc = await reference.add(base.toJson());
    final snapshot = await doc.get();
    return CollectionBase.fromSnapshot(this, snapshot);
  }
}
